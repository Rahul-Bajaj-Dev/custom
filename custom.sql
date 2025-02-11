-- Retrieve the names of all restaurants offering a specific cuisine (e.g., Italian)
SELECT name FROM restaurants WHERE cuisine = 'Italian';

-- Add a new customer to the database with their details
INSERT INTO customers (name, email, phone, address) VALUES ('John Doe', 'johndoe@example.com', '1234567890', '123 Main St');

-- Update the price of a particular dish in a specific restaurant
UPDATE dishes SET price = 15.99 WHERE name = 'Pasta Carbonara' AND restaurant_id = 1;

-- Remove a dish from the menu if it's marked as unavailable
DELETE FROM dishes WHERE available = false;

-- Display the customer who has placed the highest number of orders
SELECT customer_id, COUNT(*) AS order_count FROM orders GROUP BY customer_id ORDER BY order_count DESC LIMIT 1;

-- For each cuisine type, calculate the average price of dishes
SELECT cuisine, AVG(price) AS average_price FROM dishes JOIN restaurants ON dishes.restaurant_id = restaurants.id GROUP BY cuisine;

-- Retrieve the top 5 most popular dishes based on the number of times they were ordered
SELECT dish_id, COUNT(*) AS order_count FROM order_items GROUP BY dish_id ORDER BY order_count DESC LIMIT 5;

-- Identify customers who haven't placed an order in the last month
SELECT * FROM customers WHERE id NOT IN (SELECT DISTINCT customer_id FROM orders WHERE order_date >= NOW() - INTERVAL '1 month');

-- Find restaurants that offer dishes priced above the average price for their cuisine type
SELECT DISTINCT r.name FROM restaurants r JOIN dishes d ON r.id = d.restaurant_id WHERE d.price > (SELECT AVG(d2.price) FROM dishes d2 WHERE d2.restaurant_id = r.id);

-- Display the order details for a given order ID, including customer information and ordered items
SELECT o.id AS order_id, c.name AS customer_name, c.email, c.phone, c.address, d.name AS dish_name, d.price FROM orders o JOIN customers c ON o.customer_id = c.id JOIN order_items oi ON o.id = oi.order_id JOIN dishes d ON oi.dish_id = d.id WHERE o.id = ?;
