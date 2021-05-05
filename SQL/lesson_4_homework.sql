--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). Вывести: model, maker, type

select p.model, maker, type 
from pc p 
join product p2 
on p.model = p2.model
union all
select p3.model, maker, p2.type 
from printer p3 
join product p2 
on p3.model = p2.model
union all
select l.model, maker, p2.type 
from laptop l 
join product p2 
on l.model = p2.model

--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, у кого цена вышей средней PC - "1", у остальных - "0"
select * , 
case
    when price > (select AVG(price) from pc) 
    then 1
    else 0
    end flag
 from printer 
 
 

--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)

 
 select name from ships 
 where class is null 

--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.
 

select name
from battles
where (SELECT Extract(YEAR from date) FROM battles) not in
     (select launched
      from ships
      )

--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.
select battle from outcomes o 
left join ships s 
on o.ship = s.name
where class = 'Kongo'
      
      
--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag

create view all_products_flag_300 as
select model, price,
case
    when price > 300 
    then 1
    else 0
    end flag
from pc
union all 
select model, price,
case
    when price > 300 
    then 1
    else 0
    end flag
from printer
union all 
select model, price,
case
    when price > 300 
    then 1
    else 0
    end flag
from laptop


--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше cредней . Во view три колонки: model, price, flag

create view all_products_flag_avg_price as
with all_prices as (select price from pc union all select price from printer union all select price from laptop)
select model, price,
case
    when price > (select avg(price) from all_prices)
    then 1
    else 0
    end flag
from pc
union all 
select model, price,
case
    when price > (select avg(price) from all_prices)
    then 1
    else 0
    end flag
from printer
union all 
select model, price,
case
    when price > (select avg(price) from all_prices)
    then 1
    else 0
    end flag
from laptop

--task3  (lesson4)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model

select p.model from printer p 
left join product p2 
on p.model = p2.model
where maker = 'A' and price > 
    (select AVG(price) from printer p 
    left join product p2 
    on p.model = p2.model
    where maker = 'D' or maker = 'C')


--task4 (lesson4)
-- Компьютерная фирма: Вывести все товары производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model
    
 with all_model_a as
      (select p.model, maker, price from pc p 
      left join product p2 
      on p.model = p2.model 
      where maker = 'A'
      union all 
      select p3.model, maker, price from printer p3 
      left join product p2 
      on p3.model = p2.model 
      where maker = 'A'
      union all 
      select l.model, maker, price from laptop l 
      left join product p2 
      on l.model = p2.model 
       where maker = 'A')
 select model from all_model_a
 where price > 
    (select AVG(price) from printer p 
    left join product p2 
    on p.model = p2.model
    where maker = 'D' or maker = 'C')
 
 

--task5 (lesson4)
-- Компьютерная фирма: Какая средняя цена среди уникальных продуктов производителя = 'A' (printer & laptop & pc)
    
   
    select avg(price),p2.model from pc p2 
    left join product p 
    on p2.model = p.model 
    where maker = 'A'
    group by p2.model
        union all 
    select avg(price),l.model from laptop l 
    left join product p 
    on l.model = p.model 
    where maker = 'A'
    group by l.model
        union all 
    select avg(price),p3.model from printer p3 
    left join product p 
    on p3.model = p.model 
    where maker = 'A'
    group by p3.model

--task6 (lesson4)
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. Во view: maker, count
    
create view count_products_by_makers as
with all_models as (
select p2.model, maker from pc p2 
left join product p 
on p2.model = p.model 
     union all 
select l.model, maker from laptop l 
left join product p 
on l.model = p.model 
        union all 
select p3.model, maker from printer p3 
left join product p 
on p3.model = p.model)
select count(model), maker from all_models
group by maker
 
 

--task7 (lesson4)
-- По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)

df = pd.read_sql_query(request, conn)
fig = px.bar(x=df['maker'].to_list(), y=df['count'].to_list(), labels={'x':'maker', 'y':'count'})
fig.show()

--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'

CREATE TABLE printer_updated AS
TABLE printer 

with printer_updated2 as (select * from printer_updated pu
left join product p2 
on pu.model = p2.model)
delete from printer_updated2
where maker = 'D'


-- Тут выдает ошибку, не понимаю, почему.  ERROR: relation "printer_updated2" does not exist
  








--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой производителя (название printer_updated_with_makers)

--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes). Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)

--task11 (lesson4)
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)

--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: если количество орудий больше или равно 9 - то 1, иначе 0

--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)

--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".

--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.

--task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)
