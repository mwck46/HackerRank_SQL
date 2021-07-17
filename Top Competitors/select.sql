-- Common Table Expresseion
WITH CTE1 (hacker_id, num_full_score)
AS
(
	SELECT s.hacker_id, COUNT(s.submission_id)
	FROM Submissions s
	LEFT JOIN Challenges c ON c.challenge_id = s.challenge_id
	LEFT JOIN Difficulty d ON c.difficulty_level = d.difficulty_level
	WHERE s.score = d.score
	GROUP BY s.hacker_id
	HAVING COUNT(s.submission_id) > 1
)
SELECT CTE1.hacker_id, h.name
FROM CTE1
LEFT JOIN Hackers h ON CTE1.hacker_id = h.hacker_id
ORDER BY CTE1.num_full_score DESC, hacker_id ASC;

/*
I think it is more efficient than the following because the number of 
rows is fewer when JOINing the 'Hackers' table

	SELECT s.hacker_id, h.name
	FROM Submissions s
	LEFT JOIN Challenges c ON c.challenge_id = s.challenge_id
	LEFT JOIN Difficulty d ON c.difficulty_level = d.difficulty_level
	LEFT JOIN Hackers h ON s.hacker_id = h.hacker_id
	WHERE s.score = d.score
	GROUP BY s.hacker_id
	HAVING COUNT(s.submission_id) > 1
	ORDER BY COUNT(s.submission_id) DESC, hacker_id ASC;
	
*/