from flask_wtf import FlaskForm
from flask_wtf.file import FileAllowed
from wtforms import StringField, PasswordField, BooleanField, SubmitField
from wtforms.fields.choices import SelectField, RadioField, SelectMultipleField
from wtforms.fields.datetime import DateField
from wtforms.fields.numeric import IntegerField, FloatField
from wtforms.fields.simple import TextAreaField, FileField
from wtforms.validators import ValidationError, DataRequired, Email, EqualTo, Length, Optional, NumberRange, Regexp
import sqlalchemy as sa
from app import db
from app.models import User, Priority, Status, Project


class LoginForm(FlaskForm):
    username = StringField('Почта / Логин', validators=[DataRequired()])
    password = PasswordField('Пароль', validators=[DataRequired()])
    remember_me = BooleanField('Запомнить вход')
    submit = SubmitField('Войти')


class RegistrationForm(FlaskForm):
    username = StringField('Логин', validators=[
        DataRequired(message="Поле 'Логин' обязательно для заполнения."),
        Length(min=3, max=20, message="Логин должен быть от 3 до 20 символов.")
    ])
    email = StringField('Почта', validators=[
        DataRequired(message="Поле 'Почта' обязательно для заполнения."),
        Email(message="Введите корректный адрес электронной почты.")
    ])
    password = PasswordField('Пароль', validators=[
        DataRequired(message="Поле 'Пароль' обязательно для заполнения."),
        Length(min=8, message="Пароль должен быть не менее 8 символов."),
        Regexp(r'(?=.*\d)', message="Пароль должен содержать хотя бы одну цифру."),
        Regexp(r'(?=.*[a-z])', message="Пароль должен содержать хотя бы одну строчную букву."),
        Regexp(r'(?=.*[A-Z])', message="Пароль должен содержать хотя бы одну заглавную букву."),
        Regexp(r'(?=.*[!@#$%^&*(),.?":{}|<>])', message="Пароль должен содержать хотя бы один специальный символ.")
    ])
    password2 = PasswordField(
        'Повторите пароль',
        validators=[
            DataRequired(message="Поле 'Пароль' обязательно для заполнения."),
            EqualTo('password', message="Пароли должны совпадать.")
        ]
    )
    submit = SubmitField('Зарегистрироваться')

    def validate_username(self, username):
        user = db.session.scalar(sa.select(User).where(
            User.username == username.data))
        if user is not None:
            raise ValidationError('Пожалуйста, выберите другое имя пользователя.')

    def validate_email(self, email):
        user = db.session.scalar(sa.select(User).where(
            User.email == email.data))
        if user is not None:
            raise ValidationError('Пожалуйста, используйте другой адрес электронной почты.')


from flask_wtf import FlaskForm
from wtforms import StringField, TextAreaField, BooleanField, SubmitField, DateField
from flask_wtf.file import FileField, FileAllowed
from wtforms.validators import DataRequired, Length, Optional, Regexp


