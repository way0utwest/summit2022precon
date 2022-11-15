ALTER PROCEDURE dbo.[Total Employee Sales By Country]
AS
BEGIN
  SELECT DISTINCT e.FirstName, e.LastName, e.Country, 
     SUM(os.Subtotal) OVER (PARTITION BY E.country) AS total
   FROM dbo.Employees e
   INNER JOIN dbo.Orders o
   ON o.EmployeeID = e.EmployeeID
   INNER JOIN dbo.[Order Subtotals] os
   ON os.OrderID = o.OrderID
RETURN
END
GO
