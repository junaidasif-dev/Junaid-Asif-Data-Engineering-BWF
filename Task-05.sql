-- Write a query to retrieve all orders placed by customers, including customer details (name, phone), order details (order ID, timestamp), and item details (product, amount). 

SELECT c.name AS customer_name, c.phone AS customer_phone, o.order_id, o.order_timestamp, i.product_id, i.amount
	FROM Orders o
	JOIN Customers c ON o.customer_id = c.customer_id
	JOIN Items i ON o.order_id = i.order_id;

-- Write a query to fetch all products along with their suppliers' details (name, phone) and the corresponding category name.

SELECT  p.product_id, p.name AS product_name, p.price, s.name AS supplier_name, s.phone AS supplier_phone, c.name AS category_name
	FROM Products p
	JOIN Suppliers s ON p.supplier_id = s.supplier_id
	JOIN Categories c ON p.category = c.category_id;

-- Write a query to retrieve details of all orders including the product name and amount ordered for each item.

SELECT o.order_id, o.order_timestamp, i.product_id, p.name AS product_name, i.amount
	FROM Orders o
	JOIN Items i ON o.order_id = i.order_id
	JOIN Products p ON i.product_id = p.product_id;

-- Write a query to retrieve all suppliers along with the city and country where they are located, and the products they supply.

SELECT s.supplier_id, s.name AS supplier_name, s.phone AS supplier_phone, 
	c.city_id, c.name AS city_name, c.country, p.product_id, p.name AS product_name
	FROM Suppliers s
	JOIN Products p ON s.supplier_id = p.supplier_id
	JOIN Cities c ON s.location = c.city_id;

-- Write a query to fetch details of the most recent order (by timestamp) placed by each customer, including the product details for each item in the order. [This question will use a Window Function alongside Joins]

WITH RecentOrders AS (
    SELECT o.customer_id, o.order_id, 
	o.order_timestamp, RANK() OVER (PARTITION BY o.customer_id ORDER BY o.order_timestamp DESC) AS rank
    FROM Orders o
)
SELECT c.customer_id, c.name AS customer_name, c.phone AS customer_phone, ro.order_id,
    ro.order_timestamp, i.product_id, p.name AS product_name, i.amount
	FROM RecentOrders ro
	JOIN Customers c ON ro.customer_id = c.customer_id
	JOIN Items i ON ro.order_id = i.order_id
	JOIN Products p ON i.product_id = p.product_id
	WHERE ro.rank = 1;
