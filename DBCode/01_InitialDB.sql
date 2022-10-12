/*
Data Community Summit Precon

01 - Setup production database

Copyright 2022 Redgate Software
*/
USE [master]
GO
/* Production */
If not exists (select [name] from sys.databases where [name]='Westwind')
 CREATE DATABASE [Westwind]
GO
USE [Westwind]
GO
/* Dev */
If not exists (select [name] from sys.databases where [name]='Westwind_1_Dev')
 CREATE DATABASE [Westwind_1_Dev]
GO
USE [Westwind_1_Dev]
GO
