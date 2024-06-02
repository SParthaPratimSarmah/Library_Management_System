-- CREATE DATABASE LIBRARY MANAGEMENT SYSTEM

create database library2302021;
use library2302021;

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    book_title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
     publication_year varchar(255),total_book int,
    ISBN VARCHAR(20) NOT NULL unique
);

create table register(
id int primary key auto_increment,
username varchar(255),
Password varchar(255),
Email_id varchar(255),
Phone_number varchar(200),
Category varchar(255),
Level varchar(255)
);

create table borrower(
userName varchar(255),
Email_id varchar(255),
Phone_number varchar(255),
book_id varchar(255),
issue_date datetime,
return_date datetime,
primary key(book_id,userName),
FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- (a) Retrieve the list of books borrowed by a specific borrower.
SELECT b.book_title, b.author, b.ISBN, bb.issue_date, bb.return_date
FROM borrower bb
JOIN books b ON bb.book_id = b.book_id
WHERE bb.userName = 'Simanta Das';

-- (b) Display the total number of books available in the library.
SELECT SUM(total_book) AS total_books_available
FROM books;

-- (c) Find the borrower with the highest number of borrowed books.
SELECT userName, COUNT(book_id) AS borrowed_books_count
FROM borrower
GROUP BY userName
ORDER BY borrowed_books_count DESC
LIMIT 1;

-- (d) Show the transaction history for a specific book.
SELECT bb.userName, bb.issue_date, bb.return_date
FROM borrower bb
WHERE bb.book_id = '1';


