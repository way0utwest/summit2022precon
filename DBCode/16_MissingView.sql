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
CREATE OR ALTER VIEW dbo.LatestEvents
AS
SELECT TOP(10)
 e.EventName,
 e.EventDate,
 e.EventLocation,
 e.CountryCode        
FROM dbo.Event e
INNER JOIN dbo.CountryCodes c ON c.CountryCode = e.CountryCode 
ORDER BY EventDate DESC;


GO 
SELECT * FROM dbo.LatestEvents