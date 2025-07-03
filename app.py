from flask import Flask, render_template, request, redirect, url_for, flash, session
from scraper import search_alza, scrape_alza_product
from flask_mail import Mail, Message
from SQL_Connect import (
    add_product_to_wishlist, get_wishlist, remove_from_wishlist,
    get_product_by_id, get_price_history,
    register_user, login_user, get_user_email, get_db_connection
)
import re
from datetime import timedelta
from decimal import Decimal
from functools import wraps

# ------------------- Flask Setup -------------------

app = Flask(__name__)
app.secret_key = 'muj_tajny_klic'
app.permanent_session_lifetime = timedelta(minutes=10)

# ------------------- Mail Config -------------------

app.config.update(
    MAIL_SERVER='smtp.seznam.cz',
    MAIL_PORT=587,
    MAIL_USE_TLS=True,
    MAIL_USERNAME='price_tracker@seznam.cz',
    MAIL_PASSWORD='hroch123',
    MAIL_DEFAULT_SENDER='price_tracker@seznam.cz'
)
mail = Mail(app)

# ------------------- Email Function -------------------

def poslat_email_sleva(user_email, produkt_nazev, sleva, produkt_link):
    msg = Message(
        subject="Velká sleva na produkt!",
        recipients=[user_email],
        body=f"Ahoj! Produkt '{produkt_nazev}' ('{produkt_link}') má nyní slevu {sleva:.1f}%. Mrkni na to!"
    )
    mail.send(msg)

# ------------------- Auth Routes -------------------

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        success, msg = register_user(email, password)
        if success:
            flash('Registrace proběhla úspěšně, přihlaste se prosím.', 'success')
            return redirect(url_for('login'))
        else:
            flash(msg, 'error')
    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        success, user_id_or_msg = login_user(email, password)
        if success:
            session.permanent = True
            session['user_id'] = user_id_or_msg
            flash('Přihlášení proběhlo úspěšně.', 'success')
            return redirect(url_for('home'))
        else:
            flash(user_id_or_msg, 'error')
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.pop('user_id', None)
    flash('Byl jste odhlášen.', 'info')
    return redirect(url_for('login'))

# ------------------- Login Decorator -------------------

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user_id' not in session:
            flash("Pro přístup na tuto stránku se musíte přihlásit.", "error")
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function

# ------------------- Wishlist Home -------------------

@app.route('/')
@login_required
def home():
    user_id = session['user_id']
    wishlist_produkty = get_wishlist(user_id=user_id)
    search_query = request.args.get('wishlist_search', '').strip().lower()

    if search_query:
        wishlist_produkty = [
            produkt for produkt in wishlist_produkty
            if search_query in produkt['name'].lower()
        ]

    user_email = get_user_email(user_id)

    for produkt in wishlist_produkty:
        original_cena = Decimal(str(produkt['original_price']))
        current = Decimal(str(produkt['current_price']))
        if original_cena > 0:
            rozdil = ((original_cena - current) / original_cena) * Decimal(100)
            produkt['rozdil_ceny'] = round(rozdil, 2)
            produkt_link = produkt['link']

            if rozdil >= float(20) and not produkt.get('email_sent'):
                poslat_email_sleva(user_email, produkt['name'], rozdil, produkt_link)
                conn = get_db_connection()
                cursor = conn.cursor()
                cursor.execute("UPDATE wishlist SET email_sent = TRUE WHERE id = %s", (produkt['id'],))
                conn.commit()
                cursor.close()
                conn.close()

            if rozdil <= float(20) and produkt.get('email_sent'):
                conn = get_db_connection()
                cursor = conn.cursor()
                cursor.execute("UPDATE wishlist SET email_sent = FALSE WHERE id = %s", (produkt['id'],))
                conn.commit()
                cursor.close()
                conn.close()
        else:
            produkt['rozdil_ceny'] = 0.0

    return render_template('vyhledavac.html', wishlist=wishlist_produkty, user_email=user_email)

# ------------------- Vyhledávání produktů -------------------

@app.route('/search_alza', methods=['POST'])
@login_required
def alza():
    produkt_or_query = request.form['produkt']
    max_results = int(request.form.get('max_results', 5))

    if re.match(r'^https?://', produkt_or_query):
        produkt = scrape_alza_product(produkt_or_query)
        if not produkt:
            return "Produkt se nepodařilo načíst.", 500
        return render_template('vysledek_url.html', produkt=produkt)
    else:
        results = search_alza(produkt_or_query, max_results=max_results)
        return render_template('vysledek.html', results=results, produkt=produkt_or_query, max_results=max_results)

# ------------------- Přidání do wishlistu -------------------

@app.route('/pridatwishlist')
@login_required
def pridat_wishlist():
    user_id = session['user_id']
    try:
        name = request.args.get('name')
        link = request.args.get('link')
        original_price = float(request.args.get('price'))
        image_url = request.args.get('image_url')
        description = request.args.get('description')

        success = add_product_to_wishlist(name, original_price, link, image_url, description, user_id=user_id)

        if success:
            flash(f"✅ Produkt „{name}“ byl úspěšně přidán do wishlistu.", "success")
        else:
            flash(f"⚠️ Produkt „{name}“ už je v wishlistu a nebyl znovu přidán.", "warning")

    except Exception as e:
        flash(f"❌ Nepodařilo se přidat produkt: {e}", "error")

    return redirect(url_for('home'))

# ------------------- Odebrání z wishlistu -------------------

@app.route('/odstranitzwishlistu')
@login_required
def odstranit_z_wishlistu():
    user_id = session['user_id']
    product_id = request.args.get('id')
    if product_id:
        remove_from_wishlist(product_id, user_id=user_id)
    return redirect(url_for('home'))

# ------------------- Detail produktu -------------------

@app.route('/produkt/<int:id>')
@login_required
def detail_produktu(id):
    user_id = session['user_id']
    produkt = get_product_by_id(id, user_id=user_id)
    historie = get_price_history(id)
    if not produkt:
        flash("Produkt nebyl nalezen nebo nemáte přístup.", "error")
        return redirect(url_for('home'))
    return render_template("produkt_detail.html", produkt=produkt, historie=historie)

# ------------------- Spuštění aplikace -------------------

if __name__ == '__main__':
    app.run()
