CREATE OR REPLACE FUNCTION
    fn_full_name (first_name VARCHAR, last_name VARCHAR)
RETURNS VARCHAR
AS
$$
    DECLARE
        full_name VARCHAR;
    BEGIN
        full_name := INITCAP(first_name) || ' ' || initcap(last_name);
        RETURN full_name;
    END;
$$
LANGUAGE plpgsql;

