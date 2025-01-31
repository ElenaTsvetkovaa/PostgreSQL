CREATE OR REPLACE PROCEDURE sp_deposit_money (
    account_id INT,
    money_amount NUMERIC
)
AS
$$
    DECLARE
       initial_balance INT;
        temp_val INT;
BEGIN
    SELECT balance FROM accounts WHERE id = account_id INTO initial_balance;

    UPDATE accounts
    SET balance = balance + money_amount
    WHERE id = account_id;

    SELECT balance FROM accounts WHERE id = account_id INTO temp_val;

    IF initial_balance + money_amount <> temp_val
        THEN ROLLBACK;
    END IF;

    COMMIT;
END;
$$
LANGUAGE plpgsql;
