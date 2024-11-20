import os
import shutil
import sqlite3
import subprocess
from datetime import datetime, timezone
from flask import render_template, flash, url_for, request, redirect, send_file, session, jsonify
from flask_login import current_user, login_user, logout_user, login_required
import sqlalchemy as sa
from urllib.parse import urlsplit

from werkzeug.utils import secure_filename

from app import app, db
from app.forms import LoginForm, RegistrationForm, EditProfileForm, ProjectForm, TaskForm, UserForm, RoleForm, \
    ProjectStatisticsForm
from app.models import User, Project, Task, Role, Status, Priority, ProjectStatistics


# Главная страница приложения
@app.route('/')
def preindex():
    return render_template('preindex.html', title='Добро пожаловать!', is_login=True)


@app.route('/index')
@login_required
def index():
    projects = Project.query.filter_by(manager_id=current_user.id).all()
    return render_template('index.html', projects=projects)


# Профиль пользователя
@app.route('/user/<username>')
@login_required
def user(username):
    user = db.first_or_404(sa.select(User).where(User.username == username))
    projects = Project.query.filter_by(manager_id=user.id).all()
    return render_template('user.html', title='Профиль', user=user, projects=projects)


# Авторизация
@app.route('/login', methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('index'))
    form = LoginForm()
    if form.validate_on_submit():
        user = db.session.scalar(
            sa.select(User).where(User.username == form.username.data))
        if user is None or not user.check_password(form.password.data):
            flash('Invalid username or password')
            return redirect(url_for('login'))
        login_user(user, remember=form.remember_me.data)
        next_page = request.args.get('next')
        if not next_page or urlsplit(next_page).netloc != '':
            next_page = url_for('index')
        return redirect(next_page)
    return render_template('login.html', title='Авторизация', form=form, is_login=True)


# Регистрация
@app.route('/register', methods=['GET', 'POST'])
def register():
    if current_user.is_authenticated:
        return redirect(url_for('index'))
    form = RegistrationForm()
    if form.validate_on_submit():
        user = User(username=form.username.data, email=form.email.data)
        user.set_password(form.password.data)
        db.session.add(user)
        db.session.commit()
        flash('Поздравляю, теперь вы зарегистрированный пользователь!')
        return redirect(url_for('login'))
    return render_template('register.html', title='Регистрация', form=form, is_login=True)


@app.route('/edit_profile', methods=['GET', 'POST'])
@login_required
def edit_profile():
    form = EditProfileForm(current_user.username)
    if form.validate_on_submit():
        current_user.username = form.username.data
        current_user.about_me = form.about_me.data

        # Обработка загрузки аватара
        if form.avatar.data:
            avatar_file = form.avatar.data
            filename = secure_filename(avatar_file.filename)
            filepath = os.path.join('static/uploads/avatars', filename)
            avatar_file.save(filepath)

            # Сохраняем путь к аватарке
            current_user.avatar_url = url_for('static', filename=f'uploads/avatars/{filename}')

        db.session.commit()
        flash('Изменения были успешно сохранены!')
        return redirect(url_for('edit_profile'))
    elif request.method == 'GET':
        form.username.data = current_user.username
        form.about_me.data = current_user.about_me
    return render_template('edit_profile.html', title='Редактирование профиля', form=form)


# Выход из аккаунта
@app.route('/logout')
def logout():
    logout_user()
    flash('Вы успешно вышли из аккаунта.', 'success')
    return redirect(url_for('preindex'))


# Обновление времени последнего действия пользователя
@app.before_request
def before_request():
    if current_user.is_authenticated:
        current_user.last_seen = datetime.now(timezone.utc)
        db.session.commit()


# Страница проекта
@app.route('/project/<int:project_id>')
@login_required
def project_detail(project_id):
    project = Project.query.get_or_404(project_id)
    if project.manager_id != current_user.id and project.responsible_id != current_user.id:
        flash("You don't have permission to view this project.")
        return redirect(url_for('index'))
    tasks = Task.query.filter_by(project_id=project_id).all()
    return render_template('project_detail.html', project=project, tasks=tasks)


