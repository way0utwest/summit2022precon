/*
Data Community Summit Precon

15 - deploy to production, manual, but a review. 
   - email this file to someone


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

