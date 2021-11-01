import pymysql
import pytz
import datetime

# MySQL DB
_host = ''
_user = ''
_password = ''
_db = ''

_charset = 'utf32'

debug = False
inserted_id = 0

art = 'арт'

local_tz = pytz.timezone('Europe/Moscow')

def utc_to_local(utc_dt):
    local_dt = utc_dt.replace(tzinfo=pytz.utc).astimezone(local_tz)
    return local_tz.normalize(local_dt) # .normalize might be unnecessary

def aslocaltimestr(utc_dt):
    return utc_to_local(utc_dt).strftime('%Y-%m-%d %H:%M:%S.%f')
#   return utc_to_local(utc_dt).strftime('%Y-%m-%d %H:%M:%S.%f %Z%z')

order_statuses = {'I':'заполняется пользователем',
                  'P':'передан в службу доставки',
                  'U':'отгружен курьеру, в пути',
                  'F':'доставлен',
                  'C':'отменен'}
status_with_user = list(order_statuses.keys())[0]
status_sent_to_CS = list(order_statuses.keys())[1]


def clean(txt):
    if txt is None:
        txt = ""
    txt = str.strip(txt)
    txt = str.replace(txt, "\"\"", "")
    txt = str.replace(txt, "\"", "")
    txt = str.replace(txt, "'", "")
    txt = txt.replace('\n', ' ')
    txt = txt.replace('\r', '')
    return txt


def getconnect():
    connect = pymysql.connect(host=_host,
                              user=_user,
                              password=_password,
                              db=_db,
                              port=3306)
    return connect


def disconnect(connect):
    connect.close()


def ins(connection, table, ischeckdupl, flddupl, valdupl, **kwargs):
    id = 0
    global debug
    try:
        fields = ""
        vals = ""
        if ischeckdupl == True:
            with connection.cursor() as cur:
                sql = 'select max(id) from {} where {} = "{}"'.format(table, flddupl, valdupl)
                cur.execute(sql)
                for row in cur:
                    id = row['max(id)']
                if id is None:
                    id = 0
            connection.commit()
        if int(id) == 0:  # dublia ne nashli ili i ne iskali tk poh
            if kwargs is not None:
                for key, value in kwargs.items():
                    fields = fields + key + ", "
                    vals = vals + "\"" + value + "\", "
            fields = fields[0:-2]
            vals = vals[0:-2]
            with connection.cursor() as cursor:
                sql = "INSERT INTO " + table + " (" + fields + ") VALUES (" + vals + ")"
                if debug == True:
                    print("ins : " + sql)
                cursor.execute(sql)
            connection.commit()
            with connection.cursor() as cur:
                sql = "select max(id) from " + table
                cur.execute(sql)
                for row in cur:
                    id = row['max(id)']
            connection.commit()
            if debug == True : print("ins id: " + str(id))
    except Exception as ex:
        id = -1
        template = "An exception of type {0} occurred. Arguments:\n{1!r}"
        message = template.format(type(ex).__name__, ex.args)
        print(message)
    finally:
        return id


def upd(connection, table, id, **kwargs):
    try:
        vals = ""
        if kwargs is not None:
            for key, value in kwargs.items():
                vals = vals + key + " = \"" + str(value) + "\", "
        vals = vals[0:-2]
        with connection.cursor() as cursor:
            sql = "update " + table + " set " + vals + " where id = " + str(id)
            if debug == True:
                print("upd : " + sql)
            cursor.execute(sql)
        connection.commit()
    finally:
        sql = ""


def delete(connection, table, all=False, id=0):
    with connection.cursor() as cursor:
        sql = "delete FROM " + table
        if all != True:
            sql = sql + " WHERE id = " + str(id)
        if debug == True:
            print("del : " + sql)
        cursor.execute(sql)
        connection.commit()



def get_user_by_id(user_id):
    connect = getconnect()
    user = {}
    with connect.cursor() as cur:
        sql_select = 'select id, user_id, phone, pd_accept from clients where user_id={}'.format(user_id)
        cur.execute(sql_select)
        cur.fetchall
        if cur.rowcount < 1:
            sql_create = 'insert into clients (user_id) values ({})'.format(user_id)
            cur.execute(sql_create)
            connect.commit()
            cur.execute(sql_select)
            cur.fetchall
        for row in cur:
            user['id'] = row[0]
            user['user_id'] = row[1]
            user['phone'] = row[2]
            user['pd_accept'] = row[3]
    disconnect(connect)
    return user


def set_user_pd_accepted(user_id):
    connect = getconnect()
    with connect.cursor() as cur:
        sql = 'update clients set pd_accept = "{}" where user_id={}'.format('да', user_id)
        cur.execute(sql)
        connect.commit()
    disconnect(connect)
    return 1


def set_user_pd_revoked(user_id):
    connect = getconnect()
    with connect.cursor() as cur:
        sql = 'update clients set pd_accept = "нет", phone="не указан" where user_id={}'.format(user_id)
        cur.execute(sql)
        connect.commit()
    disconnect(connect)
    return 1


