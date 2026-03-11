--creating books table 
Create TABLE Books (Book_ID SERIAL PRIMARY KEY,
Title	VARCHAR(100),
Author	VARCHAR(100),
Genre	VARCHAR(50),
Published_Year	INT,
Price	DECIMAL(10,2),
Stock	INT
);

--creating customers table
CREATE TABLE Customers (Customer_ID	SERIAL PRIMARY KEY,
name VARCHAR(100),Email	VARCHAR(100),
Phone	VARCHAR(20),
City	VARCHAR(50),
Country	VARCHAR(150)
) ;

--creating orders table
CREATE TABLE Orders  (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2));


SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

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

-- Advance Queries : 


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

--9) Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id ;

