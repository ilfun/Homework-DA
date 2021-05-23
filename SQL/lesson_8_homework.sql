--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/

with temp as
(
select department.name as Department, employee.name as Employee, Salary,
DENSE_RANK() OVER(partition by department.name order by salary desc) as num
from employee
join department
on employee.departmentid = department.id
)
select Department, Employee, Salary
from temp
where num < 4

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17

SELECT member_name, status, sum(unit_price*amount) as costs
from FamilyMembers
JOIN Payments ON 
FamilyMembers.member_id = Payments.family_member
where YEAR(date) = 2005
GROUP BY member_id

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13

SELECT name
from Passenger
GROUP BY name
HAVING COUNT(name) > 1 

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

SELECT COUNT(first_name) as count
from Student
where first_name = 'Anna' 

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35

select count(classroom) as count
from Schedule
where DAYOFMONTH(date) = 2
GROUP BY date

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

SELECT COUNT(first_name) as count
from Student
where first_name = 'Anna' 

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32

 Select ROUND(avg((YEAR(CURRENT_DATE)-YEAR(birthday))-(RIGHT(CURRENT_DATE,5)<RIGHT(birthday,5)
  )),0) AS age
  FROM  FamilyMembers

--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27
  
SELECT good_type_name, sum(amount*unit_price) as costs from Payments
join Goods
on Payments.good=Goods.good_id
join GoodTypes
on Goods.type=GoodTypes.good_type_id
where YEAR(date) = 2005
GROUP BY good_type_name

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37

Select ROUND(min((YEAR(CURRENT_DATE)-YEAR(birthday))-(RIGHT(CURRENT_DATE,5)<RIGHT(birthday,5)
  )),0) AS year
  FROM  Student

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44
  
Select ROUND(max((YEAR(CURRENT_DATE)-YEAR(birthday))-(RIGHT(CURRENT_DATE,5)<RIGHT(birthday,5)
)),0) AS max_year
FROM  Student
JOIN Student_in_class
on Student.id = Student_in_class.student
join Class
on Student_in_class.class=class.id
where name LIKE '10%'

--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20

SELECT status, member_name, sum(amount*unit_price) as costs  from Payments
join Goods
on Payments.good=Goods.good_id
join GoodTypes
on Goods.type=GoodTypes.good_type_id
join FamilyMembers
on Payments.family_member=FamilyMembers.member_id
where good_type_name = 'entertainment'
GROUP BY family_member

--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55
with tmp_table1 as
(
with tmp_table as
(select company, count(id) as count, 
DENSE_RANK() OVER(ORDER BY count(id)) as rnk
from trip
GROUP BY Company)
select name
 from tmp_table
join Company
on tmp_table.company = Company.id
WHERE rnk = 1
)
delete from Company
where name in (select name from tmp_table1)

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45
with final_tab AS 
(
select classroom, count(classroom) as count, 
DENSE_RANK() OVER(ORDER BY count(classroom) desc) as rnk
from Schedule
GROUP BY  classroom)
select classroom from final_tab
where rnk < 2

--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43
SELECT last_name from 
Schedule
join Subject
on Schedule.subject=Subject.id
JOIN Teacher
on Schedule.teacher=Teacher.id
where Subject.name = 'Physical Culture'
ORDER BY last_name

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63

SELECT (CONCAT(student.last_name, '.', LEFT(student.first_name, 1), '.', LEFT(student.middle_name, 1), '.')) as name FROM Student
ORDER BY name
