CREATE TABLE IF NOT EXISTS gift_recipients (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(80),
    country_id INT,
    gift_sent BOOLEAN DEFAULT FALSE,

    CONSTRAINT fk_gift_recipients_countries
    FOREIGN KEY (country_id) REFERENCES countries(id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO gift_recipients
    (name, country_id, gift_sent)
SELECT
    CONCAT(first_name, ' ', last_name),
    country_id,
    CASE
        WHEN country_id IN (7, 8, 14, 17, 26) THEN TRUE
        ELSE FALSE
    END
FROM
    customers;