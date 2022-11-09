/*
Data Community Summit Precon

01 - Setup production database

Copyright 2022 Redgate Software
*/
USE [master]
GO
/****** Object:  Database [Westwind]    Script Date: 22/08/2022 20:39:10 ******/
IF EXISTS (select [name] from sys.databases where [name]='Westwind_Shadow')
  ALTER DATABASE [Westwind_Shadow] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
DROP DATABASE IF EXISTS Westwind_Shadow 
GO
IF not exists (select [name] from sys.databases where [name]='Westwind_Shadow')
 CREATE DATABASE [Westwind_Shadow]
GO
