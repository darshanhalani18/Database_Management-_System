
-- Stored Procedure :

CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
);--PART-A--1. Department, Designation & Person Table’s INSERT, UPDATE & DELETE Procedures.

--Insert Department

create or alter procedure PR_Insert_Into_Dept
@DeptID int,
@DeptName varchar(50)
as
begin
	insert into Department(DepartmentID,DepartmentName)
	values (@DeptID,@DeptName)
end

exec PR_Insert_Into_Dept 1,'Admin';
exec PR_Insert_Into_Dept 2,'IT';
exec PR_Insert_Into_Dept 3,'HR';
exec PR_Insert_Into_Dept 4,'Account';

select * from Department;

--Insert Designation-

create or alter procedure PR_Insert_Into_Designation
@DesignationID int,
@DesignationName varchar(50)
as 
begin
	insert into Designation(DesignationID,DesignationName)
	values (@DesignationID,@DesignationName)
end

execute PR_Insert_Into_Designation 11,'Jobber'
execute PR_Insert_Into_Designation 12,'Welder'
execute PR_Insert_Into_Designation 13,'Clerk'
execute PR_Insert_Into_Designation 14,'Manager'
execute PR_Insert_Into_Designation 15,'CEO'

select * from Designation;

--Insert Person

create or alter procedure PR_Insert_Person
@Fname varchar(50),
@Lname varchar(50),
@Salary decimal(8,2),
@date datetime,
@DId int,
@DeID int
as
begin
	insert into Person values(@Fname,@Lname,@Salary,@date,@DId,@DeID)
end

exec PR_Insert_Person 'Rahul','Anshu',56000,'1990-01-01',1,12
exec PR_Insert_Person 'Hardik','Hinsu',18000,'1990-09-25',2,11
exec PR_Insert_Person 'Bhavin','Kamani',25000,'1991-05-14',null,11
exec PR_Insert_Person 'Bhoomi','Patel',39000,'2014-02-20',1,13
exec PR_Insert_Person 'Rohit','Rajgor',17000,'1990-07-23',2,15
exec PR_Insert_Person 'Priya','Mehta',25000,'1990-10-18',2,null
exec PR_Insert_Person 'Neha','Trivedi',18000,'2014-02-20',3,15

select * from Person

--Update Department :

create or alter procedure PR_Update_Department
@DID int,
@DName varchar(50)
as
begin
	update Department set
	DepartmentName=@DName 
	where DepartmentID=@DID
end

exec PR_Update_Department 1,'Computer'
select * from Department

--Update Designation :

create or alter procedure PR_Update_Designation
@DId int,
@Dname varchar(50)
as
begin
	update Designation set
	DesignationName=@DName
	where DesignationID=@DId
end	

exec PR_Update_Designation 15,'Employee'
select * from Designation;

--Update Person :

create or alter procedure PR_Update_Person
@PId int,
@FName varchar(50),
@LName varchar(50),
@salary decimal(8,2),
@JDate datetime,
@DID int,
@DeID int
as
begin
	update Person set
	FirstName=@FName,
	LastName=@LName,
	Salary=@salary,
	JoiningDate=@JDate,
	DepartmentID=@DID,
	DesignationID=@DeID
	where PersonID=@PId
end

exec PR_Update_Person 101,'Darshan','Halani',80000,'2005-09-18','1','12'
select * from Person;

--Delete Department : 

create or alter procedure PR_Delete_Department
@Did int
as
begin
	delete from Department
	where DepartmentID=@Did
end

--exec PR_Delete_Department 4
exec PR_Insert_Into_Dept 4,'Account'

select * from Department

--Delete Designation : 

create or alter procedure PR_Delete_Designation
@DID int
as
begin
	delete from Designation
	where DesignationID=@DID
end

--exec PR_Delete_Designation 14
exec PR_Insert_Into_Designation 14,'Manager'

select * from Designation

--Delete Person :

create or alter procedure PR_Delete_Person
@PID int
as
begin
	delete from Person
	where PersonID=@PID
end

--2. Department, Designation & Person Table’s SELECTBYPRIMARYKEY.

--Department :

create or alter procedure PR_Department_SELECTBYPRIMARYKEY
@DID int
as
begin
	select * from Department
	where DepartmentID=@DID
end
exec PR_Department_SELECTBYPRIMARYKEY 2

--Designation :

create or alter procedure PR_Designation_SELECTBYPRIMARYKEY
@DID int
as
begin
	select * from Designation
	where DesignationID=@DID
end
exec PR_Designation_SELECTBYPRIMARYKEY 15

--Person :

create or alter procedure PR_Person_SELECTBYPRIMARYKEY
@PID int
as
begin
	select * from Person
	where PersonID=@PID
end
exec PR_Person_SELECTBYPRIMARYKEY 105

--3. Department, Designation & Person Table’s (If foreign key is available then do write join and take
--columns on select list)

create or alter procedure PR_Select_All
as
begin
	select * from 
	Person P join Department D
	on P.DepartmentID=D.DepartmentID
	join Designation De
	on P.DesignationID=De.DesignationID
end
exec PR_Select_All

