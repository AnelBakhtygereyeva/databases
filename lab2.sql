--1
create database lab2;

--2
create table countries (
    country_id serial primary key,
    country_name text,
    region_id int,
    population int
);

--3
insert into countries (country_name, region_id, population)
values ('Kazakhstan', 9, 20000000);

--4
insert into countries (country_id, country_name)
values (2, 'Japan');

--5
insert into countries (country_name, region_id, population)
values ('Switzerland', Null, 123456);

--6
insert into countries (country_name, region_id, population)
values ('Russia', 1,223024031),
       ('Canada', 2, 23423932),
       ('Germany', 3,134982049);

--7
alter table countries
alter column country_name set default 'Kazakhstan';

--8
insert into countries (region_id, population)
values (4, 23423432);

--9
insert into countries default values;

--10
create table countries_new (like countries);

--11
insert into countries_new (select * from countries);

--12
update countries_new
set region_id = 1
where region_id is null;

--13
select country_name,
       population * 1.10 as "New Population"
from countries_new;

--14
delete from countries
where population < 100000;

--15
delete from countries_new
using countries
where countries_new.country_id = countries.country_id
returning countries_new.*;

--16
delete from countries
returning *;

--at the end both tables are empty:(