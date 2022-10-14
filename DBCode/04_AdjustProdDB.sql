/*
Data Community Summit Precon

01 - Adjust production database

Copyright 2022 Redgate Software
*/

/*****************************************************************************************
*****************************************************************************************
-- Run Data Generator with File in root of repo
*****************************************************************************************
*****************************************************************************************/

USE [Westwind]
GO
DECLARE @empid INT, @cnt INT, @orderid INT, @discount NUMERIC(4, 2);
SELECT @empid = EmployeeID, @cnt = COUNT(*)
  FROM dbo.[Orders] WHERE OrderDate > '2022-01-01'
  GROUP BY EmployeeID HAVING COUNT(*) > 5
SELECT EmployeeID, COUNT(*)
  FROM dbo.[Orders] WHERE OrderDate > '2022-01-01'
  GROUP BY EmployeeID HAVING COUNT(*) > 5
  SELECT * FROM orders WHERE EmployeeID = @empid
SELECT od.*
  FROM dbo.[Order Details] od INNER JOIN orders o ON o.OrderID = od.OrderID 
  WHERE o.EmployeeID = @empid

DECLARE mycurs CURSOR 
 FOR SELECT OrderID FROM orders WHERE EmployeeID = @empid
  AND OrderDate > '2022-01-01'
OPEN mycurs
FETCH NEXT FROM mycurs INTO @orderid
SET @discount = .8
WHILE @@FETCH_STATUS = 0
 BEGIN	
   SELECT @orderid
   UPDATE dbo.[Order Details]
    SET Discount = @discount
	 WHERE OrderID = @orderid
	SET @discount = @discount + .2
   FETCH NEXT FROM mycurs INTO @orderid
 END
SELECT od.*
  FROM dbo.[Order Details] od INNER JOIN orders o ON o.OrderID = od.OrderID 
  WHERE o.EmployeeID = @empid
CLOSE mycurs
DEALLOCATE mycurs
GO

