--1. Display all information in the tables EMP and DEPT. 
Select * from employees
Select * from departments

 --2. Display only the hire date and employee name for each employee. 
 Select employee_id,first_name,hire_date from employees

 /* 3. Display the ename concatenated with the job ID, separated by a comma and space, and
name the column Employee and Title */
Select CONCAT(first_name,', ',job_id) 'Employee and Title' from employees 

--4. Display the hire date, name and department number for all clerks.
Select first_name,hire_date,department_id from employees where job_id like '%CLERK'

/* 5. Create a query to display all the data from the EMP table. Separate each column by a
comma. Name the column THE OUTPUT*/
Select CONCAT(employee_id,', ',first_name,', ',last_name,', ',email,', ',
phone_number,', ',hire_date,', ',job_id,', ',salary,', ', commission_pct,', ',
manager_id,', ',department_id) 'The Output From Employees' from employees

--6. Display the names and salaries of all employees with a salary greater than 2000
Select first_name,last_name,salary from employees where salary > 2000

--7. Display the names and dates of employees with the column headers "Name" and "StartDate" 
Select CONCAT(first_name,' ',last_name) 'Name',hire_date 'Start Date' from employees

--8. Display the names and hire dates of all employees in the order they were hired. 
Select first_name,last_name,hire_date from employees order by hire_date

 --9. Display the names and salaries of all employees in reverse salary order. 
 Select first_name,	last_name,salary from employees order by salary desc

/* 10. Display 'ename" and "deptno" who are all earned commission and display salary in
reverse order. */
Select first_name,last_name,department_id from employees where commission_pct is not null 
order by salary desc

--11. Display the last name and job title of all employees who do not have a manager 
Select e.first_name,e.last_name,j.job_title from employees e join jobs j 
on e.job_id = j.job_id where e.manager_id is null

/* 12 Display the last name, job, and salary for all employees whose job is 
sales representative or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000*/
Select e.first_name,e.last_name,j.job_title,e.salary from employees e join jobs j 
on e.job_id = j.job_id where j.job_title in ('sales representative','stock clerk') and 
e.salary not in (2500,3500,5000)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--1. Display the maximum, minimum and average salary and commission earned.
Select commission_pct,MAX(salary) 'Max Salary',MIN(salary) 'Min Salary',AVG(salary) 'Avg Salary'
from employees group by commission_pct having commission_pct is not null

/* 2. Display the department number, total salary payout and total commission payout for 
each department. */
Select d.department_id,d.department_name, SUM(salary) 'Total salary' 
,case when Sum(commission_pct) is null then 0
else Sum(commission_pct) end 'Total comission' from employees e join departments d 
on e.department_id = d. department_id group by d.department_id,d.department_name
 
 --3. Display the department number and number of employees in each department.
 Select department_id,COUNT(employee_id) 'No. of emp.' from employees group by department_id 

 --4. Display the department number and total salary of employees in each department.
 Select department_id,SUM(salary) 'Total salary' from employees group by department_id


/* 5. Display the employee's name who doesn't earn a commission. Order the result set 
without using the column name*/
select CONCAT(first_name,' ',last_name) from employees where commission_pct is null
order by CONCAT(first_name,' ',last_name) 

/* 6. Display the employees name, department id and commission. If an Employee doesn't 
earn the commission, then display as 'No commission'. Name the columns appropriately*/
Select first_name,department_id, case when commission_pct is null then '0'
else commission_pct end 'Commission PCT' from employees

/* 7. Display the employee's name, salary and commission multiplied by 2. If an Employee 
doesn't earn the commission, then display as 'No commission. Name the columns 
appropriately*/
Select first_name,salary, case when commission_pct is not null then (commission_pct*2)
else '0' end 'Commission PCT' from employees 

/* 8. Display the employee's name, department id who have the first name same as another 
employee in the same department*/
Select department_id,first_name from employees group by department_id,first_name
having COUNT(first_name) >1


 --9. Display the sum of salaries of the employees working under each Manager.
Select manager_id,SUM(salary) 'Sum of salary' from employees group by manager_id

