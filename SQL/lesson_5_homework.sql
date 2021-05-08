--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- Компьютерная фирма: Сделать view (pages_all_products),  . Вывод: все данные из laptop, номер страницы, список всех страниц
create view pages_all_products as
SELECT *, 
      CASE WHEN num % 2 = 0 
      THEN num/2 
      ELSE num/2 + 1 
      END AS page_num
FROM (
      SELECT *, ROW_NUMBER() OVER() AS num, 
             COUNT(*) OVER() AS total 
      FROM Laptop
) a


--task2 (lesson5)
-- Компьютерная фирма: Сделать view (distribution_by_type), в рамках которого будет процентное соотношение всех товаров по типу устройства. Вывод: производитель,

create view distribution_by_type as
with final_tab as(
SELECT distinct type, COUNT(*) OVER(partition by type) AS total_type, COUNT(*) OVER() AS total
from 
(select p.model, maker, p2.type from pc p 
join product p2 
on p.model=p2.model 
union all
select p3.model, maker, p2.type from printer p3 
join product p2 
on p3.model=p2.model 
union all
select l.model, maker, p2.type from laptop l
join product p2 
on l.model=p2.model) a)
select type, (cast(total_type as float) / total)*100 as dolya
from final_tab


--task3 (lesson5)
-- Компьютерная фирма: Сделать на базе предыдущенр view график - круговую диаграмму

request = """
select * from distribution_by_type
"""

df = pd.read_sql_query(request, conn)
fig = px.pie(df, values='dolya', names='type')
fig.show()

--task4 (lesson5)
-- Корабли: Сделать копию таблицы ships (ships_two_words), но у название корабля должно состоять из двух слов

create table ships_two_words as 
(select * from ships 
where name like '% %') 

--task5 (lesson5)
-- Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL) и название начинается с буквы "S"

select * from ships 
where class is null and name LIKE 'S%'


--task6 (lesson5)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и три самых дорогих (через оконные функции). Вывести model

select * from 
(
select *, row_number() over (order by price desc) as rn
from 
(select * from printer p 
          join product p2 
          on p.model = p2.model
          where maker = 'A' and price > (select avg(price) from printer p 
                                                           join product p2 
                                                           on p.model = p2.model 
                                                           where maker ='D')
) b
) a
where rn < 4

