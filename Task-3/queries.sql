-- Write a query to fetch all customer names and sort them alphabetically. (Topic Soring)

SELECT name
FROM customers
ORDER BY name ASC;

-- Write a query to fetch all product names and their prices, sorted by price from low to high. (Topic Sorting)

SELECT name, price
FROM products
ORDER BY price ASC;

-- Write a query to fetch supplier names that start with the letter 'A' and sort them by their names. (Topic Sorting with Operators and Wildcards)

SELECT name
FROM suppliers
WHERE name LIKE 'A%'
ORDER BY name ASC;

-- Write a query to fetch all items and sort them by their status, placing NULL values first.

SELECT *
FROM items
ORDER BY status NULLS FIRST;

-- Write a query to fetch all products, sort them first by category and then by price in descending order.

SELECT *
FROM products
ORDER BY category ASC, price DESC;

-- Write a query to fetch all customer names and phone numbers, but sort them by the last four digits of their phone numbers in ascending order. (Hint use sorting with substings)

SELECT name, phone
FROM customers
ORDER BY substring(phone from '-4'::text) ASC;