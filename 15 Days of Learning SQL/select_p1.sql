/*
Partt 1 of the query:
(total number of unique hackers) who made at least 1 submission each day (since the start)
*/

-- ok, wrong
WITH CTE1 (submission_date, hacker_id, num_submission)
AS
(
	SELECT submission_date, hacker_id, COUNT(submission_id)
	FROM Submissions 
	GROUP BY submission_date, hacker_id
)
SELECT t3.submission_date, COUNT(DISTINCT hacker_id) AS total_submission
FROM (SELECT * FROM CTE1 WHERE CTE1.num_submission >= 1) t3
GROUP BY t3.submission_date;














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

SELECT * FROM #Temp;

-- ok
SELECT #Temp.submission_date, COUNT(#Temp.hacker_id) AS total_submission
FROM #Temp
GROUP BY #Temp.submission_date;
































