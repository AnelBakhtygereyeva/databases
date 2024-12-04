create database lab10;

create table books (
    book_id int primary key,
    title varchar(255),
    author varchar(255),
    price decimal(10, 2),
    quantity int
);

create table orders (
    order_id int primary key,
    book_id int references books(book_id),
    customer_id int,
    order_date date,
    quantity int
);


create table customers (
    customer_id int primary key,
    name varchar(255),
    email varchar(255)
);

insert into Books (book_id, title, author, price, quantity) values
(1,'Database 101', 'A. Smith', 40.00, 10),
(2,'Learn SQL', 'B. Johnson', 35.00, 15),
(3,'Advanced DB', 'C. Lee', 50.00, 5);

insert into Customers (customer_id, name, email) values
(101,'John Doe', 'johndoe@example.com'),
(102,'Jane Doe', 'janedoe@example.com');


--Tasks
--1 Transaction for Placing an Order

begin transaction;

insert into Orders (order_id, book_id, customer_id, order_date, quantity)
values (1, 1, 101, CURRENT_DATE, 2);

update Books
set quantity = quantity - 2
where book_id = 1;

commit;

--2 Transaction with Rollback

begin transaction;

insert into Orders (order_id, book_id, customer_id, order_date, quantity)
values (2, 3, 102, CURRENT_DATE, 10);


select * from books;
select * from orders;

rollback;

--or with the function
do $$
declare
    current_quantity int;
begin
    select quantity INTO current_quantity
    from books
    where book_id = 3;

    insert into orders (order_id, book_id, customer_id, order_date, quantity)
    values (2, 3, 102, CURRENT_DATE, 10);

    if current_quantity >= 10 then
        update books
        set quantity = quantity - 10
        where book_id = 3;

        commit;
        raise notice 'Order placed successfully. Transaction committed.';
    else
        rollback;
        raise exception 'Not enough stock. Transaction rolled back.';
    end if;
end $$;


--3 Isolation Level Demonstration

begin;

set transaction isolation level read committed;

update books
set price = 55.00
where book_id = 3;

begin;

set transaction isolation level read committed;

select price
from books
where book_id = 3;

commit;

select price
from books
where book_id = 3;

--4 Durability Check
begin;

update customers
set email = 'newemail@example.com'
where customer_id = 102;

commit;

--restarting the database server and then checking the email again
select email
from customers
where customer_id = 102;



