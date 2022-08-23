/*
Data Community Summit Precon

31 - Starting to use Flyway

There also is a ticket to alter the order table

Copyright 2022 Redgate Software
*/

-- We want a "attended event" added to the customers table.
ALTER TABLE dbo.Customers
 ADD AttendedEvent INT NULL
GO
-- We want a FK, but let's create a snippet as well
-- nfk
/*
ALTER TABLE dbo.$tablename$ 
  ADD CONSTRAINT $tablename$_$parentname$_FK FOREIGN KEY dbo.$parentname$ ($pkcol$)
$CURSOR$
*/


-- Create FK
-- table - Customers
-- parent - Event
-- Col - EventID


-- should look like this:
--ALTER TABLE dbo.Customers ADD CONSTRAINT Customers_Event_FK FOREIGN KEY dbo.Event (EventID)
--GO


-- save as migration script.
