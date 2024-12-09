"""nullable

Revision ID: e1f1231ecccd
Revises: d58d73f0f66a
Create Date: 2024-11-25 14:28:57.477812

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'e1f1231ecccd'
down_revision = 'd58d73f0f66a'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('projects', schema=None) as batch_op:
        batch_op.alter_column('priority_id',
               existing_type=sa.INTEGER(),
               nullable=True)

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('projects', schema=None) as batch_op:
        batch_op.alter_column('priority_id',
               existing_type=sa.INTEGER(),
               nullable=False)

    # ### end Alembic commands ###
