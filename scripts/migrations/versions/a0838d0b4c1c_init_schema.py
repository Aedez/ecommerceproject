"""init schema

Revision ID: a0838d0b4c1c
Revises: 
Create Date: 2025-04-21 19:30:06.576293

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'a0838d0b4c1c'
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade():
    op.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100),
            email VARCHAR(100) UNIQUE
        );
    """)
    op.execute("""
        CREATE TABLE IF NOT EXISTS products (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100),
            price NUMERIC(10, 2),
            category VARCHAR(50)
        );
    """)



def downgrade():
    op.execute("DROP TABLE IF EXISTS products;")
    op.execute("DROP TABLE IF EXISTS users;")