class EditProfileForm(FlaskForm):
    username = StringField('Имя пользователя', validators=[DataRequired()])
    first_name = StringField('Имя', validators=[Optional(), Length(1, 64)])
    last_name = StringField('Фамилия', validators=[Optional(), Length(1, 64)])
    phone_number = StringField('Номер телефона', validators=[
        Optional(),
        Regexp(r'^\+?\d{10,15}$', message="Введите корректный номер телефона, состоящий из 10 цифр")
    ])
    date_birth = DateField('Дата рождения', validators=[Optional()], format='%Y-%m-%d')
    about_me = TextAreaField('О себе', validators=[Length(min=0, max=140)])
    avatar = FileField('Загрузить аватар', validators=[FileAllowed(['jpg', 'png'], 'Только изображения!')])
    use_gravatar = BooleanField('Использовать Gravatar вместо загруженной аватарки')
    notify_birthday = BooleanField('Согласен(-на) на оповещения о моём дне рождения')
    submit = SubmitField('Сохранить изменения')

    def __init__(self, original_username, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.original_username = original_username


class ProjectForm(FlaskForm):
    title = StringField('Название', validators=[DataRequired()])
    description = TextAreaField('Описание', validators=[DataRequired()])
    status_id = SelectField('Статус', coerce=int, validators=[DataRequired()])
    priority_id = SelectField('Приоритет', coerce=int, validators=[DataRequired()])
    responsible_id = SelectField('Ответственный за проект', coerce=int, validators=[DataRequired()])
    submit = SubmitField('Создать проект')

    def populate_choices(self):
        self.status_id.choices = [(status.id, status.name) for status in Status.query.all()]
        self.priority_id.choices = [(priority.id, priority.level) for priority in Priority.query.all()]
        self.responsible_id.choices = [
            (user.id, f"{user.first_name or ''} {user.last_name or ''}".strip() or user.username)
            for user in User.query.all()
        ]


class TaskForm(FlaskForm):
    title = StringField('Название задачи', validators=[DataRequired()])
    description = TextAreaField('Описание', validators=[DataRequired()])
    status_id = SelectField('Статус', coerce=int, validators=[DataRequired()])
    priority_id = SelectField('Приоритет', coerce=int, validators=[DataRequired()])
    deadline = DateField('Срок выполнения', format='%Y-%m-%d', validators=[DataRequired()])
    submit = SubmitField('Создать задачу')

    def populate_choices(self):
        self.status_id.choices = [(status.id, status.name) for status in Status.query.all()]
        self.priority_id.choices = [(priority.id, priority.level) for priority in Priority.query.all()]


class UserForm(FlaskForm):
    username = StringField('Имя пользователя', validators=[DataRequired(), Length(min=3, max=64)])
    roles = SelectMultipleField('Роли', coerce=int)
    email = StringField('Email', validators=[DataRequired(), Email(), Length(max=120)])
    first_name = StringField('Имя', validators=[DataRequired(), Length(max=55)])
    last_name = StringField('Фамилия', validators=[DataRequired(), Length(max=55)])
    middle_name = StringField('Отчество', validators=[Optional(), Length(max=55)])
    phone_number = StringField('Телефон', validators=[Optional(), Length(max=55)])
    date_birth = DateField('Дата рождения', format='%Y-%m-%d', validators=[Optional()])
    about_me = TextAreaField('О себе', validators=[Optional(), Length(max=140)])
    avatar = StringField('URL аватара', validators=[Optional(), Length(max=255)])
    is_active = BooleanField('Активен')
    password = PasswordField('Пароль', validators=[DataRequired(),
                                                   Length(min=6, max=256)])
    submit = SubmitField('Сохранить')


class UserEditForm(FlaskForm):
    username = StringField('Имя пользователя', validators=[DataRequired(), Length(min=3, max=64)])
    roles = SelectMultipleField('Роли', coerce=int)
    email = StringField('Email', validators=[DataRequired(), Email(), Length(max=120)])
    first_name = StringField('Имя', validators=[Optional(), Length(max=55)])
    last_name = StringField('Фамилия', validators=[Optional(), Length(max=55)])
    middle_name = StringField('Отчество', validators=[Optional(), Length(max=55)])
    phone_number = StringField('Телефон', validators=[Optional(), Length(max=55)])
    date_birth = DateField('Дата рождения', format='%Y-%m-%d', validators=[Optional()])
    about_me = TextAreaField('О себе', validators=[Optional(), Length(max=140)])
    avatar = StringField('URL аватара', validators=[Optional(), Length(max=255)])
    is_active = BooleanField('Активен')
    password = PasswordField('Пароль', validators=[Optional(),
                                                   Length(min=6, max=256)])  # Необязательное поле для изменения пароля
    submit = SubmitField('Сохранить')


class RoleForm(FlaskForm):
    name = StringField('Название роли', validators=[DataRequired(), Length(min=3, max=64)])
    submit = SubmitField('Сохранить')


class StatusForm(FlaskForm):
    name = StringField('Название', validators=[DataRequired(), Length(max=50)])
    submit = SubmitField('Сохранить')


class PriorityForm(FlaskForm):
    level = StringField('Уровень', validators=[DataRequired(), Length(max=20)])
    submit = SubmitField('Сохранить')


class ProjectStatisticsForm(FlaskForm):
    project_id = SelectField('Проект', coerce=int, validators=[DataRequired()])
    tasks_total = IntegerField('Задачи всего', validators=[DataRequired(), NumberRange(min=0)])
    tasks_completed = IntegerField('Завершенные задачи', validators=[DataRequired(), NumberRange(min=0)])
    average_completion_time = FloatField('Среднее время завершения (часы)', validators=[Optional(), NumberRange(min=0)])
    submit = SubmitField('Сохранить')

    def populate_choices(self):
        # Заполняем выпадающий список с проектами
        self.project_id.choices = [(project.id, project.title) for project in Project.query.all()]


class ChatMessageForm(FlaskForm):
    chat_room_id = SelectField('Чат-комната', coerce=int, validators=[DataRequired()])
    user_id = SelectField('Пользователь', coerce=int, validators=[DataRequired()])
    content = TextAreaField('Сообщение', validators=[DataRequired()])
    submit = SubmitField('Сохранить')

    def populate_choices(self):
        from app.models import ChatRoom, User
        self.chat_room_id.choices = [(room.id, room.id) for room in ChatRoom.query.all()]
        self.user_id.choices = [(user.id, user.username) for user in User.query.all()]


class ChatRoomForm(FlaskForm):
    project_id = SelectField('Проект', coerce=int, validators=[DataRequired()], choices=[])
    task_id = SelectField('Задача', coerce=int, validators=[DataRequired()], choices=[])
    type = StringField('Тип комнаты', validators=[DataRequired()])
    choice = RadioField('Выберите', choices=[('project', 'Проект'), ('task', 'Задача')], validators=[DataRequired()])
    submit = SubmitField('Сохранить')

    def populate_choices(self):
        from app.models import Project, Task
        self.project_id.choices = [(p.id, p.title) for p in Project.query.all()]
        self.task_id.choices = [(t.id, t.title) for t in Task.query.all()]
