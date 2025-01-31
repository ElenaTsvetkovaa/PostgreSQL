CREATE OR REPLACE PROCEDURE sp_withdraw_money (
    account_id INT,
    money_amount NUMERIC
)
AS
$$
    DECLARE
        initial_balance INT;
    BEGIN
        SELECT balance FROM accounts WHERE id = account_id INTO initial_balance;

        IF initial_balance < money_amount THEN
            RAISE NOTICE 'NOTICE: Insufficient balance to withdraw %', money_amount;
        ELSE
            UPDATE accounts
            SET balance = balance - money_amount
            WHERE id = account_id;
            COMMIT;
        END IF;

    END;
$$
LANGUAGE plpgsql;