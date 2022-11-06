/*
Data Community Summit Precon

01 - Setup production database

Copyright 2022 Redgate Software
*/
USE [master]
GO
/****** Object:  Database [Westwind]    Script Date: 22/08/2022 20:39:10 ******/
If not exists (select [name] from sys.databases where [name]='Westwind_1_Dev')
 CREATE DATABASE [Westwind_1_Dev]
GO
USE [Westwind_1_Dev]
GO
/* Dev */
If not exists (select [name] from sys.databases where [name]='Westwind_1_Dev')
 CREATE DATABASE [Westwind_1_Dev]
GO
USE [Westwind_1_Dev]
GO
ALTER DATABASE Westwind_1_Dev SET TRUSTWORTHY ON
GO

