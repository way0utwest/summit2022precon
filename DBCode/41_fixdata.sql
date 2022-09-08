/*
Data Community Summit Precon

40 - More Data and CI

We want to start using CI to validate things.
This script adds more data that we want to deploy

Copyright 2022 Redgate Software
*/
USE Westwind
GO
-- fix existing data
UPDATE dbo.Summit2022
 SET QuoteByURL = ''
 WHERE Summit2022ID = 


 -- new data
INSERT dbo.Summit2022
(
    QuoteBy,
    Quote
)
VALUES
(   '', -- QuoteBy - varchar(50)
    ''  -- Quote - varchar(500)
    )




-- save as migration script