# Страница задачи
@app.route('/task/<int:task_id>')
@login_required
def task_detail(task_id):
    task = Task.query.get_or_404(task_id)
    project = Project.query.get(task.project_id)
    if project.manager_id != current_user.id and project.responsible_id != current_user.id:
        flash("You don't have permission to view this task.")
        return redirect(url_for('index'))
    return render_template('task_detail.html', task=task)


@app.route('/create_project', methods=['GET', 'POST'])
@login_required
def create_project():
    form = ProjectForm()
    form.populate_choices()  # Загружаем данные в выборы формы
    if form.validate_on_submit():
        project = Project(
            title=form.title.data,
            description=form.description.data,
            status_id=form.status_id.data,
            priority_id=form.priority_id.data,
            manager_id=current_user.id,
            responsible_id=form.responsible_id.data
        )
        db.session.add(project)
        db.session.commit()
        flash("Проект успешно создан.")
        return redirect(url_for('index'))
    return render_template('create_project.html', form=form)


@app.route('/create_task/<int:project_id>', methods=['GET', 'POST'])
@login_required
def create_task(project_id):
    project = Project.query.get_or_404(project_id)
    if project.manager_id != current_user.id and project.responsible_id != current_user.id:
        flash("You don't have permission to add tasks to this project.")
        return redirect(url_for('project_detail', project_id=project_id))
    form = TaskForm()
    form.populate_choices()
    if form.validate_on_submit():
        task = Task(
            title=form.title.data,
            description=form.description.data,
            project_id=project_id,
            status_id=form.status_id.data,
            priority_id=form.priority_id.data,
            deadline=form.deadline.data
        )
        db.session.add(task)
        db.session.commit()
        flash("Задача успешно создана.")
        return redirect(url_for('project_detail', project_id=project_id))
    return render_template('create_task.html', form=form, project=project)


# # ADMIN
# ALLOWED_EXTENSIONS = {'sql'}
#
#
# def allowed_file(filename):
#     return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS
#
# @app.route('/admin/backup', methods=['GET'])
# def backup_database():
#     if not current_user.has_role('admin'):
#         flash('У вас нет доступа к этой функции', 'error')
#         return redirect(url_for('index'))
#
#     db_path = app.config['SQLALCHEMY_DATABASE_URI'].replace('sqlite:///', '')
#     backup_dir = os.path.join(os.getcwd(), "backups")
#     backup_filename = f"backup_{datetime.now().strftime('%Y%m%d_%H%M%S')}.sql"
#     backup_path = os.path.join(backup_dir, backup_filename)
#
#     os.makedirs(backup_dir, exist_ok=True)
#
#     try:
#         with open(backup_path, 'w') as f:
#             subprocess.run(["sqlite3", db_path, ".dump"], stdout=f, check=True)
#         session['backup_file'] = backup_filename
#         flash('Бэкап успешно создан. Вы можете его скачать.', 'success')
#     except subprocess.CalledProcessError as e:
#         flash(f'Ошибка при создании бэкапа: {str(e)}', 'error')
#
#     return redirect(url_for('index'))
#
# @app.route('/admin/download_backup', methods=['GET'])
# def download_backup():
#     backup_filename = session.pop('backup_file', None)
#     if not backup_filename:
#         flash('Файл бэкапа не найден', 'error')
#         return redirect(url_for('index'))
#
#     backup_path = os.path.join(os.getcwd(), "backups", backup_filename)
#     return send_file(backup_path, as_attachment=True)
#
#
# @app.route('/admin/upload_backup', methods=['POST'])
# def upload_backup():
#     if not current_user.has_role('admin'):
#         flash('У вас нет доступа к этой функции', 'error')
#         return redirect(url_for('index'))
#
#     if 'file' not in request.files:
#         flash('Нет файла в запросе', 'error')
#         return redirect(url_for('index'))
#
#     file = request.files['file']
#     if file.filename == '':
#         flash('Файл не выбран', 'error')
#         return redirect(url_for('index'))
#
#     if file and allowed_file(file.filename):
#         filename = secure_filename(file.filename)
#         backup_path = os.path.join(os.getcwd(), "backups", filename)
#         file.save(backup_path)
#
#         db_path = app.config['SQLALCHEMY_DATABASE_URI'].replace('sqlite:///', '')
#
#         # Удаление существующей базы данных перед восстановлением
#         if os.path.exists(db_path):
#             os.remove(db_path)
#
#         # Восстановление базы данных из дампа
#         try:
#             conn = sqlite3.connect(db_path)
#             with open(backup_path, 'r') as f:
#                 sql_script = f.read()
#                 conn.executescript(sql_script)
#             conn.commit()
#             conn.close()
#             flash('Бэкап успешно загружен и база данных обновлена.', 'success')
#         except sqlite3.Error as e:
#             flash(f'Ошибка при восстановлении базы данных: {str(e)}', 'error')
#         return redirect(url_for('index'))
#
#     flash('Неверный формат файла. Пожалуйста, загрузите файл .sql.', 'error')
#     return redirect(url_for('index'))

