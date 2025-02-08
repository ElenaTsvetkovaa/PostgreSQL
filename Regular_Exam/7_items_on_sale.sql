SELECT
    i.name,
    CONCAT_WS(
        '/',
        UPPER(b.name),
        LOWER(c.name)
    ) AS promotion,
    CONCAT('On sale: ', i.description) AS description,
    i.quantity
FROM
    items AS i
JOIN
    brands AS b
ON i.brand_id = b.id
JOIN
    classifications AS c
ON i.classification_id = c.id
WHERE
    i.id NOT IN
    (SELECT item_id FROM orders_items)
ORDER BY
    quantity DESC,
    name ASC