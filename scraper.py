from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
import mysql.connector
import re
import time
from decimal import Decimal

def search_alza(produkt, max_results):
    options = Options()
    options.add_argument("--headless")
    options.add_argument("--disable-blink-features=AutomationControlled")
    options.add_argument("user-agent=Mozilla/5.0")

    driver = webdriver.Chrome(options=options)
    driver.get(f"https://www.alza.cz/search.htm?exps={produkt}")

    produkty = []
    items = driver.find_elements(By.CLASS_NAME, "browsingitem")

    for i, item in enumerate(items, 1):
        if i > max_results:
            break
        try:
            name_elem = item.find_element(By.CSS_SELECTOR, "a.name.browsinglink.js-box-link")
            price_elem = item.find_element(By.CSS_SELECTOR, "span.price-box__primary-price__value.js-price-box__primary-price__value")
            link = name_elem.get_attribute("href")
            desc_elem = item.find_element(By.CSS_SELECTOR, "div.Description")

            name = name_elem.text.strip()
            price_raw = price_elem.text.strip()
            desc = desc_elem.text.strip()

            # Čištění ceny
            match = re.search(r"\d{1,3}(?: \d{3})*,-", price_raw)
            price_clean = match.group(0) if match else price_raw
            price_number = float(price_clean.replace(" ", "").replace(",-", "").replace(",", "."))

            try:
                img_elem = item.find_element(By.CSS_SELECTOR, "img")
                srcset = img_elem.get_attribute("srcset")
                if srcset:
                    img_url = srcset.split(",")[0].strip().split(" ")[0]
                else:
                    img_url = img_elem.get_attribute("src")
            except Exception:
                img_url = None

            produkty.append({
                "name": name,
                "original_price": price_number,
                "current_price": Decimal(str(price_number)),
                "link": link,
                "image_url": img_url,
                "description": desc
            })

        except Exception as e:
            print(f"Chyba u produktu {i}: {e}")
            continue

    driver.quit()
    return produkty


def scrape_alza_product(url):
    print("Spouštím prohlížeč...")
    options = Options()
    options.add_argument("--headless")
    options.add_argument("--disable-blink-features=AutomationControlled")
    options.add_argument("user-agent=Mozilla/5.0")

    driver = webdriver.Chrome(options=options)
    print(f"Načítám URL: {url}")
    driver.get(url)
    print("Čekám 3 vteřiny na načtení stránky...")
    time.sleep(3)

    try:
        print("Hledám název produktu...")
        name_elem = driver.find_element(By.CLASS_NAME, "h1-placeholder")
        name = name_elem.text.strip()
        price_elem = driver.find_element(By.CSS_SELECTOR, "span.price-box__primary-price__value.js-price-box__primary-price__value")
        desc_elem = driver.find_element(By.CSS_SELECTOR, "div.nameextc span")

        price_raw = price_elem.text.strip()
        desc = desc_elem.text.strip()
        
        match = re.search(r"\d{1,3}(?:\s?\d{3})*,-", price_raw)
        price_clean = match.group(0) if match else price_raw
        price_number = float(price_clean.replace(" ", "").replace(",-", "").replace(",", "."))        
        print(f"Číslo ceny: {price_number}")

        print("Hledám obrázek produktu...")

        img_url = None

        imgs = driver.find_elements(By.TAG_NAME, "img")
        for img in imgs:
            alt = img.get_attribute("alt")
            if alt and "hlavní obrázek" in alt.lower():
                img_url = img.get_attribute("src")
                break

        if not img_url:
            group_imgs = driver.find_elements(By.CSS_SELECTOR, 'img.group-image[height="70"][width="70"]')
            if group_imgs:
                img_url = group_imgs[0].get_attribute("src")

        if img_url:
            print(f"Nalezený obrázek: {img_url}")
        else:
            print("Obrázek produktu nenalezen.")

        produkt = {
            "name": name,
            "original_price": price_number,
            "current_price": price_number,
            "link": url,
            "image_url": img_url,
            "description": desc
        }

        return produkt

    except Exception as e:
        print(f"Chyba při načítání produktu: {e}")
        return None

    finally:
        driver.quit()
        print("Prohlížeč ukončen.")