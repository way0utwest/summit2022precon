-- Procedure already in Prod
CREATE OR ALTER PROCEDURE SalesReport
 @StartDate datetime
 , @EndDate datetime
 , @EmployeeID int
AS
BEGIN
  SELECT @EndDate = DATEADD(DAY, 1, @EndDate);
  SELECT o.OrderID
       , o.OrderDate
	   , c.CompanyName
	   , e.FirstName + ' ' + e.LastName AS SoldBy
	   , SUM( CONVERT(MONEY,(UnitPrice*Quantity*(1-Discount)/100))*100) AS TotalSales
   FROM dbo.Orders AS o
   INNER JOIN dbo.[Order Details] AS od
   ON od.OrderID = o.OrderID
   INNER JOIN dbo.Customers AS c ON c.CustomerID = o.CustomerID
   INNER JOIN dbo.Employees AS e ON e.EmployeeID = o.EmployeeID
   WHERE o.OrderDate > @StartDate 
   AND o.OrderDate < @EndDate
   AND o.EmployeeID = @EmployeeID
   GROUP BY e.FirstName + ' ' + e.LastName, o.OrderID, o.OrderDate, c.CompanyName
END

GO
-- Ticket filed in production about bad order data
-- DBA Investigate in production
-- Devs SHOULD HAVE NO ACCESS to Production
USE Westwind
GO
EXEC SalesReport '2022/01/01', '2022/12/31', 1

-- Zero dollar sale
-- get from above
SELECT * FROM dbo.[Order Details] AS od WHERE od.OrderID IN (26482,
26301,
13073
)

-- Why a high discount?
-- Nothing should be higher than .4
SELECT * FROM dbo.[Order Details] AS od WHERE od.Discount > .8

-- Check the others
-- Find more problems
SELECT o.*
FROM dbo.[Order Details] AS od
    INNER JOIN dbo.Orders o
        ON o.OrderID = od.OrderID
WHERE od.Discount > .8;


-- Check in development
-- Can a Dev replicate this problem
use Westwind_1_Dev
GO

SELECT * FROM dbo.[Order Details] AS od WHERE od.Discount > .8
-- no data



-- Check the constraint




-- No restrictions on Discount
-- we had a malicious employee
-- We need better data in dev


-- Get updated dev environment from TDM/Data Virtualization (Cloning tech)
-- Do this safely


-- create clone
-- check data
-- Westwind
/*
use westwind
go
SELECT * FROM dbo.[Order Details] AS od WHERE od.Discount > .8
SELECT * from employees

-- Vertical tab
use westwind_1_Beca
go
SELECT * FROM dbo.[Order Details] AS od WHERE od.Discount > .8
SELECT * from employees

*/


-- We also need a constraint, but we need to talk to business people
-- about how to deal with existing data and decide what to change.
