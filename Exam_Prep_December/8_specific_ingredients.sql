SELECT
    i.name AS ingredient_name,
    p.name AS product_name,
    d.name AS distributor_name
FROM
    products_ingredients AS pri
JOIN
    products AS p
ON pri.product_id = p.id
JOIN
    ingredients AS i
ON i.id = pri.ingredient_id
JOIN
    distributors AS d
ON i.distributor_id = d.id
WHERE
    i.name ILIKE 'mustard'
        AND
    d.country_id = 16
ORDER BY
    product_name;