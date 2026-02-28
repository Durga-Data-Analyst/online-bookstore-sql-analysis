-- ========================================
-- BUSINESS ANALYSIS QUERIES
-- ========================================

-- 1️⃣ Top 5 Revenue Generating Books
SELECT 
    b.title,
    SUM(o.total_amount) AS total_revenue
FROM books b
JOIN orders o ON b.book_id = o.book_id
GROUP BY b.title
ORDER BY total_revenue DESC
LIMIT 5;


-- 2️⃣ Monthly Revenue Trend
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY month
ORDER BY month;


-- 3️⃣ Customer Lifetime Value (Window Function)
SELECT 
    c.customer_id,
    c.name,
    SUM(o.total_amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS spending_rank
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;


-- 4️⃣ Low Stock Alert (Operational Insight)
SELECT 
    title,
    stock
FROM books
WHERE stock < 5
ORDER BY stock;
