/*
Data Community Summit Precon

15 - deploy to production, manual, but a review. 

We realized that we wanted the table with a primary key. However, we forgot.
The commented code is the code we meant to write, but didn't. The code below that
is the way to fix this development mistakes.

We want to email this file to someone to deploy and fix our issue.

Copyright 2022 Redgate Software
*/

-- We REALLY wanted this:
--CREATE TABLE dbo.Summit2022 (
-- Summit2022ID INT IDENTITY(1,1) NOT NULL CONSTRAINT Summit2022PK PRIMARY KEY,
-- QuoteBy VARCHAR(50),
-- Quote VARCHAR(500)
--)
--;
-- How do we fix it?
ALTER TABLE Summit2022 ALTER COLUMN Summit2022ID INT NOT NULL;

ALTER TABLE dbo.Summit2022 ADD CONSTRAINT Summit2022PK PRIMARY KEY (Summit2022ID)
GO

