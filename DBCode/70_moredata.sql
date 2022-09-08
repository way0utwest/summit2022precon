/*
Data Community Summit Precon

70 - More Data

We need to alter a report procedure to use more modern code.
First, we want a test, then refactor code

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
