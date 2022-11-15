/*
Data Community Summit Precon

12 - create a new view

This is a script meant to be run in the background, after sending script 10_
to someone else. Background work done, but forgotten to send to someone to
deploy.

Copyright 2022 Redgate Software
*/
CREATE VIEW LatestEvents
AS
SELECT TOP 10 *
 FROM dbo.Event
 ORDER BY EventDate DESC
 

SELECT top 10
 *
 FROM latestevents

 