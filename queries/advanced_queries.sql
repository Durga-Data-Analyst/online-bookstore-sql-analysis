-- ========================================
-- Advanced Queries
-- ========================================

-- 1) Retrieve the total number of books sold for each genre:
SELECT b.genre,SUM(quantity) AS Total_books_sold
FROM books b
JOIN orders o ON o.book_id=b.book_id
GROUP BY b.genre ;

-- 2) Find the average price of books in the "Fantasy" genre:
SELECT ROUND(AVG(price),2) AS average_price
FROM books WHERE genre='Fantasy';

-- 3) List customers who have placed at least 2 orders:
SELECT c.customer_id,c.name,COUNT(o.order_id) AS orders_COUNT
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id,c.name
HAVING COUNT(o.order_id)>=2 ;

-- 4) Find the most frequently ordered book:
SELECT b.book_id,b.title,COUNT(o.order_id) AS orders_count
FROM books b
JOIN orders o ON b.book_id =o.book_id
GROUP BY b.book_id,b.title
ORDER BY COUNT(o.order_id) DESC
LIMIT 1 ;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM books 
WHERE genre='Fantasy'
ORDER BY price DESC
LIMIT 3 ;

---- 6) Retrieve the total quantity of books sold by each author:
SELECT b.author,SUM(o.quantity) AS Total_quantity
FROM books b
JOIN orders o on b.book_id = o.book_id
GROUP BY b.author ;

-- 7) List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.city,o.total_amount
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
WHERE o.total_amount>30 ;

-- 8) Find the customer who spent the most on orders:
SELECT c.customer_id,c.name,SUM(total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.name,c.customer_id
ORDER BY SUM(total_amount) DESC
LIMIT 1 ;
