import os

basedir = os.path.abspath(os.path.dirname(__file__))


class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'you-will-never-guess'
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or \
                              'postgresql://dubinkerus:1234@127.0.0.1:5432/postgres'
    MAIL_SERVER = 'smtp.yandex.ru'
    MAIL_PORT = 587
    MAIL_USE_TLS = True
    MAIL_USERNAME = 'servet0chka@yandex.ru'
    MAIL_PASSWORD = 'mimgbmpdcqbuuimj'
    ADMINS = ['servet0chka@yandex.ru']


    SESSION_COOKIE_SAMESITE = "Lax"
    SESSION_COOKIE_SECURE = False

