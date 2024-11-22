from flask_wtf import FlaskForm
from flask_wtf.file import FileAllowed
from wtforms import StringField, PasswordField, BooleanField, SubmitField
from wtforms.fields.choices import SelectField
from wtforms.fields.datetime import DateField
from wtforms.fields.numeric import IntegerField, FloatField
from wtforms.fields.simple import TextAreaField, FileField
from wtforms.validators import ValidationError, DataRequired, Email, EqualTo, Length, Optional, NumberRange
import sqlalchemy as sa
from app import db
from app.models import User, Priority, Status, Project


class LoginForm(FlaskForm):
    username = StringField('Почта / Логин', validators=[DataRequired()])
    password = PasswordField('Пароль', validators=[DataRequired()])
    remember_me = BooleanField('Запомнить вход')
    submit = SubmitField('Войти')


class RegistrationForm(FlaskForm):
    username = StringField('Логин', validators=[DataRequired()])
    email = StringField('Почта', validators=[DataRequired(), Email()])
    password = PasswordField('Пароль', validators=[DataRequired()])
    password2 = PasswordField(
        'Повторите пароль', validators=[DataRequired(), EqualTo('password')])
    submit = SubmitField('Зарегистрироваться')

    def validate_username(self, username):
        user = db.session.scalar(sa.select(User).where(
            User.username == username.data))
        if user is not None:
            raise ValidationError('Please use a different username.')

    def validate_email(self, email):
        user = db.session.scalar(sa.select(User).where(
            User.email == email.data))
        if user is not None:
            raise ValidationError('Please use a different email address.')


class EditProfileForm(FlaskForm):
    username = StringField('Имя пользователя', validators=[DataRequired()])
    about_me = TextAreaField('О себе', validators=[Length(min=0, max=140)])
    avatar = FileField('Загрузить аватар', validators=[FileAllowed(['jpg', 'png'], 'Только изображения!')])
    use_gravatar = BooleanField('Использовать Gravatar вместо загруженной аватарки')
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
        self.responsible_id.choices = [(user.id, f'{user.first_name} {user.last_name}') for user in User.query.all()]


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
    email = StringField('Email', validators=[DataRequired(), Email(), Length(max=120)])
    first_name = StringField('Имя', validators=[DataRequired(), Length(max=55)])
    last_name = StringField('Фамилия', validators=[DataRequired(), Length(max=55)])
    middle_name = StringField('Отчество', validators=[Optional(), Length(max=55)])
    phone_number = StringField('Телефон', validators=[Optional(), Length(max=55)])
    date_birth = DateField('Дата рождения', format='%Y-%m-%d', validators=[Optional()])
    about_me = TextAreaField('О себе', validators=[Optional(), Length(max=140)])
    avatar = StringField('URL аватара', validators=[Optional(), Length(max=255)])
    is_active = BooleanField('Активен')
    password = PasswordField('Пароль', validators=[Optional(), Length(min=6, max=256)])  # Необязательное поле для изменения пароля
    submit = SubmitField('Сохранить')

class RoleForm(FlaskForm):
    name = StringField('Название роли', validators=[DataRequired(), Length(min=3, max=64)])
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