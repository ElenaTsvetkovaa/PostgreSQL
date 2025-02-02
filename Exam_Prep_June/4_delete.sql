DELETE FROM addresses
WHERE
    id IN
        (SELECT
            id
        FROM
            addresses
        WHERE
            id % 2 = 0
                AND
            LOWER(street) LIKE '%r%')