/*
Data Community Summit Precon

01 - Setup production database

Copyright 2022 Redgate Software
*/
USE [master]
GO
/****** Object:  Database [Westwind]    Script Date: 22/08/2022 20:39:10 ******/
IF EXISTS (select [name] from sys.databases where [name]='Westwind')
  ALTER DATABASE [Westwind] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
DROP DATABASE IF EXISTS Westwind 
GO
IF not exists (select [name] from sys.databases where [name]='Westwind')
 CREATE DATABASE [Westwind]
GO
