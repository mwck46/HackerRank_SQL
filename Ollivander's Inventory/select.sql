/*
Wands: id, code, coins_needed, power
Wands_Property: code, age, is_evil
*/

;WITH CTE1 (id, age, coins_needed, power)
AS
(
SELECT w.id, p.age, w.coins_needed, w.power
FROM Wands w
JOIN Wands_Property p
ON p.code = w.code
WHERE p.is_evil = 0
)
SELECT t0.id, t0.age, t0.coins_needed, t0.power
FROM
(
SELECT CTE1.*, ROW_NUMBER() OVER (PARTITION BY CTE1.age, CTE1.power ORDER BY CTE1.coins_needed ASC) AS rn
FROM CTE1
) t0
WHERE rn = 1
ORDER BY t0.power DESC, t0.age DESC;