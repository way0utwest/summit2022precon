/*
Data Community Summit Precon

92 - Debugging a Problem

Copyright 2022 Redgate Software
*/
SELECT o.EmployeeID, o.OrderDate, od.*, CONVERT(MONEY,(UnitPrice*Quantity*(1-Discount)/100))*100 AS ExtendedSale
, CONVERT(MONEY,(UnitPrice*Quantity)) AS ExpectedSale
 FROM dbo.[Order Details] AS od
 INNER JOIN dbo.Orders AS o ON o.OrderID = od.OrderID
 WHERE o.EmployeeID = 189
 ORDER BY o.OrderDate
