--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem

SELECT 
CASE WHEN Grades.Grade > 7 THEN Students.Name WHEN Grades.Grade <= 7 THEN NULL END, 
Grades.Grade, 
Students.Marks 
FROM Students 
INNER JOIN Grades 
ON Students.Marks BETWEEN Grades.Min_Mark AND Grades.Max_Mark 
ORDER BY Grades.Grade DESC, Students.Name ASC, Students.Marks ASC;

--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem
SELECT 
MIN(CASE WHEN Occupation = 'Doctor' THEN Name ELSE NULL END) AS Doctor, 
MIN(CASE WHEN Occupation = 'Professor' THEN Name ELSE NULL END) AS Professor, 
MIN(CASE WHEN Occupation = 'Singer' THEN Name ELSE NULL END) AS Singer, 
MIN(CASE WHEN Occupation = 'Actor' THEN Name ELSE NULL END) AS Actor 
FROM 
(SELECT a.Occupation, a.Name, DENSE_RANK() OVER (PARTITION BY a.Occupation ORDER BY a.Name) rank FROM Occupations a ) c GROUP BY c.rank ORDER BY c.rank

--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem

SELECT DISTINCT CITY
FROM STATION
WHERE not (CITY LIKE 'A%' OR  CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%');
					
--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem

SELECT DISTINCT CITY 
FROM STATION
WHERE not (CITY LIKE '%a' OR  CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u');

--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem

SELECT DISTINCT CITY
FROM STATION
WHERE not (CITY LIKE '%a' OR  CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u') 
or not(CITY LIKE 'A%' OR  CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%');

--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem

SELECT DISTINCT CITY
FROM STATION
WHERE not (CITY LIKE '%a' OR  CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u') 
and not(CITY LIKE 'A%' OR  CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%');

--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem

select name from Employee
where salary > 2000 and months < 10
order by employee_id;

--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem

SELECT 
CASE WHEN Grades.Grade > 7 THEN Students.Name WHEN Grades.Grade <= 7 THEN NULL END, 
Grades.Grade, 
Students.Marks 
FROM Students 
INNER JOIN Grades 
ON Students.Marks BETWEEN Grades.Min_Mark AND Grades.Max_Mark 
ORDER BY Grades.Grade DESC, Students.Name ASC, Students.Marks ASC;
