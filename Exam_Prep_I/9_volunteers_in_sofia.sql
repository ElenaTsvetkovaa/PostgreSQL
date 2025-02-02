SELECT
    name,
    phone_number,
    (SELECT SUBSTR(address, POSITION(',' IN address) + 1)) AS address
FROM
    volunteers AS v
JOIN
     volunteers_departments AS vd
ON v.department_id = vd.id
WHERE
    vd.department_name = 'Education program assistant'
        AND
    v.address LIKE '%Sofia%'
ORDER BY
    v.name ASC;
