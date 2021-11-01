import logging

import aiogram.utils.markdown as md
from aiogram.types import ReplyKeyboardMarkup, KeyboardButton
from aiogram.contrib.fsm_storage.memory import MemoryStorage
from aiogram.dispatcher import FSMContext
from aiogram.types import ParseMode
from aiogram import Bot, types
from aiogram.dispatcher import Dispatcher, filters
from aiogram.dispatcher.filters.state import State, StatesGroup
from aiogram.utils import executor
import re
import dbwork2
import emailwork

# Enable logging
logging.basicConfig(filename='frobot2.log', filemode='a',
                    format='%(asctime)s - %(process)d - %(name)s - %(levelname)s - %(message)s')

'''
logging.warning('This will get logged to a file')
name = 'John'
logging.error(f'{name} raised an error')
a = 5
b = 0
try:
  c = a / b
except Exception as e:
  logging.exception("Exception occurred") <<< better
  logging.error("Exception occurred", exc_info=True)
'''

'''get_pd_accept
logging.debug('This is a debug message')
logging.info('This is an info message')
logging.warning('This is a warning message')
logging.error('This is an error message')
logging.critical('This is a critical message')
await bot.send_message(
def error(update, context):
    """Log Errors caused by Updates."""
    logger.warning('Update "%s" caused error "%s"', update, context.error)
'''

#API_TOKEN = ''  # @
API_TOKEN = ''  # @testshopcatalog_bot

PROXY_URL = ''
PROXY_AUTH = ''
storage = MemoryStorage()

bot = Bot(token=API_TOKEN)
dp = Dispatcher(bot, storage=storage)

restrict_access = False
ACCESS_ID_LIST = [986346431, 229793913]

cmnd_start = 'start'
cmnd_cancel = 'cancel'

basket_smbl1 = '🍦'
basket_smbl2 = '🍨'
vieworder_smbl = '🛒'
pdagree_smbl = '📝'
dlvry_smbl = '🚐'
sendordr_smbl = '👌'

art = dbwork2.art

cmnd_view_catalog = '{} Просмотреть каталог, добавить в заказ {}'.format(basket_smbl1, basket_smbl2)
cmnd_view_catalog_backtomain = 'В каталог'
cmnd_view_order = 'Просмотреть заказ {}'.format(vieworder_smbl)
cmnd_pd_data = 'Согласие на обработку ПД и Ваш контактный номер {}'.format(pdagree_smbl)
cmnd_delivery_info = 'Информация о доставке {}'.format(dlvry_smbl)
cmnd_send_order = 'Отправить заказ {}'.format(sendordr_smbl)
cmnd_my_orders = 'Мои заказы'

cmnd_back_to_catalog = cmnd_view_catalog_backtomain
cmnd_back_to_menu = 'В главное меню'

cmnd_yes_pd_accepted = 'Да, я принимаю условия обработки перс. данных'
cmnd_no_pd_not_accepted = 'Нет, я не принимаю условия обработки перс. данных'
cmnd_revoke_accept = 'Отозвать согласие обработки и удалить мои перс. данные'

cmnd_change_phone = 'Указать номер телефона'
mess_pd_agree = 'Сообщая номер телефона Вы даете согласие ООО ... на ' \
                                  'его сохранение и обработку. Пожалуйста введите и отправьте Ваш контактный номер телефона:'
mess_phone_update_done = 'Ваш контактный номер телефона:'
mess_number_saved = 'Номер сохранен'

add_art_to_order = 'Добавить в заказ арт'
rmv_art_from_order = 'Удалить из заказа арт'

need_greeting = True
user = None

top_cat_level = {}
last_category_viewed = ''


class PhoneNumProcess(StatesGroup):
    PhoneNum = State()
    #EMail = State() не сделал, надоело

'''
async def func_name(message: types.Message):
    try:
    
    except Exception as e:
        logging.exception('Exception occurred in proc: {}'.format('func_name'))
'''

