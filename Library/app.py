from flask import render_template
from flask import Flask, jsonify, render_template, request, redirect, url_for, session, flash
from model import db, Register, Book, User, Borrower
from bcrypt import hashpw, gensalt
from flask import request, jsonify
from sqlalchemy.orm.exc import NoResultFound
from sqlalchemy import func
from sqlalchemy.exc import IntegrityError
import string
import random
from datetime import datetime  # Added this import for datetime


def get_current_timestamp():
    return datetime.now().strftime('%Y-%m-%d %H:%M:%S')


app = Flask(__name__)
app.secret_key = "your_secret_key"
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@localhost/library2302021'
db.init_app(app)


@app.route("/")
def hello():
    return render_template("home.html")


@app.route("/add_book")
def addBook():
    return render_template("addbook.html")


# ... (your existing imports) ...

@app.route("/recovery", methods=['GET', 'POST'])
def recovery():
    if request.method == 'POST':
        # Retrieve form data
        username = request.form['uname']
        email = request.form['email']
        phone = request.form['phone']
        recovery_password = request.form['recovery_password']

        # Check if the user exists with the provided details
        user = Register.query.filter_by(
            username=username, Email_id=email, Phone_number=phone).first()

        if user:
            # Update the user's password with the recovery password
            hashed_recovery_password = hashpw(
                recovery_password.encode('utf-8'), gensalt())
            user.Password = hashed_recovery_password
            db.session.commit()
            # flash('Password reset successfully!', 'success')
            return redirect(url_for('LOGIN_STYLE'))
        else:
            # flash('Invalid username, email, or phone number. Please try again.', 'error')
            print('ula')

    return render_template("passwordrecovery.html")

# Create a new route to handle the password reset action


@app.route("/reset_password", methods=['POST'])
def reset_password():
    # Retrieve form data
    username = request.form['uname']
    email = request.form['email']
    phone = request.form['phone']
    recovery_password = request.form['recovery_password']

    # Check if the user exists with the provided details
    user = Register.query.filter_by(
        username=username, Email_id=email, Phone_number=phone).first()

    if user:
        # Update the user's password with the recovery password
        hashed_recovery_password = hashpw(
            recovery_password.encode('utf-8'), gensalt())
        user.Password = hashed_recovery_password
        db.session.commit()

    else:
        print("Ulla")

    return redirect(url_for('LOGIN_STYLE'))

# ... (rest of your existing code) ...


@app.route("/borrowed_book_by_user")
def borrwoedBookbyuser():
    # Get the username from the session
    username = session.get('username')

    # Fetch the borrowed books for the given username
    borrowed_books = Borrower.query.filter_by(userName=username).all()

    # Fetch book details for borrowed books
    borrowed_books_details = []
    for borrowed_book in borrowed_books:
        book_id = borrowed_book.book_id
        book_details = Book.query.filter_by(book_id=book_id).first()
        if book_details:
            borrowed_books_details.append({
                'book_id': book_id,
                'book_title': book_details.book_title,
                'author': book_details.author
            })

    return render_template("borrowed_book_user.html", borrowed_books_details=borrowed_books_details)


@app.route("/addBook", methods=['POST'])
def add_book():
    if request.method == 'POST':
        # Extract form data
        book_title = request.form['book_titile']
        author = request.form['author']
        publication_year = request.form['publication_year']
        total_book = int(request.form['total_book'])  # Convert to int
        isbn = request.form['ISBN']

        # Create a new book record
        new_book = Book(
            book_title=book_title,
            author=author,
            publication_year=publication_year,
            total_book=total_book,
            ISBN=isbn
        )

        # Add the new book record to the database
        db.session.add(new_book)
        db.session.commit()

        # Redirect to the book catalog page
        return redirect(url_for('adlog'))

    # Redirect to the add book page if not a POST request
    return redirect(url_for('addBook'))


@app.route("/book")
def partha():
    books = Book.query.all()
    # Get the user type from the session
    user_type = session.get('user_type', None)
    return render_template('Bookcatalog.html', books=books, user_type=user_type)


@app.route("/login")
def log():
    books = Book.query.all()
    user_type = session.get('user_type', None)
    borrowed_books = Borrower.query.filter_by(
        userName=session['username']).all()
    borrowed_book_ids = [
        borrowed_book.book_id for borrowed_book in borrowed_books]

    return render_template('studentlogin.html', books=books, user_type=user_type, borrowed_book_ids=borrowed_book_ids)

# ...


@app.route("/adminlogin")
def adlog():
    books = Book.query.all()
    # Get the user type from the session
    username = session.get('username')
    user_type = session.get('user_type', None)
    return render_template('admin.html', books=books, username=username, user_type=user_type)


# ... (your existing code) ...

# ... (your existing code) ...


