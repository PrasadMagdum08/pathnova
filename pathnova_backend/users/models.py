from mongoengine import Document, StringField, EmailField

class User(Document):
    name = StringField(required=True, max_length=100)
    email = EmailField(required=True, unique=True)
    password = StringField(required=True, max_length=128)
    role = StringField(required=True, choices=('admin', 'student'))