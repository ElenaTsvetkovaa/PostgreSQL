CREATE OR REPLACE PROCEDURE udp_modify_account(
    address_street VARCHAR(30),
    address_town VARCHAR(30)
) AS
$$
BEGIN
    UPDATE accounts
    SET
        job_title = CONCAT('(Remote) ', accounts.job_title)
    WHERE
        id = (SELECT
                ad.account_id
            FROM
                addresses AS ad
            WHERE
                ad.street = address_street
                    AND
                ad.town = address_town);
END;
$$
LANGUAGE plpgsql;