/* 10. Select the Managers name, the count of employees working under and the department 
ID of the manager.*/
Select m.manager_id,COUNT(e.employee_id) 'No. of Empls.' ,m.department_id
from employees e join employees m on e.employee_id = m.manager_id 
group by m.manager_id,m.department_id order by m.manager_id


/* 11. Select the employee name, department id, and the salary. Group the result with the 
manager name and the employee last name should have second letter 'a!*/
Select first_name,last_name,department_id,salary from employees 
where last_name like '_a%'

/* 12. Display the average of sum of the salaries and group the result with the department id. 
Order the result with the department id.*/
Select department_id,SUM(salary)'Sum salary' from employees group by department_id
having SUM(salary) > (Select AVG(salary) from employees)

 --13. Select the maximum salary of each department along with the department id 
 Select department_id,MAX(salary) 'Max Salary' from employees group by department_id


/* 14. Display the commission, if not null display 10% of salary, 
if null display a default value 1*/
Select salary, commission_pct, case when commission_pct is not null then ((salary*10)/100)
else salary end 'Salary' from employees 

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


/* 1. Write a query that displays the employee's last names only from the string's 2-5th 
position with the first letter capitalized and all other letters lowercase, 
Give each column an appropriate label.*/
Select last_name,Concat(UPPER(SUBSTRING(last_name,2,1)),LOWER(SUBSTRING(last_name,3,3))) 
'2-5th Last name' from employees

/* 2. Write a query that displays the employee's first name and last name along with a '-' in 
between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the 
month on which the employee has joined*/
Select CONCAT(first_name,'-',last_name)'Full Name', MONTH(hire_date) 'Joining Month',hire_date 
from employees order by 'Joining Month'

/* 3. Write a query to display the employee's last name and if half of the salary is greater than 
ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of 
1500 each. Provide each column an appropriate label.*/
Select last_name, salary,case when (salary/2) > 10000 then (salary+((salary*10)/100)+1500)
else (salary+((salary*11.5)/100)+1500) end 'New Salary' from employees

/* 4. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, 
department id, salary and the manager name all in Upper case, if the Manager name 
consists of 'z' replace it with '$! */
Select  e.employee_id,
CONCAT(SUBSTRING(CAST(e.employee_id AS varchar),1,2),'00',
SUBSTRING(CAST(e.employee_id AS varchar),3,3),'E') 'Update_ID' ,e.department_id,e.salary
, UPPER(REPLACE(m.first_name,'z','$')) 'Upper'
from employees e join employees m on e.employee_id = m.manager_id 

/* 5. Write a query that displays the employee's last names with the first letter 
capitalized and all other letters lowercase, and the length of the names, for all
employees whose name starts with J, A, or M. Give each column an appropriate label. 
Sort the results by the employees' last names*/
Select last_name,first_name, case when first_name like 'J%' or first_name like 'A%' or 
first_name like 'M%' then LEN(first_name) else null end 'LEN of J,A,M'
from employees order by last_name

/* 6. Create a query to display the last name and salary for all employees. Format the 
salary to be 15 characters long, left-padded with $. Label the column SALARY*/
 SELECT Left(CONCAT('$',salary), 15) 'Salary$',
 last_name, salary from employees

 -- 7. Display the employee's name if it is a palindrome
 Select first_name, Case when first_name=REVERSE(first_name) then first_name
 else null end 'Palindrome'
 from employees

-- 8. Display First names of all employees with initcaps. 
Select CONCAT(UPPER(SUBSTRING(first_name,1,1)),LOWER(Substring(first_name,2,Len(first_name))))
from employees

/* 9. From LOCATIONS table, extract the word between first and second space from the 
STREET ADDRESS column.*/ 
select left(substring(street_address,
charindex(' ',street_address)+1,len(street_address)),
charindex(' ',substring(street_address,
charindex(' ',street_address)+2,len(street_address)))) 'Between' ,street_address
from locations

/* 10. Extract first letter from First Name column and append it with the Last Name. Also add 
"@systechusa.com" at the end. Name the column as e-mail address. All characters should 
be in lower case. Display this along with their First Name.*/
Select first_name,CONCAT(LOWER(SUBSTRING(first_name,1,1)),LOWER(SUBSTRING(last_name,1,LEN(last_name))),
'@systechusa.com') 'E-mail Address' from employees


