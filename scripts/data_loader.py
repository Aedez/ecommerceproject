import os
import psycopg2
from faker import Faker
import random
from dotenv import load_dotenv

# Load .env variables
load_dotenv()

fake = Faker()

DB_HOST = os.getenv("DB_HOST")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASS = os.getenv("DB_PASS")

conn = psycopg2.connect(
    host=DB_HOST,
    dbname=DB_NAME,
    user=DB_USER,
    password=DB_PASS
)

cur = conn.cursor()

# Create schema tables if not exist
cur.execute("""
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE
);
""")

cur.execute("""
CREATE TABLE IF NOT EXISTS products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  price NUMERIC(10, 2),
  category VARCHAR(50)
);
""")
conn.commit()

def create_users(n=10):
    for _ in range(n):
        name = fake.name()
        email = fake.unique.email()
        cur.execute("INSERT INTO users (name, email) VALUES (%s, %s)", (name, email))

def create_products(n=10):
    for _ in range(n):
        name = fake.word().capitalize()
        price = round(random.uniform(10.0, 500.0), 2)
        category = random.choice(['Books', 'Electronics', 'Clothing', 'Home'])
        cur.execute("INSERT INTO products (name, price, category) VALUES (%s, %s, %s)", (name, price, category))

create_users()
create_products()
conn.commit()

cur.close()
conn.close()

print("✅ Sample data inserted.")
