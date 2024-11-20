from datetime import datetime, timezone
import sqlalchemy as sa
import sqlalchemy.orm as so
from flask_login import UserMixin

from app import db
from werkzeug.security import generate_password_hash, check_password_hash
from hashlib import md5


class User(UserMixin, db.Model):
    __tablename__ = 'users'
    id: so.Mapped[int] = so.mapped_column(primary_key=True)
    username: so.Mapped[str] = so.mapped_column(sa.String(64), index=True, unique=True)
    email: so.Mapped[str] = so.mapped_column(sa.String(120), index=True, unique=True)
    password_hash: so.Mapped[str] = so.mapped_column(sa.String(256))
    first_name: so.Mapped[str] = so.mapped_column(sa.String(55), nullable=True)
    last_name: so.Mapped[str] = so.mapped_column(sa.String(55), nullable=True)
    middle_name: so.Mapped[str] = so.mapped_column(sa.String(55), nullable=True)
    phone_number: so.Mapped[str] = so.mapped_column(sa.String(55), unique=True, nullable=True)
    date_birth: so.Mapped[datetime] = so.mapped_column(sa.Date, nullable=True)
    avatar: so.Mapped[str] = so.mapped_column(sa.String(255), nullable=True)
    avatar_url = db.Column(db.String(255), nullable=True)
    is_active: so.Mapped[bool] = so.mapped_column(default=True)
    creation_time: so.Mapped[datetime] = so.mapped_column(default=lambda: datetime.now(timezone.utc))
    about_me: so.Mapped[str] = so.mapped_column(sa.String(140), nullable=True)
    last_seen: so.Mapped[datetime] = so.mapped_column(default=lambda: datetime.now(timezone.utc))

    posts = so.relationship('Post', back_populates='author', lazy='dynamic')
    managed_projects = so.relationship('Project', back_populates='manager',
                                       foreign_keys='Project.manager_id',
                                       cascade='all, delete-orphan')
    responsible_projects = so.relationship('Project', back_populates='responsible_user',
                                           foreign_keys='Project.responsible_id')
    assigned_tasks = so.relationship('Task', secondary='task_executors', back_populates='executors')
    projects = so.relationship('Project', secondary='project_executors', back_populates='executors')
    roles = so.relationship('Role', secondary='user_roles', back_populates='users')

    def __repr__(self):
        return f'<User {self.username}>'

    def set_password(self, password: str):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password: str) -> bool:
        return check_password_hash(self.password_hash, password)

    def avatar(self, size: int = 128) -> str:
        if self.avatar_url:
            return f"{self.avatar_url}?s={size}"
        digest = md5(self.email.lower().encode('utf-8')).hexdigest()
        return f'https://www.gravatar.com/avatar/{digest}?d=monsterid&s={size}'

    def has_role(self, role_name):
        return any(role.name == role_name for role in self.roles)


class Role(db.Model):
    __tablename__ = 'roles'
    id: so.Mapped[int] = so.mapped_column(primary_key=True)
    name: so.Mapped[str] = so.mapped_column(sa.String(64), unique=True, nullable=False)

    users = so.relationship('User', secondary='user_roles', back_populates='roles')


class Project(db.Model):
    __tablename__ = 'projects'
    id: so.Mapped[int] = so.mapped_column(primary_key=True)
    title: so.Mapped[str] = so.mapped_column(sa.String(128), index=True)
    description: so.Mapped[str] = so.mapped_column(sa.String(500))
    start_date: so.Mapped[datetime] = so.mapped_column(default=lambda: datetime.now(timezone.utc))
    end_date: so.Mapped[datetime] = so.mapped_column(nullable=True)
    status_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey('statuses.id'), nullable=False)
    priority_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey('priorities.id'), nullable=False)
    created_at: so.Mapped[datetime] = so.mapped_column(default=lambda: datetime.now(timezone.utc))
    updated_at: so.Mapped[datetime] = so.mapped_column(default=lambda: datetime.now(timezone.utc),
                                                       onupdate=lambda: datetime.now(timezone.utc))

    manager_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey('users.id'))
    responsible_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey('users.id'), nullable=True)

    status = so.relationship('Status')
    priority = so.relationship('Priority')
    manager = so.relationship('User', back_populates='managed_projects', foreign_keys=[manager_id])
    responsible_user = so.relationship('User', back_populates='responsible_projects', foreign_keys=[responsible_id])
    executors = so.relationship('User', secondary='project_executors', back_populates='projects')
    tasks = so.relationship('Task', back_populates='project')


