SELECT [A], [B], [C]
 FROM [mytest].[dbo].[triangles];

 -- The order of the rules is IMPORTANT!!!
SELECT 
	CASE
		WHEN [A] + [B] <= [C] OR [B] + [C] <= [A] OR [A] + [C] <= [B] THEN 'Not A Triangle'
		WHEN [A] = [B] AND [B] = [C] THEN 'Equilateral'
		WHEN [A] = [B] OR [B] = [C] OR [A] = [C] THEN 'Isosceles'	
		ELSE 'Scalene'
	END
FROM [mytest].[dbo].[triangles];

/* 
--wrong!
SELECT 
	CASE
		WHEN [A] = [B] OR [B] = [C] OR [A] = [C] THEN 'Isosceles'
		WHEN [A] + [B] <= [C] OR [B] + [C] <= [A] OR [A] + [C] <= [B] THEN 'Not A Triangle'
		WHEN [A] = [B] AND [B] = [C] THEN 'Equilateral'
		ELSE 'Scalene'
	END
FROM [mytest].[dbo].[triangles];

--wrong!
SELECT 
	CASE
		WHEN [A] + [B] <= [C] OR [B] + [C] <= [A] OR [A] + [C] <= [B] THEN 'Not A Triangle'
		WHEN [A] = [B] OR [B] = [C] OR [A] = [C] THEN 'Isosceles'
		WHEN [A] = [B] AND [B] = [C] THEN 'Equilateral'
		ELSE 'Scalene'
	END
FROM [mytest].[dbo].[triangles];
*/