SELECT
    i.name AS item_name,
    ROUND(AVG(rating), 2) AS average_rating,
    COUNT(r.item_id) AS total_reviews,
    b.name AS brand_name,
    c.name AS classification_name
FROM
    items AS i
JOIN
    reviews AS r
ON i.id = r.item_id
JOIN
    brands AS b
ON i.brand_id = b.id
JOIN
    classifications AS c
ON i.classification_id = c.id
GROUP BY
    i.name, b.name, c.name
HAVING
    COUNT(r.item_id) >= 3
ORDER BY
    average_rating DESC,
    item_name ASC
LIMIT 3;