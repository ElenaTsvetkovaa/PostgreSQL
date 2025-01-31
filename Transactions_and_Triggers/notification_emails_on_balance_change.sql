CREATE TABLE IF NOT EXISTS notification_emails (
    id SERIAL PRIMARY KEY,
    recipient_id INT,
    subject VARCHAR(50),
    body TEXT
);

CREATE OR REPLACE FUNCTION trigger_fn_send_email_on_balance_change ()
RETURNS TRIGGER AS
$$
    BEGIN
        INSERT INTO notification_emails
            (recipient_id, subject, body)
        VALUES
            (
             NEW.account_id,
             FORMAT('Balance change for account: %s', NEW.account_id),
             FORMAT('On %s your balance was changed from %s to %s.',
             TO_CHAR(NOW(), 'YYYY-MM-DD'), OLD.old_sum, NEW.new_sum)
             );
        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER
    tr_send_email_on_balance_change
AFTER UPDATE ON logs
FOR EACH ROW
WHEN
    ( OLD.old_sum <> NEW.new_sum )
EXECUTE FUNCTION trigger_fn_send_email_on_balance_change();
