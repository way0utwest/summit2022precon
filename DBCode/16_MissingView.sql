/*
Data Community Summit Precon

16 - forgot this code
   - let's clean it up and make it better

Copyright 2022 Redgate Software
*/

-- drop view if exists
GO
-- fix this code, 
-- add OR ALTER
-- select *
-- schema
-- ij to countrycodes for name
CREATE VIEW LatestEvents
AS
SELECT TOP 10
       *
FROM dbo.Event e
ORDER BY EventDate DESC;


