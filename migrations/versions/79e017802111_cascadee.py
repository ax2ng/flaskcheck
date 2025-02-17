"""cascadEE

Revision ID: 79e017802111
Revises: 11d6abd07e05
Create Date: 2024-12-07 16:30:46.608489

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '79e017802111'
down_revision = '11d6abd07e05'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('files', schema=None) as batch_op:
        batch_op.drop_constraint('files_project_id_fkey', type_='foreignkey')
        batch_op.create_foreign_key(None, 'projects', ['project_id'], ['id'], ondelete='CASCADE')

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('files', schema=None) as batch_op:
        batch_op.drop_constraint(None, type_='foreignkey')
        batch_op.create_foreign_key('files_project_id_fkey', 'projects', ['project_id'], ['id'])

    # ### end Alembic commands ###
