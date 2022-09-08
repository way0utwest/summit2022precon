/*
Data Community Summit Precon

50 - Testing Changes

We need to alter a report procedure to use more modern code.
First, we want a test, then refactor code

Copyright 2022 Redgate Software
*/

-- we have this report [Employee Sales by Country]
DROP PROCEDURE dbo.[Total Employee Sales By Country]
GO
CREATE PROCEDURE dbo.[Total Employee Sales By Country]
AS
BEGIN
  SELECT e.FirstName, e.LastName, e.Country, SUM(os.Subtotal) AS Total
   FROM dbo.Employees e
   INNER JOIN dbo.Orders o
   ON o.EmployeeID = e.EmployeeID
   INNER JOIN dbo.[Order Subtotals] os
   ON os.OrderID = o.OrderID
   GROUP BY e.FirstName,
            e.LastName,
            e.Country
RETURN
END
GO


-- we want to change it, but do we get the right results?
-- let's write a test. First, add tsqlt
-- next, we want to write a test that shows results
EXEC tsqlt.NewTestClass @ClassName = N'xUnitTests' -- nvarchar(max)
GO
CREATE PROCEDURE xUnitTests.[test Total Employee Sales By Country]
  AS
BEGIN
	-- assemble
    -- setup test data for employees, orders, order details
	EXEC tSQLt.FakeTable @TableName = N'Employees',        -- nvarchar(max)
	                     @SchemaName = N'dbo'       -- nvarchar(max)

	INSERT dbo.Employees
	(   EmployeeID,
	    LastName,
	    FirstName,
	    Country
	)
	VALUES
	( 1,  N'Doe', N'John', 'USA' ),
	( 2,  N'Smith', N'Ian', 'UK' ),
	( 3,  N'Antoinette', N'Marie', 'France' )

	EXEC tSQLt.FakeTable @TableName = N'Orders',        -- nvarchar(max)
	                     @SchemaName = N'dbo'       -- nvarchar(max)

INSERT dbo.Orders
 (   OrderID,
     CustomerID,
     EmployeeID,
     ShippedDate
 )
 VALUES
 (   1, 1, 1,'2022-05-01' ),
 (   2, 2, 2,'2022-05-02' ),
 (   3, 2, 2,'2022-05-03' ),
 (   6, 4, 3,'2022-05-03' ),
 (   7, 5, 3,'2022-05-02' )

  EXEC tSQLt.FakeTable @TableName = N'Order Details',        -- nvarchar(max)
                       @SchemaName = N'dbo'
  INSERT dbo.[Order Details]
  (
      OrderID,
      ProductID,
      UnitPrice,
      Quantity,
      Discount
  )
  VALUES
  ( 1, 1, 10, 1, 0 ),
  ( 2, 1, 10, 2, 0 ),
  ( 2, 3, 10, 3, 0 ),
  ( 3, 1, 10, 4, 0 ),
  ( 6, 1, 10, 9, 0 ),
  ( 7, 1, 10, 10, 0 ),
  ( 7, 3, 10, 10, 0 )
  
   CREATE TABLE #expected (
   FirstName NVARCHAR(10),
   LastName NVARCHAR(20),
   Country NVARCHAR(15),
   Total MONEY
   )
	   -- storage for actual results
   SELECT *
    INTO #actual 
	FROM #expected

   
   -- store the expected results
   INSERT #expected
   (
       Country,
       LastName,
       FirstName,
       Total
   )
   VALUES
    ( N'USA',    N'DoE',        N'John', 10.0000 ), 
    ( N'UK',     N'Smith',      N'Ian', 90.0000 ), 
    ( N'France', N'Antoinette', N'Marie', 290.0000 )


	-- act
	INSERT #actual EXEC dbo.[Total Employee Sales by Country]

	-- assert
	EXEC tsqlt.AssertEqualsTable @Expected = N'#expected', -- nvarchar(max)
	                             @Actual = N'#actual',   -- nvarchar(max)
	                             @Message = N'correct results',  -- nvarchar(max)
	                             @FailMsg = N'incorrect results'   -- nvarchar(max)
	
END
GO

-- run the test
EXEC tsqlt.run 'xUnitTests.[test Total Employee Sales By Country]'
GO
-- the test passes
-- now, let's refactor code
-- let's allow nulls and set the dates to the min and max
-- let's also add a time to the enddate that is the end of the day
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

-- re-test
EXEC tsqlt.run 'xUnitTests.[test Total Employee Sales By Country]'
GO


-- save as migration script(s).
-- 1 script for tests, qualify the deployment
-- 2 script for new report code, Repeatable