class ProjectStatistics(db.Model):
    __tablename__ = 'project_statistics'
    id: so.Mapped[int] = so.mapped_column(primary_key=True)
    project_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey('projects.id'), nullable=False)
    tasks_total: so.Mapped[int] = so.mapped_column(default=0)
    tasks_completed: so.Mapped[int] = so.mapped_column(default=0)
    average_completion_time: so.Mapped[float] = so.mapped_column(nullable=True)
    created_at: so.Mapped[datetime] = so.mapped_column(default=lambda: datetime.now(timezone.utc))
    updated_at: so.Mapped[datetime] = so.mapped_column(onupdate=lambda: datetime.now(timezone.utc))


class Status(db.Model):
    __tablename__ = 'statuses'
    id: so.Mapped[int] = so.mapped_column(primary_key=True)
    name: so.Mapped[str] = so.mapped_column(sa.String(50), unique=True, nullable=False)


class Priority(db.Model):
    __tablename__ = 'priorities'
    id: so.Mapped[int] = so.mapped_column(primary_key=True)
    level: so.Mapped[str] = so.mapped_column(sa.String(20), unique=True, nullable=False)


class File(db.Model):
    __tablename__ = 'files'
    id: so.Mapped[int] = so.mapped_column(primary_key=True)
    user_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey('users.id'), nullable=False)
    project_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey('projects.id'), nullable=True)
    task_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey('tasks.id'), nullable=True)
    chat_message_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey('chat_messages.id'), nullable=True)
    file_url: so.Mapped[str] = so.mapped_column(sa.String(255), nullable=False)
    upload_time: so.Mapped[datetime] = so.mapped_column(default=lambda: datetime.now(timezone.utc))


class ChatRoom(db.Model):
    __tablename__ = 'chat_rooms'
    id: so.Mapped[int] = so.mapped_column(primary_key=True)
    project_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey('projects.id'), nullable=True)
    task_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey('tasks.id'), nullable=True)
    created_at: so.Mapped[datetime] = so.mapped_column(default=lambda: datetime.now(timezone.utc))
    type: so.Mapped[str] = so.mapped_column(sa.String(50))
    messages: so.WriteOnlyMapped['ChatMessage'] = so.relationship('ChatMessage', back_populates='chat_room')


class ChatMessage(db.Model):
    __tablename__ = 'chat_messages'
    id: so.Mapped[int] = so.mapped_column(primary_key=True)
    chat_room_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey('chat_rooms.id'))
    user_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey('users.id'))
    content: so.Mapped[str] = so.mapped_column(sa.Text, nullable=True)
    timestamp: so.Mapped[datetime] = so.mapped_column(default=lambda: datetime.now(timezone.utc))

    chat_room = so.relationship('ChatRoom', back_populates='messages')
    user = so.relationship('User')
    files: so.WriteOnlyMapped['File'] = so.relationship('File', backref='chat_message')

    def __repr__(self):
        return f'<ChatMessage {self.id} from User {self.user_id}>'


class Task(db.Model):
    __tablename__ = 'tasks'
    id: so.Mapped[int] = so.mapped_column(primary_key=True)
    title: so.Mapped[str] = so.mapped_column(sa.String(128), index=True, nullable=False)
    description: so.Mapped[str] = so.mapped_column(sa.String(500), nullable=True)
    deadline: so.Mapped[datetime] = so.mapped_column(nullable=True)
    project_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey('projects.id'), nullable=True)
    status_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey('statuses.id'), nullable=True)
    priority_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey('priorities.id'), nullable=True)
    created_at: so.Mapped[datetime] = so.mapped_column(default=lambda: datetime.now(timezone.utc))

    project = so.relationship('Project', back_populates='tasks')
    executors = so.relationship('User', secondary='task_executors', back_populates='assigned_tasks')
    status = so.relationship('Status')
    priority = so.relationship('Priority')


class Post(db.Model):
    __tablename__ = 'posts'
    id: so.Mapped[int] = so.mapped_column(primary_key=True)
    body: so.Mapped[str] = so.mapped_column(sa.String(140), nullable=True)
    timestamp: so.Mapped[datetime] = so.mapped_column(default=lambda: datetime.now(timezone.utc), index=True)
    user_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey('users.id'))

    author = so.relationship('User', back_populates='posts')


# Таблицы для связей многих ко многим
project_executors = db.Table(
    'project_executors',
    db.Column('user_id', db.Integer, db.ForeignKey('users.id'), primary_key=True),
    db.Column('project_id', db.Integer, db.ForeignKey('projects.id'), primary_key=True)
)

task_executors = db.Table(
    'task_executors',
    db.Column('user_id', db.Integer, db.ForeignKey('users.id'), primary_key=True),
    db.Column('task_id', db.Integer, db.ForeignKey('tasks.id'), primary_key=True)
)

user_roles = db.Table(
    'user_roles',
    db.Column('user_id', db.Integer, db.ForeignKey('users.id'), primary_key=True),
    db.Column('role_id', db.Integer, db.ForeignKey('roles.id'), primary_key=True)
)
