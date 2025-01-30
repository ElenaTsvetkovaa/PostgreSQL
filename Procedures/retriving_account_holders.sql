CREATE OR REPLACE PROCEDURE sp_retrieving_holders_with_balance_higher_than(
    searched_balance NUMERIC
)
AS
$$
    DECLARE
        acc_record RECORD;
    BEGIN
        FOR acc_record IN
            SELECT
                first_name,
                last_name,
                SUM(a.balance) AS total_balance
            FROM
                account_holders AS ah
                    JOIN
                accounts AS a
                ON
                    ah.id = a.account_holder_id
            GROUP BY
                first_name,
                last_name
            ORDER BY
                first_name,
                last_name
        LOOP
            IF acc_record.total_balance > searched_balance
                THEN RAISE NOTICE 'NOTICE: % % - %',
                    acc_record.first_name, acc_record.last_name, acc_record.total_balance;
            END IF;
        END LOOP;
    END;
$$
LANGUAGE plpgsql;


CALL sp_retrieving_holders_with_balance_higher_than(200000)
