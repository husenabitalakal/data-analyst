-- Q1. create a database called 'assignment' (Note please do the assignment tasks in this database)
Create database `assignment`;

Use assignment;
-- Q3. Create a table called countries with the following columns name, population, capital 
Create table Countries(
Name varchar(50) unique
,Popoulation int
,Capital varchar(50) unique
);

-- Q3.a. Insert the following data into the table

insert into Countries (Name,Popoulation,Capital)
value ('China', 1382, 'Beijing'), ('India', 1326, 'Delhi'), ('United States', 324, 'Washington D.C.'), ('Indonesia', 260, 'Jakarta'), ('Brazil', 209, 'Brasilia'), ('Pakistan', 193, 'Islamabad'), 
('Nigeria', 187, 'Abuja'), ('Bangladesh', 163, 'Dhaka'), ('Russia', 163, 'Moscow'), ('Mexico', 128, 'Mexico City'), ('Japan', 126, 'Tokyo'), ('Philippines', 102, 'Manila'), ('Ethiopia', 101, 'Addis Ababa'),
('Vietnam', 94, 'Hanoi'), ('Egypt', 93, 'Cairo'), ('Germany', 81, 'Berlin'), ('Iran', 80, 'Tehran'), ('Turkey', 79, 'Ankara'), ('Congo', 79, 'Kinshasa'), ('France', 64, 'Paris'), ('United Kingdom', 65, 'London'),
('Italy', 60, 'Rome'), ('South Africa', 55, 'Pretoria'), ('Myanmar', 54, 'Naypyidaw');

-- Q3.b. Add a couple of countries of your choice
insert into Countries (Name,Popoulation,Capital)
value('Nepal', 100, 'Kathmandu'), ('Tibet', 99, 'Lhasa'), ('Bhutan', 95, 'Thimpu');

-- Q3.c. Change ‘Delhi' to ‘New Delhi'
update countries
set capital =  'New Delhi'
where capital = 'Delhi';

-- Q4. Rename the table countries to big_countries 
Rename table countries to big_countries;

-- Q5. Create following table: Product, Suppliers & Stock

Create table Supplier(
Supplier_id int primary key AUTO_INCREMENT
,Supplier_Name varchar(50) unique not null 
,Location varchar(50) not null
); 

Create table Product(
Product_id int primary key auto_increment
,Product_Name varchar(50) unique not null 
,Supplier_id int 
,Description text 
,foreign key (Supplier_id) references Supplier(Supplier_id)
);

create table Stock(
id int primary key auto_increment
,Product_id int
,foreign key (Product_id) references Product(Product_id)
,Balance_stock int
);

-- Q6. Enter some records into the three tables.
insert into Supplier(Supplier_Name, Location)
values ('Bharati', 'Bangalore'), ('Aliya', 'Aandra Pradesh'), ('kavya', 'Kerala'), ('purnima', 'pune'), ('Raju', 'Raipur') ;

insert into Product(Supplier_id,Product_Name, Description)
values ( 1,'Iphone', 'The iPhone is a smartphone made by Apple that combines a computer, iPod, digital camera and cellular phone into one device with a touchscreen interface. The iPhone runs the iOS operating system')
,( 2,'Ipad', 'The iPad is a brand of iOS and iPadOS-based tablet computers developed by Apple Inc. The iPad is a touchscreen tablet PC made by Apple')
,(3,'Macbook', 'The MacBook is a brand of Macintosh notebook computers designed and marketed by Apple Inc. that uses macOS operating system')
,(4,'Airpods', 'AirPods are wireless Bluetooth earbuds designed by Apple Inc. ')
,(5,'Apple watch', 'The Apple Watch is a smartwatch that operates as a small wearable computing device worn on a user’s wrist');

insert into stock (Product_id,Balance_stock)
values (2,3000),(3,5000),(4,8000),(5,6000);

-- Q8.a. Modify the emp table and a.	Add a column called deptno
alter table emp
add deptno int;

SET SQL_SAFE_UPDATES = 0;

-- Q8.b. Set the value of deptno in the following order:  deptno = 20 where emp_id is divisible by 2;  deptno = 30 where emp_id is divisible by 3; deptno = 40 where emp_id is divisible by 4;  deptno = 50 where emp_id is divisible by 5;  deptno = 10 for the remaining records.

update emp 
set deptno = CASE 
WHEN  (mod(emp_no,2) = 0) THEN 20
WHEN  (mod(emp_no,3) = 0) THEN 30
WHEN (mod(emp_no,4) = 0) THEN 40
WHEN (mod(emp_no,5) = 0) THEN 50
ELSE 10
END;

-- Q9. Create a unique index on the emp_id column
create unique index empid_index on emp(emp_no);


-- Q10. Create a view called emp_sal on the emp table by selecting the following fields in the order of highest salary to the lowest salary.

create view emp_sal as 
select emp_no, first_name,last_name,salary from emp
order by salary desc;

SELECT * FROM emp_sal;