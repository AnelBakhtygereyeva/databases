--1
create database lab4;
--2
create table Warehouses (
    code integer,
    location character varying (255),
    capacity integer
);
--3.1
insert into Warehouses(code,location,capacity)
values (1,'Chicago',3),
       (2,'Chicago',4),
       (3,'New York',7),
       (4,'Los Angeles',2),
       (5,'San Francisco',8);
--2
create table Boxes (
    code character (4),
    contents character varying (255),
    value real,
    warehouse integer
);
--3.2
insert into Boxes (code,contents,value,warehouse)
values ('OMN7','Rocks',180,3),
       ('4H8P','Rocks',250,1),
       ('4RT3','Scissors',190,4),
       ('7G3H','Rocks',200,1),
       ('8JN6','Papers',75,1),
       ('8Y6U','Papers',50,3),
       ('9J6F','Papers',175,2),
       ('LL08','Rocks', 140,4),
       ('P0H6', 'Scissors',125,1),
       ('P2T6','Scissors',150,2),
       ('TU55','Papers',90,5);
--4
select * from Warehouses;
--5
select * from boxes
         where value > 150;
--6
select distinct contents from boxes;
select contents, count(*) as numberOfBoxes
from boxes
group by contents;
--7
select warehouse, count(*) as numberOfBoxes
from boxes
group by warehouse;
--8
select warehouse, count(*) as numberOfBoxes
from boxes
group by warehouse
having count(*) > 2;
--9
insert into warehouses
values (5, 'New York',3);
--10
insert into boxes
values ('H5RT','Papers',200,2);
--11
update boxes
set value = value * 0.85
where value = (
    select value from boxes
    order by value desc
    limit 1 offset 2
);
--12
delete from boxes
     where value < 150;
--13
delete from warehouses
       where location = 'New York'
returning *;