db_path = app.config['SQLALCHEMY_DATABASE_URI'].replace('sqlite:///', '')

@app.route('/admin/backup', methods=['GET'])
def backup_database():
    if not current_user.has_role('admin'):
        flash('У вас нет доступа к этой функции', 'error')
        return redirect(url_for('index'))

    # Create backup directories for .db and .sql files
    backup_dir = os.path.join(os.getcwd(), "backups")
    backup_sql_dir = os.path.join(backup_dir, "sql")
    os.makedirs(backup_dir, exist_ok=True)
    os.makedirs(backup_sql_dir, exist_ok=True)

    # Set backup filenames
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    backup_db_filename = f"backup_{timestamp}.db"
    backup_sql_filename = f"backup_{timestamp}.sql"
    backup_db_path = os.path.join(backup_dir, backup_db_filename)
    backup_sql_path = os.path.join(backup_sql_dir, backup_sql_filename)

    try:
        # Copy the .db file
        shutil.copyfile(db_path, backup_db_path)

        # Generate SQL dump
        conn = sqlite3.connect(db_path)
        with open(backup_sql_path, 'w') as f:
            for line in conn.iterdump():
                f.write(f"{line}\n")
        conn.close()

        session['backup_file'] = backup_db_filename
        flash('Бэкап успешно создан. Вы можете его скачать.', 'success')
    except IOError as e:
        flash(f'Ошибка при создании бэкапа: {str(e)}', 'error')

    return redirect(url_for('index'))

# Загрузка файла бэкапа
@app.route('/admin/download_backup', methods=['GET'])
def download_backup():
    backup_filename = session.pop('backup_file', None)
    if not backup_filename:
        flash('Файл бэкапа не найден', 'error')
        return redirect(url_for('index'))

    backup_path = os.path.join(os.getcwd(), "backups", backup_filename)
    return send_file(backup_path, as_attachment=True)

# Восстановление базы данных из файла бэкапа
@app.route('/admin/upload_backup', methods=['POST'])
def upload_backup():
    if not current_user.has_role('admin'):
        flash('У вас нет доступа к этой функции', 'error')
        return redirect(url_for('index'))

    if 'file' not in request.files:
        flash('Нет файла в запросе', 'error')
        return redirect(url_for('index'))

    file = request.files['file']
    if file.filename == '':
        flash('Файл не выбран', 'error')
        return redirect(url_for('index'))

    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        backup_path = os.path.join(os.getcwd(), "backups", filename)
        file.save(backup_path)

        # Замена существующей базы данных на загруженный файл
        try:
            shutil.copyfile(backup_path, db_path)
            flash('База данных успешно обновлена.', 'success')
        except IOError as e:
            flash(f'Ошибка при восстановлении базы данных: {str(e)}', 'error')

        return redirect(url_for('index'))

    flash('Неверный формат файла. Пожалуйста, загрузите файл .db.', 'error')
    return redirect(url_for('index'))

