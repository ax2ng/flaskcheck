from app import db, app
from app.models import User, Role, Project, Task, Status, Priority, ChatRoom, ChatMessage, File
from datetime import datetime, timedelta, timezone
import random

# Очистка базы данных
with app.app_context():
    db.drop_all()  # Удаляем все таблицы
    db.create_all()  # Создаем все таблицы заново


def create_roles_if_not_exist(role_names):
    for role_name in role_names:
        existing_role = db.session.query(Role).filter_by(name=role_name).first()
        if not existing_role:
            new_role = Role(name=role_name)
            db.session.add(new_role)
            print(f'Роль "{role_name}" успешно добавлена.')
        else:
            print(f'Роль "{role_name}" уже существует.')
    db.session.commit()


# Список ролей
role_names = ["admin", "manager", "responsible", "executor"]


def add_users():
    role_admin = Role.query.filter_by(name="admin").first()
    role_executor = Role.query.filter_by(name="executor").first()

    users_data = [
        {"username": "admin", "email": "admin@example.com", "first_name": "Admin", "last_name": "User",
         "middle_name": "A", "role": role_admin},
        {"username": "admin2", "email": "admin2@example.com", "first_name": "Admin", "last_name": "User",
         "middle_name": "A", "role": role_admin},
        {"username": "executor1", "email": "executor1@example.com", "first_name": "Executor", "last_name": "E",
         "middle_name": None, "role": role_executor},
    ]

    for user_data in users_data:
        existing_user = db.session.query(User).filter(
            (User.username == user_data["username"]) | (User.email == user_data["email"])
        ).first()

        if not existing_user:
            user = User(
                username=user_data["username"],
                email=user_data["email"],
                first_name=user_data["first_name"],
                last_name=user_data["last_name"],
                middle_name=user_data["middle_name"]
            )
            user.set_password("password")
            user.roles.append(user_data["role"])  # Назначаем роль
            db.session.add(user)
        else:
            print(f"User with username '{user_data['username']}' or email '{user_data['email']}' already exists.")

    db.session.commit()


def add_statuses_and_priorities():
    statuses = ["Not Started", "In Progress", "Completed"]
    priorities = ["Low", "Medium", "High"]
    for status in statuses:
        db.session.add(Status(name=status))
    for priority in priorities:
        db.session.add(Priority(level=priority))
    db.session.commit()


def add_projects():
    for i in range(3):
        project = Project(
            title=f"Project {i + 1}",
            description=f"Description of Project {i + 1}",
            start_date=datetime.now(timezone.utc),
            end_date=datetime.now(timezone.utc) + timedelta(days=30),
            status_id=random.randint(1, 3),
            priority_id=random.randint(1, 3),
            manager_id=1,  # Обязательно укажите manager_id
            responsible_id=2  # И responsible_id
        )
        db.session.add(project)
    db.session.commit()


def add_tasks():
    for i in range(10):
        task = Task(
            title=f"Task {i + 1}",
            description=f"Description of Task {i + 1}",
            deadline=datetime.now(timezone.utc) + timedelta(days=random.randint(5, 20)),
            project_id=random.randint(1, 3),
            status_id=random.randint(1, 3),
            priority_id=random.randint(1, 3)
        )
        db.session.add(task)
    db.session.commit()


def add_chat_rooms_and_messages():
    for project_id in range(1, 4):
        chat_room = ChatRoom(project_id=project_id, type="project")
        db.session.add(chat_room)
        db.session.flush()

        for i in range(5):
            message = ChatMessage(
                chat_room_id=chat_room.id,
                user_id=random.randint(1, 3),
                content=f"Message {i + 1} in project {project_id}",
                timestamp=datetime.now(timezone.utc)
            )
            db.session.add(message)
    db.session.commit()


def add_files():
    for i in range(10):
        file = File(
            user_id=random.randint(1, 3),
            project_id=random.randint(1, 3),
            file_url=f"https://example.com/file{i + 1}.txt",
            upload_time=datetime.now(timezone.utc)
        )
        db.session.add(file)
    db.session.commit()


def populate_database():
    create_roles_if_not_exist(role_names)
    add_users()
    add_statuses_and_priorities()
    add_projects()
    add_tasks()
    add_chat_rooms_and_messages()
    add_files()
    print("Database populated with test data!")


if __name__ == "__main__":
    with app.app_context():
        populate_database()
