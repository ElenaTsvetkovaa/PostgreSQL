INSERT INTO items
    (name, quantity, price, description, brand_id, classification_id)
SELECT
    CONCAT('Item', r.created_at),
    r.customer_id,
    r.rating * 5,
    NULL,
    r.item_id,
    (SELECT MIN(item_id) FROM reviews)
FROM
    reviews AS r
ORDER BY
    item_id ASC
LIMIT 10