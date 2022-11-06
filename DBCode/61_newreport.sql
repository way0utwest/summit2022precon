/*
Data Community Summit Precon

61 - New Report

We need to get a report of sales into countries, along with the running totals

Copyright 2022 Redgate Software
*/
-- someone sent this to us
-- let's make a procedure
-- USE THE CLONED DB

DECLARE @startdate DATE = '2022-01-01'
, @enddate DATE = '2022-12-31'

-- New report 
SELECT o.OrderID,
       o.CustomerID,
       YEAR(o.ShippedDate) AS ShipYear,
	   MONTH(o.ShippedDate) AS ShipMonth,
	   SUM(od.UnitPrice * od.Quantity) OVER (PARTITION BY o.ShipCountry, MONTH(o.shippeddate) ORDER BY o.ShippedDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Ordertotal
 FROM dbo.Orders o
 INNER JOIN dbo.[Order Details] od
 ON od.OrderID = o.OrderID
 WHERE o.ShippedDate BETWEEN @startdate AND @enddate
 ORDER BY Ordertotal
GO


CREATE PROCEDURE dbo.[Running Country Sales by Month]
  @startdate DATE = null
, @enddate DATE = null
as
BEGIN
 
SELECT o.OrderID,
       o.CustomerID,
       YEAR(o.ShippedDate) AS ShipYear,
	   MONTH(o.ShippedDate) AS ShipMonth,
	   SUM(od.UnitPrice * od.Quantity) OVER (PARTITION BY o.ShipCountry, YEAR(o.shippeddate), MONTH(o.shippeddate) ORDER BY o.ShippedDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Ordertotal
 FROM dbo.Orders o
 INNER JOIN dbo.[Order Details] od
 ON od.OrderID = o.OrderID
 WHERE o.ShippedDate BETWEEN @startdate AND @enddate
 ORDER BY Ordertotal
END
GO


-- save as new repeatable.
