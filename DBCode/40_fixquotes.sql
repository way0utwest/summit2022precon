/*
Data Community Summit Precon

40 - More Data and CI

We want to start using CI to validate things.
We realize that there is a problem with quotes. The who needs to be linked.
Let's add a URL

Copyright 2022 Redgate Software
*/
-- alter the table to allow a URL for the person
ALTER TABLE dbo.Summit2022
 ADD QuoteByURL VARCHAR(200)


-- save as migration script
-- add undo
ALTER TABLE dbo.Summit2022 DROP COLUMN QuoteByURL
