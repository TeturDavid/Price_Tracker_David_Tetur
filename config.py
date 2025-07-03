import mysql.connector

def get_db_connection():
    return mysql.connector.connect(
        host='mysql-pricetracker.alwaysdata.net',
        user='421084',
        password='heslo123',
        database='pricetracker_1',
        port=3306
    )