def allowed_file(filename):
    ALLOWED_EXTENSIONS = {'db'}
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


# Отображение всех проектов для админ-панели
@app.route('/admin/projects')
@login_required
def admin_projects():
    projects = Project.query.all()
    return render_template('admin_projects.html', projects=projects)


# Редактирование проекта
@app.route('/admin/edit_project/<int:project_id>', methods=['GET', 'POST'])
@login_required
def edit_project(project_id):
    project = Project.query.get_or_404(project_id)
    form = ProjectForm(obj=project)
    form.populate_choices()
    if form.validate_on_submit():
        project.title = form.title.data
        project.description = form.description.data
        project.status_id = form.status_id.data
        project.priority_id = form.priority_id.data
        project.responsible_id = form.responsible_id.data
        db.session.commit()
        flash('Проект успешно обновлен!')
        return redirect(url_for('admin_projects'))
    return render_template('edit_project.html', form=form, project=project)


# Удаление проекта
@app.route('/delete_project/<int:project_id>', methods=['POST'])
@login_required
def delete_project(project_id):
    project = Project.query.get_or_404(project_id)

    # Удаление связанных задач
    for task in project.tasks:
        db.session.delete(task)

    db.session.delete(project)
    db.session.commit()
    flash("Проект и связанные задачи успешно удалены.")
    return redirect(url_for('admin_projects'))


# Роут для отображения всех задач в админке
@app.route('/admin/tasks')
@login_required
def admin_tasks():
    tasks = Task.query.all()
    return render_template('admin_tasks.html', tasks=tasks)


# Роут для создания новой задачи в админке
@app.route('/admin/create_task', methods=['GET', 'POST'])
@login_required
def admin_create_task():
    form = TaskForm()
    form.populate_choices()
    if form.validate_on_submit():
        task = Task(
            title=form.title.data,
            description=form.description.data,
            status_id=form.status_id.data,
            priority_id=form.priority_id.data,
            deadline=form.deadline.data
        )
        db.session.add(task)
        db.session.commit()
        flash("Задача успешно создана.")
        return redirect(url_for('admin_tasks'))
    return render_template('create_task.html', form=form)


# Роут для редактирования задачи в админке
@app.route('/admin/edit_task/<int:task_id>', methods=['GET', 'POST'])
@login_required
def edit_task(task_id):
    task = Task.query.get_or_404(task_id)
    form = TaskForm(obj=task)
    form.populate_choices()
    if form.validate_on_submit():
        task.title = form.title.data
        task.description = form.description.data
        task.status_id = form.status_id.data
        task.priority_id = form.priority_id.data
        task.deadline = form.deadline.data
        db.session.commit()
        flash("Задача успешно обновлена.")
        return redirect(url_for('admin_tasks'))
    return render_template('edit_task.html', form=form, task=task)


# Роут для удаления задачи в админке
@app.route('/admin/delete_task/<int:task_id>', methods=['POST'])
@login_required
def delete_task(task_id):
    task = Task.query.get_or_404(task_id)
    db.session.delete(task)
    db.session.commit()
    flash("Задача успешно удалена.")
    return redirect(url_for('admin_tasks'))


# Создание нового пользователя
@app.route('/admin/create_user', methods=['GET', 'POST'])
@login_required
def create_user():
    form = UserForm()
    if form.validate_on_submit():
        user = User(
            username=form.username.data,
            email=form.email.data,
            first_name=form.first_name.data,
            last_name=form.last_name.data,
            middle_name=form.middle_name.data,
            phone_number=form.phone_number.data,
            date_birth=form.date_birth.data,
            about_me=form.about_me.data,
            avatar=form.avatar.data,
            is_active=form.is_active.data
        )
        user.set_password(form.password.data)
        db.session.add(user)
        db.session.commit()
        flash("Пользователь успешно создан.")
        return redirect(url_for('admin_users'))
    return render_template('create_user.html', form=form)


