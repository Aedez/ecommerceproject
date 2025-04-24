import os
import psycopg2
import pytest
from dotenv import load_dotenv

load_dotenv()

@pytest.fixture
def db_conn():
    raw_host = os.getenv("DB_HOST")
    host = raw_host.split(":")[0] if ":" in raw_host else raw_host

    conn = psycopg2.connect(
        host=host,
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASS")
    )
    yield conn
    conn.close()


def test_user_table_exists(db_conn):
    with db_conn.cursor() as cur:
        cur.execute("SELECT to_regclass('public.users')")
        assert cur.fetchone()[0] == 'users'

def test_product_count(db_conn):
    with db_conn.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM products")
        assert cur.fetchone()[0] >= 10

def test_orders_exist(db_conn):
    with db_conn.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM orders")
        assert cur.fetchone()[0] >= 1

def test_order_items_match_orders(db_conn):
    with db_conn.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM order_items")
        items = cur.fetchone()[0]
        cur.execute("SELECT COUNT(*) FROM orders")
        orders = cur.fetchone()[0]
        assert items >= orders

def test_payments_exist_and_linked(db_conn):
    with db_conn.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM payments")
        assert cur.fetchone()[0] >= 1

        cur.execute("""
            SELECT COUNT(*) FROM payments p
            LEFT JOIN orders o ON p.order_id = o.id
            WHERE o.id IS NULL
        """)
        assert cur.fetchone()[0] == 0

def test_shipping_addresses_exist(db_conn):
    with db_conn.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM shipping_addresses")
        assert cur.fetchone()[0] >= 1

        cur.execute("""
            SELECT COUNT(*) FROM shipping_addresses s
            LEFT JOIN users u ON s.user_id = u.id
            WHERE u.id IS NULL
        """)
        assert cur.fetchone()[0] == 0
