/*
Partt 2 of the query:
(hacker_id, name) of the hacker who made maximum number of submissions each day.
If more than one such hacker has a maximum number of submissions, print the lowest hacker_id. 
*/
 
-- get row number with ROW_NUMBER() PARTITION
;WITH CTE1 (submission_date, hacker_id, num_submission)
AS
(
	SELECT submission_date, hacker_id, COUNT(submission_id)
	FROM Submissions 
	GROUP BY submission_date, hacker_id
)
SELECT submission_date, hacker_id, num_submission, 
	ROW_NUMBER() OVER (PARTITION BY submission_date ORDER BY num_submission DESC, hacker_id ASC) AS rn
FROM CTE1
ORDER BY submission_date, rn;

-- ok
;WITH CTE1 (submission_date, hacker_id, num_submission)
AS
(
	SELECT submission_date, hacker_id, COUNT(submission_id)
	FROM Submissions 
	GROUP BY submission_date, hacker_id
)
SELECT t1.submission_date AS submission_date, t1.hacker_id AS hacker_id, h.name AS hacker_name
FROM
(
	SELECT submission_date, hacker_id, num_submission, 
		ROW_NUMBER() OVER (PARTITION BY submission_date ORDER BY num_submission DESC, hacker_id ASC) AS rn
	FROM CTE1
) t1
LEFT JOIN Hackers h ON h.hacker_id = t1.hacker_id
WHERE rn = 1
GO



