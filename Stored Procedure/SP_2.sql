
--Lab-3 : Advanced Stored Procedure.

--create table Departments

CREATE TABLE Departments (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE,
 ManagerID INT NOT NULL,
 Location VARCHAR(100) NOT NULL
);----create table EmployeeCREATE TABLE Employee (
 EmployeeID INT PRIMARY KEY,
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 DoB DATETIME NOT NULL,
 Gender VARCHAR(50) NOT NULL,
 HireDate DATETIME NOT NULL,
 DepartmentID INT NOT NULL,
 Salary DECIMAL(10, 2) NOT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);------create table ProjectsCREATE TABLE Projects (
 ProjectID INT PRIMARY KEY,
 ProjectName VARCHAR(100) NOT NULL,
 StartDate DATETIME NOT NULL,
 EndDate DATETIME NOT NULL,
 DepartmentID INT NOT NULL, FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID, Location)
VALUES
 (1, 'IT', 101, 'New York'),
 (2, 'HR', 102, 'San Francisco'),
 (3, 'Finance', 103, 'Los Angeles'),
 (4, 'Admin', 104, 'Chicago'),
 (5, 'Marketing', 105, 'Miami');INSERT INTO Employee (EmployeeID, FirstName, LastName, DoB, Gender, HireDate, DepartmentID,
Salary)
VALUES
 (101, 'John', 'Doe', '1985-04-12', 'Male', '2010-06-15', 1, 75000.00),
 (102, 'Jane', 'Smith', '1990-08-24', 'Female', '2015-03-10', 2, 60000.00),
 (103, 'Robert', 'Brown', '1982-12-05', 'Male', '2008-09-25', 3, 82000.00),
 (104, 'Emily', 'Davis', '1988-11-11', 'Female', '2012-07-18', 4, 58000.00),
 (105, 'Michael', 'Wilson', '1992-02-02', 'Male', '2018-11-30', 5, 67000.00);INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
VALUES
 (201, 'Project Alpha', '2022-01-01', '2022-12-31', 1),
 (202, 'Project Beta', '2023-03-15', '2024-03-14', 2),
 (203, 'Project Gamma', '2021-06-01', '2022-05-31', 3),
 (204, 'Project Delta', '2020-10-10', '2021-10-09', 4),
 (205, 'Project Epsilon', '2024-04-01', '2025-03-31', 5);

 select * from Departments
 select * from Employee
 select * from Projects

--PART-A

--1. Create Stored Procedure for Employee table As User enters either First Name or Last Name and based
--on this you must give EmployeeID, DOB, Gender & Hiredate.

create or alter procedure PR_Employee_Details
@Fname varchar(100)=null,
@Lname varchar(50)=null
as
begin
	select EmployeeID,DoB,Gender,HireDate From Employee
	where FirstName=@Fname or LastName =@Lname
end

exec PR_Employee_Details 'John'
exec PR_Employee_Details @Lname='Doe'

--2. Create a Procedure that will accept Department Name and based on that gives employees list who
--belongs to that department.create or alter procedure PR_Employee_List@Dname varchar(100)asbegin	select * from 	Departments D join Employee E	on D.DepartmentID=E.DepartmentID	where D.DepartmentName = @Dnameendexec PR_Employee_List'HR'--3. Create a Procedure that accepts Project Name & Department Name and based on that you must give
--all the project related details.

create or alter procedure PR_Project_Details
@Pname varchar(100),
@Dname varchar(100)
as
begin
	select * from 
	Departments D join Projects P
	on D.DepartmentID = P.DepartmentID
	where P.ProjectName = @Pname and D.DepartmentName=@Dname
end

exec PR_Project_Details 'Project Beta','HR'

--4. Create a procedure that will accepts any integer and if salary is between provided integer, then those
--employee list comes in output.

create or alter procedure PR_GetEmployeesBySalaryRange
@value1 int,
@value2 int
as
begin
	select * from Employee
	where Salary between @value1 and @value2
end

exec PR_GetEmployeesBySalaryRange 50000,70000

--5. Create a Procedure that will accepts a date and gives all the employees who all are hired on that datecreate or alter procedure PR_GetEmployeesByHireDate@date datetimeasbegin	select * from Employee	where HireDate = @dateendexec PR_GetEmployeesByHireDate '2008-09-25'--PART-B --6. Create a Procedure that accepts Gender’s first letter only and based on that employee details will be
--served.

create or alter procedure PR_FetchEmployeesByGender
@FirstLetter char
as
begin
	select * from Employee
	where Gender like @FirstLetter + '%'
end

exec PR_FetchEmployeesByGender 'M'

--7. Create a Procedure that accepts First Name or Department Name as input and based on that employee
--data will come.

create or alter procedure PR_GetEmployeesByNameOrDepartment
@Fname varchar(100),
@Dname varchar(100)
as
begin
	select * from 
	Departments D join Employee E
	on D.DepartmentID = E.DepartmentID
	where E.FirstName = @Fname or D.DepartmentName = @Dname
end

exec PR_GetEmployeesByNameOrDepartment 'Emily','Marketing'

--8. Create a procedure that will accepts location, if user enters a location any characters, then he/she will
--get all the departments with all data. create or alter procedure PR_GetDepartmentsByLocation@location varchar(100)asbegin	select * from 	Departments D join Employee E	on D.DepartmentID = E.DepartmentID	where D.Location like '%'+@location+'%'endexec PR_GetDepartmentsByLocation 'Chicago'--PART-C
--9. Create a procedure that will accepts From Date & To Date and based on that he/she will retrieve Project
--related data.

create or alter procedure PR_GetProjectsByDateRange
@startDate datetime,
@endDate datetime
as
begin
	select * from Projects
	where StartDate = @startDate and EndDate = @endDate
end

exec PR_GetProjectsByDateRange '2020-10-10','2021-10-09'

--10. Create a procedure in which user will enter project name & location and based on that you must
--provide all data with Department Name, Manager Name with Project Name & Starting Ending Dates. create or alter procedure PR_GetProjectDetailsByNameAndLocation@Pname varchar(100),@location varchar(100)asbegin	select DepartmentName,FirstName,LastName,ProjectName,StartDate,EndDate	from Departments D join Employee E	on D.DepartmentID = E.DepartmentID	join Projects P	on P.DepartmentID=D.DepartmentID	where ProjectName = @Pname and Location= @locationendexec PR_GetProjectDetailsByNameAndLocation 'Project Delta','Chicago'