/*
Data Community Summit Precon

71 - Refactor our view

We want to rename this view without a space. As a first step, we will add a new view.

Copyright 2022 Redgate Software
*/

-- new view, based on old one.
CREATE VIEW dbo.OrderSubTotalsByOrder
AS
SELECT od.OrderID, 
    SUM(CONVERT(money,(od.UnitPrice*Quantity*(1-Discount)/100))*100) AS Subtotal
FROM [Order Details] od
GROUP BY od.OrderID
GO

-- save a migration script
