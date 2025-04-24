import os
import psycopg2
from faker import Faker
import random
from dotenv import load_dotenv

load_dotenv()
fake = Faker()

# Load DB creds
raw_host = os.getenv("DB_HOST")
DB_HOST = raw_host.split(":")[0] if ":" in raw_host else raw_host
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

# --------------------- Schema Tables --------------------- #

def create_users(n=10):
    user_ids = []
    for _ in range(n):
        name = fake.name()
        email = fake.unique.email()
        cur.execute("INSERT INTO users (name, email) VALUES (%s, %s) RETURNING id", (name, email))
        user_ids.append(cur.fetchone()[0])
    return user_ids

def create_products(n=10):
    product_ids = []
    for _ in range(n):
        name = fake.word().capitalize()
        price = round(random.uniform(10.0, 500.0), 2)
        category = random.choice(['Books', 'Electronics', 'Clothing', 'Home'])
        cur.execute("INSERT INTO products (name, price, category) VALUES (%s, %s, %s) RETURNING id", (name, price, category))
        product_ids.append(cur.fetchone()[0])
    return product_ids

def create_addresses(user_ids):
    for user_id in user_ids:
        cur.execute("""
            INSERT INTO shipping_addresses (user_id, address_line, city, postal_code, country)
            VALUES (%s, %s, %s, %s, %s)
        """, (
            user_id,
            fake.street_address(),
            fake.city(),
            fake.postcode(),
            fake.country()
        ))

def create_orders(user_ids, product_ids):
    for user_id in user_ids:
        if random.random() > 0.7:
            continue  # Not every user places an order

        total = 0
        cur.execute("INSERT INTO orders (user_id, total_amount) VALUES (%s, %s) RETURNING id", (user_id, 0))
        order_id = cur.fetchone()[0]
        num_items = random.randint(1, 4)

        for _ in range(num_items):
            product_id = random.choice(product_ids)
            quantity = random.randint(1, 3)
            cur.execute("SELECT price FROM products WHERE id = %s", (product_id,))
            unit_price = cur.fetchone()[0]
            line_total = unit_price * quantity
            total += line_total

            cur.execute("""
                INSERT INTO order_items (order_id, product_id, quantity, unit_price)
                VALUES (%s, %s, %s, %s)
            """, (order_id, product_id, quantity, unit_price))

        cur.execute("UPDATE orders SET total_amount = %s WHERE id = %s", (total, order_id))

        # Add payment
        status = random.choice(['Completed', 'Pending', 'Failed'])
        cur.execute("""
            INSERT INTO payments (order_id, amount, status)
            VALUES (%s, %s, %s)
        """, (order_id, total, status))

# --------------------- Execution --------------------- #

user_ids = create_users(10)
product_ids = create_products(15)
create_addresses(user_ids)
create_orders(user_ids, product_ids)

conn.commit()
cur.close()
conn.close()

print("✅ Data inserted: users, products, addresses, orders, and payments.")
# Note: This script assumes that the database and tables already exist.