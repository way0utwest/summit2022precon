/*
Data Community Summit Precon

04 - Adjust production database to create an issue

Copyright 2022 Redgate Software
*/

/*****************************************************************************************
*****************************************************************************************
-- Run Data Generator with File in root of repo
*****************************************************************************************
*****************************************************************************************/

USE [Westwind];
GO
DECLARE @empid INT,
        @cnt INT,
        @orderid INT,
        @discount NUMERIC(4, 2);
SELECT TOP 1
		@empid = EmployeeID,
		@cnt = COUNT(*)
FROM dbo.[Orders]
WHERE OrderDate > '2022-01-01'
GROUP BY EmployeeID
HAVING COUNT(*) > 5
       AND EmployeeID IS NOT NULL
ORDER BY EmployeeID ASC;

SELECT TOP 1 
		EmployeeID,
		COUNT(*)
FROM dbo.[Orders]
WHERE OrderDate > '2022-01-01'
GROUP BY EmployeeID
HAVING COUNT(*) > 5
       AND EmployeeID IS NOT NULL
ORDER BY EmployeeID;

SELECT OrderID, EmployeeID
FROM Orders
WHERE EmployeeID = @empid;

SELECT od.*
FROM dbo.[Order Details] od
    INNER JOIN Orders o
        ON o.OrderID = od.OrderID
WHERE o.EmployeeID = @empid;


UPDATE dbo.Orders
SET OrderDate = '3/15/2022'
WHERE EmployeeID = @empid
      AND DATEPART(y, OrderDate) < 2022;


DECLARE mycurs CURSOR FOR
SELECT OrderID
FROM Orders
WHERE EmployeeID = @empid
      AND OrderDate > '2022-01-01';
OPEN mycurs;
FETCH NEXT FROM mycurs
INTO @orderid;
SET @discount = .8;
WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @orderid, @discount;

    UPDATE dbo.[Order Details]
    SET Discount = @discount
    WHERE OrderID = @orderid;

    SET @discount = @discount + .2;
    FETCH NEXT FROM mycurs
    INTO @orderid;
END;
SELECT od.*
FROM dbo.[Order Details] od
    INNER JOIN Orders o
        ON o.OrderID = od.OrderID
WHERE o.EmployeeID = @empid;
CLOSE mycurs;
DEALLOCATE mycurs;
GO



