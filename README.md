
# 🏷️ Price Tracker

Webová aplikace pro sledování vývoje cen produktů. Umožňuje registrovaným uživatelům přidávat produkty, sledovat jejich historické ceny a dostávat upozornění na změny.

## 🧰 Funkcionalita

- Registrace / přihlášení uživatele
- Přehled všech sledovaných produktů
- Detaily jednotlivých produktů včetně cenové historie
- Pravidelné aktualizace cen pomocí scraperu

## 📁 Struktura projektu

```
PRICE_TRACKER/
├── static/                  # Statické soubory (CSS, favicon)
│   ├── detail_style.css
│   ├── login.css
│   ├── favicon.webp
│   ├── vyhledavac_style.css
│   ├── vysledek_style.css
│   ├── vysledek_url.css
│
├── templates/               # HTML šablony
│   ├── alert.html
│   ├── login.html
│   ├── produkt_detail.html
│   ├── register.html
│   ├── vyhledavac.html
│   ├── vysledek.html
│   ├── vysledek_url.html
│
├── app.py                   # Flask aplikace
├── SQL_Connect.py           # Připojení k databázi
├── price_tracker.sql        # SQL skript pro vytvoření DB
├── scraper.py               # Skript pro stahování cen
├── updater.py               # Hlavní update logiky
├── updater.vbs              # Spouštěcí skript pro Windows
├── update_log.txt           # Záznam změn v cenách
```

## 🛠️ Instalace a spuštění

### 1. Klonování repozitáře

```bash
git clone https://github.com/tvoje-jmeno/price-tracker.git
cd price-tracker
```

### 2. Instalace závislostí

```bash
pip install flask requests beautifulsoup4
```

### 3. Inicializace databáze

Spusť:
```bash
sqlite3 price_tracker.db < price_tracker.sql
```

### 4. Spuštění aplikace

```bash
python app.py
```

Aplikace poběží na `http://127.0.0.1:5000`

## 👤 Testovací účet

Pro otestování aplikace se můžeš přihlásit jako:

- **Email:** `guest@seznam.cz`
- **Heslo:** `pricetracker1`

## ⏱️ Automatické aktualizace cen

Pro pravidelné aktualizace spusť:
```bash
python updater.py
```

Volitelně na Windows můžeš naplánovat `updater.vbs` do Plánovače úloh.

---

### ✨ Funkce aplikace

-Uživatel může do vyhledávacího pole zadat klíčové slovo nebo přímý odkaz z webu Alza.cz.

-Aplikace zobrazí 9 až 30 produktů odpovídajících dotazu.

-U každého produktu může uživatel kliknout na „Sledovat“, čímž se produkt uloží do databáze pod jeho e-mail.

Pro sledované produkty lze:

-Zobrazit detailní informace

-Zobrazit graf s historií cen

-Pokud cena sledovaného produktu klesne o více než 20 %, aplikace odešle upozornění e-mailem s odkazem na produkt a výší slevy.