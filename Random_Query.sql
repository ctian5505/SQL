---------------------------------------------------------------------------------------------------------
DATA

INSERT INTO [Orders](customer_id, order_date)
VALUES
(1, '2023-01-01'),
(1, '2023-01-02'),
(2, '2023-02-10'),
(2, '2023-02-11'),
(3, '2023-03-03'),
(3, '2023-03-05')


CREATE TABLE Orders(
customer_id int,
order_date DATE
)

-- Write a SQL Query to find the customers who have made at least two consecutive orders

WITH CTE AS (
SELECT 
	customer_id, 
	order_date,
	LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS Previous_order,
	DATEDIFF(day,LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date),order_date) AS Interval
FROM Orders
)

SELECT *
FROM CTE
WHERE Interval = 1

---------------------------------------------------------------------------------------------------------
