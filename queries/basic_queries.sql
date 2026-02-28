-- ========================================
--Basic QUERIES
-- ========================================


-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM books WHERE genre ='Fiction'


-- 2) Find books published after the year 1950:
SELECT * FROM books WHERE published_year > 1950 ;


-- 3) List all customers from the Canada:
SELECT * FROM customers WHERE country ='Canada';

-- 4) Show orders placed in November 2023:
SELECT * FROM orders WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30' ;

-- 5) Retrieve the total stock of books available:
SELECT SUM(stock) AS total_stock FROM books ;

-- 6) Find the details of the most expensive book:
SELECT * FROM books 
ORDER BY price DESC
LIMIT 1 ;

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM orders WHERE quantity > 1 ;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM orders WHERE total_amount > 20 ;

-- 9) List all genres available in the Books table:
SELECT DISTINCT genre FROM books ;

-- 10) Find the book with the lowest stock:
SELECT * FROM books
ORDER BY stock
LIMIT 1 ;

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) AS revenue 
FROM orders ;
