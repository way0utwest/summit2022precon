SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   PROCEDURE [dbo].[SalesReport]
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
