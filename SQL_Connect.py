import mysql.connector
from datetime import datetime
from decimal import Decimal
import bcrypt

from scraper import search_alza
from config import get_db_connection

# -------------------

def register_user(email, password):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT id FROM uzivatele WHERE email = %s", (email,))
    if cursor.fetchone():
        cursor.close()
        conn.close()
        return False, "Uživatel už existuje"

    hashed = bcrypt.hashpw(password.encode(), bcrypt.gensalt())

    cursor.execute("INSERT INTO uzivatele (email, password_hash) VALUES (%s, %s)", (email, hashed.decode()))
    conn.commit()
    cursor.close()
    conn.close()
    return True, "Registrace proběhla úspěšně"

def login_user(email, password):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT id, password_hash FROM uzivatele WHERE email = %s", (email,))
    user = cursor.fetchone()

    cursor.close()
    conn.close()

    if not user:
        return False, "Uživatel nenalezen"

    user_id, password_hash = user
    if bcrypt.checkpw(password.encode(), password_hash.encode()):
        return True, user_id
    else:
        return False, "Nesprávné heslo"

def get_user_email(user_id):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute('SELECT email FROM uzivatele WHERE id = %s', (user_id,))
    user = cursor.fetchone()

    cursor.close()
    conn.close()

    return user[0] if user else None

# -------------------

def add_product_to_wishlist(name, original_price, link, image_url, description, user_id):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT id FROM wishlist WHERE link = %s AND user_id = %s", (link, user_id))
    if cursor.fetchone():
        cursor.close()
        conn.close()
        return False

    cursor.execute("""
        INSERT INTO wishlist (name, original_price, current_price, link, last_checked, image_url, description, user_id)
        VALUES (%s, %s, %s, %s, NOW(), %s, %s, %s)
    """, (name, original_price, original_price, link, image_url, description, user_id))

    product_id = cursor.lastrowid
    conn.commit()

    add_price_history(product_id, original_price)

    cursor.close()
    conn.close()
    return True

def get_wishlist(user_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM wishlist WHERE user_id = %s ORDER BY current_price DESC", (user_id,))
    products = cursor.fetchall()

    cursor.close()
    conn.close()
    return products

def remove_from_wishlist(product_id, user_id):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute("DELETE FROM wishlist WHERE id = %s AND user_id = %s", (product_id, user_id))
    conn.commit()

    cursor.close()
    conn.close()

def get_product_by_id(product_id, user_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM wishlist WHERE id = %s AND user_id = %s", (product_id, user_id))
    product = cursor.fetchone()

    cursor.close()
    conn.close()
    return product

# -------------------

def add_price_history(product_id, price):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute("INSERT INTO price_history (product_id, price) VALUES (%s, %s)", (product_id, price))
    conn.commit()

    cursor.close()
    conn.close()

def get_price_history(product_id):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT price, timestamp FROM price_history 
        WHERE product_id = %s 
        ORDER BY timestamp ASC
    """, (product_id,))

    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    return [
        {"price": price, "time": timestamp.strftime('%d.%m.%Y %H:%M')}
        for price, timestamp in rows
    ]

def update_price():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT id, name, original_price, current_price, email_sent FROM wishlist")
    products = cursor.fetchall()

    for product in products:
        scraped_results = search_alza(product['name'], 1)
        if scraped_results:
            scraped = scraped_results[0]
            new_price = Decimal(str(scraped['current_price']))
            old_price = Decimal(str(product['current_price']))

            if new_price != old_price:
                cursor.execute("""
                    UPDATE wishlist 
                    SET current_price = %s, last_checked = NOW() 
                    WHERE id = %s
                """, (new_price, product['id']))

                conn.commit()
                add_price_history(product['id'], new_price)

    cursor.close()
    conn.close()
