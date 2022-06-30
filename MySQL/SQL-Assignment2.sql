use assignment;

-- Q1. select all employees in department 10 whose salary is greater than 3000 [table: employee]
select *
from employee
where salary >3000 and deptno =10;


-- Q2. The grading of students based on the marks they have obtained is done as follows:
-- 40 to 50 -> Second Class
-- 50 to 60 -> First Class
-- 60 to 80 -> First Class
-- 80 to 100 -> Distinctions
-- a. How many students have graduated with first class?
-- b. How many students have obtained distinction? [table: students] 

select
case
when marks between 40 and 50 then 'Second class'
when marks between 50 and 60 then 'First class'
when marks between 60 and 80 then 'First class'
when marks between 80 and 100 then 'Distinctions'
end as Grade
,
count(case
when marks between 50 and 80  then 'First class'
when marks between 80 and 100 then 'Distinctions'
end) as Grade_Count
from students group by Grade;

-- Q3. Get a list of city names from station with even ID numbers only. Exclude duplicates from your answer.[table: station]
select distinct
id,city
from station
where mod(id,2)=0;

-- Q4. Find the difference between the total number of city entries in the table and the number of distinct city entries in the table. In other words, if N is the number of city entries in station, and N1 is the number of distinct city names in station, write a query to find the value of N-N1 from station.[table: station]
select
count(city) as city_count,
count(distinct city) as distinct_city,
(count(city) -count(distinct city)) as count_diffrence 
from station;

-- Q5.a. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates. [Hint: Use RIGHT() / LEFT() methods ]
select
distinct city 
from station
where left(city,1) in ('a','e','i','o','u');

-- Q5.b. Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
select
distinct city 
from station
where left(city,1) in ('a','e','i','o','u') and right(city,1) in ('a','e','i','o','u');

-- Q5.c. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates
select
distinct city 
from station
where left(city,1) not in ('a','e','i','o','u');

-- Q5.d. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates. [table: station]
select
distinct city 
from station
where left(city,1) not in ('a','e','i','o','u') and right(city,1) not in ('a','e','i','o','u');

-- Q6. Write a query that prints a list of employee names having a salary greater than $2000 per month who have been employed for less than 36 months. Sort your result by descending order of salary. [table: emp]
select *
from emp where salary>2000 and year(now()) -year(hire_date); 

-- Q7. How much money does the company spend every month on salaries for each department? [table: employee]
select deptno,
sum(salary)
from employee
group by deptno;

-- Q8. How many cities in the CITY table have a Population larger than 100000. [table: city]
select 
count(name) as 'city_count_population >1 lakh'
from city where population > 100000;

-- Q9. What is the total population of California? [table: city]
select sum(population) as 'total population of California'
from city where district ='California';

-- Q10. What is the average population of the districts in each country? [table: city]
 select district, 
 avg(population) 
 from city 
 group by district;
 
 -- Q11. Find the ordernumber, status, customernumber, customername and comments for all orders that are ‘Disputed=  [table: orders, customers]
 select
 o.ordernumber
 ,o.status
 ,c.customernumber
 ,c.customername
 ,o.comments
 from orders as o inner join customers as c on c.customerNumber=o.customerNumber
 where status ='Disputed';
 