-- 1). Write a query to calculate the percentage contribution of each item's amount to its order's total amount, grouped by order_id. (Topics: Partition BY)

SELECT item_id, order_id, amount, total_amount, (amount / total_amount) * 100 AS percentage_contribution
	FROM (SELECT i.item_id, i.order_id, i.amount, o.total_amount, SUM(i.amount) OVER (PARTITION BY i.order_id) AS total_order_amount
	FROM Items i JOIN Orders o ON i.order_id = o.order_id);

-- 2). Write a query to rank orders by their total amount within each customer, ordering them from highest to lowest total amount. (Topics: Window functions like RANK, PARTITION BY, and ORDER BY)

SELECT customer_id, order_id, total_amount, 
	RANK() OVER (PARTITION BY customer_id ORDER BY total_amount DESC) AS order_rank
    FROM Orders;

-- 3). Write a query to calculate the average price of products supplied by each supplier. Exclude suppliers who have no products in the result. (Topics: JOINS, AGGREGATE FUNCTIONS, GROUP BY)

SELECT s.supplier_id, s.name, AVG(p.price) AS average_price FROM Suppliers s 
	JOIN Products p ON s.supplier_id = p.supplier_id
	GROUP BY s.supplier_id, s.name
	HAVING COUNT(p.product_id) > 0;

-- 4). Write a query to count the number of products in each category. Include categories with zero products in the result set. (WINDOW FUNCTIONS, AGGREGATE FUNCTIONS, JOINS, GROUP BY)

SELECT c.category_id, c.name, COUNT(p.product_id) AS product_count FROM Categories c
	LEFT JOIN Products p ON c.category_id = p.category
	GROUP BY c.category_id, c.name;

-- 5). Write a query to retrieve the total amount spent by each customer, along with their name and phone number. Ensure customers with no orders also appear with a total amount of 0. (WINDOW FUNCTIONS, AGGREGATE FUNCTIONS, JOINS, GROUP BY)

SELECT c.customer_id, c.name, c.phone, COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.phone;
