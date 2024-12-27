
--Lab-4 : UFDs

--PART-A

--1.Write a function to print "hello world".

create or alter function FN_PrintHelloWorld()
returns varchar(50)
as
begin
	return 'Hello World'
end

select dbo.FN_PrintHelloWorld() as Message

--2. Write a function which returns addition of two numbers.

create or alter function FN_AddTwoNumbers
(@n1 int,@n2 int)
returns int
as
begin
	return @n1+@n2
end

select dbo.FN_AddTwoNumbers(10,20) as Sum

--OR

create or alter function FN_AddTwoNumbers
(@n1 int,@n2 int)
returns int
as
begin
	declare @sum int
	set @sum=@n1+@n2
	return @sum
end

select dbo.FN_AddTwoNumbers(10,20) as Sum

--3. Write a function to check whether the given number is ODD or EVEN.

create or alter function FN_CheckOddEven(@n int)
returns varchar(50)
as
begin
	declare @result varchar(50)
	if @n%2=0
		set @result='Even Number'
	else
		set @result='Odd Number'
	return @result
end

select dbo.FN_CheckOddEven(6) as Result

--4. Write a function which returns a table with details of a person whose first name starts with B.

create or alter function FN_GetPersonsByFirstNameB()
returns table
as
	return (select * from Person where FirstName like 'B%')

select * from dbo.FN_GetPersonsByFirstNameB()

--5. Write a function which returns a table with unique first names from the person table.

create or alter function FN_GetUniqueFirstNames()
returns table
as
	return (select distinct FirstName from Person)

select * from dbo.FN_GetUniqueFirstNames()

--6. Write a function to print number from 1 to N. (Using while loop)

create or alter function FN_PrintNumbersToN(@n int)
returns varchar(200)
as
begin
	declare @numbers varchar(200),@i int
	set @numbers=' '
	set @i=1

	while(@i<=@n)
	begin
	set @numbers=@numbers+' '+cast(@i as varchar)
	set @i=@i+1
	end
	return @numbers
end

select dbo.FN_PrintNumbersToN(20) as Numbers

--7. Write a function to find the factorial of a given integer.

create or alter function FN_CalculateFactorial(@n int)
returns int
as
begin
	declare @fact int,@i int
	set @fact=1
	set @i=1
	while(@i<=@n)
	begin
		set @fact=@fact*@i
		set @i=@i+1
	end
	return @fact
end

select dbo.FN_CalculateFactorial(5) as Answer

--PART-B

--8. Write a function to compare two integers and return the comparison result. (Using Case statement).

create or alter function FN_CompareIntegers(@n1 int,@n2 int)
returns varchar(100)
as
begin
	return case
		when @n1=@n2 then 'Both Numbers are equal'
		when @n1>@n2 then 'Number-1 is Greater than Number-2'
		when @n1<@n2 then 'Number-2 is Greater than Number-1'
		else 'Invalid Numbers!'
		end
end

select dbo.FN_CompareIntegers(50,50) as Result

--9. Write a function to print the sum of even numbers between 1 to 20.

create or alter function FN_SumOfEvenNumbers_1To20()
returns int
as
begin
	declare @sum int,@i int
	set @sum=0
	set @i=2
	while(@i<=20)
	begin
		set @sum=@sum+@i
		set @i=@i+2
	end
	return @sum
end

select dbo.FN_SumOfEvenNumbers_1To20() as Answer

--10. Write a function that checks if a given string is a palindrome

create or alter function FN_CheckPalindrome(@s varchar(100))
returns varchar(100)
as
begin
	declare @result varchar(100)
	if @s=REVERSE(@s)
		set @result=@s+' is Palindrome'
	else
		set @result=@s+' is not Palindrome'
	return @result
end

select dbo.FN_CheckPalindrome('madam')

--PART-C

--11. Write a function to check whether a given number is prime or not.

create or alter function FN_CheckPrimeNumber(@n int)
returns varchar(100)
as
begin
	declare @result varchar(100),@i int,@count int

		if @n<=1
			begin
				set @result=cast(@n as varchar)+' is Not Prime Number.'
				return @result
			end

	set @i=2
	set @count=0

	while(@i<@n)
		begin
			if @n%@i=0
				set @count=1
				break
		end
		set @i=@i+1
	if @count=0
		set @result=cast(@n as varchar)+' is Prime Number.'
	else
		set @result=cast(@n as varchar)+' is Not Prime Number.'
	return @result
end

select dbo.FN_CheckPrimeNumber(15) as Answer

--12. Write a function which accepts two parameters start date & end date, and returns a difference in days.

create or alter function FN_CalculateDateDifference
(@date1 date,@date2 date)
returns varchar(100)
as
begin
	declare @difference varchar(100)
	set @difference=cast((select DATEDIFF(day,@date1,@date2)as [Day Difference])as varchar(100))+' Days'
	return @difference
end

select dbo.FN_CalculateDateDifference('2024-12-27','2024-12-31') as Difference

--13. Write a function which accepts two parameters year & month in integer and returns total days each
--year.

create or alter function FN_TotalDaysInMonth
(@year int,@month int)
returns varchar(100)
as
begin
	declare @totalDays int
	set @totalDays=day(EOMONTH(DATEFROMPARTS(@year,@month,1)))
	return cast(@totalDays as varchar(100))+' Days'
end

select dbo.FN_TotalDaysInMonth(2024,2) as Result
--Year(2024-Leap Year) and Month(2)
--DATEFROMPARTS(2024,2,1)->'2024-02-01'
--EOMONTH('2024-02-01')->'2024-02-29'
--DAY('2024-02-29')->29 Days


--14. Write a function which accepts departmentID as a parameter & returns a detail of the persons.

create or alter function FN_GetPersonsByDepartment(@DID int)
returns table
as
	return (select * from Person where DepartmentID=@DID)

select * from dbo.FN_GetPersonsByDepartment(1)

--15. Write a function that returns a table with details of all persons who joined after 1-1-1991.

create or alter function FN_GetPersonsJoinedAfter1991()
returns table
as
	return select * from Person where JoiningDate > '1991-1-1'

select * from dbo.FN_GetPersonsJoinedAfter1991()
