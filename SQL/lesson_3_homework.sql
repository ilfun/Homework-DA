--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.

select class, count(ship)
from outcomes o 
left join ships s  
on o.ship = s.name
where result = 'sunk'
group by class


--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, 
--определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.

select min(launched),class
from ships
group by class


--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.
select min(launched),class from ships group by class


--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).
with ships_classes as (
select * 
from ships s 
left join classes c 
on s.class = c.class
) 
select distinct ship
from outcomes o
left join ships_classes sc
on o.ship = sc.name 
where numguns = (select max(numguns) from ships_classes) 



--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. 
--Вывести: Maker

with maker_pc_printer as 
(
    with min_ram_maker as 
         (
         select maker, ram, speed
         from pc p3 
         left join product p4  
         on p3.model = p4.model
         where ram = (select min(ram) from pc)
         )
        select maker, max(speed) 
        from min_ram_maker
        group by maker
)
select distinct maker 
from printer p 
join product p2 
on p.model = p2.model
where maker = any (select maker from maker_pc_printer)



