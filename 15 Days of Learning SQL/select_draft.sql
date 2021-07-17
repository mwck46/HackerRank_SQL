/* 
Combine 2 parts of the query
*/

/*
-- ok, wrong
WITH CTE1 (submission_date, hacker_id, num_submission)
AS
(
	SELECT submission_date, hacker_id, COUNT(submission_id)
	FROM Submissions 
	GROUP BY submission_date, hacker_id
)
SELECT t2.submission_date, t4.total_submission, t2.hacker_id, t2.hacker_name
FROM
(
	SELECT t1.submission_date AS submission_date, t1.hacker_id AS hacker_id, h.name AS hacker_name
	FROM
	(
		SELECT submission_date, hacker_id, num_submission, 
			ROW_NUMBER() OVER (PARTITION BY submission_date ORDER BY num_submission DESC, hacker_id ASC) AS rn
		FROM CTE1
	) t1
	LEFT JOIN Hackers h ON h.hacker_id = t1.hacker_id
	WHERE rn = 1
) t2
LEFT JOIN 
(
	SELECT submission_date, COUNT(DISTINCT hacker_id) AS total_submission
	FROM (SELECT * FROM CTE1 WHERE CTE1.num_submission >= 1) t3
	GROUP BY t3.submission_date
) t4
ON t2.submission_date = t4.submission_date 
*/


-- ok
--preparation for part 1 start
If(OBJECT_ID('tempdb..#Temp') Is Not Null)
Begin
  Drop Table #Temp
End
CREATE TABLE #Temp(
  submission_date DATE,
  hacker_id INTEGER, 
  num_submission INTEGER
)
DECLARE @d DATE = '2016-03-01'
;WITH CTE1 (submission_date, hacker_id, num_submission)
AS
(
	SELECT submission_date, hacker_id, COUNT(submission_id)
	FROM Submissions 
	GROUP BY submission_date, hacker_id
)
INSERT INTO #Temp
SELECT * FROM CTE1 WHERE CTE1.submission_date = @d

WHILE @d <= '2016-03-15'
BEGIN
	SET @d = DATEADD(DAY, 1, @d)

	;WITH CTE1 (submission_date, hacker_id, num_submission)
	AS
	(
		SELECT submission_date, hacker_id, COUNT(submission_id)
		FROM Submissions 
		GROUP BY submission_date, hacker_id
	)
	INSERT INTO #Temp (submission_date, hacker_id, num_submission)
	SELECT *
	FROM CTE1
	WHERE CTE1.submission_date = @d AND
	CTE1.hacker_id IN (SELECT hacker_id FROM #Temp WHERE #Temp.submission_date = DATEADD(DAY, -1, @d))

END
GO
--preparation for part 1 end
WITH CTE1 (submission_date, submission_date_p1, hacker_id, num_submission)
AS
(
	SELECT submission_date, DATEADD(DAY, 1, submission_date), hacker_id, COUNT(submission_id)
	FROM Submissions 
	GROUP BY submission_date, hacker_id
)
SELECT t2.submission_date, t4.total_submission, t2.hacker_id, t2.hacker_name
FROM
(
	SELECT t1.submission_date AS submission_date, t1.hacker_id AS hacker_id, h.name AS hacker_name
	FROM
	(
		SELECT submission_date, hacker_id, num_submission, 
			ROW_NUMBER() OVER (PARTITION BY submission_date ORDER BY num_submission DESC, hacker_id ASC) AS rn
		FROM CTE1
	) t1
	LEFT JOIN Hackers h ON h.hacker_id = t1.hacker_id
	WHERE rn = 1
) t2
LEFT JOIN 
(
	SELECT #Temp.submission_date, COUNT(#Temp.hacker_id) AS total_submission
	FROM #Temp
	GROUP BY #Temp.submission_date
) t4
ON t2.submission_date = t4.submission_date;





