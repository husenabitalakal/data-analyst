USE `assignment`;

-- Q1. Write a stored procedure that accepts the month and year as inputs and prints the ordernumber, orderdate and status of the orders placed in that month. 

delimiter &&
create procedure order_status(In month int,year int)
Begin
select orderNumber, orderDate, status from orders where month(orderDate)=month and year(orderDate)=year;
End &&
delimiter ;

call order_status(03,2003);

-- Q2. Write a stored procedure to insert a record into the cancellations table for all cancelled orders.
-- STEPS: 
-- a.Create a table called cancellations with the following fields
-- id (primary key), 
-- customernumber (foreign key - Table customers), 
-- ordernumber (foreign key - Table Orders), 
-- comments
-- All values except id should be taken from the order table

create table cancellations(
ID int primary key auto_increment, 
customernumber int,
ordernumber int,
comments text,
foreign key(customernumber) references customers (customerNumber),
foreign key(ordernumber) references orders (orderNumber)
);

-- Q2.b. Read through the orders table . If an order is cancelled, then put an entry in the cancellations table.

DELIMITER &&
CREATE PROCEDURE insert_cancelled_order()
BEGIN
declare done int default false;
declare customerNumber, orderNumber int;
declare comments text;
declare cancelled_order_cursor cursor for select
c.customerNumber,
o.orderNumber,
o.comments
from orders as o inner join customers as c on c.customerNumber=o.customerNumber where status='cancelled';
declare continue handler for not found set done=true;

open cancelled_order_cursor;
read_loop: loop
fetch cancelled_order_cursor into customerNumber,orderNumber,comments;
if done then 
leave read_loop;
end if;
insert into cancellations(customernumber,ordernumber,comments) values(customerNumber,orderNumber,comments);
end loop;
close cancelled_order_cursor;
END&&

DELIMITER ;

call insert_cancelled_order()

-- Q3. a. Write function that takes the customernumber as input and returns the purchase_status based on the following criteria . [table:Payments]
-- if the total purchase amount for the customer is < 25000 status = Silver, amount between 25000 and 50000, status = Gold
-- if amount > 50000 Platinum

DELIMITER &&
CREATE PROCEDURE get_purchase_status (cust_no int)
BEGIN
select case
when amount <25000 then 'Silver'
when amount between 25000 and 50000 then 'Gold'
when amount > 50000 then 'Platinum' 
end
from payments where customerNumber=cust_no;
END&&

DELIMITER ;

call get_purchase_status(103);

DELIMITER &&
CREATE PROCEDURE `get_purchase_status`(cust_no int)
BEGIN
select sum(amount) as 'Total Purchase',
case
when sum(amount) <25000 then 'Silver'
when sum(amount) between 25000 and 50000 then 'Gold'
when sum(amount) > 50000 then 'Platinum' 
end as 'Purchase Status'
from payments where customerNumber=cust_no;
END&&
DELIMITER ;

call get_purchase_status(103)

-- Q3.b. Write a query that displays customerNumber, customername and purchase_status from customers table.

DELIMITER &&
CREATE PROCEDURE get_customer_details_with_purchase_status(cust_no int)
BEGIN
select c.customerNumber,c.customerName, sum(amount) as 'Total Purchase',
case
when sum(amount) <25000 then 'Silver'
when sum(amount) between 25000 and 50000 then 'Gold'
when sum(amount) > 50000 then 'Platinum' 
end as 'Purchase Status'
from payments as p inner join customers as c on p.customerNumber=c.customerNumber where p.customerNumber=cust_no;
END&&
DELIMITER ;

call get_customer_details_with_purchase_status(112);

-- Q4. Replicate the functionality of 'on delete cascade' and 'on update cascade' using triggers on movies and rentals tables. Note: Both tables - movies and rentals - don't have primary or foreign keys. Use only triggers to implement the above.

-- Q5. Select the first name of the employee who gets the third highest salary. [table: employee]
select fname as 'First Name' from employee order by salary desc limit 1 offset 2;


-- Q6. Assign a rank to each employee  based on their salary. The person having the highest salary has rank 1. [table: employee]
SELECT *,
RANK() OVER (
ORDER BY salary desc
) 'Rank by Salary'
FROM employee;