async def get_user_by_id(id):
    try:
        user = dbwork2.get_user_by_id(id)
        return user
    except Exception as e:
        logging.exception('Exception occurred in proc: {}'.format('get_user_by_id'))


async def get_main_menu(message: types.Message):
    # основная клавиатура
    keyboard = ReplyKeyboardMarkup(resize_keyboard=True, one_time_keyboard=True)
    keyboard.row(KeyboardButton(cmnd_view_catalog))
    keyboard.row(KeyboardButton(cmnd_view_order), KeyboardButton(cmnd_my_orders))
    keyboard.row(KeyboardButton(cmnd_pd_data))
    keyboard.row(KeyboardButton(cmnd_delivery_info), KeyboardButton(cmnd_send_order))
    return keyboard


@dp.message_handler(commands=[cmnd_start])
async def start(message: types.Message):
    global need_greeting
    global user
    '''
    с глобальными переменными может быть проблема - если они относятся ко всем юзерам
    но это вряд ли, скорее всего отдельный поток на ИД 
    '''
    try:
        if restrict_access:
            if message.from_user.id not in ACCESS_ID_LIST:
                await message.answer('Access denied')
                pass

        user = await get_user_by_id(message.chat.id)

        if need_greeting:
            text = 'Привет, я бот компании ООО ... . С моей помощью вы можете ' \
                   'заказать мороженое на дом по Москве и Московской области. ' \
                   'Заказы возможны к объему от короба. ' \
                   'Выберите действие из вариантов ниже.'
            need_greeting = False
        else:
            text = "Выберите действие из вариантов ниже."
        await bot.send_message(
                message.chat.id,
                md.text(
                    md.text(text),
                    sep='\n',
                ),
                reply_markup=await get_main_menu(message),
                parse_mode=ParseMode.MARKDOWN,
        )
    except Exception as e:
        logging.exception('Exception occurred in proc: {}'.format('start'))


@dp.message_handler(lambda message: message.text == cmnd_back_to_menu)
async def start_wrapper(message: types.Message):
    await start(message)


#@dp.message_handler(commands=[cmnd_view_catalog])
@dp.message_handler(lambda message: message.text in [cmnd_view_catalog, cmnd_view_catalog_backtomain])
async def view_catalog(message: types.Message):
    global top_cat_level
    top_cat_level.clear()
    try:
        keyboard = ReplyKeyboardMarkup(resize_keyboard=True, one_time_keyboard=True)
        goods_cat_links = dbwork2.return_full_main_menu()
        i = 0
        for goods_cat_link in goods_cat_links:
            val = goods_cat_link['text']
            top_cat_level[val] = i
            i += 1
            keyboard.row(KeyboardButton(val))
        keyboard.row(KeyboardButton(cmnd_back_to_menu))
        await bot.send_message(
                message.chat.id,
                md.text(
                    md.text('Выберите раздел каталога'),
                    sep='\n',
                ),
                reply_markup=keyboard,
                parse_mode=ParseMode.MARKDOWN,
        )
    except Exception as e:
        logging.exception('Exception occurred in proc: {}'.format(''))


async def is_top_lvl_cat(txt):
    for key, value in top_cat_level.items():
        if key == txt:
            return value
    return 0


@dp.message_handler(lambda message: message.text in top_cat_level.keys())
async def show_goods_in_category(message: types.Message):
    global last_category_viewed
    last_category_viewed = message.text
    menuid = await is_top_lvl_cat(message.text)
    keyboard = ReplyKeyboardMarkup(resize_keyboard=True, one_time_keyboard=True)
    goods = dbwork2.return_goods_by_menuid(menuid)
    for val in goods:
        keyboard.row(KeyboardButton(val))
    keyboard.row(KeyboardButton(cmnd_view_catalog_backtomain))
    await bot.send_message(
        message.chat.id,
        md.text(
            md.text('Выберите позицию для подробного просмотра'),
            sep='\n',
        ),
        reply_markup=keyboard,
        parse_mode=ParseMode.MARKDOWN,
    )


