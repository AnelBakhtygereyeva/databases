--1
create database lab8;

--2
create table salesman (
    salesman_id int primary key,
    name varchar(100),
    city varchar(100),
    commission decimal(5,2)
);

create table customers (
    customer_id int primary key,
    cust_name varchar(100),
    city varchar(100),
    grade int,
    salesman_id int
);

create table orders (
    ord_no int primary key,
    purch_amt decimal(10,2),
    ord_date date,
    customer_id int,
    salesman_id int
);

insert into salesman values (5001, 'James Hoog', 'New York', 0.15),
                            (5002, 'Nail Knite', 'Paris', 0.13),
                            (5005, 'Pit Alex', 'London', 0.11),
                            (5006, 'Mc Lyon', 'Paris', 0.14),
                            (5003, 'Lausen Hen', null, 0.12),
                            (5007,'Paul Adam', 'Rome',0.13);

insert into customers values (3002, 'Nick Rimando', 'New York', 100, 5001),
                             (3005, 'Graham Zusi', 'California', 200, 5002),
                             (3001, 'Brad Guzan', 'London', null, 5005),
                             (3004, 'Fabian Johns', 'Paris', 300, 5006),
                             (3007, 'Brad Davis', 'New York', 200, 5001),
                             (3009, 'Geoff Camero', 'Berlin', 100, 5003),
                             (3008,'Juliain Green', 'London', 300, 5002);

insert into orders values (70001, 150.5, '20121005', 3005, 5002),
                          (70009, 270.65, '20120910', 3002, 5001),
                          (70002, 65.26, '20121005',3002,5001),
                          (70004, 110.5, '20120817',3009, 5003),
                          (70007, 948.5, '20120910',3005,5002),
                          (70005, 2400.6, '20120727',3007,5001),
                          (70008,5760, '20120910',3002,5001);

--3
-- Create role named «junior_dev» with login privilege
create role junior_dev login;

--4
--Create a view for those salesmen belongs to the city New York
create view ny_view as
    select * from salesman
        where city = 'New York';

--5
-- Create a view that shows for each order the salesman and customer by name. Grant all privileges to «junior_dev»
create view order_details as
    select o.ord_no,
           o.ord_date,
           o.purch_amt,
           c.cust_name as customer_name,
           s.name as salesman_name
    from orders o
    join customers c on o.customer_id = c.customer_id
    join salesman s on c.salesman_id = s.salesman_id;

grant all privileges on order_details to junior_dev;

--6
--Create a view that shows all of the customers who have the highest grade. Grant only select statements to «junior_dev»
create view highest_grade_customer as
    select * from customers
    where grade = (select max(grade) from customers);

grant select on highest_grade_customer to junior_dev;

--7
--Create a view that shows the number of the salesman in each city.
create view salesman_number_by_city as
    select city, count(*) as number_of_salesman
    from salesman
    group by city;

--8
--Create a view that shows each salesman with more than one customers.
create view salesman_with_customers as
    select s.name as salesman_name, count(c.customer_id) as customer_number_count
    from salesman s
    join customers c on s.salesman_id = c.salesman_id
    group by s.name
    having count(c.customer_id) > 1;

--9
--Create role «intern» and give all privileges of «junior_dev».
create role intern;
grant intern to junior_dev;








