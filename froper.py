from selenium import webdriver
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
import re
import time

import dbwork2

debug = True
WebDriverWaitInSec = 30


def init_driver():
    binary = r'c:\Program Files (x86)\Mozilla Firefox\firefox.exe'
    options = Options()
    options.binary = binary
    cap = DesiredCapabilities().FIREFOX
    cap["marionette"] = True #optional
    return webdriver.Firefox(options=options, capabilities=cap, executable_path="c:\\geckodriver\\geckodriver.exe")


def iselementpresent(bywhat, key):
    try:
        driver.find_element(bywhat, key)
        return True
    except:
        return False


def findelementtext(bywhat, key):
    try:
        txt = driver.find_element(bywhat, key).text
        return txt
    except:
        return ""


def findelementattr(bywhat, key, attr):
    try:
        txt = driver.find_element(bywhat, key).get_attribute(attr)
        return txt
    except:
        return ""


def sleep(secs, place='whatever'):
    ttlsecs = secs
    while secs > 0:
        time.sleep(1)
        print('now: {} - {} of {} in {}'.format(time.datetime.datetime.now(), secs, ttlsecs, place))
        secs -= 1


def create_update_good(url, menuid):
    global driver2
    driver2.get(url)
    art = driver2.find_element_by_xpath('//*[@id="page"]/section/div[1]/div/article/div[2]/div[1]/div[1]').text

    costblocks = driver2.find_elements_by_xpath('//*[@id="page"]/section/div[1]/div/article/div[2]/div[2]')
    for costblock in costblocks:
        costtext = costblock.find_element_by_class_name('main').text

    #art = re.sub('\D', '', art)
    art = ''.join(i for i in art if i.isdigit())
    name = driver2.find_element_by_xpath('//*[@id="page"]/section/div[1]/div/article/div[2]/div[1]/h1').text
    dbwork2.create_update_good(art, name, url, menuid, costtext)
    print(name)
    print(art)
    print(url)
    print(menuid)


if __name__ == "__main__":
    driver = init_driver()
    driver2 = init_driver()
    driver.get('https://somesite.ru/')

    try:
        ## обновляем главное меню VVV
        dbwork2.delete_menus()
        menu_list = driver.find_elements_by_xpath('//*[@id="page"]/header/nav/div/div/ul')
        for menu in menu_list:
            links = menu.find_elements_by_tag_name('a')
            ind = 0
            for linkdata in links:
                if linkdata.text != '':
                    print(linkdata.text)
                    print(linkdata.get_attribute('href'))
                    dbwork2.create_update_goods_main_menu(ind, linkdata.text,
                                                          linkdata.get_attribute('href') + '?PAGE_EL_COUNT=ALL')
                    ind += 1
        ## обновляем главное меню AAA

        ## обновляем весь каталог по записям главного меню VVV
        dbwork2.delete_goods()

        goods_cat_links = dbwork2.return_main_menu_as_links()

        menuid = 0
        for goods_cat_link in goods_cat_links:
            driver.get(goods_cat_link)

            goods_container = driver.find_element_by_xpath('//*[@id="catalog-content"]/div[1]')
            links = goods_container.find_elements_by_tag_name('a')
            for link in links:
                url = link.get_attribute('href')
                if '?PAGE_EL_COUNT=ALL' not in url and 'javascript' not in url:
                    create_update_good(url, menuid)
                    print('time.sleep(1)')
                    time.sleep(1)
            menuid += 1

        ## обновляем весь каталог по записям главного меню AAA

    except Exception as e:
        print('Exception occurred in proc: {}'.format('froper_main'))
        print(e)
    finally:
        driver.quit()
        driver2.quit()