def find_art_in_txt(operation, txt):
    art = 0
    if (operation in txt) and ('#' in txt):
        art = int(txt[len(operation):txt.find('#')])  ## add_art_to_order = 'Добавить в заказ арт'
    return art


@dp.message_handler(lambda message: find_art_in_txt(add_art_to_order, message.text) > 0)
async def add_ice_to_order(message: types.Message):
    art_code = find_art_in_txt(add_art_to_order, message.text)
    order = dbwork2.get_order_by_user(message.chat.id, list(dbwork2.order_statuses.keys())[0])
    dbwork2.add_ice_to_order(order['id'], art_code)
    #await bot.send_message(message.chat.id, '{}'.format(ice['name']))
    #await bot.send_message(message.chat.id, '{}'.format(ice['url']))
    #await bot.send_message(message.chat.id, '{}'.format(ice['cost_text']))
    await bot.send_message(message.chat.id, 'арт{} добавлен в заказ'.format(art_code))

    keyboard = ReplyKeyboardMarkup(resize_keyboard=True, one_time_keyboard=True)

    btntext_addtoorder = '{}{}# еще раз'.format(add_art_to_order, art_code)
    keyboard.row(KeyboardButton(btntext_addtoorder))

    cat = dbwork2.return_category_text_by_art(art_code)
    keyboard.row(KeyboardButton(cat['text']))

    keyboard.row(KeyboardButton(cmnd_view_order))

    keyboard.row(KeyboardButton(cmnd_view_catalog_backtomain))

    await bot.send_message(
        message.chat.id,
        md.text(
            md.text('Выберите действие'),
            sep='\n',
        ),
        reply_markup=keyboard,
        parse_mode=ParseMode.HTML,
    )


@dp.message_handler(lambda message: find_art_in_txt(rmv_art_from_order, message.text) > 0)
async def remove_ice_from_order(message: types.Message):
    art_code = find_art_in_txt(rmv_art_from_order, message.text)
    order = dbwork2.get_order_by_user(message.chat.id, list(dbwork2.order_statuses.keys())[0])
    dbwork2.delete_ice_from_order(order['id'], art_code)
    await bot.send_message(message.chat.id, 'арт{} удален из заказа (1 раз)'.format(art_code))
    await view_order(message)


def get_art(txt):
    art_code = 0
    if (art in txt) and txt.find('#') > len(art) and (add_art_to_order not in txt) and (rmv_art_from_order not in txt):
        try:
            art_code = int(txt[len(art):txt.find('#')])  # !!!!!!!!! получше потом обработку написать
        except:
            art_code = 0
    return art_code



@dp.message_handler(lambda message: get_art(message.text) > 0)
async def show_icecream(message: types.Message):
    art_code = get_art(message.text)

    keyboard = ReplyKeyboardMarkup(resize_keyboard=True, one_time_keyboard=True)

    ice = dbwork2.return_good_by_art(art_code)

    await bot.send_message(message.chat.id, '{}'.format(ice['name']))
    await bot.send_message(message.chat.id, '{}'.format(ice['url']))
    await bot.send_message(message.chat.id, '{}'.format(ice['cost_text']))

    btntext_addtoorder = '{}{}#'.format(add_art_to_order, ice['art'])

    keyboard.row(KeyboardButton(btntext_addtoorder))

    art_cat = dbwork2.return_category_text_by_art(ice['art'])
    keyboard.row(KeyboardButton(art_cat['text']))

    keyboard.row(KeyboardButton(cmnd_view_catalog_backtomain))

    await bot.send_message(
        message.chat.id,
        md.text(
            md.text('Выберите действие'),
            sep='\n',
        ),
        reply_markup=keyboard,
        parse_mode=ParseMode.MARKDOWN,
    )


