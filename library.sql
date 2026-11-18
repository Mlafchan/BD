CREATE TABLE Readers (
    reader_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL
        CHECK (TRIM(full_name) <> ''),
    phone VARCHAR(20) NOT NULL UNIQUE
        CHECK (TRIM(phone) <> '')
);

CREATE TABLE Books (
    isbn VARCHAR(20) PRIMARY KEY,
    title VARCHAR(200) NOT NULL
        CHECK (TRIM(title) <> ''),
    publication_year INTEGER NOT NULL
        CHECK (publication_year BETWEEN 1000 AND 2026)
);

CREATE TABLE Authors (
    author_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL
        CHECK (TRIM(full_name) <> '')
);

CREATE TABLE Book_Authors (
    book_isbn VARCHAR(20) NOT NULL,
    author_id INTEGER NOT NULL,

    PRIMARY KEY (book_isbn, author_id),

    FOREIGN KEY (book_isbn) REFERENCES Books(isbn),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

CREATE TABLE Loans (
    loan_id SERIAL PRIMARY KEY,
    reader_id INTEGER NOT NULL,
    book_isbn VARCHAR(20) NOT NULL,
    loan_date DATE NOT NULL,
    planned_return_date DATE NOT NULL,
    actual_return_date DATE,

    FOREIGN KEY (reader_id) REFERENCES Readers(reader_id),
    FOREIGN KEY (book_isbn) REFERENCES Books(isbn),

    CHECK (planned_return_date >= loan_date),
    CHECK (
        actual_return_date IS NULL
        OR actual_return_date >= loan_date
    )
);

INSERT INTO Readers (full_name, phone)
VALUES
('Анна Петрова', '+7-900-111-22-33'),
('Иван Соколов', '+7-900-222-33-44'),
('Мария Ким', '+7-900-333-44-55'),
('Олег Васильев', '+7-900-444-55-66'),
('Елена Смирнова', '+7-900-555-66-77');

INSERT INTO Books (isbn, title, publication_year)
VALUES
('978-5-17-118366-8', 'Мастер и Маргарита', 1967),
('978-5-389-06256-6', 'Преступление и наказание', 1866),
('978-5-04-116716-3', 'Война и мир', 1869),
('978-5-699-12014-7', 'Золотой теленок', 1931),
('978-5-389-03713-7', 'Пикник на обочине', 1972);

INSERT INTO Authors (full_name)
VALUES
('Михаил Булгаков'),
('Федор Достоевский'),
('Лев Толстой'),
('Илья Ильф'),
('Евгений Петров'),
('Аркадий Стругацкий'),
('Борис Стругацкий');

INSERT INTO Book_Authors (book_isbn, author_id)
VALUES
('978-5-17-118366-8', 1),
('978-5-389-06256-6', 2),
('978-5-04-116716-3', 3),
('978-5-699-12014-7', 4),
('978-5-699-12014-7', 5),
('978-5-389-03713-7', 6),
('978-5-389-03713-7', 7);

INSERT INTO Loans (
    reader_id,
    book_isbn,
    loan_date,
    planned_return_date,
    actual_return_date
)
VALUES
(1, '978-5-17-118366-8', '2026-10-01', '2026-10-15', NULL),
(1, '978-5-389-06256-6', '2026-09-01', '2026-09-15', '2026-09-14'),
(2, '978-5-04-116716-3', '2026-10-05', '2026-10-20', NULL),
(3, '978-5-699-12014-7', '2026-08-10', '2026-08-25', '2026-08-23'),
(4, '978-5-389-03713-7', '2026-09-10', '2026-09-25', '2026-09-24'),
(2, '978-5-17-118366-8', '2026-10-10', '2026-10-25', NULL);

UPDATE Readers
SET phone = '+7-900-777-88-99'
WHERE reader_id = 1;

UPDATE Loans
SET actual_return_date = '2026-10-12'
WHERE loan_id = 1;

DELETE FROM Readers
WHERE reader_id = 5
AND NOT EXISTS (
    SELECT 1
    FROM Loans
    WHERE Loans.reader_id = Readers.reader_id
);