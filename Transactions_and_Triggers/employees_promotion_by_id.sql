CREATE OR REPLACE PROCEDURE sp_increase_salary_by_id(id INT)
AS
$$
    BEGIN
        IF id <> ( SELECT
                       employee_id
                   FROM
                       employees
                   WHERE
                       employee_id = id)
        THEN ROLLBACK;
        END IF;
        UPDATE
            employees
        SET
            salary = salary * 1.05
        WHERE
            employee_id = id;
    END;
$$
LANGUAGE plpgsql;