@dp.message_handler(text=cmnd_view_order)
async def view_order(message: types.Message, send_mail=False):
    try:
        global user
        user = dbwork2.get_user_by_id(message.chat.id)
        order = dbwork2.get_order_by_user(message.chat.id, list(dbwork2.order_statuses.keys())[0])
        order_content = dbwork2.get_order_content_by_order_id(order['id'])

        keyboard = ReplyKeyboardMarkup(resize_keyboard=True, one_time_keyboard=True)

        mess = []
        mess.append('Информация по заказу №: {}'.format(order['id']))
        mess.append('')
        mess.append('Контактный телефон клиента: {}'.format(user['phone']))
        mess.append('')
        mess.append('Содержимое заказа: ')
        mess.append('')

        sep1 = '\n'
        text = sep1.join(mess)

        if not send_mail:
            await bot.send_message(
                message.chat.id,
                md.text(
                    md.text(text),
                    sep=sep1,
                ),
                reply_markup=None,
                parse_mode=ParseMode.MARKDOWN,
            )

        sep2 = '\n'
        for row in order_content.items():
            icecream = []
            id = row[1]['id']
            name = row[1]['name']
            art_code = row[1]['art']
            cost_text = row[1]['cost_text']
            url = row[1]['url']
            icecream.append('арт{} {} {} {}| '.format(art_code, cost_text, name, url))
            icecream.append('')
            icecream.append('\n')


            order_position = sep2.join(icecream)
            text = text + order_position

            if not send_mail:
                await bot.send_message(
                    message.chat.id,
                    md.text(
                        md.text(order_position),
                        sep=sep2,
                    ),
                    reply_markup=None,
                    parse_mode=ParseMode.HTML,
                )
                #await bot.send_message(message.chat.id, '================')

                keyboard.row(KeyboardButton(rmv_art_from_order+'{}#'.format(art_code)))

        if not send_mail:
            keyboard.row(KeyboardButton(cmnd_view_catalog_backtomain))
            keyboard.row(KeyboardButton(cmnd_back_to_menu))
            keyboard.row(KeyboardButton(cmnd_send_order))

            await bot.send_message(
                message.chat.id,
                md.text(
                    md.text('Выберите действие'),
                    sep='\n',
                ),
                reply_markup=keyboard,
                parse_mode=ParseMode.MARKDOWN,
            )

        return text
    except Exception as e:
        logging.exception('Exception occurred in proc: {}'.format('@dp.message_handler(text=cmnd_view_order) '
                                                                  'async def view_order(message: types.Message):'))
        print(e)


@dp.message_handler(text=cmnd_send_order)
async def send_order(message: types.Message):
    try:
        user = dbwork2.get_user_by_id(message.chat.id)
        order = dbwork2.get_order_by_user(message.chat.id, list(dbwork2.order_statuses.keys())[0])
        order_content = dbwork2.get_order_content_by_order_id(order['id'])

        if len(order_content) > 0 :
            if re.sub("\D", "", user['phone']) == '':
                await bot.send_message(message.chat.id, '{}'.format('Не указан контактный номер телефона '
                                                                    '- укажите его пожалуйста. Он нужен для '
                                                                    'того чтобы после отправки '
                                                                    'заказа мы на него перезвонили для уточнения '
                                                                    'адреса и даты-времени доставки.'))
            else:
                text = await view_order(message, send_mail=True)
                await emailwork.send_order_to_cs(
                                                'sergei.ulvis@gmail.com',
                                                'Заказ {}'.format(order['id']), text)
                dbwork2.set_order_status(order['id'], 1)  # dbwork2.order_statuses
                await bot.send_message(message.chat.id, 'Заказ {} отправлен, '
                                                        'наши операторы очень скоро свяжутся с Вами.'.format(order['id']))
        else:
            await bot.send_message(message.chat.id, '{}'.format('В заказе нет позиций, добавьте что-нибудь в заказ из каталога.'))

        await start(message)
    except Exception as e:
        logging.exception('Exception occurred in proc: {}'.format('send_order'))


