import schedule
import time
import os
from datetime import datetime
from SQL_Connect import update_price

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

def log(message):
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    report = f"{message} {timestamp}"
    print(report)
    log_path = os.path.join(BASE_DIR, "update_log.txt")
    with open(log_path, "a", encoding="utf-8") as f:
        f.write(report + "\n")

def run_update():
    log("spouštím updater v: ")
    try:
        update_price()
        log("Update proběhl v pořádku ✅")
    except Exception as e:
        log(f"Update selhal ❌ - chyba: {e}")

schedule.every(2).hours.do(run_update)

while True:
    schedule.run_pending()
    time.sleep(300)