CREATE OR REPLACE PROCEDURE sp_customer_country_name(
    IN customer_full_name VARCHAR(50),
    OUT country_name VARCHAR(50)
) AS
$$
    BEGIN
        SELECT
            ct.name INTO country_name
        FROM
            countries AS ct
        JOIN
            customers AS cu
        ON ct.id = cu.country_id
        WHERE
            CONCAT(cu.first_name, ' ', cu.last_name) = customer_full_name;
    END;
$$
LANGUAGE plpgsql;

CALL sp_customer_country_name('Betty Wallace', '')