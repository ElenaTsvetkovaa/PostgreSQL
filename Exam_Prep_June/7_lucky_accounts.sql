SELECT
    CONCAT(a.id, ' ', a.username) AS id_username,
    a.email
FROM
    accounts_photos AS ap
JOIN
    accounts AS a
ON ap.account_id = a.id
WHERE
    ap.account_id = ap.photo_id
ORDER BY
    ap.account_id