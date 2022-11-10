/*
Data Community Summit Precon

60 - More Data

Let's add more data to deploy

Copyright 2022 Redgate Software
*/

-- get a quote from the audience
INSERT dbo.Summit2022
(
    QuoteBy,
    Quote
)
VALUES
(   '', -- QuoteBy - varchar(50)
    ''  -- Quote - varchar(500)
    )
GO


-- save as migration script
-- check FWD for the next number
