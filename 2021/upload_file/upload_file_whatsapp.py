import random
from selenium import webdriver
from os import getcwd, listdir, path

driver = webdriver.Chrome()
driver.get('https://web.whatsapp.com/')
driver.implicitly_wait(30)
driver.set_page_load_timeout(30)

nameList = ["Diogo","ruby","Python","QA Produtos","Qualidade como Cultura"]
dir = "{}\\arquivo\\".format(getcwd())

input('Enter anything after scanning QR code')

for name in nameList:
    files = [f for f in listdir(dir) if path.isfile(path.join(dir, f))]
    filepath = "{}\\arquivo\\{}".format(getcwd(), random.choice(files))

    driver.find_element_by_css_selector('#pane-side span[title*="{}"]'.format(name)).click()
    driver.find_element_by_css_selector('div[role=button] span[data-icon="clip"]').click()

    driver.find_element_by_xpath(
        '//input[@accept="image/*,video/mp4,video/3gpp,video/quicktime"]').send_keys(filepath)

    driver.find_element_by_css_selector("div[data-animate-media-caption='true'] div[class*='copyable-text selectable-text']").\
        send_keys("Feliz Ano Novo!!! Sucesso...")
    driver.find_element_by_css_selector('span[data-testid="send"]').click()