@dp.message_handler(text=cmnd_my_orders)
async def view_my_orders(message: types.Message):
    orders_info = []
    try:
        for i in range(0, len(dbwork2.order_statuses)-1):
            orders = dbwork2.get_orders_by_user(message.chat.id, list(dbwork2.order_statuses.keys())[i])
            for order in orders:
                orders_info.append('№ заказа: {} Дата заказа: {} Статус: {}'.format(order['id'],
                                                                                    order['order_datetime_msk'],
                                                                                    order['status_text']))
                order_contents = dbwork2.get_order_details(order['id'])
                for order_content in order_contents:
                    orders_info.append('{} : {} : {}'.format(order_content['art'],
                                                         order_content['name'],
                                                         order_content['cost_text']))
        for row in orders_info:
            await bot.send_message(
                message.chat.id,
                md.text(
                    md.text(row),
                    sep='\n',
                ),
                reply_markup=None,
                parse_mode=ParseMode.MARKDOWN,
            )
        keyboard = ReplyKeyboardMarkup(resize_keyboard=True, one_time_keyboard=True)
        keyboard.row(KeyboardButton(cmnd_back_to_menu))
        await bot.send_message(
            message.chat.id,
            md.text(
                md.text('Выберите действие'),
                sep='\n',
            ),
            reply_markup=keyboard,
            parse_mode=ParseMode.MARKDOWN,
        )
    except Exception as e:
        print(e)


## personal data processing VVVVVVVVVVVVVVVVVV
@dp.message_handler(lambda message: message.text == cmnd_pd_data)
async def pd_data(message: types.Message):
    try:
        is_accepted, phone = await is_user_accepted_pd(message)
        if not is_accepted:
            await message.answer('Ваш номер телефона нужен для обратной связи и уточнения даты и времени доставки. \n '
                                 'Запросить и сохранить Ваш номер телефона мы можем только после Вашего согласия с '
                                 'Политикой обработки персональных данных компании ООО ..., доступной по '
                                 'ссылке:\n https://opensource.org/licenses/MIT \n'
                                 'Пожалуйста выберите действие из вариантов ниже:',
                                 reply_markup=await get_pd_accept_menu(message)) # да, принимаю или нет, не принимаю
        else:
            await message.answer('Вы выразили согласие с Политикой обработки персональных данных компании '
                                 'ООО ....\nВаш контактный телефон: {} \n'.format(phone),
                                 reply_markup=await change_phone_or_back_to_main_menu(message))
    except Exception as e:
        logging.exception('Exception occurred in proc: {}'.format('pd_data'))


async def is_user_accepted_pd(message: types.Message):
    user = await get_user_by_id(message.chat.id)
    pd_accept = user['pd_accept']
    phone = user['phone']
    is_accepted = (pd_accept == 'да')
    return is_accepted, phone


async def get_pd_accept_menu(message: types.Message):
    # основная клавиатура
    keyboard = ReplyKeyboardMarkup(resize_keyboard=True, one_time_keyboard=True)
    keyboard.row(KeyboardButton(cmnd_yes_pd_accepted))
    keyboard.row(KeyboardButton(cmnd_no_pd_not_accepted))
    return keyboard


async def change_phone_or_back_to_main_menu(message: types.Message):
    # основная клавиатура
    keyboard = ReplyKeyboardMarkup(resize_keyboard=True, one_time_keyboard=True)
    keyboard.row(KeyboardButton(cmnd_change_phone))
    keyboard.row(KeyboardButton(cmnd_revoke_accept))
    keyboard.row(KeyboardButton(cmnd_back_to_menu))
    return keyboard


