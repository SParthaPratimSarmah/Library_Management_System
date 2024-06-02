from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@localhost/library2302021'
db = SQLAlchemy(app)


class Register(db.Model):
    __tablename__ = 'register'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(255))
    Password = db.Column(db.String(255))
    Email_id = db.Column(db.String(255))
    Phone_number = db.Column(db.String(15))
    Category = db.Column(db.String(255))
    Level = db.Column(db.String(255))


class Book(db.Model):
    __tablename__ = 'books'
    book_id = db.Column(db.Integer, primary_key=True)
    book_title = db.Column(db.String(255), nullable=False)
    author = db.Column(db.String(255), nullable=False)
    publication_year = db.Column(db.String(255))
    ISBN = db.Column(db.String(20), unique=True, nullable=False)
    total_book = db.Column(db.Integer)


class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(255), unique=True, nullable=False)
    password = db.Column(db.String(255), nullable=False)


class Borrower(db.Model):
    __tablename__ = 'borrower'

    userName = db.Column(db.String(255), primary_key=True)
    Email_id = db.Column(db.String(255))
    Phone_number = db.Column(db.String(255))
    book_id = db.Column(db.String(255), primary_key=True)
    issue_date = db.Column(db.DateTime)
    return_date = db.Column(db.DateTime)

    __table_args__ = (
        db.ForeignKeyConstraint(['book_id'], ['books.book_id']),
    )


if __name__ == "__main__":
    with app.app_context():
        db.create_all()
    app.run(debug=True)
