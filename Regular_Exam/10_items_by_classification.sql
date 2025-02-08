CREATE OR REPLACE FUNCTION udf_classification_items_count(
    classification_name VARCHAR(30)
) RETURNS VARCHAR(100)
AS
$$
    DECLARE
        items_count INT;
        message VARCHAR(100);
    BEGIN
        SELECT
            COUNT(*) INTO items_count
        FROM
            items as i
                JOIN
            classifications AS c
            ON i.classification_id = c.id
        WHERE
            c.name = classification_name;

        IF items_count > 0 THEN
            message := FORMAT('Found %s items.', items_count);
        ELSE
            message := 'No items found.';
        END IF;

        RETURN message;
    END;
$$
LANGUAGE plpgsql;

SELECT udf_classification_items_count('Laptops') AS message_text;

SELECT udf_classification_items_count('Nonexistent') AS message_text;