def set_user_phone(user_id, phone):
    #user = get_user_by_id(user_id)
    connect = getconnect()
    with connect.cursor() as cur:
        sql = 'update clients set phone = "{}", pd_accept="{}" where user_id={}'.format(phone, 'да', user_id)
        cur.execute(sql)
        connect.commit()
    disconnect(connect)
    return 1


def get_phone_by_user_id(user_id):
    connection_ = getconnect()
    with connection_.cursor() as cur:
        sql = 'select phone from clients where user_id={}'.format(user_id)
        cur.execute(sql)
        for row in cur:
            phone = row[0]
    disconnect(connection_)
    return phone



def create_update_goods_main_menu(menuid, text, url):
    connection_ = getconnect()
    #mainmenu = {}
    resp = 'inserted'

    with connection_.cursor() as cur:
        sql_select = 'select id, menuid, text, url from menus where menuid = {} ' \
                     'order by id asc'.format(menuid)
        cur.execute(sql_select)
        cur.fetchall
        curr_dt = aslocaltimestr(datetime.datetime.utcnow())

        if cur.rowcount < 1:
            sql_create = 'insert into menus (parentid, menuid, text, url, update_datetime_msk) ' \
                         'values ({}, {}, "{}", "{}", "{}")'.format(
                            0, menuid, text, url, curr_dt)
            cur.execute(sql_create)
            connection_.commit()
        else:
            with cur:
                sql = 'update menus set text = "{}", url = "{}", update_datetime_msk = "{}" ' \
                      'where menuid={}'.format(text, url, curr_dt, menuid)
                cur.execute(sql)
                connection_.commit()
                resp = 'updated'

    disconnect(connection_)
    return resp


def return_main_menu_as_links():
    connection_ = getconnect()
    mainmenu = []
    with connection_.cursor() as cur:
        sql_select = 'select url from menus where parentid = 0 order by menuid asc'
        cur.execute(sql_select)
        cur.fetchall
    for row in cur:
        mainmenu.append(row[0])
    disconnect(connection_)
    return mainmenu


def return_goods_by_menuid(menuid):
    connection_ = getconnect()
    goods = []
    with connection_.cursor() as cur:
        sql_select = 'select id, url, art, name, cost_text from goods where menuid={} order by id asc'.format(menuid)
        cur.execute(sql_select)
        cur.fetchall
    for row in cur:
        ice = '{}{}# - {} - {}'.format(art, row[2], row[4], row[3])
        goods.append(ice)
    disconnect(connection_)
    return goods


def return_full_main_menu():
    connection_ = getconnect()
    mainmenulist = []
    with connection_.cursor() as cur:
        sql_select = 'select text, url, menuid from menus where parentid = 0 ' \
                     'order by menuid asc'
        cur.execute(sql_select)
        cur.fetchall
    for row in cur:
        mainmenu = {}
        mainmenu['text'] = row[0]
        mainmenu['url'] = row[1]
        mainmenu['menuid'] = row[2]
        mainmenulist.append(mainmenu)
        del mainmenu
    disconnect(connection_)
    return mainmenulist


def delete_menus():
    connection_ = getconnect()
    delete(connection_, 'menus', True)
    disconnect(connection_)


def delete_goods():
    connection_ = getconnect()
    delete(connection_, 'goods', True)
    disconnect(connection_)


def create_update_good(art, name, url, menuid, costtext):
    connection_ = getconnect()
    resp = 'inserted'
    with connection_.cursor() as cur:
        curr_dt = aslocaltimestr(datetime.datetime.utcnow())
        sql_create = 'insert into goods (art, name, url, menuid, cost_text, update_datetime_msk) ' \
                         'values ("{}", "{}", "{}", {}, "{}", "{}")'.format(
                            art, name, url, menuid, costtext, curr_dt)
        cur.execute(sql_create)
        connection_.commit()
    disconnect(connection_)
    return resp


def return_good_by_art(art):
    connection_ = getconnect()
    ice = {}
    with connection_.cursor() as cur:
        sql_select = 'select id, url, art, name, cost_text from goods where art={}'.format(art)
        cur.execute(sql_select)
        cur.fetchall
    for row in cur:
        ice['id'] = row[0]
        ice['url'] = row[1]
        ice['art'] = row[2]
        ice['name'] = row[3]
        ice['cost_text'] = row[4]
    disconnect(connection_)
    return ice


def return_category_text_by_art(art_code):
    connection_ = getconnect()
    cat = {}
    with connection_.cursor() as cur:
        sql_select = 'select text from menus where menuid=' \
                     '(select max(menuid) from goods where art ={})'.format(art_code)
        cur.execute(sql_select)
        cur.fetchall
    for row in cur:
        cat['text'] = row[0]
    disconnect(connection_)
    return cat


