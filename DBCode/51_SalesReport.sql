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
EXEC SalesReport '2022/01/01', '2022/12/31', 1

-- Zero dollar sale
SELECT * FROM dbo.[Order Details] AS od WHERE od.OrderID = 16821

-- Why a high discount?
-- Nothing should be higher than .4

-- Check others
-- Find more problems

-- Check in development
SELECT * FROM dbo.[Order Details] AS od WHERE od.Discount > .8
-- no data



-- Check the constraint




-- No restrictions on Discount
-- we had a malicious employee
-- We need better data in prod
/*
17657
17992
17178
16821
16372
*/
/*
UPDATE dbo.[Order Details]
 SET Discount = .6
  WHERE orderid IN (
17657,
17992
  )

*/