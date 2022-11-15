SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping foreign keys from [dbo].[Customers]'
GO
ALTER TABLE [dbo].[Customers] DROP CONSTRAINT [Customers_Event_FK]
GO
PRINT N'Altering [dbo].[Customers]'
GO
ALTER TABLE [dbo].[Customers] DROP
COLUMN [AttendedEvent]
GO
PRINT N'Creating [dbo].[Running Country Sales by Month]'
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
PRINT N'Refreshing [dbo].[Customer and Suppliers by City]'
GO
EXEC sp_refreshview N'[dbo].[Customer and Suppliers by City]'
GO
PRINT N'Refreshing [dbo].[Invoices]'
GO
EXEC sp_refreshview N'[dbo].[Invoices]'
GO
PRINT N'Refreshing [dbo].[Orders Qry]'
GO
EXEC sp_refreshview N'[dbo].[Orders Qry]'
GO
PRINT N'Refreshing [dbo].[Quarterly Orders]'
GO
EXEC sp_refreshview N'[dbo].[Quarterly Orders]'
GO
PRINT N'Refreshing [dbo].[Sales Totals by Amount]'
GO
EXEC sp_refreshview N'[dbo].[Sales Totals by Amount]'
GO
