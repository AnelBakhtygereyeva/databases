create database lab9;
--1
create or replace function increase_value(int_value int)
returns int as $$
begin
    return int_value + 10;
end;
    $$ language plpgsql;


--2
create or replace function compare_numbers(a int, b int, out result text)
language plpgsql
as $$
begin
    if a > b then
        result:= 'Greater';
    elsif a = b then
        result:= 'Equal';
    else
        result:= 'Lesser';
    end if;
end;
$$;


--3
create or replace function number_series(n int, out series text)
language plpgsql
as $$
declare
    i int;
begin
    if n < 1 then
        raise exception 'input must equal or greater than 1';
    end if;
    for i in 1..n loop
        raise notice '%', i;
        end loop;
end;
$$;

--4
create or replace function find_employee(employee_name text, out employee_d text)
language plpgsql
as $$
begin
    select concat('id: ', id, 'name: ', name, 'age: ', age, 'position: ', position)
    into employee_d
    from employees
    where name = employee_name;
end;
$$;

--5
create or replace function list_products(product_category text)
language plpgsql
as $$
begin
    return query
    select id, name, category, price
    from products
    where category = product_category;
end;
$$;

--6
create or replace function calculate_bonus(employee_id int, out bonus numeric)
language plpgsql
as $$
begin
    select salary * 0.1
    into bonus
    from employees
    where id = employee_id;

    if bonus is null then
        bonus:= 0;
    end if;
end;
$$;


create or replace function update_salary(employee_id int)
language plpgsql
as $$
declare
    employee_bonus numeric;
begin
    select bonus into employee_bonus
    from calculate_bonus(employee_id);

    update employees
    set salary = salary + employee_bonus
    where id = employee_id;
end;
$$;

--7
create or replace function complex_calculation(i_number int, i_string varchar, out result varchar)
language plpgsql
as $$
declare
    upper_string varchar;
    root_number int;
begin
    begin
        begin
            upper_string:= upper(i_string);
        end;
        begin
            root_number:= sqrt(i_number);
        end;
        result:= 'String: ' || upper_string || ', root number: ', root_number;
    end;
end;
    $$


