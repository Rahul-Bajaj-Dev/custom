-- 1. Retrieve the names of all restaurants offering a specific cuisine (e.g., Italian).
SELECT DISTINCT r.name
FROM restaurants r
JOIN dishes d ON r.restaurant_id = d.restaurant_id
WHERE d.cuisine = 'Italian';

-- 2. Add a new customer to the database with their details.
INSERT INTO customers (customer_id, name, email, phone_number, address)
VALUES (1, 'John Doe', 'johndoe@example.com', '123-456-7890', '123 Main St, Springfield');

-- 3. Update the price of a particular dish in a specific restaurant.
UPDATE dishes
SET price = 19.99
WHERE dish_id = 101 AND restaurant_id = 1;

-- 4. Remove a dish from the menu if it's marked as unavailable.
DELETE FROM dishes
WHERE dish_id = 202 AND availability = 'unavailable';

-- 5. Display the customer who has placed the highest number of orders.
SELECT c.name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY order_count DESC
LIMIT 1;

-- 6. For each cuisine type, calculate the average price of dishes.
SELECT d.cuisine, AVG(d.price) AS average_price
FROM dishes d
GROUP BY d.cuisine;

-- 7. Retrieve the top 5 most popular dishes based on the number of times they were ordered.
SELECT d.dish_name, COUNT(oi.dish_id) AS order_count
FROM dishes d
JOIN order_items oi ON d.dish_id = oi.dish_id
GROUP BY d.dish_id
ORDER BY order_count DESC
LIMIT 5;

-- 8. Identify customers who haven't placed an order in the last month.
SELECT c.name, c.email
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date < CURRENT_DATE - INTERVAL 1 MONTH OR o.order_date IS NULL;

-- 9. Find restaurants that offer dishes priced above the average price for their cuisine type.
SELECT r.name
FROM restaurants r
JOIN dishes d ON r.restaurant_id = d.restaurant_id
WHERE d.price > (
    SELECT AVG(price)
    FROM dishes
    WHERE cuisine = d.cuisine
);

-- 10. Display the order details for a given order ID, including customer information and ordered items.
SELECT o.order_id, c.name AS customer_name, c.email, d.dish_name, oi.quantity, oi.price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN dishes d ON oi.dish_id = d.dish_id
WHERE o.order_id = 123;
