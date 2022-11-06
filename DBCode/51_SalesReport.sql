/*
Data Community Summit Precon

51 - Test Data Management

We need to have some production data in development, in  safe manner

Copyright 2022 Redgate Software
*/

-- This procedure is already in Production
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

-- Someone files a ticket about a problem in production
-- A DBA investigates in production with this script.
-- Devs have NO access to production
USE Westwind
GO
EXEC SalesReport '2022/01/01', '2022/12/31', 1

-- There is a zero dollar sale (among other issues
-- get OrderIDs from above
SELECT * FROM dbo.[Order Details] AS od WHERE od.OrderID IN (10465,
10591,
10921,
10946,
10546,
10850,
10270,
10900,
10469,
10910,
10374,
10792
)

-- Why a high discount?
-- Nothing should be higher than .4
SELECT * FROM dbo.[Order Details] AS od WHERE od.Discount > .8

-- Check the other orders for more issues
-- Find more problems
SELECT o.*
FROM dbo.[Order Details] AS od
    INNER JOIN dbo.Orders o
        ON o.OrderID = od.OrderID
WHERE od.Discount > .8;


-- Let's check in development
use Westwind_1_Dev
GO

SELECT * FROM dbo.[Order Details] AS od WHERE od.Discount > .8
-- no data



-- Check the constraint
-- Westwind_1_Dev, Tables, Constraints
-- There is no CK_ constraint on discount
-- Someone deleted it.





-- No restrictions on Discount
-- we had a problem, a mistake, a hack, or a malicious employee
-- We need better data in dev


-- Get updated dev environment from TDM/Data Virtualization (Cloning tech)
-- Do this safely
-- create clone





/*
-- Run this for production
use westwind
go
SELECT * FROM dbo.[Order Details] AS od WHERE od.Discount > .8
SELECT * from employees

-- New Vertical tab in SSMS (Window| Vertical Tab Group
use westwind_1_Beca
go
SELECT * FROM dbo.[Order Details] AS od WHERE od.Discount > .8
SELECT * from employees

*/


-- We also need a constraint, but we need to talk to business people
-- about how to deal with existing data and decide what to change.
-- alter table Order Details add constraint CK_OD_Discount for discount < .8 and discount >= 0
