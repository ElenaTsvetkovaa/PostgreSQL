SELECT
    c.id AS customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    COUNT(o.id) AS total_orders,
    CASE
        WHEN c.loyalty_card = TRUE THEN 'Loyal Customer'
        ELSE 'Regular Customer'
    END AS loyalty_status
FROM
    customers AS c
JOIN
    orders AS o
ON c.id = o.customer_id
GROUP BY
    c.id, c.first_name, c.last_name
HAVING
    c.id NOT IN (SELECT customer_id FROM reviews)
        AND
    COUNT(o.id) >= 1
ORDER BY
    total_orders DESC,
    customer_id ASC;