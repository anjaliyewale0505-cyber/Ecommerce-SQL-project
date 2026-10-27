create database ecommerce_project; 

use ecommerce_project; 

CREATE TABLE Customers (
    customer_id   INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email         VARCHAR(100) NOT NULL,
    city          VARCHAR(50),
    phone         VARCHAR(15),
    signup_date   DATE
);
 
CREATE TABLE Products (
    product_id     INT AUTO_INCREMENT PRIMARY KEY,
    product_name   VARCHAR(100) NOT NULL,
    category       VARCHAR(50),
    price          DECIMAL(10,2) NOT NULL,
    stock_quantity INT,
    brand          VARCHAR(50)
);
 
CREATE TABLE Orders (
    order_id      INT AUTO_INCREMENT PRIMARY KEY,
    customer_id   INT,
    product_id    INT,
    quantity      INT,
    order_date    DATE,
    total_amount  DECIMAL(10,2)
);

select count(*) from Orders;


select * from Customers; 

select * from Products; 

select * from orders; 

create database demo; 

use demo; 

select * from customers;

select * from orders;

select * from products; 

-- 1 Display all products from the Products table 

SELECT *
FROM products; 

-- 2 Find all customers who are from Mumbai 

SELECT *
FROM customers
WHERE city = 'Mumbai';
 
-- 3 Display products where the price is greater than ₹1,000

SELECT *
FROM products
WHERE price > 1000;  

-- 4 Find the total number of products available 

SELECT COUNT(*) AS total_products
FROM products; 

-- 5 Display all orders placed after 2025-01-01 

SELECT *
FROM orders
WHERE order_date > '2025-01-01'; 

-- 6 Find the average price of all products 

SELECT AVG(price) AS average_price
FROM products; 

-- 7 Find the maximum and minimum product price 

SELECT MAX(price) AS highest_price
FROM products; 

-- 8 Find the minimum product price

SELECT MIN(price) AS lowest_price
FROM products; 

-- 9 Find the number of orders placed by each customer 

SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;

-- 10 Find customers who have placed more than 3 orders 

SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 3;

-- 11 Display products category-wise 

SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category; 

-- 12 Find the top 5 most expensive products 

SELECT *
FROM products
ORDER BY price DESC
LIMIT 5; 

-- 13 Find products whose price is between ₹500 and ₹2,000 

SELECT *
FROM products
WHERE price BETWEEN 500 AND 2000; 

-- 14 Find the total quantity sold for each product 

SELECT product_id, SUM(quantity) AS total_quantity
FROM orders
GROUP BY product_id; 

-- 15 Display customer name and their order details using JOIN 

SELECT c.customer_name,
       o.order_id,
       o.order_date,
       o.total_amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id; 

-- 16 Find the total sales for each product 

SELECT product_id, SUM(total_amount) AS total_sales
FROM orders
GROUP BY product_id; 

-- 17 Display product name, quantity, and order amount using JOIN 

SELECT p.product_name,
       o.quantity,
       o.total_amount
FROM products p
JOIN orders o
ON p.product_id = o.product_id; 

-- 18 Find customers who have never placed an order 

SELECT c.customer_id, c.customer_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL; 

-- 19 Find the category having the highest total sales 

SELECT p.category, SUM(o.total_amount) AS total_sales
FROM products p
JOIN orders o
ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY total_sales DESC
LIMIT 1; 

-- 20 Find the total revenue generated in each month 

SELECT MONTH(order_date) AS month,
       SUM(total_amount) AS total_revenue
FROM orders
GROUP BY MONTH(order_date)
ORDER BY month; 

-- 21 Find the second-highest product price 

SELECT MAX(price) AS second_highest_price
FROM products
WHERE price < (
    SELECT MAX(price)
    FROM products
); 

-- 22 Find the customer who spent the maximum amount 

SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 1; 

-- 23 Find top 3 customers by total spending 

SELECT customer_id,
       SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 3; 

-- 24 Find products whose sales are greater than average product sales  

SELECT product_id,
       SUM(total_amount) AS total_sales
FROM orders
GROUP BY product_id
HAVING SUM(total_amount) > (
    SELECT AVG(total_sales)
    FROM (
        SELECT SUM(total_amount) AS total_sales
        FROM orders
        GROUP BY product_id
    ) AS sales
); 

-- 25 Find the most frequently ordered product 

SELECT product_id,
       COUNT(*) AS order_count
FROM orders
GROUP BY product_id
ORDER BY order_count DESC
LIMIT 1; 

-- 26 Find customers who placed more orders than the average customer 

SELECT customer_id,
       COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > (
    SELECT AVG(order_count)
    FROM (
        SELECT COUNT(*) AS order_count
        FROM orders
        GROUP BY customer_id
    ) AS customer_orders
); 

-- 27 Find the highest-selling product in each category 

SELECT category, product_id, total_sales
FROM (
    SELECT p.category,
           p.product_id,
           SUM(o.total_amount) AS total_sales,
           RANK() OVER (
               PARTITION BY p.category
               ORDER BY SUM(o.total_amount) DESC
           ) AS rnk
    FROM products p
    JOIN orders o
    ON p.product_id = o.product_id
    GROUP BY p.category, p.product_id
) AS ranked_products
WHERE rnk = 1; 

-- 28 Find the month with the highest revenue 

SELECT MONTH(order_date) AS month,
       SUM(total_amount) AS revenue
FROM orders
GROUP BY MONTH(order_date)
ORDER BY revenue DESC
LIMIT 1; 

-- 29 Find customers who purchased more than 3 different products 

SELECT customer_id,
       COUNT(DISTINCT product_id) AS different_products
FROM orders
GROUP BY customer_id
HAVING COUNT(DISTINCT product_id) > 3; 

-- 30 Find the second-highest-selling category 
SELECT category, total_sales
FROM (
    SELECT p.category,
           SUM(o.order_date) AS total_sales,
           DENSE_RANK() OVER (
               ORDER BY SUM(o.total_amount) DESC
           ) AS rnk
    FROM products p
    JOIN orders o
    ON p.product_id = o.product_id
    GROUP BY p.category
) AS category_sales
WHERE rnk = 2;