# Отображение всех пользователей для админ-панели
@app.route('/admin/users')
@login_required
def admin_users():
    users = User.query.all()
    return render_template('admin_users.html', users=users)


@app.route('/admin/edit_user/<int:user_id>', methods=['GET', 'POST'])
@login_required
def edit_user(user_id):
    user = User.query.get_or_404(user_id)
    form = UserForm(obj=user)

    # Установка текущего значения для поля is_active, если это GET-запрос
    if request.method == 'GET':
        form.is_active.data = user.is_active

    if form.validate_on_submit():
        user.username = form.username.data
        user.email = form.email.data
        user.first_name = form.first_name.data
        user.last_name = form.last_name.data
        user.middle_name = form.middle_name.data
        user.phone_number = form.phone_number.data
        user.date_birth = form.date_birth.data
        user.about_me = form.about_me.data
        user.avatar = form.avatar.data
        user.is_active = form.is_active.data  # Убедитесь, что is_active обновляется
        if form.password.data:
            user.set_password(form.password.data)
        db.session.commit()
        flash('Пользователь успешно обновлен!')
        return redirect(url_for('admin_users'))
    return render_template('edit_user.html', form=form, user=user)


# Удаление пользователя
@app.route('/admin/delete_user/<int:user_id>', methods=['POST'])
@login_required
def delete_user(user_id):
    user_to_delete = User.query.get_or_404(user_id)

    # Проверка: если текущий пользователь - администратор и он пытается удалить себя
    if current_user.id == user_to_delete.id and user_to_delete.has_role('admin'):
        flash("Вы не можете удалить себя, так как необходимо оставить хотя бы одного администратора.", "error")
        return redirect(url_for('admin_users'))

    # Удаляем пользователя (с проектами)
    db.session.delete(user_to_delete)
    db.session.commit()

    flash("Пользователь успешно удален!")
    return redirect(url_for('admin_users'))



# Создание новой роли
@app.route('/admin/create_role', methods=['GET', 'POST'])
@login_required
def create_role():
    form = RoleForm()
    if form.validate_on_submit():
        role = Role(name=form.name.data)
        db.session.add(role)
        db.session.commit()
        flash("Роль успешно создана.")
        return redirect(url_for('admin_roles'))
    return render_template('create_role.html', form=form)


# Отображение всех ролей для админ-панели
@app.route('/admin/roles')
@login_required
def admin_roles():
    roles = Role.query.all()
    return render_template('admin_roles.html', roles=roles)


# Редактирование роли
@app.route('/admin/edit_role/<int:role_id>', methods=['GET', 'POST'])
@login_required
def edit_role(role_id):
    role = Role.query.get_or_404(role_id)
    form = RoleForm(obj=role)
    if form.validate_on_submit():
        role.name = form.name.data
        db.session.commit()
        flash('Роль успешно обновлена!')
        return redirect(url_for('admin_roles'))
    return render_template('edit_role.html', form=form, role=role)


# Удаление роли
@app.route('/admin/delete_role/<int:role_id>', methods=['POST'])
@login_required
def delete_role(role_id):
    role = Role.query.get_or_404(role_id)
    db.session.delete(role)
    db.session.commit()
    flash("Роль успешно удалена.")
    return redirect(url_for('admin_roles'))


from datetime import datetime, timezone

@app.route('/admin/create_project_stat', methods=['GET', 'POST'])
@login_required
def create_project_stat():
    form = ProjectStatisticsForm()
    form.populate_choices()  # Заполняем выбор проектов
    if form.validate_on_submit():
        project_stat = ProjectStatistics(
            project_id=form.project_id.data,
            tasks_total=form.tasks_total.data,
            tasks_completed=form.tasks_completed.data,
            average_completion_time=form.average_completion_time.data,
            updated_at=datetime.now(timezone.utc)  # Устанавливаем значение updated_at вручную
        )
        db.session.add(project_stat)
        db.session.commit()
        flash("Статистика проекта успешно создана.")
        return redirect(url_for('admin_project_stats'))
    return render_template('create_project_stat.html', form=form)


