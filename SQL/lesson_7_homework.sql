--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: Сделать тестовый проект с БД (sqlite3, project name: task1_7). В таблицу table1 записать 1000 строк с случайными значениями (3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонко

"Это задание не выполнил. Таблицу создал в sql, но запутлася в синтаксисе создания  в sqlite3"

CREATE TABLE table1 as
select generate_series(1,1000) AS id, (floor(random() * 1000)::int) as r, (floor(random() * 1000)::int) as k 

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/

select email
from Person
group by email
having count(email) > 1

--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/

SELECT a.name as Employee
FROM Employee a,Employee b
WHERE a.ManagerId=b.Id
AND a.salary > b.salary

--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/

SELECT score,  
DENSE_RANK() OVER(ORDER BY score desc) as RANK
FROM Scores

--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/

select firstname, lastname, city, state
from person
left join address on person.personid = address.personid