@app.route("/borrower")
def borrower():
    # Fetch distinct names and corresponding email IDs and phone numbers
    distinct_data = db.session.query(
        Borrower.userName, Borrower.Email_id, Borrower.Phone_number).distinct().all()

    # Get the user type and username from the session
    user_type = session.get('user_type', None)
    username = session.get('username', None)

    return render_template("borrower.html", distinct_data=distinct_data, user_type=user_type, username=username)


# ... (rest of your code) ...


@app.route("/transaction")
def transaction():
    # Fetch the required data from the Borrower table
    transaction_data = db.session.query(
        Borrower.userName,
        Borrower.book_id,
        Borrower.issue_date,
        Borrower.return_date,
        Borrower.Phone_number,
        Borrower.Email_id
    ).all()

    # Pass the data to the template for rendering
    return render_template("transaction.html", transaction_data=transaction_data)


@app.route("/error")
def error():
    # Implement transaction route logic
    return render_template("error.html")


@app.route("/flash")
def flash():
    return render_template("flash.html")


@app.route("/flashR")
def flashR():
    return render_template("flash1.html")


@app.route("/LOGIN_STYLE")
def LOGIN_STYLE():
    # Implement transaction route logic
    return render_template("LOGIN_STYLE.html")


@app.route("/logout")
def logout():
    session.pop('username', None)
    session.pop('user_type', None)
    return redirect(url_for('hello'))


@app.route("/register", methods=['GET', 'POST'])
def partha3():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']
        phone = request.form['phone']

        # Hash the password
        hashed_password = hashpw(password.encode('utf-8'), gensalt())

        user_type = request.form.get('userType')

        # Determine category and level based on user type
        if user_type == 'admin':
            category = 'Admin'
            level = request.form.get('userTypeAdmin')
        else:
            category = 'Student'
            level = request.form.get('userTypeStudent')

        # Save registration data to the "register" table
        new_user = Register(username=username, Password=hashed_password, Email_id=email,
                            Phone_number=phone, Category=category, Level=level)
        db.session.add(new_user)
        db.session.commit()

        return redirect(url_for('hello'))
    else:
        return render_template('register.html')


@app.route("/login", methods=['POST'])
def login():
    username = request.form['uname']
    password = request.form['psw']
    user_type = request.form['userType']

    # Check if the user exists and the password is correct
    user = Register.query.filter_by(
        username=username, Category=user_type).first()

    if user and hashpw(password.encode('utf-8'), user.Password.encode('utf-8')) == user.Password.encode('utf-8'):
        session['username'] = username
        session['user_type'] = user_type  # Store user type in session
        if session['user_type'] == 'admin':
            return redirect(url_for('adlog'))
        else:
            return redirect(url_for('log'))
    else:
        return redirect(url_for('error'))
# ... (your existing code) ...


def get_current_timestamp():
    return datetime.now().strftime('%Y-%m-%d %H:%M:%S')


@app.route("/borrow__1", methods=['POST'])
def borrow_book_1():
    if request.method == 'POST':
        username = request.form['username']
        book_id = request.form['book_id']
        formatted_datetime = get_current_timestamp()

        try:
            # Fetch user details from Register table
            user_details = Register.query.filter_by(username=username).first()

            # Check if the user exists
            if user_details:
                email = user_details.Email_id
                phone = user_details.Phone_number

                # Perform necessary actions for borrowing a book
                new_user = Borrower(
                    userName=username, Email_id=email, Phone_number=phone, book_id=book_id, issue_date=formatted_datetime)

                db.session.add(new_user)
                db.session.commit()

                return redirect(url_for('login'))
            else:
                return redirect(url_for('flash'))
        except IntegrityError as e:
            # Handle IntegrityError (e.g., duplicate entry)
            # Redirect to the flash page or handle as needed
            return redirect(url_for('flash'))

    return redirect(url_for('flash'))


@app.route("/return", methods=['POST'])
def return_book_1():
    if request.method == 'POST':
        username = request.form['username']
        book_id = request.form['book_id']

        # Get the current timestamp (current date and time)
        return_datetime = datetime.now()

        try:
            # Fetch the Borrower record
            borrower_record = Borrower.query.filter_by(
                userName=username, book_id=book_id).first()

            if borrower_record:
                # Check if the return_date is already filled
                if borrower_record.return_date:

                    return redirect(url_for('flashR'))

                # Update the return_date to the current timestamp
                borrower_record.return_date = return_datetime

                # Commit the changes to the database
                db.session.commit()

                return redirect(url_for('login'))
            else:

                return redirect(url_for('flashR'))
        except IntegrityError as e:
            # Handle IntegrityError (e.g., duplicate entry)

            return redirect(url_for('flashR'))

    return redirect(url_for('error2'))


if __name__ == '__main__':
    app.run(debug=True)
