/*
Data Community Summit Precon

30 - Starting to use Flyway

Let's create a procedure to get data from our new view

Copyright 2022 Redgate Software
*/

CREATE PROCEDURE GetEvents
  @count INT
  AS
  BEGIN
      IF @count IS NULL OR @count > 10
	    SELECT @count = 10
	SELECT TOP @count FROM dbo.LatestEvents
	ORDER BY EventDate desc
  END
GO



-- save as migration script