@dp.message_handler(lambda message: (message.text == cmnd_yes_pd_accepted or message.text == cmnd_change_phone))
async def yes_pd_accepted(message: types.Message):
    global user
    try:
        await set_user_pd_accepted(message.chat.id)
        await message.answer('Согласие принято, пожалуйста введите Ваш контактный номер телефона: \n',
                             reply_markup=types.ReplyKeyboardRemove())
        await PhoneNumProcess.PhoneNum.set()
    except Exception as e:
        logging.exception('Exception occurred in proc: {}'.format('yes_pd_accepted'))


@dp.message_handler(lambda message: (message.text == cmnd_revoke_accept))
async def revoke_accept(message: types.Message):
    try:
        await set_user_pd_revoked(message.chat.id)
        await message.answer('Согласие отозвано, перс. данные удалены. \n', reply_markup=types.ReplyKeyboardRemove())
        await start(message)
    except Exception as e:
        logging.exception('Exception occurred in proc: {}'.format('revoke_accept'))


@dp.message_handler(state=PhoneNumProcess.PhoneNum)
async def PhoneNumProcess_PhoneNum(message: types.Message, state: FSMContext):
    phone = message.text[:40]
    phone = re.sub('\D', '', phone)
    if phone == '':
        await message.answer('Извините, но во введенной строке нет чисел. Попробуйте еще раз. \n',
                             reply_markup=types.ReplyKeyboardRemove())
        await state.finish()
        await yes_pd_accepted(message)
    else:
        await set_user_phone(message.chat.id, phone)
        #async with state.proxy() as data:
        #    data['phone'] = phone
        await state.finish()
        await message.answer('Ваш контактный номер {} сохранен.'.format(phone))
        await start(message)


@dp.message_handler(lambda message: message.text == cmnd_no_pd_not_accepted)
async def no_pd_not_accepted(message: types.Message):
    try:
        await message.answer('К сожалению, без контактного телефона мы не сможем принять заказ. \n',
                             reply_markup=types.ReplyKeyboardRemove())
        await set_user_pd_revoked(message.chat.id)
        await start(message)
        '''
        await bot.send_message(
                message.chat.id,
                md.text(
                    md.text('К сожалению, без контактного телефона мы не сможем принять заказ. \n'),
                    sep='\n',
                ),
                reply_markup=await get_main_menu(message),
                parse_mode=ParseMode.MARKDOWN,
        )
        '''
    except Exception as e:
        logging.exception('Exception occurred in proc: {}'.format('no_pd_not_accepted'))


async def set_user_pd_accepted(id):
    try:
        dbwork2.set_user_pd_acccepted(id)
        return 'set_user_pd_accepted'
    except Exception as e:
        logging.exception('Exception occurred in proc: {}'.format('set_user_pd_accepted'))


async def set_user_pd_revoked(id):
    try:
        dbwork2.set_user_pd_revoked(id)
        return 'set_user_pd_revoked'
    except Exception as e:
        logging.exception('Exception occurred in proc: {}'.format('set_user_pd_revoked'))


async def set_user_phone(id, phone):
    try:
        dbwork2.set_user_phone(id, phone)
        return 'set_user_phone'
    except Exception as e:
        logging.exception('Exception occurred in proc: {}'.format('set_user_phone'))
## personal data processing AAAAAAAAAAAAAAAAAA


@dp.message_handler(lambda message: message.text == cmnd_delivery_info)
async def delivery(message: types.Message):
    try:
        await message.answer('Информация о доставке: по Москве и МО по будням с 9 до 18. '
                             'Пожалуйста для уточнения свяжитесь с нашим отделом Обслуживания Клиентов по тел.: +7 (999) 999-99-99',
                             reply_markup=await get_main_menu(message),
                             )
    except Exception as e:
        logging.exception('Exception occurred in proc: {}'.format('delivery'))


if __name__ == '__main__':
    try:
        executor.start_polling(dp, skip_updates=True)
    except Exception as e:
        logging.exception('Exception occurred')