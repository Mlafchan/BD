SELECT *
FROM Readers;

SELECT title, publication_year
FROM Books;

SELECT title, publication_year
FROM Books
WHERE publication_year BETWEEN 1801 AND 1900;

SELECT title, publication_year
FROM Books
WHERE publication_year BETWEEN 1917 AND 1991;

SELECT *
FROM Readers
WHERE phone = '+7-900-777-88-99';

SELECT *
FROM Readers
WHERE full_name LIKE '%Петров%';

SELECT *
FROM Loans
WHERE actual_return_date IS NULL;

SELECT title, publication_year
FROM Books
ORDER BY title ASC;

SELECT *
FROM Loans
WHERE actual_return_date IS NULL
ORDER BY planned_return_date ASC;

SELECT title, publication_year
FROM Books
ORDER BY publication_year ASC
LIMIT 3;