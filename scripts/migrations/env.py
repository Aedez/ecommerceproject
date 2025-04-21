import os
from dotenv import load_dotenv
from logging.config import fileConfig

from sqlalchemy import engine_from_config, pool
from alembic import context

# Load environment variables
load_dotenv()

# Read .env vars
DB_URL = f"postgresql+psycopg2://{os.getenv('DB_USER')}:{os.getenv('DB_PASS')}@{os.getenv('DB_HOST')}/{os.getenv('DB_NAME')}"

# Set the Alembic config
config = context.config
fileConfig(config.config_file_name)

# Override sqlalchemy.url with dynamic .env value
config.set_main_option("sqlalchemy.url", DB_URL)

target_metadata = None  # Add SQLAlchemy metadata if you use models

def run_migrations_offline():
    context.configure(url=DB_URL, literal_binds=True)
    with context.begin_transaction():
        context.run_migrations()

def run_migrations_online():
    connectable = engine_from_config(
        config.get_section(config.config_ini_section),
        prefix="sqlalchemy.",
        poolclass=pool.NullPool,
    )

    with connectable.connect() as connection:
        context.configure(connection=connection)
        with context.begin_transaction():
            context.run_migrations()

if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()
