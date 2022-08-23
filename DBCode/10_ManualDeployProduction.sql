/*
Data Community Summit Precon

10 - deploy to production

We need a new table

Copyright 2022 Redgate Software
*/
CREATE TABLE dbo.Summit2022 (
 Summit2022ID INT IDENTITY(1,1),
 QuoteBy VARCHAR(50),
 Quote VARCHAR(500)
)
;
GO

