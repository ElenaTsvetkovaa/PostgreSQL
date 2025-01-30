CREATE OR REPLACE FUNCTION fn_count_employees_by_town(town_name VARCHAR(20))
RETURNS INT
AS
$$
    DECLARE
        e_count INT;
    BEGIN
        SELECT
            count(employee_id) INTO e_count
        FROM
            employees
                JOIN
            addresses
            USING
                (address_id)
                JOIN
            towns AS t
            USING
                (town_id)
        WHERE
            t.name = town_name;
        RETURN e_count;
    END;
$$
LANGUAGE plpgsql;