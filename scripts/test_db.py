import os
import psycopg2
import pytest
from dotenv import load_dotenv

load_dotenv()

@pytest.fixture(scope="module")
def db_conn():
    conn = psycopg2.connect(
        host=os.getenv("DB_HOST"),
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