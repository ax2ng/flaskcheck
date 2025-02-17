"""nullable

Revision ID: ca7e3a19b1f7
Revises: 54304cf7ff4a
Create Date: 2024-10-27 19:58:29.382471

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'ca7e3a19b1f7'
down_revision = '54304cf7ff4a'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('posts', schema=None) as batch_op:
        batch_op.alter_column('body',
               existing_type=sa.VARCHAR(length=140),
               nullable=True)

    with op.batch_alter_table('projects', schema=None) as batch_op:
        batch_op.alter_column('description',
               existing_type=sa.VARCHAR(length=500),
               nullable=True)
        batch_op.alter_column('manager_id',
               existing_type=sa.INTEGER(),
               nullable=True)
        batch_op.alter_column('responsible_id',
               existing_type=sa.INTEGER(),
               nullable=True)

    with op.batch_alter_table('tasks', schema=None) as batch_op:
        batch_op.alter_column('description',
               existing_type=sa.VARCHAR(length=500),
               nullable=True)

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('tasks', schema=None) as batch_op:
        batch_op.alter_column('description',
               existing_type=sa.VARCHAR(length=500),
               nullable=False)

    with op.batch_alter_table('projects', schema=None) as batch_op:
        batch_op.alter_column('responsible_id',
               existing_type=sa.INTEGER(),
               nullable=False)
        batch_op.alter_column('manager_id',
               existing_type=sa.INTEGER(),
               nullable=False)
        batch_op.alter_column('description',
               existing_type=sa.VARCHAR(length=500),
               nullable=False)

    with op.batch_alter_table('posts', schema=None) as batch_op:
        batch_op.alter_column('body',
               existing_type=sa.VARCHAR(length=140),
               nullable=False)

    # ### end Alembic commands ###
