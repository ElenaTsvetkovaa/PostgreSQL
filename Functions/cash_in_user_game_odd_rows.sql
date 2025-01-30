CREATE OR REPLACE FUNCTION fn_cash_in_users_games(
    game_name VARCHAR(50)
) RETURNS TABLE (
    total_cash NUMERIC
)
AS
$$
BEGIN
    RETURN QUERY
        SELECT
            SUM(ROUND(rn.cash, 2))
        FROM
            (SELECT
                 g.name,
                 ug.cash,
                 ROW_NUMBER() OVER (PARTITION BY g.name ORDER BY ug.cash DESC) AS r_classified
             FROM
                 users_games AS ug
                     JOIN
                 games AS g
                 ON ug.game_id = g.id
             WHERE
                 g.name = game_name
            ) AS rn
        WHERE rn.r_classified % 2 = 1;
END;
$$
LANGUAGE plpgsql;