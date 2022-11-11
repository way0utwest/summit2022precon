/*
Data Community Summit Precon

16 - forgot this code


We forgot to deploy 12_ before, so let's clean it up and make it better. This script
shows how we can make this code better with SQL Prompt.

Copyright 2022 Redgate Software
*/

-- drop view if exists
GO
-- fix this code, 
-- add OR ALTER
-- select *
-- schema
-- ij to countrycodes for name of country
CREATE VIEW LatestEvents
AS
SELECT TOP 10 
       *
FROM dbo.Event e
ORDER BY EventDate DESC;