# Отображение всех записей статистики для админ-панели
@app.route('/admin/project_stats')
@login_required
def admin_project_stats():
    project_stats = ProjectStatistics.query.all()
    return render_template('admin_project_stats.html', project_stats=project_stats)

# Редактирование записи статистики проекта
@app.route('/admin/edit_project_stat/<int:stat_id>', methods=['GET', 'POST'])
@login_required
def edit_project_stat(stat_id):
    project_stat = ProjectStatistics.query.get_or_404(stat_id)
    form = ProjectStatisticsForm(obj=project_stat)
    form.populate_choices()  # Заполняем выбор проектов
    if form.validate_on_submit():
        project_stat.project_id = form.project_id.data
        project_stat.tasks_total = form.tasks_total.data
        project_stat.tasks_completed = form.tasks_completed.data
        project_stat.average_completion_time = form.average_completion_time.data
        db.session.commit()
        flash('Статистика проекта успешно обновлена!')
        return redirect(url_for('admin_project_stats'))
    return render_template('edit_project_stat.html', form=form, project_stat=project_stat)


# Удаление записи статистики проекта
@app.route('/admin/delete_project_stat/<int:stat_id>', methods=['POST'])
@login_required
def delete_project_stat(stat_id):
    project_stat = ProjectStatistics.query.get_or_404(stat_id)
    db.session.delete(project_stat)
    db.session.commit()
    flash("Статистика проекта успешно удалена.")
    return redirect(url_for('admin_project_stats'))



# CANBAN TASKS


@app.route('/tasks')
def tasks():
    tasks = Task.query.all()  # Получаем все задачи с их статусами
    return render_template('tasks.html', tasks=tasks, title='Задачи')


# Создание задачи
@app.route('/tasks/create', methods=['GET', 'POST'])
def create_tasks():
    if request.method == 'POST':
        title = request.form['title']
        description = request.form['description']
        deadline = request.form['deadline']
        status_id = request.form['status_id']
        new_task = Task(title=title, description=description, deadline=deadline, status_id=status_id)
        db.session.add(new_task)
        db.session.commit()
        flash('Задача успешно создана!', 'success')
        return redirect(url_for('tasks'))
    statuses = Status.query.all()
    return render_template('create_tasks.html', statuses=statuses)

# Обновление задачи
@app.route('/tasks/update/<int:id>', methods=['GET', 'POST'])
def update_tasks(id):
    task = Task.query.get(id)
    if request.method == 'POST':
        task.status_id = request.form['status_id']
        db.session.commit()
        flash('Задача обновлена!', 'success')
        return redirect(url_for('tasks'))
    statuses = Status.query.all()
    return render_template('update_tasks.html', task=task, statuses=statuses)

# Удаление задачи
@app.route('/tasks/delete/<int:id>', methods=['GET', 'POST'])
def delete_tasks(id):
    task = Task.query.get(id)
    db.session.delete(task)
    db.session.commit()
    flash('Задача удалена!', 'success')
    return redirect(url_for('tasks'))


@app.route('/update_task_status/<int:task_id>', methods=['POST'])
@login_required
def update_task_status(task_id):
    status_data = request.get_json()  # Получаем данные из запроса (статус)
    new_status = status_data.get('status').replace('-', ' ').title()  # Преобразуем дефисы в пробелы и капитализируем

    print("Received data:", status_data)
    print("Status from request:", new_status)

    # Проверяем, что новый статус правильный
    if new_status not in ['Not Started', 'In Progress', 'Completed']:
        return jsonify({'error': 'Invalid status'}), 400

    task = Task.query.get_or_404(task_id)

    # Обновляем статус задачи в базе данных
    status = Status.query.filter_by(name=new_status).first()  # Находим статус по имени
    if not status:
        return jsonify({'error': 'Status not found'}), 404

    task.status_id = status.id
    db.session.commit()

    return jsonify({'message': 'Task status updated successfully'}), 200