--11. Display the names and job titles of all employees with the same job as Trenna. 
Select e.first_name,j.job_title from employees e join jobs j 
on e.job_id = j.job_id where j.job_id = 
(Select job_id from employees where first_name = 'Trenna')

/* 12. Display the names and department name of all employees working in the same city as 
Trenna*/
Select * from employees where first_name = 'Trenna'
Select * from departments
Select * from locations

Select e.first_name,e.last_name,e.department_id
from employees e join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id where l.city = 
(Select l.city from employees e join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id where e.first_name = 'Trenna')

--13. Display the name of the employee whose salary is the lowest.
Select first_name,last_name from employees where salary = 
(Select MIN(salary) from employees)

--14. Display the names of all employees except the lowest paid.
Select first_name,last_name from employees where salary != 
(Select MIN(salary) from employees)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* 1. Write a query to display the last name, department number, department name for all 
employees.*/
Select e.last_name,e.department_id,d.department_name from employees e join departments d 
on e.department_id = d.department_id

/* 2. Create a unique list of all jobs that are in department 4. Include the location of the 
department in the output.*/ 
Select Distinct(j.job_title),d.department_name,l.city
from employees e join departments d on e.department_id = d.department_id
join jobs j on e.job_id = j.job_id join locations l on d.location_id = l.location_id
where d.department_id in (10,20,30,40)

/* 3. Write a query to display the employee last name,department name,location id and city of 
all employees who earn commission.*/ 
Select e.last_name,d.department_name,l.location_id,l.city from employees e join departments d 
on e.department_id = d.department_id join locations l on d.location_id = l.location_id
where e.commission_pct is not null

/* 4. Display the employee last name and department name of all employees who have an 'a' 
in their last name*/
select e.last_name,d.department_name from employees e join departments d 
on e.department_id = d.department_id where e.last_name like '%a%'

/* 5. Write a query to display the last name,job,department number and department name for 
all employees who work in ATLANTA.*/
Select e.last_name,e.job_id,d.department_id,d.department_name from employees e join departments d 
on e.department_id = d.department_id join locations l on d.location_id = l.location_id
where l.state_province = 'California'

/* 6. Display the employee last name and employee number along with their manager's last 
name and manager number.*/ 
Select e.last_name,e.employee_id,m.last_name,m.employee_id from employees e join employees m 
on e.employee_id = m.manager_id

/* 7. Display the employee last name and employee number along with their manager's last 
name and manager number (including the employees who have no manager).*/ 
Select e.last_name,e.employee_id,m.last_name,m.employee_id from employees e join employees m 
on e.employee_id = m.manager_id

/* 8. Create a query that displays employees last name,department number,and all the 
employees who work in the same department as a given employee.*/
Select last_name,department_id from employees order by department_id

/* 9. Create a query that displays the name,job,department name,salary,grade for all 
employees. Derive grade based on salary(>=50000=A, >=30000=B,<30000=C)*/
Select CONCAT(first_name,' ',last_name)'Full name',e.job_id,d.department_name,e.salary,
Case when e.salary >= 50000 then 'A'
	 when e.salary >= 30000 then 'B'
	 else 'C' end 'Grade'
from employees e join departments d on e.department_id = d.department_id 

/* 10. Display the names and hire date for all employees who were hired before their 
managers along withe their manager names and hire date. Label the columns as Employee 
name, emp_hire_date,manager name,man_hire_date*/
Select e.first_name,e.hire_date 'M_hire_date' ,m.first_name,m.hire_date 'E_hire_date'
from employees e join employees m on e.employee_id = m.manager_id
where m.hire_date > e.hire_date

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* 1. Write a query to display the last name and hire date of any employee in the same 
department as SALES.*/
Select e.last_name,e.hire_date,d.department_name from employees e join departments d 
on e.department_id = d.department_id where d.department_name = 'SALES'

/* 2. Create a query to display the employee numbers and last names of all employees who 
earn more than the average salary. Sort the results in ascending order of salary.*/
select employee_id,last_name,salary from employees where salary >
(Select AVG(salary) from employees) order by salary

