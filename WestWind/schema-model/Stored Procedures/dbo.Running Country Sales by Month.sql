SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Running Country Sales by Month]
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
