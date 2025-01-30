
CREATE OR REPLACE FUNCTION fn_get_department_salaries_and_workers(dep_id INT)
RETURNS TABLE (
    employee_id INT,
    first_name VARCHAR,
    last_name VARCHAR,
    salary NUMERIC,
    department_name VARCHAR
)
AS
$$
    BEGIN
        RETURN QUERY (
            SELECT
                e.employee_id,
                e.first_name,
                e.last_name,
                e.salary,
                d.name AS department_name
            FROM
                employees AS e
                    JOIN
                departments AS d
                USING (department_id)
            WHERE
                d.department_id = dep_id);
    END;
$$
LANGUAGE plpgsql;

