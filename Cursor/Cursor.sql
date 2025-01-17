
--Lab-6 : Cursor

CREATE TABLE Products ( 
Product_id INT PRIMARY KEY, 
Product_Name VARCHAR(250) NOT NULL, 
Price DECIMAL(10, 2) NOT NULL 
);

INSERT INTO Products (Product_id, Product_Name, Price) VALUES 
(1, 'Smartphone', 35000), 
(2, 'Laptop', 65000), 
(3, 'Headphones', 5500), 
(4, 'Television', 85000), 
(5, 'Gaming Console', 32000);

select * from Products
--PART-A

--1. Create a cursor Product_Cursor to fetch all the rows from a products table.

declare @PID int, @PName varchar(250), @Pr decimal(10,2)

declare Product_Cursor cursor
for
	select Product_id, Product_Name, Price
	from Products

open Product_Cursor

fetch next from Product_Cursor
into @PID, @PName, @Pr
 
while @@FETCH_STATUS = 0
	begin
		print cast(@PID as varchar)+' '+@PName+' '+cast(@Pr as varchar)
		fetch next from Product_Cursor
		into @PID, @PName, @Pr
	end

close Product_Cursor
deallocate Product_Cursor

--2. Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName.
--(Example: 1_Smartphone)

declare @id int, @name varchar(250)

declare Product_Cursor_Fetch cursor
for
	select Product_id,Product_Name
	from Products

open Product_Cursor_Fetch

fetch next from Product_Cursor_Fetch
into @id,@name

while @@FETCH_STATUS=0
	begin
		print cast(@id as varchar)+'_'+@name
		fetch next from Product_Cursor_Fetch
		into @id,@name
	end

close Product_Cursor_Fetch
deallocate Product_Cursor_Fetch

--3. Create a Cursor to Find and Display Products Above Price 30,000.

declare @name1 varchar(250), @price decimal(10,2)

declare Product_Above_30000 cursor
for
	select Product_Name,Price
	from Products where Price > 30000

open Product_Above_30000

fetch next from Product_Above_30000
into @name1,@price

while @@FETCH_STATUS = 0
	begin
		print @name1+' '+cast(@price as varchar)
		fetch next from Product_Above_30000
		into @name1,@price
	end

close Product_Above_30000
deallocate Product_Above_30000

--4. Create a cursor Product_CursorDelete that deletes all the data from the Products table.

declare @id1 int

declare  Product_CursorDelete cursor
for
	select Product_id
	from Products

open Product_CursorDelete

fetch next from Product_CursorDelete
into @id1

while @@FETCH_STATUS = 0
	begin
		delete from Products where Product_id = @id1
		 fetch next from Product_CursorDelete
		 into @id1
	end

close Product_CursorDelete
deallocate Product_CursorDelete

--PART-B

--5. Create a cursor Product_CursorUpdate that retrieves all the data from the products table and increases
--the price by 10%.

declare @id2 int, @name3 varchar(250), @price3 decimal(10,2)

declare Product_CursorUpdate cursor
for
	select Product_id,Product_Name,Price
	from Products

open Product_CursorUpdate

fetch next from Product_CursorUpdate
into @id2,@name3,@price3

while @@FETCH_STATUS = 0
	begin
		update Products
		set Price = Price + @price3 * 0.1
		where Product_id = @id2
		fetch next from Product_CursorUpdate
		into @id2,@name3,@price3
	end

close Product_CursorUpdate
deallocate Product_CursorUpdate

select * from Products

--6. Create a Cursor to Rounds the price of each product to the nearest whole number.
declare @id3 int, @name4 varchar(250), @price4 decimal(10,2)

declare Round_Price cursor
for
	select Product_id,Product_Name,Price
	from Products

open Round_Price

fetch next from Round_Price
into @id3,@name4,@price4

while @@FETCH_STATUS = 0
	begin
		update Products
		set Price = CEILING(@price4)
		where Product_id = @id3
		fetch next from Round_Price
		into @id3,@name4,@price4
	end

close Round_Price
deallocate Round_Price

select * from Products

--PART-C

--7. Create a cursor to insert details of Products into the NewProducts table if the product is “Laptop”
--(Note: Create NewProducts table first with same fields as Products table).

CREATE TABLE NewProducts ( 
Product_id INT PRIMARY KEY, 
Product_Name VARCHAR(250) NOT NULL, 
Price DECIMAL(10, 2) NOT NULL 
);

declare @id4 int, @name5 varchar(250), @price5 decimal(10,2)

declare insert_into_NewProducts cursor
for
	select Product_id,Product_Name,Price
	from Products
	where Product_Name = 'Laptop'

open insert_into_NewProducts

fetch next from insert_into_NewProducts
into @id4,@name5,@price5

while @@FETCH_STATUS = 0
	begin
		insert into NewProducts(Product_id,Product_Name,Price) values (@id4,@name5,@price5)
		fetch next from insert_into_NewProducts
		into @id4,@name5,@price5
	end

close insert_into_NewProducts
deallocate insert_into_NewProducts

select * from NewProducts

--8. Create a Cursor to Archive High-Price Products in a New Table (ArchivedProducts), Moves products
--with a price above 50000 to an archive table, removing them from the original Products table.


CREATE TABLE ArchivedProducts( 
Product_id INT PRIMARY KEY, 
Product_Name VARCHAR(250) NOT NULL, 
Price DECIMAL(10, 2) NOT NULL 
);

declare @id5 int, @name6 varchar(250), @price6 decimal(10,2)

declare Archive_HighPrice_Products cursor
for
	select * from Products
	where Price > 50000

open Archive_HighPrice_Products

fetch next from Archive_HighPrice_Products
into @id5,@name6,@price6

while @@FETCH_STATUS = 0
	begin
		insert into ArchivedProducts(Product_id,Product_Name,Price) values (@id5,@name6,@price6)
		delete from Products where Product_id = @id5
		fetch next from Archive_HighPrice_Products
		into @id5,@name6,@price6
	end

close  Archive_HighPrice_Products
deallocate  Archive_HighPrice_Products

select * from ArchivedProducts
select * from Products