/* 3. Write a query that displays the employee numbers and last names of all employees who 
work in a department with any employee whose last name contains a' u*/
Select employee_id,last_name from employees 
where department_id is not null and last_name like '%u%'

/* 4. Display the last name, department number, and job ID of all employees whose 
department location is ATLANTA.*/ 
Select e.last_name,e.department_id,e.job_id from employees e 
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id where l.state_province = 'Washington'

--5. Display the last name and salary of every employee who reports to FILLMORE.
Select m.last_name,m.salary from employees e join employees m 
on e.employee_id = m.employee_id where e.last_name = 'King'

/* 6. Display the department number, last name, and job ID for every employee in the 
OPERATIONS department.*/ 
Select e.department_id,e.last_name,e.job_id from employees e 
join departments d on e.department_id = d.department_id where d.department_name = 'OPERATIONS'

/* 7. Modify the above query to display the employee numbers, last names, and salaries of all 
employees who earn more than the average salary and who work in a department with any 
employee with a 'u'in their name.*/
Select employee_id,last_name,salary from employees 
where department_id is not null and last_name like '%u%' and salary >
(Select AVG(salary) from employees)

--8. Display the names of all employees whose job title is the same as anyone in the sales dept. 
Select first_name,j.job_title from employees e 
join departments d on e.department_id = d.department_id
join jobs j on j.job_id = e.job_id where d.department_name = 'Sales'

/* 9. Write a compound query to produce a list of employees showing raise percentages, 
employee IDs, and salaries. Employees in department 1 and 3 are given a 5% raise, 
employees in department 2 are given a 10% raise, employees in departments 4 and 5 are 
given a 15% raise, and employees in department 6 are not given a raise.*/
Select employee_id,salary,department_id,
Case when department_id in (10,30) then salary+((salary*5)/100)
	 when department_id = 20 then salary+((salary*10)/100)
	 when department_id in (40,50) then salary+((salary*15)/100)
	 when department_id = 60 then salary
	 else salary end 'New Salary'
from employees where department_id in (10,20,30,40,50,60)

/* 10. Write a query to display the top three earners in the EMPLOYEES table. 
Display their last names and salaries.*/
Select top 3 last_name,salary from employees order by salary desc

/* 11. Display the names of all employees with their salary and commission earned. Employees 
with a null commission should have O in the commission column */
Select first_name,last_name,salary,
Case when commission_pct is null then 0 else commission_pct end 'Commission'
from employees

/* 12. Display the Managers (name) with top three salaries along with their salaries and 
department information*/
Select distinct(e.first_name), e.salary ,e.department_id from employees e join employees m 
on e.employee_id = m.manager_id

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


Select * from Date_function

insert into Date_function values(1,'2000-01-01','2013-10-07');
insert into Date_function values(2,'2003-12-04','2017-08-03');
insert into Date_function values(3,'2012-09-22','2015-06-21');
insert into Date_function values(4,'2015-04-13',null);
insert into Date_function values(5,'2016-06-03',null);
insert into Date_function values(6,'2017-08-08',null);
insert into Date_function values(7,'2016-11-13',null);
insert into Date_function values(8,'2001-05-22','2017-07-20');
insert into Date_function values(9,'2003-10-25','2012-12-31');
insert into Date_function values(10,'2000-01-13',null);

/* 1. Find the date difference between the hire date and resignation_date for all the 
employees. Display in no. of days, months and year(1 year 3 months 5 days).*/
Select DATEDIFF(YEAR,Hire_date,Resignation_date) 'Year'
from Date_function

/* 2. Format the hire date as mm/dd/yyyy(09/22/2003) and resignation_date as mon dd, 
yyyy(Aug 12th, 2004). Display the null as (DEC, 01th 1900)*/
Select FORMAT(Hire_date,'MM/dd/yyyy') 'Hire', 
 Case when Resignation_date is not null then FORMAT(Resignation_date,'MMM dd yyyy') 
 else 'Dec 01 1900' end 'Resignation'
from Date_function

 -- 3. Calcuate experience of the employee till date in Years and months
 Select DATEDIFF(YEAR,Hire_date,Resignation_date) 'Experience' from Date_function