def get_order_by_user(user_id, status):
    connection_ = getconnect()
    order = {}

    with connection_.cursor() as cur:
        sql_select = 'select id, user_id, order_datetime_msk, status, status_text, ' \
                     'update_datetime_msk from orders where user_id = {} and status="{}" ' \
                     'order by id desc'.format(user_id, status)
        cur.execute(sql_select)
        cur.fetchall

        if status == status_with_user and cur.rowcount < 1:
            curr_dt = aslocaltimestr(datetime.datetime.utcnow())
            sql_create = 'insert into orders (user_id, order_datetime_msk, status, status_text, update_datetime_msk) values ({}, "{}", "{}", "{}", "{}")'.format(
                user_id,
                curr_dt,
                status,
                #list(order_statuses.values())[0],
                order_statuses[status],
                curr_dt,
                )
            cur.execute(sql_create)
            connection_.commit()
            cur.execute(sql_select)
            cur.fetchall

        for row in cur:
            order['id'] = row[0]
            order['id_client'] = row[1]
            order['order_datetime_msk'] = row[2]
            order['status'] = row[3]
            order['status_text'] = row[4]
            order['update_datetime'] = row[5]
    disconnect(connection_)
    return order


def get_orders_by_user(user_id, status):
    connection_ = getconnect()
    orders = []
    with connection_.cursor() as cur:
        sql_select = 'select id, user_id, order_datetime_msk, status, status_text, ' \
                     'update_datetime_msk from orders where user_id = {} and status="{}" ' \
                     'order by id asc'.format(user_id, status)
        cur.execute(sql_select)
        cur.fetchall
        for row in cur:
            order = {}
            order['id'] = row[0]
            order['id_client'] = row[1]
            order['order_datetime_msk'] = row[2]
            order['status'] = row[3]
            order['status_text'] = row[4]
            order['update_datetime'] = row[5]
            orders.append(order)
    disconnect(connection_)
    return orders


def get_order_details(order_id):
    connection_ = getconnect()
    order_details = []
    with connection_.cursor() as cur:
        sql_select = 'select g.art, g.name, g.cost_text from orders_sku os left join goods g on ' \
                     'os.art_goods = g.art where os.id_orders = {}'.format(order_id)
        cur.execute(sql_select)
        cur.fetchall
        for row in cur:
            order = {}
            order['art'] = row[0]
            order['name'] = row[1]
            order['cost_text'] = row[2]
            order_details.append(order)
    disconnect(connection_)
    return order_details


def add_ice_to_order(order_id, ice_art):
    connection_ = getconnect()
    with connection_.cursor() as cur:
        sql_insert = 'insert into orders_sku (id_orders, art_goods) ' \
                     'values ({}, "{}")'.format(order_id, ice_art)
        cur.execute(sql_insert)
        connection_.commit()
    disconnect(connection_)


def delete_ice_from_order(order_id, ice_art):
    connection_ = getconnect()
    with connection_.cursor() as cur:
        sql_delete = 'select min(id) from orders_sku where ' \
                     'id_orders = {} and ' \
                     'art_goods = "{}"'.format(order_id, ice_art)
        cur.execute(sql_delete)
        cur.fetchall
        for row in cur:
            id = row[0]
        sql_delete = 'delete from orders_sku where id={}'.format(id)
        cur.execute(sql_delete)
        connection_.commit()
    disconnect(connection_)


def set_order_status(order_id, order_statuses_key):
    connection_ = getconnect()
    with connection_.cursor() as cur:
        sql = 'update orders set status = "{}", status_text = "{}" where id={}'.format(list(order_statuses.keys())[order_statuses_key], list(order_statuses.values())[order_statuses_key], order_id)
        cur.execute(sql)
        connection_.commit()
    disconnect(connection_)


def get_order_content_by_order_id(order_id):
    connection_ = getconnect()
    order_content = {}

    with connection_.cursor() as cur:
        sql_select = 'SELECT os.id, go.name, go.art, go.cost_text, go.url ' \
                     'FROM orders_sku os ' \
                     'left join orders fo on os.id_orders = fo.id ' \
                     'left join goods go on os.art_goods = go.art where fo.id ={}'.format(order_id)
        cur.execute(sql_select)
        cur.fetchall

        for row in cur:
            order_row = {}
            order_row['id']   = row[0]
            order_row['name'] = row[1]
            order_row['art']  = row[2]
            order_row['cost_text'] = row[3]
            order_row['url'] = row[4]
            order_content[order_row['id']] = order_row  ## ключом словаря является id из orders_sku

    disconnect(connection_)
    return order_content


def get_order_text(user):
    order = get_order_by_user(user['user_id'], list(order_statuses.keys())[0])
    order_content = get_order_content_by_order_id(order['id'])

    mess = []
    mess.append('Информация по заказу №: {}'.format(order['id']))
    mess.append(' | ')
    mess.append('Контактный телефон клиента: {}'.format(user['phone']))
    mess.append(' | ')
    mess.append('Содержимое заказа: ')

    for row in order_content.items():
        name = row[1]['name']
        sku = row[1]['sku']
        cost = row[1]['cost']
        mess.append('{} - {} руб.; SKU: {} | '.format(name, cost, sku, ))

    text = ''.join(mess)
    return text