--4. Create a Procedure that shows details of the first 3 persons.create or alter procedure PR_Top3_Personsasbegin	select top 3 * from Personendexec PR_Top3_Persons--PART-B
--5. Create a Procedure that takes the department name as input and returns a table with all workers
--working in that department.

create or alter procedure PR_Select_Workers
@DName varchar(50)
as
begin
	select * from 
	Department D join Person P
	on D.DepartmentID=P.DepartmentID
	where DepartmentName=@DName;
end
exec PR_Select_Workers 'Computer'

--6. Create Procedure that takes department name & designation name as input and returns a table with
--worker’s first name, salary, joining date & department name.

create or alter procedure PR_Workers_Details
@DName varchar(50),
@DeName varchar(50)
as
begin
	select P.FirstName,P.Salary,P.Joiningdate,D.DepartmentName
	from Department D join Person P
	on D.DepartmentID=P.DepartmentID
	join Designation De
	on P.DesignationID=De.DesignationID
	where D.DepartmentName=@DName and
	De.DesignationName=@DeName
end
exec PR_Workers_Details 'IT','Employee'

--7. Create a Procedure that takes the first name as an input parameter and display all the details of the
--worker with their department & designation name.

create or alter procedure PR_Workers_Data
@Fname varchar(50)
as
begin
	select * from 
	Person P join Department D
	on P.DepartmentID=D.DepartmentID
	join Designation De
	on P.DesignationID=De.DesignationID
	where P.FirstName=@Fname
end
exec PR_Workers_Data 'Hardik'

--8. Create Procedure which displays department wise maximum, minimum & total salaries.

create or alter procedure PR_Departmentwise_Salary
as
begin
	select D.DepartmentName,
	max(P.Salary) as Max_Salary,
	min(P.Salary) as Min_Salary,
	sum(P.Salary) as Total_Salary
	from Department D join Person P
	on D.DepartmentID=P.DepartmentID
	group by D.DepartmentName
end
exec PR_Departmentwise_Salary

--9. Create Procedure which displays designation wise average & total salaries.

create or alter procedure PR_Designationwise_Salary
as
begin
	select De.DesignationName,
	avg(P.Salary) as Avg_Salary,
	sum(P.Salary) as Total_Salary
	from Designation De join Person P
	on De.DesignationID=P.DesignationID
	group by De.DesignationName
end
exec PR_Designationwise_Salary

--PART-C 

--10. Create Procedure that Accepts Department Name and Returns Person Count.
create or alter procedure PR_Count_Person
@DName varchar(50)
as
begin
	select D.DepartmentName,count(P.PersonID) as Persons
	from Department D join Person P
	on D.DepartmentID=P.DepartmentID
	group by D.DepartmentName 
	having D.DepartmentName=@DName
end
exec PR_Count_Person 'HR'

--11. Create a procedure that takes a salary value as input and returns all workers with a salary greater than
--input salary value along with their department and designation details.

create or alter procedure PR_Greater_Salary_Workers
@Salary decimal(8,2)
as
begin
	select P.FirstName,D.DepartmentName,De.DesignationName,P.Salary
	from Person P join Department D
	on P.DepartmentID=D.DepartmentID
	join Designation De
	on P.DesignationID=De.DesignationID
	where P.Salary > @Salary
end
exec PR_Greater_Salary_Workers '15000'

--12. Create a procedure to find the department(s) with the highest total salary among all departments.

create or alter procedure PR_Highest_Total_Salary_Dept
as
begin
	select top 1 D.DepartmentName,sum(P.Salary) as [Highest Total Salary] 
	from Department D join Person P
	on D.DepartmentID=P.DepartmentID
	group by DepartmentName
	order by [Highest Total Salary] desc
end
exec PR_Highest_Total_Salary_Dept

--13. Create a procedure that takes a designation name as input and returns a list of all workers under that
--designation who joined within the last 10 years, along with their department.

create or alter procedure PR_List_Of_Workers
@DesignationName varchar(50)
as
begin
	select P.FirstName,D.DepartmentName,P.JoiningDate from 
	Department D join Person P
	on D.DepartmentID=P.DepartmentID
	join Designation De
	on P.DesignationID=De.DesignationID
	where De.DesignationName=@DesignationName
	and P.JoiningDate >= DATEADD(year,-10,GETDATE())
end

exec PR_Update_Person 105,'Rohit','Rajgor',17000,'2014-12-25',2,15
exec PR_List_Of_Workers 'Employee'

select * from Person


--14. Create a procedure to list the number of workers in each department who do not have a designation
--assigned.

create or alter procedure PR_Not_have_Designation
as
begin
	select D.DepartmentName,count(*) as Workers
	from Department D join Person P
	on D.DepartmentID=P.DepartmentID
	where P.DesignationID is null
	group by DepartmentName
end
exec PR_Not_have_Designation

--15. Create a procedure to retrieve the details of workers in departments where the average salary is above
--12000.

create or alter procedure PR_AvgSalaryAbove_12000
as
begin
	select D.DepartmentName,avg(P.Salary) as [Avg Salary]
	from Department D join Person P
	on D.DepartmentID=P.DepartmentID
	group by DepartmentName
	having avg(Salary) > 12000
end
exec PR_AvgSalaryAbove_12000