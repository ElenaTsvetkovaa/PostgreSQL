
-- Creating bank and inserting values
CREATE TABLE bank (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10),
    amount INT
);

-- Creating transaction
CREATE OR REPLACE PROCEDURE sp_money_transfer (
    IN transaction_amount INT,
    IN sender_name VARCHAR(20),
    IN receiver_name VARCHAR(20),
    OUT status VARCHAR(40)
)
AS
$$
    DECLARE
        sender_id INT := (SELECT fn_get_bank_user_id(sender_name));
        receiver_id INT := (SELECT fn_get_bank_user_id(receiver_name));
        sender_money INT;
        receiver_money INT;
        temp_val INT;
    BEGIN
        IF sender_id IS NOT NULL AND receiver_id IS NOT NULL
            THEN SELECT amount FROM bank WHERE id = sender_id INTO sender_money;
                 SELECT amount FROM bank WHERE id = receiver_id INTO receiver_money;
        ELSE
            RAISE NOTICE 'Invalid account name.';
            RETURN;
        END IF;

        IF sender_money < transaction_amount THEN
        RAISE NOTICE 'Not enough money in the bank account.' ;
        RETURN;
        END IF;

        UPDATE bank SET amount = sender_money - transaction_amount WHERE id = sender_id;
        UPDATE bank SET amount = receiver_money + transaction_amount WHERE id = receiver_id;

        SELECT amount FROM bank WHERE id = sender_id INTO temp_val;

        IF sender_money - transaction_amount <> temp_val
            THEN status := 'Unsuccessful transfer of sender.';
                ROLLBACK;
        END IF;

        SELECT amount FROM bank WHERE id = receiver_id INTO temp_val;

        IF receiver_money + transaction_amount <> temp_val
            THEN status := 'Unsuccessful transfer to receiver.';
                ROLLBACK;
        END IF;

        status := 'Successful transaction';
        COMMIT ;


        END;
$$
LANGUAGE plpgsql;

-- Function to get the bank user id
CREATE OR REPLACE FUNCTION fn_get_bank_user_id (user_name varchar)
RETURNS INT
AS
$$
    DECLARE
        searched_id INT;
    BEGIN
        SELECT
            id INTO searched_id
        FROM
            bank
        WHERE
            name = user_name;
        RETURN searched_id;
    END;
$$
LANGUAGE plpgsql;

-- Calling the procedure
CALL sp_money_transfer(200, 'Elena', 'Ava', null);

-- Comparing results before and after
SELECT * FROM bank;