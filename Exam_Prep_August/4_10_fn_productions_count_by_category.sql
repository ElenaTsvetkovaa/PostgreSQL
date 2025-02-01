CREATE OR REPLACE FUNCTION udf_category_productions_count(
    category_name VARCHAR(50)
) RETURNS VARCHAR(50)
AS
$$
    DECLARE
        productions_count INT;
    BEGIN
        SELECT
            COUNT(cp.production_id) INTO productions_count
        FROM
            categories AS c
        JOIN
            categories_productions AS cp
        ON c.id = cp.category_id
        WHERE
            c.name = category_name;
        RETURN FORMAT('Found %s productions.', productions_count);
    END;
$$
LANGUAGE plpgsql;

SELECT udf_category_productions_count('Nonexistent') AS message_text;

