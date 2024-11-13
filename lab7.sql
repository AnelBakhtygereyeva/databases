create database lab7;

--1
--SELECT * FROM countries WHERE name = 'string';
create index index_countries_name on countries(name);

--2
--SELECT * FROM employees WHERE name = ‘string’ AND surname = ‘string’;
create index index_countries_name on countries(name, surname);

--3
--SELECT * FROM employees WHERE salary < value1 AND salary > value2;
create unique index index_employees_salary_unique on employees(salary);

--4
--SELECT * FROM employees WHERE substring(name FROM 1 FOR 4) = 'abcd';
create index index_employees_name_prefix_search on employees((substring(name FROM 1 FOR 4)));

--5
--SELECT * FROM employees e JOIN departments d ON d.department_id = e.department_id WHERE d.budget > value2 AND e.salary < value2;
create index index_departments_deptid_budget on departments(department_id, budget);
create index index_employees_deptid_salary on employees(department_id, salary);

