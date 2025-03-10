-- Step 1: Populate the database with sample data

INSERT INTO Books (book_id, title, author, isbn, publication_year, genre)
VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', 1925, 'Fiction'),
(2, 'To Kill a Mockingbird', 'Harper Lee', '9780061120084', 1960, 'Fiction'),
(3, '1984', 'George Orwell', '9780451524935', 1949, 'Dystopian'),
(4, 'Moby Dick', 'Herman Melville', '9781503280786', 1851, 'Adventure');

INSERT INTO Borrowers (borrower_id, name, contact_info, membership_date)
VALUES
(1, 'Alice Johnson', 'alice@example.com', '2023-01-15'),
(2, 'Bob Smith', 'bob@example.com', '2023-02-20');

INSERT INTO Loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date)
VALUES
(1, 1, 1, '2024-03-01', '2024-03-15', NULL),
(2, 2, 2, '2024-03-05', '2024-03-19', '2024-03-18');

-- Step 2: Retrieve a list of all overdue books
SELECT b.title, br.name, l.due_date
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
JOIN Borrowers br ON l.borrower_id = br.borrower_id
WHERE l.due_date < CURRENT_DATE AND l.return_date IS NULL;

-- Step 3: Generate a report on most popular book genres
SELECT b.genre, COUNT(l.loan_id) AS loan_count
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
GROUP BY b.genre
ORDER BY loan_count DESC;

-- Step 4: Identify top borrowers
SELECT br.name, COUNT(l.loan_id) AS total_loans
FROM Loans l
JOIN Borrowers br ON l.borrower_id = br.borrower_id
GROUP BY br.name
ORDER BY total_loans DESC
LIMIT 5;

-- Step 5: Search books by keyword
SELECT * FROM Books
WHERE title LIKE '%keyword%' OR author LIKE '%keyword%';

-- Step 6: Create a view for borrower profile
CREATE VIEW BorrowerProfile AS
SELECT br.borrower_id, br.name, br.contact_info, br.membership_date, b.title AS borrowed_book, l.loan_date, l.return_date
FROM Borrowers br
LEFT JOIN Loans l ON br.borrower_id = l.borrower_id
LEFT JOIN Books b ON l.book_id = b.book_id;

-- Step 7: Update book availability
UPDATE Books
SET availability = CASE 
    WHEN book_id IN (SELECT book_id FROM Loans WHERE return_date IS NULL) THEN 'Not Available'
    ELSE 'Available'
END;
