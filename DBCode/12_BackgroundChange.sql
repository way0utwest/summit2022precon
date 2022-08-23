/*
Data Community Summit Precon

12 - create a new view

Copyright 2022 Redgate Software
*/
CREATE VIEW LatestEvents
AS
SELECT TOP 10 *
 FROM dbo.Event
 ORDER BY EventDate DESC
 

