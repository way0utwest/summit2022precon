/*
Data Community Summit Precon

10 - deploy to production

Demo 1: We need a new table in our system. Let's add this table and insert
some data. We need to do this in dev and prod. The prod scripts are commented 
out so you can simulate having someone else get this code and run it from 
their machine.

Copyright 2022 Redgate Software
*/
USE Westwind_1_Dev
GO
CREATE TABLE dbo.Summit2022 (
 Summit2022ID INT IDENTITY(1,1),
 QuoteBy VARCHAR(50),
 Quote VARCHAR(500)
)
;
GO

-- Let's test this:
SELECT * FROM dbo.Summit2022
GO

-- add data, edit as needed to tests
INSERT dbo.Summit2022
(
    QuoteBy,
    Quote
)
VALUES
(   'way0utwest', -- QuoteBy - varchar(50)
    'It is wonderful to be back at a live Community Summit'  -- Quote - varchar(500)
    )
GO
SELECT Summit2022ID,
       QuoteBy,
       Quote
 FROM dbo.Summit2022
GO


-- deploy to prod
-- somehow
/* 
-- email this to someone

CREATE TABLE dbo.Summit2022 (
 Summit2022ID INT IDENTITY(1,1),
 QuoteBy VARCHAR(50),
 Quote VARCHAR(500)
)
;
GO

*/


-- add new data in prod
/*
-- Did this get emailed as well?
INSERT dbo.Summit2022
(
    QuoteBy,
    Quote
)
VALUES
(   'way0utwest', -- QuoteBy - varchar(50)
    'It is really wonderful to be back at a live Community Summit'  -- Quote - varchar(500)
    )
GO

*/