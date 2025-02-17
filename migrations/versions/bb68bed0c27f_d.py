"""d

Revision ID: bb68bed0c27f
Revises: c953f10f342c
Create Date: 2024-10-28 22:15:56.823647

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'bb68bed0c27f'
down_revision = 'c953f10f342c'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('tasks', schema=None) as batch_op:
        batch_op.alter_column('project_id',
               existing_type=sa.INTEGER(),
               nullable=True)
        batch_op.alter_column('status_id',
               existing_type=sa.INTEGER(),
               nullable=True)
        batch_op.alter_column('priority_id',
               existing_type=sa.INTEGER(),
               nullable=True)

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('tasks', schema=None) as batch_op:
        batch_op.alter_column('priority_id',
               existing_type=sa.INTEGER(),
               nullable=False)
        batch_op.alter_column('status_id',
               existing_type=sa.INTEGER(),
               nullable=False)
        batch_op.alter_column('project_id',
               existing_type=sa.INTEGER(),
               nullable=False)

    # ### end Alembic commands ###
