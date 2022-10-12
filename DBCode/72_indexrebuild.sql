/*
Data Community Summit Precon

72 - Index Rebuild

We know this needs to be done before the next deployment

Copyright 2022 Redgate Software
*/


-- rebuild index
ALTER INDEX ALL ON dbo.Orders REBUILD
GO
