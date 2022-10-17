﻿/*
Data Community Summit Precon

01 - Setup production database

Copyright 2022 Redgate Software
*/
USE [Westwind_1_Dev]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 22/08/2022 20:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [nchar](5) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[ContactName] [nvarchar](30) NULL,
	[ContactTitle] [nvarchar](30) NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL,
	[LinkedIn] [nvarchar](50) NULL,
	[RegionCode] [nvarchar](20) NULL,
	[CityCode] [nvarchar](20) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 22/08/2022 20:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[ContactName] [nvarchar](30) NULL,
	[ContactTitle] [nvarchar](30) NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL,
	[HomePage] [ntext] NULL,
	[CreditLimit] [money] NULL,
 CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[Customer and Suppliers by City]    Script Date: 22/08/2022 20:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Customer and Suppliers by City] AS
SELECT City, CompanyName, ContactName, 'Customers' AS Relationship 
FROM Customers
UNION SELECT City, CompanyName, ContactName, 'Suppliers'
FROM Suppliers
--ORDER BY City, CompanyName
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 22/08/2022 20:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](15) NOT NULL,
	[Description] [ntext] NULL,
	[Picture] [image] NULL,
	[date] [date] NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 22/08/2022 20:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](40) NOT NULL,
	[SupplierID] [int] NULL,
	[CategoryID] [int] NULL,
	[QuantityPerUnit] [nvarchar](20) NULL,
	[UnitPrice] [money] NULL,
	[UnitsInStock] [smallint] NULL,
	[UnitsOnOrder] [smallint] NULL,
	[ReorderLevel] [smallint] NULL,
	[Discontinued] [bit] NOT NULL,
	[Colour] [nvarchar](50) NULL,
	[Colour2] [nvarchar](50) NULL,
	[Colour3] [nvarchar](50) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Alphabetical list of products]    Script Date: 22/08/2022 20:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Alphabetical list of products] AS
SELECT Products.*, Categories.CategoryName
FROM Categories INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
WHERE (((Products.Discontinued)=0))
GO
/****** Object:  View [dbo].[Current Product List]    Script Date: 22/08/2022 20:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Current Product List] AS
SELECT Product_List.ProductID, Product_List.ProductName
FROM Products AS Product_List
WHERE (((Product_List.Discontinued)=0))
--ORDER BY Product_List.ProductName
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 22/08/2022 20:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [nchar](5) NULL,
	[EmployeeID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[RequiredDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[ShipVia] [int] NULL,
	[Freight] [money] NULL,
	[ShipName] [nvarchar](40) NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
	[ShipCountry] [nvarchar](15) NULL,
	[ShipCountryCode] [int] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Orders Qry]    Script Date: 22/08/2022 20:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Orders Qry] AS
SELECT Orders.OrderID, Orders.CustomerID, Orders.EmployeeID, Orders.OrderDate, Orders.RequiredDate, 
	Orders.ShippedDate, Orders.ShipVia, Orders.Freight, Orders.ShipName, Orders.ShipAddress, Orders.ShipCity, 
	Orders.ShipRegion, Orders.ShipPostalCode, Orders.ShipCountry, 
	Customers.CompanyName, Customers.Address, Customers.City, Customers.Region, Customers.PostalCode, Customers.Country
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GO
/****** Object:  View [dbo].[Products Above Average Price]    Script Date: 22/08/2022 20:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Products Above Average Price] AS
SELECT Products.ProductName, Products.UnitPrice
FROM Products
WHERE Products.UnitPrice>(SELECT AVG(UnitPrice) From Products)
--ORDER BY Products.UnitPrice DESC
GO
/****** Object:  View [dbo].[Products by Category]    Script Date: 22/08/2022 20:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Products by Category] AS
SELECT Categories.CategoryName, Products.ProductName, Products.QuantityPerUnit, Products.UnitsInStock, Products.Discontinued
FROM Categories INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
WHERE Products.Discontinued <> 1
--ORDER BY Categories.CategoryName, Products.ProductName
GO
/****** Object:  View [dbo].[Quarterly Orders]    Script Date: 22/08/2022 20:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Quarterly Orders] AS
SELECT DISTINCT Customers.CustomerID, Customers.CompanyName, Customers.City, Customers.Country
FROM Customers RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderDate BETWEEN '19970101' And '19971231'
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 22/08/2022 20:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[FirstName] [nvarchar](10) NOT NULL,
	[Title] [nvarchar](30) NULL,
	[TitleOfCourtesy] [nvarchar](25) NULL,
	[BirthDate] [datetime] NULL,
	[HireDate] [datetime] NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[HomePhone] [nvarchar](24) NULL,
	[Extension] [nvarchar](4) NULL,
	[Photo] [image] NULL,
	[Notes] [ntext] NULL,
	[ReportsTo] [int] NULL,
	[PhotoPath] [nvarchar](255) NULL,
	[EmailAddress] [NVARCHAR](300),
	[TaxID] VARCHAR(10),
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shippers]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shippers](
	[ShipperID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[Phone] [nvarchar](24) NULL,
	[id] [int] NULL,
	[ShipId] [int] NULL,
 CONSTRAINT [PK_Shippers] PRIMARY KEY CLUSTERED 
(
	[ShipperID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order Details]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order Details](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[Discount] [real] NOT NULL,
 CONSTRAINT [PK_Order_Details] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Invoices]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Invoices] AS
SELECT Orders.ShipName, Orders.ShipAddress, Orders.ShipCity, Orders.ShipRegion, Orders.ShipPostalCode, 
	Orders.ShipCountry, Orders.CustomerID, Customers.CompanyName AS CustomerName, Customers.Address, Customers.City, 
	Customers.Region, Customers.PostalCode, Customers.Country, 
	(FirstName + ' ' + LastName) AS Salesperson, 
	Orders.OrderID, Orders.OrderDate, Orders.RequiredDate, Orders.ShippedDate, Shippers.CompanyName As ShipperName, 
	"Order Details".ProductID, Products.ProductName, "Order Details".UnitPrice, "Order Details".Quantity, 
	"Order Details".Discount, 
	(CONVERT(money,("Order Details".UnitPrice*Quantity*(1-Discount)/100))*100) AS ExtendedPrice, Orders.Freight
FROM 	Shippers INNER JOIN 
		(Products INNER JOIN 
			(
				(Employees INNER JOIN 
					(Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID) 
				ON Employees.EmployeeID = Orders.EmployeeID) 
			INNER JOIN "Order Details" ON Orders.OrderID = "Order Details".OrderID) 
		ON Products.ProductID = "Order Details".ProductID) 
	ON Shippers.ShipperID = Orders.ShipVia
GO
/****** Object:  View [dbo].[Order Details Extended]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Order Details Extended] AS
SELECT "Order Details".OrderID, "Order Details".ProductID, Products.ProductName, 
	"Order Details".UnitPrice, "Order Details".Quantity, "Order Details".Discount, 
	(CONVERT(money,("Order Details".UnitPrice*Quantity*(1-Discount)/100))*100) AS ExtendedPrice
FROM Products INNER JOIN "Order Details" ON Products.ProductID = "Order Details".ProductID
--ORDER BY "Order Details".OrderID
GO
/****** Object:  View [dbo].[Order Subtotals]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Order Subtotals] AS
SELECT "Order Details".OrderID, Sum(CONVERT(money,("Order Details".UnitPrice*Quantity*(1-Discount)/100))*100) AS Subtotal
FROM "Order Details"
GROUP BY "Order Details".OrderID
GO
/****** Object:  View [dbo].[Product Sales for 1997]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Product Sales for 1997] AS
SELECT Categories.CategoryName, Products.ProductName, 
Sum(CONVERT(money,("Order Details".UnitPrice*Quantity*(1-Discount)/100))*100) AS ProductSales
FROM (Categories INNER JOIN Products ON Categories.CategoryID = Products.CategoryID) 
	INNER JOIN (Orders 
		INNER JOIN "Order Details" ON Orders.OrderID = "Order Details".OrderID) 
	ON Products.ProductID = "Order Details".ProductID
WHERE (((Orders.ShippedDate) Between '19970101' And '19971231'))
GROUP BY Categories.CategoryName, Products.ProductName
GO
/****** Object:  View [dbo].[Category Sales for 1997]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Category Sales for 1997] AS
SELECT "Product Sales for 1997".CategoryName, Sum("Product Sales for 1997".ProductSales) AS CategorySales
FROM "Product Sales for 1997"
GROUP BY "Product Sales for 1997".CategoryName
GO
/****** Object:  View [dbo].[Sales by Category]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Sales by Category] AS
SELECT Categories.CategoryID, Categories.CategoryName, Products.ProductName, 
	Sum("Order Details Extended".ExtendedPrice) AS ProductSales
FROM 	Categories INNER JOIN 
		(Products INNER JOIN 
			(Orders INNER JOIN "Order Details Extended" ON Orders.OrderID = "Order Details Extended".OrderID) 
		ON Products.ProductID = "Order Details Extended".ProductID) 
	ON Categories.CategoryID = Products.CategoryID
WHERE Orders.OrderDate BETWEEN '19970101' And '19971231'
GROUP BY Categories.CategoryID, Categories.CategoryName, Products.ProductName
--ORDER BY Products.ProductName
GO
/****** Object:  View [dbo].[Sales Totals by Amount]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Sales Totals by Amount] AS
SELECT "Order Subtotals".Subtotal AS SaleAmount, Orders.OrderID, Customers.CompanyName, Orders.ShippedDate
FROM 	Customers INNER JOIN 
		(Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID) 
	ON Customers.CustomerID = Orders.CustomerID
WHERE ("Order Subtotals".Subtotal >2500) AND (Orders.ShippedDate BETWEEN '19970101' And '19971231')
GO
/****** Object:  View [dbo].[Summary of Sales by Quarter]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Summary of Sales by Quarter] AS
SELECT Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal
FROM Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID
WHERE Orders.ShippedDate IS NOT NULL
--ORDER BY Orders.ShippedDate
GO
/****** Object:  View [dbo].[Summary of Sales by Year]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Summary of Sales by Year] AS
SELECT Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal
FROM Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID
WHERE Orders.ShippedDate IS NOT NULL
--ORDER BY Orders.ShippedDate
GO
/****** Object:  Table [dbo].[CustomerCustomerDemo]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerCustomerDemo](
	[CustomerID] [nchar](5) NOT NULL,
	[CustomerTypeID] [nchar](10) NOT NULL,
 CONSTRAINT [PK_CustomerCustomerDemo] PRIMARY KEY NONCLUSTERED 
(
	[CustomerID] ASC,
	[CustomerTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerDemographics]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerDemographics](
	[CustomerTypeID] [nchar](10) NOT NULL,
	[CustomerDesc] [ntext] NULL,
	[nationality] [nvarchar](20) NULL,
 CONSTRAINT [PK_CustomerDemographics] PRIMARY KEY NONCLUSTERED 
(
	[CustomerTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeTerritories]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeTerritories](
	[EmployeeID] [int] NOT NULL,
	[TerritoryID] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_EmployeeTerritories] PRIMARY KEY NONCLUSTERED 
(
	[EmployeeID] ASC,
	[TerritoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Region]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Region](
	[RegionID] [int] NOT NULL,
	[RegionDescription] [nchar](50) NOT NULL,
	[RegionName] [nvarchar](20) NULL,
	[foo] [nvarchar](20) NULL,
	[foo2] [int] NULL,
	[foo3] [int] NULL,
 CONSTRAINT [PK_Region] PRIMARY KEY NONCLUSTERED 
(
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Territories]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Territories](
	[TerritoryID] [nvarchar](20) NOT NULL,
	[TerritoryDescription] [nchar](50) NOT NULL,
	[RegionID] [int] NOT NULL,
	[RegionName] [nchar](10) NULL,
	[RegionCode] [nchar](10) NULL,
	[RegionOwner] [nchar](10) NULL,
	[Nationality] [nvarchar](20) NULL,
	[NationalityCode] [nvarchar](20) NULL,
 CONSTRAINT [PK_Territories] PRIMARY KEY NONCLUSTERED 
(
	[TerritoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CategoryName]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [CategoryName] ON [dbo].[Categories]
(
	[CategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [City]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [City] ON [dbo].[Customers]
(
	[City] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CompanyName]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [CompanyName] ON [dbo].[Customers]
(
	[CompanyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PostalCode]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [PostalCode] ON [dbo].[Customers]
(
	[PostalCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Region]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [Region] ON [dbo].[Customers]
(
	[Region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [LastName]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [LastName] ON [dbo].[Employees]
(
	[LastName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PostalCode]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [PostalCode] ON [dbo].[Employees]
(
	[PostalCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [OrderID]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [OrderID] ON [dbo].[Order Details]
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [OrdersOrder_Details]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [OrdersOrder_Details] ON [dbo].[Order Details]
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ProductID]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [ProductID] ON [dbo].[Order Details]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ProductsOrder_Details]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [ProductsOrder_Details] ON [dbo].[Order Details]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CustomerID]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [CustomerID] ON [dbo].[Orders]
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CustomersOrders]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [CustomersOrders] ON [dbo].[Orders]
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [EmployeeID]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [EmployeeID] ON [dbo].[Orders]
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [EmployeesOrders]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [EmployeesOrders] ON [dbo].[Orders]
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [OrderDate]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [OrderDate] ON [dbo].[Orders]
(
	[OrderDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ShippedDate]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [ShippedDate] ON [dbo].[Orders]
(
	[ShippedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ShippersOrders]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [ShippersOrders] ON [dbo].[Orders]
(
	[ShipVia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ShipPostalCode]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [ShipPostalCode] ON [dbo].[Orders]
(
	[ShipPostalCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [CategoriesProducts]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [CategoriesProducts] ON [dbo].[Products]
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [CategoryID]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [CategoryID] ON [dbo].[Products]
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ProductName]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [ProductName] ON [dbo].[Products]
(
	[ProductName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [SupplierID]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [SupplierID] ON [dbo].[Products]
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [SuppliersProducts]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [SuppliersProducts] ON [dbo].[Products]
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CompanyName]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [CompanyName] ON [dbo].[Suppliers]
(
	[CompanyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PostalCode]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [PostalCode] ON [dbo].[Suppliers]
(
	[PostalCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Order Details] ADD  CONSTRAINT [DF_Order_Details_UnitPrice]  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[Order Details] ADD  CONSTRAINT [DF_Order_Details_Quantity]  DEFAULT ((1)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Order Details] ADD  CONSTRAINT [DF_Order_Details_Discount]  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_Freight]  DEFAULT ((0)) FOR [Freight]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_UnitPrice]  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_UnitsInStock]  DEFAULT ((0)) FOR [UnitsInStock]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_UnitsOnOrder]  DEFAULT ((0)) FOR [UnitsOnOrder]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_ReorderLevel]  DEFAULT ((0)) FOR [ReorderLevel]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_Discontinued]  DEFAULT ((0)) FOR [Discontinued]
GO
ALTER TABLE [dbo].[CustomerCustomerDemo]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCustomerDemo] FOREIGN KEY([CustomerTypeID])
REFERENCES [dbo].[CustomerDemographics] ([CustomerTypeID])
GO
ALTER TABLE [dbo].[CustomerCustomerDemo] CHECK CONSTRAINT [FK_CustomerCustomerDemo]
GO
ALTER TABLE [dbo].[CustomerCustomerDemo]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCustomerDemo_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[CustomerCustomerDemo] CHECK CONSTRAINT [FK_CustomerCustomerDemo_Customers]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [FK_Employees_Employees] FOREIGN KEY([ReportsTo])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Employees]
GO
ALTER TABLE [dbo].[EmployeeTerritories]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeTerritories_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[EmployeeTerritories] CHECK CONSTRAINT [FK_EmployeeTerritories_Employees]
GO
ALTER TABLE [dbo].[EmployeeTerritories]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeTerritories_Territories] FOREIGN KEY([TerritoryID])
REFERENCES [dbo].[Territories] ([TerritoryID])
GO
ALTER TABLE [dbo].[EmployeeTerritories] CHECK CONSTRAINT [FK_EmployeeTerritories_Territories]
GO
ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [FK_Order_Details_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [FK_Order_Details_Orders]
GO
ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [FK_Order_Details_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [FK_Order_Details_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [FK_Orders_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Employees]
GO
ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [FK_Orders_Shippers] FOREIGN KEY([ShipVia])
REFERENCES [dbo].[Shippers] ([ShipperID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Shippers]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Suppliers]
GO
ALTER TABLE [dbo].[Territories]  WITH CHECK ADD  CONSTRAINT [FK_Territories_Region] FOREIGN KEY([RegionID])
REFERENCES [dbo].[Region] ([RegionID])
GO
ALTER TABLE [dbo].[Territories] CHECK CONSTRAINT [FK_Territories_Region]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [CK_Birthdate] CHECK  (([BirthDate]<getdate()))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [CK_Birthdate]
GO
ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [CK_Quantity] CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [CK_Quantity]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [CK_UnitsOnOrder] CHECK  (([UnitsOnOrder]>=(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_UnitsOnOrder]
GO
/****** Object:  StoredProcedure [dbo].[CustOrderHist]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CustOrderHist] @CustomerID nchar(5)
AS
SELECT ProductName, Total=SUM(Quantity)
FROM Products P, [Order Details] OD, Orders O, Customers C
WHERE C.CustomerID = @CustomerID
AND C.CustomerID = O.CustomerID AND O.OrderID = OD.OrderID AND OD.ProductID = P.ProductID
GROUP BY ProductName
GO
/****** Object:  StoredProcedure [dbo].[CustOrdersDetail]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CustOrdersDetail] @OrderID int
AS
SELECT ProductName,
    UnitPrice=ROUND(Od.UnitPrice, 2),
    Quantity,
    Discount=CONVERT(int, Discount * 100), 
    ExtendedPrice=ROUND(CONVERT(money, Quantity * (1 - Discount) * Od.UnitPrice), 2)
FROM Products P, [Order Details] Od
WHERE Od.ProductID = P.ProductID and Od.OrderID = @OrderID
GO
/****** Object:  StoredProcedure [dbo].[CustOrdersOrders]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CustOrdersOrders] @CustomerID nchar(5)
AS
SELECT OrderID, 
	OrderDate,
	RequiredDate,
	ShippedDate
FROM Orders
WHERE CustomerID = @CustomerID
ORDER BY OrderID
GO
/****** Object:  StoredProcedure [dbo].[Employee Sales by Country]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Employee Sales by Country] 
@Beginning_Date DateTime, @Ending_Date DateTime AS
SELECT Employees.Country, Employees.LastName, Employees.FirstName, Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal AS SaleAmount
FROM Employees INNER JOIN 
	(Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID) 
	ON Employees.EmployeeID = Orders.EmployeeID
WHERE Orders.ShippedDate Between @Beginning_Date And @Ending_Date
GO
/****** Object:  StoredProcedure [dbo].[GetCategories]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[GetCategories]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT * FROM dbo.Categories
END
GO
/****** Object:  StoredProcedure [dbo].[Sales by Year]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sales by Year] 
	@Beginning_Date DateTime, @Ending_Date DateTime AS
SELECT Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal, DATENAME(yy,ShippedDate) AS Year
FROM Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID
WHERE Orders.ShippedDate Between @Beginning_Date And @Ending_Date
GO
/****** Object:  StoredProcedure [dbo].[SalesByCategory]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SalesByCategory]
    @CategoryName nvarchar(15), @OrdYear nvarchar(4) = '1998'
AS
IF @OrdYear != '1996' AND @OrdYear != '1997' AND @OrdYear != '1998' 
BEGIN
	SELECT @OrdYear = '1998'
END

SELECT ProductName,
	TotalPurchase=ROUND(SUM(CONVERT(decimal(14,2), OD.Quantity * (1-OD.Discount) * OD.UnitPrice)), 0)
FROM [Order Details] OD, Orders O, Products P, Categories C
WHERE OD.OrderID = O.OrderID 
	AND OD.ProductID = P.ProductID 
	AND P.CategoryID = C.CategoryID
	AND C.CategoryName = @CategoryName
	AND SUBSTRING(CONVERT(nvarchar(22), O.OrderDate, 111), 1, 4) = @OrdYear
GROUP BY ProductName
ORDER BY ProductName
GO
/****** Object:  StoredProcedure [dbo].[Ten Most Expensive Products]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Ten Most Expensive Products] AS
SET ROWCOUNT 10
SELECT Products.ProductName AS TenMostExpensiveProducts, Products.UnitPrice
FROM Products
ORDER BY Products.UnitPrice DESC
GO
CREATE OR ALTER PROCEDURE SalesReport
 @StartDate datetime
 , @EndDate datetime
 , @EmployeeID int
AS
BEGIN
  SELECT @EndDate = DATEADD(DAY, 1, @EndDate);
  SELECT o.OrderID
       , o.OrderDate
	   , c.CompanyName
	   , e.FirstName + ' ' + e.LastName AS SoldBy
	   , SUM( CONVERT(MONEY,(UnitPrice*Quantity*(1-Discount)/100))*100) AS TotalSales
   FROM dbo.Orders AS o
   INNER JOIN dbo.[Order Details] AS od
   ON od.OrderID = o.OrderID
   INNER JOIN dbo.Customers AS c ON c.CustomerID = o.CustomerID
   INNER JOIN dbo.Employees AS e ON e.EmployeeID = o.EmployeeID
   WHERE o.OrderDate > @StartDate 
   AND o.OrderDate < @EndDate
   AND o.EmployeeID = @EmployeeID
   GROUP BY e.FirstName + ' ' + e.LastName, o.OrderID, o.OrderDate, c.CompanyName
END

GO

CREATE TABLE dbo.Event (
EventID INT IDENTITY(1,1) NOT NULL CONSTRAINT EventPK PRIMARY KEY,
EventName VARCHAR(100),
EventDate DATE,
EventLocation VARCHAR(100),
CountryCode VARCHAR(3)
)
GO
INSERT dbo.Event
(
    EventName,
    EventDate,
	EventLocation,
	CountryCode 
)
VALUES
(   'SQL Bits 2022',
    '2022-03-12',
	'Excel Center London',
	'UK'
    )
	GO
CREATE TABLE dbo.SQLBits2022 (
 SQLBits2022ID INT IDENTITY(1,1) NOT NULL CONSTRAINT SQLBits2022PK PRIMARY KEY,
 QuoteBy VARCHAR(50),
 Quote VARCHAR(500)
)
GO
INSERT dbo.SQLBits2022 (QuoteBy, Quote) 
VALUES 
 ('way0utwest', 'By far my favorite conference'),
 ('Kevin Kline', 'Cool, rainy weather but Ol'' Blighty, SQLSentry, and SQLBits make it a warm reunion. 🙂')
GO
CREATE TABLE [dbo].[CountryCodes](
	[CountryName] [nvarchar](255) NULL,
	[CountryCode] [nvarchar](4) NOT NULL,
	[ModifiedDate] [datetime2](3) NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[CountryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CountryCodes] ADD  CONSTRAINT [DF__CountryCo__Modif__1881A0DE]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
INSERT INTO dbo.CountryCodes
(
    CountryName,
    CountryCode,
    ModifiedDate
)
VALUES
( N'UNITED ARAB EMIRATES', N'AE', NULL ), 
( N'AFGHANISTAN', N'AF', NULL ), 
( N'ANTIGUA AND BARBUDA', N'AG', NULL ), 
( N'ANGUILLA', N'AI', NULL ), 
( N'ALBANIA', N'AL', NULL ), 
( N'ARMENIA', N'AM', NULL ), 
( N'ANGOLA', N'AO', NULL ), 
( N'ANTARCTICA', N'AQ', NULL ), 
( N'ARGENTINA', N'AR', NULL ), 
( N'AMERICAN SAMOA', N'AS', NULL ), 
( N'AUSTRIA', N'AT', NULL ), 
( N'AUSTRALIA', N'AU', NULL ), 
( N'ARUBA', N'AW', NULL ), 
( N'ÅLAND ISLANDS', N'AX', NULL ), 
( N'AZERBAIJAN', N'AZ', NULL ), 
( N'BOSNIA AND HERZEGOVINA', N'BA', NULL ), 
( N'BARBADOS', N'BB', NULL ), 
( N'BANGLADESH', N'BD', NULL ), 
( N'BELGIUM', N'BE', NULL ), 
( N'BURKINA FASO', N'BF', NULL ), 
( N'BULGARIA', N'BG', NULL ), 
( N'BAHRAIN', N'BH', NULL ), 
( N'BURUNDI', N'BI', NULL ), 
( N'BENIN', N'BJ', NULL ), 
( N'SAINT BARTHÉLEMY', N'BL', NULL ), 
( N'BERMUDA', N'BM', NULL ), 
( N'BRUNEI DARUSSALAM', N'BN', NULL ), 
( N'BOLIVIA', N'BO', NULL ), 
( N'BONAIRE', N'BQ', NULL ), 
( N'BRAZIL', N'BR', NULL ), 
( N'BAHAMAS', N'BS', NULL ), 
( N'BHUTAN', N'BT', NULL ), 
( N'BOUVET ISLAND', N'BV', NULL ), 
( N'BOTSWANA', N'BW', NULL ), 
( N'BELARUS', N'BY', NULL ), 
( N'BELIZE', N'BZ', NULL ), 
( N'CANADA', N'CA', NULL ), 
( N'COCOS (KEELING) ISLANDS', N'CC', NULL ), 
( N'CONGO', N'CD', NULL ), 
( N'CENTRAL AFRICAN REPUBLIC', N'CF', NULL ), 
( N'CONGO', N'CG', NULL ), 
( N'SWITZERLAND', N'CH', NULL ), 
( N'CÔTE D''IVOIRE', N'CI', NULL ), 
( N'COOK ISLANDS', N'CK', NULL ), 
( N'CHILE', N'CL', NULL ), 
( N'CAMEROON', N'CM', NULL ), 
( N'CHINA', N'CN', NULL ), 
( N'COLOMBIA', N'CO', NULL ), 
( N'COSTA RICA', N'CR', NULL ), 
( N'CUBA', N'CU', NULL ), 
( N'CAPE VERDE', N'CV', NULL ), 
( N'CURAÇAO', N'CW', NULL ), 
( N'CHRISTMAS ISLAND', N'CX', NULL ), 
( N'CYPRUS', N'CY', NULL ), 
( N'CZECH REPUBLIC', N'CZ', NULL ), 
( N'ANDORRA', N'DA', NULL ), 
( N'GERMANY', N'DE', NULL ), 
( N'DJIBOUTI', N'DJ', NULL ), 
( N'DENMARK', N'DK', NULL ), 
( N'DOMINICA', N'DM', NULL ), 
( N'DOMINICAN REPUBLIC', N'DO', NULL ), 
( N'ALGERIA', N'DZ', NULL ), 
( N'ECUADOR', N'EC', NULL ), 
( N'ESTONIA', N'EE', NULL ), 
( N'EGYPT', N'EG', NULL ), 
( N'WESTERN SAHARA', N'EH', NULL ), 
( N'ERITREA', N'ER', NULL ), 
( N'SPAIN', N'ES', NULL ), 
( N'ETHIOPIA', N'ET', NULL ), 
( N'FINLAND', N'FI', NULL ), 
( N'FIJI', N'FJ', NULL ), 
( N'FALKLAND ISLANDS (MALVINAS)', N'FK', NULL ), 
( N'MICRONESIA', N'FM', NULL ), 
( N'FAROE ISLANDS', N'FO', NULL ), 
( N'FRANCE', N'FR', NULL ), 
( N'GABON', N'GA', NULL ), 
( N'UNITED KINGDOM', N'GB', NULL ), 
( N'GRENADA', N'GD', NULL ), 
( N'GEORGIA', N'GE', NULL ), 
( N'FRENCH GUIANA', N'GF', NULL ), 
( N'GUERNSEY', N'GG', NULL ), 
( N'GHANA', N'GH', NULL ), 
( N'GIBRALTAR', N'GI', NULL ), 
( N'GREENLAND', N'GL', NULL ), 
( N'GAMBIA', N'GM', NULL ), 
( N'GUINEA', N'GN', NULL ), 
( N'GUADELOUPE', N'GP', NULL ), 
( N'EQUATORIAL GUINEA', N'GQ', NULL ), 
( N'GREECE', N'GR', NULL ), 
( N'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS', N'GS', NULL ), 
( N'GUATEMALA', N'GT', NULL ), 
( N'GUAM', N'GU', NULL ), 
( N'GUINEA-BISSAU', N'GW', NULL ), 
( N'GUYANA', N'GY', NULL ), 
( N'HONG KONG', N'HK', NULL ), 
( N'HEARD ISLAND AND MCDONALD ISLANDS', N'HM', NULL ), 
( N'HONDURAS', N'HN', NULL ), 
( N'CROATIA', N'HR', NULL ), 
( N'HAITI', N'HT', NULL ), 
( N'HUNGARY', N'HU', NULL ), 
( N'INDONESIA', N'ID', NULL ), 
( N'IRELAND', N'IE', NULL ), 
( N'ISRAEL', N'IL', NULL ), 
( N'ISLE OF MAN', N'IM', NULL ), 
( N'INDIA', N'IN', NULL ), 
( N'BRITISH INDIAN OCEAN TERRITORY', N'IO', NULL ), 
( N'IRAQ', N'IQ', NULL ), 
( N'IRAN', N'IR', NULL ), 
( N'ICELAND', N'IS', NULL ), 
( N'ITALY', N'IT', NULL ), 
( N'JERSEY', N'JE', NULL ), 
( N'JAMAICA', N'JM', NULL ), 
( N'JORDAN', N'JO', NULL ), 
( N'JAPAN', N'JP', NULL ), 
( N'KENYA', N'KE', NULL ), 
( N'KYRGYZSTAN', N'KG', NULL ), 
( N'CAMBODIA', N'KH', NULL ), 
( N'KIRIBATI', N'KI', NULL ), 
( N'COMOROS', N'KM', NULL ), 
( N'SAINT KITTS AND NEVIS', N'KN', NULL ), 
( N'KOREA', N'KP', NULL ), 
( N'KOREA', N'KR', NULL ), 
( N'KUWAIT', N'KW', NULL ), 
( N'CAYMAN ISLANDS', N'KY', NULL ), 
( N'KAZAKHSTAN', N'KZ', NULL ), 
( N'LAO PEOPLE''S DEMOCRATIC REPUBLIC', N'LA', NULL ), 
( N'LEBANON', N'LB', NULL ), 
( N'SAINT LUCIA', N'LC', NULL ), 
( N'LIECHTENSTEIN', N'LI', NULL ), 
( N'SRI LANKA', N'LK', NULL ), 
( N'LIBERIA', N'LR', NULL ), 
( N'LESOTHO', N'LS', NULL ), 
( N'LITHUANIA', N'LT', NULL ), 
( N'LUXEMBOURG', N'LU', NULL ), 
( N'LATVIA', N'LV', NULL ), 
( N'LIBYA', N'LY', NULL ), 
( N'MOROCCO', N'MA', NULL ), 
( N'MONACO', N'MC', NULL ), 
( N'MOLDOVA', N'MD', NULL ), 
( N'MONTENEGRO', N'ME', NULL ), 
( N'SAINT MARTIN (FRENCH PART)', N'MF', NULL ), 
( N'MADAGASCAR', N'MG', NULL ), 
( N'MARSHALL ISLANDS', N'MH', NULL ), 
( N'MACEDONIA', N'MK', NULL ), 
( N'MALI', N'ML', NULL ), 
( N'MYANMAR', N'MM', NULL ), 
( N'MONGOLIA', N'MN', NULL ), 
( N'MACAO', N'MO', NULL ), 
( N'NORTHERN MARIANA ISLANDS', N'MP', NULL ), 
( N'MARTINIQUE', N'MQ', NULL ), 
( N'MAURITANIA', N'MR', NULL ), 
( N'MONTSERRAT', N'MS', NULL ), 
( N'MALTA', N'MT', NULL ), 
( N'MAURITIUS', N'MU', NULL ), 
( N'MALDIVES', N'MV', NULL ), 
( N'MALAWI', N'MW', NULL ), 
( N'MEXICO', N'MX', NULL ), 
( N'MALAYSIA', N'MY', NULL ), 
( N'MOZAMBIQUE', N'MZ', NULL ), 
( N'NAMIBIA', N'NA', NULL ), 
( N'NEW CALEDONIA', N'NC', NULL ), 
( N'NIGER', N'NE', NULL ), 
( N'NORFOLK ISLAND', N'NF', NULL ), 
( N'NIGERIA', N'NG', NULL ), 
( N'NICARAGUA', N'NI', NULL ), 
( N'NETHERLANDS', N'NL', NULL ), 
( N'NORWAY', N'NO', NULL ), 
( N'NEPAL', N'NP', NULL ), 
( N'NAURU', N'NR', NULL ), 
( N'NIUE', N'NU', NULL ), 
( N'NEW ZEALAND', N'NZ', NULL ), 
( N'OMAN', N'OM', NULL ), 
( N'PANAMA', N'PA', NULL ), 
( N'PERU', N'PE', NULL ), 
( N'FRENCH POLYNESIA', N'PF', NULL ), 
( N'PAPUA NEW GUINEA', N'PG', NULL ), 
( N'PHILIPPINES', N'PH', NULL ), 
( N'PAKISTAN', N'PK', NULL ), 
( N'POLAND', N'PL', NULL ), 
( N'SAINT PIERRE AND MIQUELON', N'PM', NULL ), 
( N'PITCAIRN', N'PN', NULL ), 
( N'PUERTO RICO', N'PR', NULL ), 
( N'PALESTINIAN TERRITORY', N'PS', NULL ), 
( N'PORTUGAL', N'PT', NULL ), 
( N'PALAU', N'PW', NULL ), 
( N'PARAGUAY', N'PY', NULL ), 
( N'QATAR', N'QA', NULL ), 
( N'RÉUNION', N'RE', NULL ), 
( N'ROMANIA', N'RO', NULL ), 
( N'SERBIA', N'RS', NULL ), 
( N'RUSSIAN FEDERATION', N'RU', NULL ), 
( N'RWANDA', N'RW', NULL ), 
( N'SAUDI ARABIA', N'SA', NULL ), 
( N'SOLOMON ISLANDS', N'SB', NULL ), 
( N'SEYCHELLES', N'SC', NULL ), 
( N'SUDAN', N'SD', NULL ), 
( N'SWEDEN', N'SE', NULL ), 
( N'SINGAPORE', N'SG', NULL ), 
( N'SAINT HELENA', N'SH', NULL ), 
( N'SLOVENIA', N'SI', NULL ), 
( N'SVALBARD AND JAN MAYEN', N'SJ', NULL ), 
( N'SLOVAKIA', N'SK', NULL ), 
( N'SIERRA LEONE', N'SL', NULL ), 
( N'SAN MARINO', N'SM', NULL ), 
( N'SENEGAL', N'SN', NULL ), 
( N'SOMALIA', N'SO', NULL ), 
( N'SURINAME', N'SR', NULL ), 
( N'SOUTH SUDAN', N'SS', NULL ), 
( N'SAO TOME AND PRINCIPE', N'ST', NULL ), 
( N'EL SALVADOR', N'SV', NULL ), 
( N'SINT MAARTEN (DUTCH PART)', N'SX', NULL ), 
( N'SYRIAN ARAB REPUBLIC', N'SY', NULL ), 
( N'SWAZILAND', N'SZ', NULL ), 
( N'TURKS AND CAICOS ISLANDS', N'TC', NULL ), 
( N'CHAD', N'TD', NULL ), 
( N'FRENCH SOUTHERN TERRITORIES', N'TF', NULL ), 
( N'TOGO', N'TG', NULL ), 
( N'THAILAND', N'TH', NULL ), 
( N'TAJIKISTAN', N'TJ', NULL ), 
( N'TOKELAU', N'TK', NULL ), 
( N'TIMOR-LESTE', N'TL', NULL ), 
( N'TURKMENISTAN', N'TM', NULL ), 
( N'TUNISIA', N'TN', NULL ), 
( N'TONGA', N'TO', NULL ), 
( N'TURKEY', N'TR', NULL ), 
( N'TRINIDAD AND TOBAGO', N'TT', NULL ), 
( N'TUVALU', N'TV', NULL ), 
( N'TAIWAN', N'TW', NULL ), 
( N'TANZANIA', N'TZ', NULL ), 
( N'UKRAINE', N'UA', NULL ), 
( N'UGANDA', N'UG', NULL ), 
( N'UNITED STATES MINOR OUTLYING ISLANDS', N'UM', NULL ), 
( N'UNITED STATES', N'US', NULL ), 
( N'URUGUAY', N'UY', NULL ), 
( N'UZBEKISTAN', N'UZ', NULL ), 
( N'HOLY SEE (VATICAN CITY STATE)', N'VA', NULL ), 
( N'SAINT VINCENT AND THE GRENADINES', N'VC', NULL ), 
( N'VENEZUELA', N'VE', NULL ), 
( N'VIRGIN ISLANDS', N'VG', NULL ), 
( N'VIRGIN ISLANDS', N'VI', NULL ), 
( N'VIET NAM', N'VN', NULL ), 
( N'VANUATU', N'VU', NULL ), 
( N'WALLIS AND FUTUNA', N'WF', NULL ), 
( N'SAMOA', N'WS', NULL ), 
( N'YEMEN', N'YE', NULL ), 
( N'MAYOTTE', N'YT', NULL ), 
( N'SOUTH AFRICA', N'ZA', NULL ), 
( N'ZAMBIA', N'ZM', NULL ), 
( N'ZIMBABWE', N'ZW', NULL )
GO
-- insert categories
INSERT INTO dbo.Categories
  (CategoryName, Description, Picture, date)
VALUES
( N'Beverages', N'Soft drinks, coffees, teas, beers, and ales', 0x151c2f00020000000d000e0014002100ffffffff4269746d617020496d616765005061696e742e5069637475726500010500000200000007000000504272757368000000000000000000a0290000424d98290000000000005600000028000000ac00000078000000010004000000000000000000880b0000880b00000800000008000000ffffff0000ffff00ff00ff000000ff00ffff000000ff0000ff00000000000000000010000000001000000001001000000000000001010100010000100100000001010001000000100100000100000010101000100000100010000000000000000000001000000001000000000000001000000000000000000000001001001000000000000000000001001001000012507070100000001000000001000100100000010000001000000000100100100000001001010101010000000000000000000001001000100000101010101000000000000000000000000000000000000101020525363777777777777753530100101000100000000001010001001000100100100000000000100000000000000000100010001001010001000000010010000000000000100000000000000000000000000000001014343577777777777777777777777777770100120001010100102000000000000000000000000100100010010000000000100010000000000000000010010000001001001010100000000000000000000000000000001021617777777775757535353525777777777777770150120000100010101000000000000000001000000000000001001001000000000010010000010010010000101001001000000100000001000000000000000000000001417777737617376377775767771707752777777776340161210300000000010000000000010000000000000000000000000000000000000000100000000000100000000000010000100000000000000000000000000100503677577571705014000000101070717775777777775334101400010101010001010010101000000000000000000000000000001000000000000000000000000000000001010001000001000000000000000000000000010357353000000000000000000000000000171777777777470612101000000001000001000000010000000000000000000000000000000100010703010101210000000000000000000000000000000000000000000000101034350000000010653435777570477474700000107757777171000000101001000101000101010000100000000000000000001041477110131035750020040477301000100000000000000000000000000000000000000000010004014176577707000067777777776560404007371734361701400001241000001000000001000020400000200000101747767777000101073777577777775372100000000100000000000000100100000000010000010000037676476700004000577470416717477421405000434140343000565120510100301014002107171370701437777777775777777112103177777777777705757771010000000100000000000000010000100000101000470440440671007477776777777614060600742524001777777747646776752060250003021716737777777777777774747727574777001016777777777767173317703000101010000000010000000001000000000000420460200077427477767777777775677777746474656606767777665746776757151253507166737777733746777577777777572776771100517777777767776015713141030020001000000001001000000000010100067440044047761477767776706767777674765673470657505767375664746757777271252167717733771737776777677567476577577121103775777777776717027753121010101000010000000000100001010000010767060004776747776776777756776777777777042477676067777467474747676777565256531311771177376477777576757777747710110701777777767777401717340000000000100001000000000001000000101004776540666050777677657777677470774777776747664607777376747476777777677717173735377717737747777777777774774770011271077777767777763171735210121010100000000000000000000010000000300406767757676775077006767477774774777774747770476777656706746777657777777777777777777737667777476574774777771001031777777776767741371771000000000010000000000000000000000101005707442567656176006767004770476707700767770000477747734656446745677676777777777777777777375667777777777777777773100010777777777777771753521010101010000000000100010000000010007777712152503004670077774767427047247776577564700076737747670474277777777777777777367777777765777777777777434777750757775377767676770172773100000000001000000000000001000101007170701614204046007746040676167470774167743656777740077776067407465677677777777777757717777737476775716161243410303077777777577775210000011350001001001000000101000100000100002100171525675070074340670005004076700706570757777767770077744746466567777677777777777777777773776777610000000137775350317777773777737750701000101021001000100000000000010100010010300067777761650604065047604760746404776406705656776770077764750474747677777777777777777773733747777773011735777777777777777757777777777767412041001001000001000001000000010001000577744140000607406706767676776777776477756767777447700774076646764777567777777777777737373737764677747753527777776777777777776365735353513010300120301010000000000000000001000107000210006147767674646040404040066667767677775476777046644644044456776767777777777733737373776777776774244777377717712777165357577534242040010010010000010001000000100010000100300050000146664000000101030734352101100065677767077770047604774377676777767777777777373737333756477657075377100770770177776525271673001012101210301001030000000100100000001000005000060046160004000125343510110101000000000007740000047744733737377757677777777777373737377737656757777777373101676770777717775671773001010300000021021010000000000000100000000100077400000414021414000000000000000000000000000300000777777773737377677677777777777373737333735677677777377710177777717774705271767340300000010101000100000100000100100000001014005660000000737560600000000000000000000000000004730777773733373737777747677777777737337353761666777777737737017771677077353777574735310012101000000010010100000100000000010004300065400000000400141254140404000000000000000000037737776773777373733777677777777777677646746565756747777773773017017710765654352735770017010303031010010000000100001001010030704000660000000000000040000000000000000000000000007777514673373373737777777476777777777474644764666776777777772711031076117307374357477373010341050043030012100100010100100012500000047000000000046742000000000000000000000000077776677777377377373733737767777777777767645676507574777657610057121101731611574777637735105270125213010050210100001070210301650000000640000000006776406776464000040641434177777767667614737337337373777777767677777776564767474664667477761775271112116101002331211101052721016120140161034106010173075617770000570047400047400446000000467770504777767173573756767776767737737773737377776777777777776564746765477576777176700774656474731010011000001250165214716170121012011070777173777400063770040000760467600000000740760600777067777777676767676767337333373737377747677777777776767747424676747677157701677677676131331213131301371317310312161525053073077777777700047577700000006006760000640400006474046740777777777676767676737737777373777777767777777777674746767467477777743670175305325352527135335353170143414371617130131211777177777777001737770006760476677047064466400047640077747777777767676767673773373333737373776746777777765467674704747674765375610731773573752534737417017035303130101010030001427777777737770047777770047460704644064400004640067004767077777777767676767673377377773737777776777777777766565665670767767775077007563153347370731013213617034343434307031417121177773777777740257737700027447000064000000000640064006760777777776767767767773373333373737777476777777777746765674464747767763477027172753717175777757757357171717171717433616163777777735737400737773400460660046000000000004000600676747777777776766766767377377777373737777747677777776756567467746765777117100537153353773777777777777777777777777737757737573777773773772047777350000474044600440000000000040047774007777700667677677633333333333737777766767777777777667476564657476760600007353375373177777777777777777777777777777737777377733753777740007177770000664024640640000000000004646700477777007767667666777777777773737777777777777776777446467565676777535373525317137177177777777777777777777777777777775377773753771737700076737350000000474664665646644400400464000077700067677677773333333333373737776676777777777767777766767765677771713175217037173777777777777777777777777775375377173753777377773700057777004007477667764766767667467600000004770000767667666677777777777337777775677777771777772604000404067761171613131535353717777777777777777777737753777777777753773717735374700000500670446677777776777776777776561004661000006767767777333131101100777777666567777567704040505140777716536353147173135371777777777777777777577577777777777777777353753777371700000001776040404040404606076767776170000470000071101100100000000000110157177776777776470124100002530004777111301313017535371777777777771771737377773777377753773717353252165376164464265700400000000000004040040076774000440000777500750000000000000000017347766777746564100000000400300652513530753303170737777775777777777777737777777773777753757035353134317137313533000046440000004400000000053770000000000077343100000000000000000004135777775676176000700000004044213052153115353371357777377737737775777777573757777777353213503161617163521657257000006700060042400000005273710000000000007577000000000000000000531117777665447405244000000040031501313030721353537737775777577753737717737777777777777035343343131303103171317337130100000567000200000031756000000000000000077771012100101101131117133375466747465707047000071502161011531534353517753773737353777737777777777737537713503353170717173561343105307030525370047014161717433700000000000000000000101011770000006402737373767456467777777773065773510137343531317073737773775777773777577375735737577777343375377373673071316352731717173137000007737352713574000000000000000000000000464000000046733737373446647777777777740007373737110310343537171773565373537577177375737777777777773353737717175357727753717163737357770000071735371677700000000000000000000000000460004004676173737374745777777777777004631713112031213131317337177737777777377777777777777777777775377737777377371717353773571747737377617771677773570000000000000000000000000400400000000406337333464673777777777774007733373311001013135317177737775377377777777777777777777777737777573777377777736771773773716717535343373525773700000000000000000000000000000000000000037337374433373777777777700007740010313133173137337357753777777777777777777777777777777737737775375737373717367171653735727367374753737174000000000000000000004600000000000000000373733643773373777777777404073000000000012137331737377777777777777777777777777777777777577773737773757575735317273353531757535737377576300000000000000000000424400000004000040007373375733337333377777770000700000000000000000070477777777777777777777777777777777777737773757753757373737777775357273673373773535737357000000000000000000004406000000000404004037337333773737737377777700400000000000004006404043777777773757777777777777777777777777773773737773777777717371737357171752573473721777340000000000000000000006446400000000004004337337333373337337337777100004705340100016503777747717717757777777777777777777777777773757757773577173577775777577377773777373757777177700000000000660000640047674000000004000003737337373377337373737774040077760004000000044004737777777777777777777777777777777777773773773577377777377377377377537177535757373537710000000000004040004640604600000000000400073733737337333737373777700000047477420000000000435777777777777777777777777777777777777757777777777777777777777777777777737737377577777000000000004600000460064600000004000000000373373337337373737373777600000000000550043617777777777777777777777777777777777777777773777777773777777777777777777777777777777737737777000000000000000000000406400000004040000003373373737337373737373770040000000002777357777777777777777777777777777777777777775777777777773777573717775777777577377777777777777757340400000000000000040004064000000000000000073373373337333373737377750000000000057777777777777777777777777777777177775737577737777777735777773777773773775377377735735735375737737000000000000000044600406060000000000000046337337337373777373733777007460000000377777777777777777777777777777777737737777377777377777737371775353753753777777777777777777737717750000000000000000000000444404400400000000063733737337333337373377774067400000000777777777777777777777777375773777757777177177377735777777777377777777777777777777777777777777777704000000000000000000006000666066000000004433733337337377333377777700676004004407777777777777777777777777777757357375377777775777737777777777777777777777777777777777777777777772010000000000000000000040004404440000000000373737337337337377777777704600674660077777777777777777777777777737777777777773773773777777777777777377377777737777753777777777777777750040000000000000000000000460460000000000463733733733733737777777770047464067000777777777777777777777777777777777777777777777777777771737177777757377377753777777777737757773737000000000000000000000644640000460000000000073373733733733777777773750660760400017777777777777777777777777777777777777777777777777777777777373773777357173775377735737777377757777240000000000000000000606400000000000000000373373773733777777777737604746400406057777777777777777777777777777777777777777775775771733735377757177175737753737537777757777777777750100000000000000000046540000000000000000007337333333777777777771771066067674767677777777777777777777777777777777377777777377737777775737573737736373717375773777373737377777371200400000000000000000046000000000000000000073737373777777777777737700656476464617777777777777777777777777775757777777575757735773735371737357737575357635733577377577777773777775000040000000000000440646000040000000000000733733377777777777777137106606476400077777777777777775777757357777777757577377375777775737777577735737377371735773757073737175777777370000000000000000046764656546400000000000007733737777537777777777774474407467005077777777777775777757377735737717737377777737777371773737373773577535373437073737757577737353777700500000000000004676474266640000000000000047333777074747777777777776567642766027777757537775777371735777777577777777577777775377777777577577777737777577737757757373737777775777000000400000000067407604040000000000000000077777103716173777777737676665646470577757377775777375777777177377777777777357357777773737777777371735737773735753737377777773577377370004000000000000666424604040000000000000000777777007677477777777767676767474003577777777773777777777777777773773573777377773777777577773777777777771775773777757353753577357777770010000000000040406404000244000000000000000777370141477567777777762476767660067777777773777777737773777753777777777777777777777777773777777777375367377375357367767767737673477140240000000000000446400004660000040000000007737520077772757777770040047667767177777757777777777777577737777757777717753717717777777757753535357777775775777777535753735757177357005004000000000000000040400476440464000000007773401616575777777006440004764256777377375775375735737777777737737737773777777777773777777777777771771777777777777773775777377577773000000040000000000400000000000067400000000077771425777367777700400060006765377777377777377737777777735735777777777777777777777757777777777777777777777777777777777777377377353770070040000000000000400000404000040000000000077770525765777777004004040440065773775717377777777377777777777777777777777777777777777777777777777777773737371775377773775657527777500004000000000000000000442424400064000000000777724077576777700400600007000373757373775775375375737777777777777777777777777777777777777737777377373577575777777573575373733771737300700004000000000000004646440000672440000000777507567657775000444040644047777377777773777777777757777777777777777777777777777777757377771777375773737373737373773377753575377577400004000000000000000000400000040440640000004777407757777700404246044604375777757737777777777777777777773777777777777777777777777377775773575737175717175717571757253372734372773007000040000000000000000000004600464000000007772525677777004704064240124373777377577777777777777773773777777573577777777777757377737373777373777737367363727373735356171737177175000400000400000000000000004600000400000000047710477777700676006564640577777777777777777777737773777777577177777777777777777377735775775377757173717535357174352537737373717717730070040000000000000000000040046000000000000077777711357047600446500072777777777737777777377777777573573777777777777777777777737777377377177377757773777377737777343574356773737710060040400400000000000000000400000000000000771571715356770446002470757775773777777377757735735773777777777777777777777777735777377777777777777737573577177535357773777371747527710160000000040000000000000006000000000000007771353777767600056440042735373775377375773777777777777777777777777777777777777777777777777777757377773777377737777735777537577373717700104004000000000000000000440000000000000077171357777674006064214357577775737757777777777777777777777777777777777777777777377777777777777777777777777777777737777373777737577777300424000400000000000000000000000000000000777174777756765404051425373735737777777777777777777777777777777777777777777777777777777777777377777577777777777777777375777737777353777100100400040400000000000000000000000000007717137577764767404061777777777777737737777777777777777377777777737537777777777777777577777777773773777737775377177577737353753737770737100400400000000000000000000000000000000077717177777467760030065377577777777777777777777777377777777777777777777777777777777373735371777775777177753777777737717757775375753573536100050040404040000000000000000000000000771717177720767000043737737737737757737773773777777777777777777777777777777777777577777777777737773777777777777777777773773737737377357753000004200000004040000000000000000000047773537777504004104375777573757777371777777777773777777777777777777777777777777373777777777777777777777777777777777777777757777777377373777200504040404000000400000000000000000077153577770000016075375373777737177777717717777777777777777777777777777777777777777777777777777777777777777777777777777777375373577177573535300100040104004000040400040040004000177353577770070007277377777537777753757777777777777777777777777777777777777777777777777777777757777777773777577777775377537727576377717252734120050040400404040000040000000400007735353777005006535357777737771773777377777777777777777777777777777777777777777777775737777377777717377777777773777777777753753735752771775173500007000040000004004000400400000477717177775004353777737377773777777777777777777777777777777777777777777777777777773737757377173717777773577737777773777773773777773771773136343700000561040405004000400400040400775317777700367771737577537757777777777777777777777777377777777777777777777777775757717777777777737177577377777775777773777353717773771776535353716000047000404004000500050010001735717777761717777573777777777777777777777777777757375777777777777777777777773737737773753777177577737777537537737777757777777771757372537737271717100005252004004040604004040077531717777177777777777777737777777775777777777777777777777777777777777777777757717753757775377737737773777777777777777777177173777737753770775363774320000416524100000400400004773717777777777737777777777777777377377777777777777777777777777777777777777777737773777773777777777577757377377777777377377777753737753771775375757377577600000106141410143405007757537777777777777377737777773777777777777777777777777777777777777777777777777753777737777777777777737777777777777777777777377777573777777377373775373735373000000000400010000077377717777737777757757571777777777777777777777777777777777777777777777777737773777777777777777777777777777777777777777777777777777777737775777777377775777777777161612161637777777101777777771771773777777777777777777777777777777777777777777177577377577757777777777777777777777777777777777737777777777777737737775773737717717771737737537777777777777777775717177777771777777777377773777777777777777777777777777777777777777777777777777777777777777777377377777377777777777377577177537777777373757737737735377735737737377737775773777377717177777777737777777777777777777377777777777777777777777777777777777777777777777357537537777577773775753573577577537377737753757357757357571753777171735735775357537737571777771717577777777777375777375735377377775377777777777777777777777777777777777777777777737777771773753757377377777737777777777773777377737737737377375377777737573537737753773777777777177777777775775737757737777777757377777777777777777777777777777777777777777357777777777777777777777777777777773777777777777777777777777777777777537717773777777777777577777717711737777173737377777377777777177377777777777777777777777777777777777777777777737377777777777777777777777773777777777737775777777777757777775373737777773777377377537737777777710101417777757757377777771735377777777777777777777777777777777777777777777777777777777377777777377377777777777775775775775737777717717371735377575735373757175365737777773737777777773617377373775737773777777777777777777777777777777777777777777777777777777377757177573737777577773575373573737737777773773737777777777777737373777175337637173573537777577717777753775777775377777777777777777777777777777777777777777777777777777777777777773737773777573573753777737777777777773773777577577737353717353577175217437753577377377771737373773777375377375377777777777777777777777777777777777777777777777777777777777777757153471773737373773771737771737377777777777773777737577777777777377737733717373717177737777777577777375377777777777777777777777777777777777777777777777777777777777777777777773737773771757577573577377717777575717377777777777377773717353717357175717577717753777175773773537777777777777777777777777777777777777777777777777777777777777777777777777777777753473535377373717353717171735373737777777777777777737777777777777737737737353735371737737777377777777777777777777777777777777777777777777777777777777777777777777777777777777777773777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777773535000000000000000000000105000000000000c7ad05fe, NULL ), 
( N'Condiments', N'Sweet and savory sauces, relishes, spreads, and seasonings', 0x151c2f00020000000d000e0014002100ffffffff4269746d617020496d616765005061696e742e5069637475726500010500000200000007000000504272757368000000000000000000a0290000424d98290000000000005600000028000000ac00000078000000010004000000000000000000880b0000880b00000800000008000000ffffff0000ffff00ff00ff000000ff00ffff000000ff0000ff00000000000000777777777737125353313731773543110105302502105313321714317343717135371373147317317171717121135301610131217777777770146765074747776567616774776565774040371737031611737710110100007777777777717435357353531713343030301103112161705353317353343717135371370317717737371734125031131352171777777714066544724767776774747657700577764774340735757100371507530210777777777777777731737317353731704311151303112110431731305317314171731717171354731713535373107131703011317177777770664576076567476404776147676777674174074740573312411002173611137777777777777353167171735337173531163125351615307173171737171707373173733537023177373737351611010113521737777775245006047474747407777777767657775747477416560075141200115351103077777777777777377143161735717353463107113131303343353171317373107177317173171477135353717370737312503173577777344760547061604760777777777777764677776007470774033001010035212100777777777777777173563535335371731053130707071351165343171701773417357717177130177173717717134101713353173777747640076047447000777777777777777775667570467760774040301010101053107777777777777773712531335337171735301531313134334135353361371350735331737137707137353731737433731717377777776040000407647604777777777777777777460547743565054776011001031213010077777777777777353561737534717337161352171712717103737335137137061373573171711073531737171710351171735373777704740460464746777777777777777777777040667746776007751300530101301300777777777777777373071713713717135241311030711317605117533517171075353357373734173173537373735373773777777770460464740406757777777777777777771777640577740457777000131035310701007777173777777775353431613717357131630731713735311637317173737171235353353535725377777777777777777773737777567404706425046777777777777777757777775246577777767711350131030311300177777357777777737350771731171337510531071351613735534317131717305737357377373077777777777777777777777777776540060405646777777777777374777377777774767777747771076035031110121000173735777777773535307131717373513243357317073171163353712571735073171733535735777777777777777777777777777704600564064077577777777777737777777777424577756771147741121161037100017357733577777773731603521725153251071335213317077071335373371732177373573737777777777777777737737777777776460464604046473777777777777777777737777567776657167647421121121103001035775737377777571711613531337353371435135351713131471731171735716171773753777777777737777777773777777777774740405674747777777777777777777377737176567757370470067070121121100010733531717577777371734173535353353107127713631735370371737173537107377373777777777773777377377171377777777444006640464677777777777777777777777777756777774747047741137112116100305737161373777737173107313531735352471713171173537017173717353731637535777777777777777737737737337177777770760650406047777777777777777077777373437777770567674776012101611210010131717135357777713253425343525353131031717373537171617171371717750537737777777777773737737733713537777777744404656440467777777777777777777377771577774764044774470717131071301210161335253077777757131035313137377534721717173537371637171733737343537777777777777777737737753713137377777764604646560457777777777777773777373001777574777764477611301121010001017135131314377773131716317353135313001717353353717165317371713573173777777777777777737573533373353717777777465404006400767777777777777377735000137776067664707640341216131300300035253521707577135271653531161773716173371375335373531717173757316773777777777777773773737377171313773777770460000440066757777777777777773700010577756764100674031311310100010103131313521073777731131052773171371310715377135737171773353353337717777777777777777773773737333131353353777776764007640456006777777777737371000013576644566565671341210131300010103521703170073735371730311173171371352735377335373725357353757177177777777777777777773737377173317173773777344564046466404444056477777537301000373405606746764011331352171001201013523152107177735303504373171357017005335217135307107317371337377777777777777777773377373137317133353353777706400004400676000640677471001000171464767444564031301052117100301001703117211617173531713035316127331710737171717731734071737171777737777777777777777777737377735333531737777717746654047046440044700465700016113000564440676653130171311303001010303152311340217173613530435313513531210717313613535312131713771777577777777777777777373735333337113713131377777344660240404740064000007003012446064000065641301430121217100303010117214341305030713521770035312153431340315251703537140713531737773573777777777777737373737171337311317171771777714540440064600464074764547407644764474661061711131171213001100121311331330433171353713107121713013170071631331353113013073173537752777777777777777773737337373131371731317707377776646600000000400464006460040000476461100121212163011710430103104341170510350307131714035353017317034353153417125240735317537717377373777777777737173537713137113133135371377737771404047400000000440040000046564612110016111211111303013012110331333130343135134352334031251210717107353213717131300131733737777577777777777777737173713737133713717131774353737777776646444600006000046442564670513430031611030301700012112131170552530043032531351307171335313137007153513035211071631535737716173777777777777737373733733531313133713707375737737757474604640746406546442411030301104111210110303104012112533130313134315113171371407135031707110712313253121520031173733537777777777777777737737373717373313533531177165373577777737777574746445652413513125110130012121121210110013152113152531725005303616343160335303521310243535161134112143537371777777173777777777777731737737313171731353137350737173717352573717737353737171343070110212100210130101013020210311612313171134121711311353134135311353531061303116113010013535373537370777777777777773777371737373331371335117340537153717352573737517340707317351130211011201712103103011001312531711725371124301253717135035215271212170171703130313030703535373777757377777777777773735733717171311371333173163537353707142570532717161352513307111211211401113502101211041713030371135363105331301212530431731135353107031100110411000713737177377377777777777773773733771733317131335353170143417217317073173535317071353250303071021120120301311303124330171711371133150435053537171703713107031316053160317031301071371717717734777777777777777377377337371331351733137124331335351700717053530700714351131501103112107111131030105001153012125363757312131303113121051707131716110210110101100300317137373737713777777777777777777777777377373331537174101170535321705713725353507331216121312110710003070125103130061213110133151317052521716161370213134310313514310303121310140307171717735653777777777777777777775341307071331313130060130305313003411310303014105310101012101214311130121103130131412130757377735213171213135105350311251212021030110101030035317337735731777777777777777777757171310101373535317100112535321610613161035110031310130103010131003030013112105007031301011317731730717031711612012135035335310503110212130104713535713737167377777777777777777737310010135153313530003011010511001212117121243001030012101103010051013100301130011030130077737771750731731631350717133031035302110211010121303533733753773177777777777777777777510100000017335331711043030312121041153010101001121031010102103010303100311012100121010010731737773731731711531300316153171307116111035031101433537533771774377777777777777753012110111000015617137200103110311121203103031210021110010030101010000103110121013000130131017771777771471352373053525313317037130612102103121312573713753777377773777777777735035355371731510001717701100314311430100101311011021102031211011010130010100312112100030012003037777737377335375317330131351631713150110311301535017353777377377177777777777773513513130111053351101771130070131303131053170161307050311101030102121000121211010010101013101101777777777716537131731570716331531352352311210713013343773777375377577777777777713171310135371315373103520010113161311032072113131110311212121012110110031101121213030003100100307737777773717137171731310315331707353014301311253353573573717377737377377777773177125353131735335357103131202521135271510113412163105211111113110121210003100111011100101301010177777377775637717331737071735213317317431734121314317373777777777757777777777317313113107173777531737150101013173031133043713353110631777377777373111001310312121030012121000210777777773733171316171611073135351731703101013171733525777777652104277777377731713535341717353537357571310100010351353250310351317377577525010505357730301031010112100210100101037377777777757335735331734353717371371707131343121753177050001040014077777737713713011331357777775337175000100010370351314771377775713400100000000000417531013130313051130100010077777777777345331735353125353310375313430521353531377770000400140014057777777351717351071353771775357331001111111353353211377777434001000000000000000003531051014110030100100210777777737735335731735217103341737137353413110313535377104700106756207747773537371710325175375777317735110110001107317351677771611013400100000000000000000703121313003012100010017777777777773433173131710735333113710305303431073737770777406456065570014777753103535113137773711771101110010100171771737777171607000010001000000000000000130110300611101010011077737777773717717353731730537516371737125313173171777575646747676566756704773757110717757777773773130000111001110771377777516101105010000000000000000000000532131101721000012000777777773777717317353431343133317171717035307173773777775747400456556756701773737711010343571513571110010010001001777777777357343034341010000050000000000000150121001121100010107777777777771635371353735343535353371335431713535377777770006047606677674073777777771711113173753000001000010100177777777535305141000000401070000000000000000313500310100100010077777777777373537037331530173537317137523173773737777777747650460447465677777777777777777777777300001100000010110777777573530530374175353107057310000000000001710071030010101010777777777377753713713573716137131733533507171353777777777774640540761465477777777777777777777575000000000000000007777777753577575031035257053007700000000000003100121121000300007777375777737343711713131716137171753533437173773777777576700766704465625777777777777777777777737000000000000000077777777773537077577561763571001000000000000053010121001000110077777737777773531733536173253717373373711717353777777777755046564476767477777777777777777777777111300000110101000777777753577753712707100142070070000000010010300713110100010000375771777373534371353317315171731717171707353777377777774766474677644747777757777777777777777717370100013000000007777777777777350574100005251007100000000000000611210030001000017737371777773716135271711732533537373737307377177777777777752424464765677777777777777777777777777141010011100000077777777777770712170710301701617000000000130010531031010101001071771735717777136131173731716173531717135353737377777777747654476744644777777777777777777777777713001011010100100777777777777570570110414161600071000000004170003071011000100000371737137773733417373171371217137373737737771777777777777777467444604677777777777777777777777771700000001010010017777777577757353052431201001015340000000012100171121200100101011735717773375353735317137131613717171731717377377777777777600742076565677777777777777777777777737100010110100000077777777777305705251525034000702100000000005037103101100010000037133710775737352135237317350713737371773777377777777777765046546046467777777675777777777777773710113110110110001777777777775730701006125010100050000000010030013103000010001010717717373737735357135117717334353537373773577377777777777567746644650477577775777777777777777750131100000100100077777777771775711753010530400001010000000010010703113100010000003710735357353737037333713317137373757377173737377777773776564745204646757774777777777777777773313010010101110007777777777577771650341252051012104200000000007001352100101000101017373171737373531617171371713435317337537357777777377377756470064404657777777776567777777777751111101000110011377777777777577161035214105200040101000000000101031013010001010000735377335773773535373173173353737737737737373737377375377777447476704677777775777777777777771371301001001011017777777777537577134104034001001000000000000000700033101000100001003171357331771737160152173171351733717373717177775371737776767460446044777777467774777777777771311111001101017777777777777577756134311012161401000100000000010101012121010000000077337335737377373137335353737363573735373737735337173177756104700046567777777757477777777777117131000100113777777777777776717351410401450101000000000000000016017110100010000010357371773177735371613533371353537373737717353173713717775654065400004677777774707757777777735311010112113777777777777777535757161252161210000010001000000010010310210001001010007335377377353773530713535337337173537373735377311713737765670000004004777765656577777777777531311010111777777777777777777536352141010014340100000000000000010000311010100000001071775335377373737170733735717537373717373735317373717775725650000474046777577777677777777773711311313777777777777777777777575757161050000100000000000000000001001210000100000000377335737737777737313571733733717373735353737731353733770567000007400077777677777577777777735311177777777777777777777777573537010116310100000000000000000000000131010010000010105335173353777371353053331353171735373737373713177737777770016140740004777757777747777777777531377777777777777777777777757347753777717400000000000000000000000010103001000001000035736317357357377317271737373735337171737353777333737377716140141003473777776757465777777773537777777777777777777777777775771757761601000000000000000000000000003100000001001010173317717377377373711373535353734737371717371377777777777502112007047377777756777777777777777777777777777777777777777777771777771501000100000000000000000000000003103010001021016317431635377377173727173373371313531373737377737737777733714005001737377777777777777777777777777777777777777777777777775777776142140100000000000000000000000000110001000101012017713173537377737353117317137137343777373737737373773737373737137773777777777777777777777777777777777777777777777777777777775011210010000000000000000000000000001200100010301211431617353717737353353613733537335373337777733737373373737373737737373777777474240567777777777777737173302137777777777777753435341410001010000000000000000000000010010003010101003173617313737573753353435373135337773333777733737373373373373733737773777756101000507777777777777776140500001377777777777753525210250000000000000000000000000000210010010210303117351314771737373371321733173737733337377333373333373373373733773773777714000404070747777777777400000000000400257777777757170714141001000000000000000000000000001003001011010100617335733135377717137152357333773337333333373337373737377373777377377777435777707477175777777700000000000000005377577777716171430300100100000000000000000000000000010021201210311314121353737173737313253333733337333373373337333373377337373337737777710777775077574707777700000000000000011007377757753717071050140000000000000000000000000000001000101310310035737171253537177317353057733737333333333333337373373337373777737777777775475725777770477770000000000000000003005777677757717070102101000000000000000000000000000121010100310311121312135353343737733337373373333373333333737333337373737373373777777777773470052574177777700000000000000000010077575777771751016010000100000000000000000000000000100030310130307171353433035353773731717373333333337337333333373733373737377777777777777747125352757657770000000000000000001250577777753571252501410100000000000000000000000000110001011013010112130313117312777733323323332337333333333737373333737373737737777777777777140016050257407700050000000000000041003777777777357103000000000000000000000000000000002030003071301213353413437017717737373333333333333333333333333373733737373737737777777777777375017257400747100000000000000001000075777577575307505101010000000000000000000000000010101211035351010313703113733337337333333323333333733733733373333373737373737777777777777777477405670067777000000000000000000007743477777737530302500000100000000000000000000000130300313121213013431353673377373323333333333323333333333373333737373737377777777777777776747640424000474775200000000000000007575707705753553141410010100000000000010000000000013011035217131301703137331373333233333323333333333333333373373733737373737737777777777777756777004774770576705700000000000002177677057777777347130012000000000000003500000000000013125035217050131353137337333313333323333233333332337333333333733737373737737777777777464644640004047406700677505000107161756505777000575357316153050101000000000017100000000000707125131213130137333273313332333233333333332333733333373737373733733737737777777777656740000074067640000575767700416500416777777775777777717535214010000001000005370000000000424133530351302130137333323233333333333333333333233333333333333333773377373737777777757474000004656504704756524057470770071257777777777777571771341431001010000010117430000000007406753071034111013273331333323332333333233233333333733733733737373377337377777777774246740047000064704706760077077574774774577777777777777775347131020500010000035210100000000675740243103130303033323233331333333333233333333333333333333733337373337373737377776564404004064000474404004104747724740776776777777777777774735317435102100010015035700000000004642440043101010101331333323333323333233333333233332333333733373733373737373777777706400000670400000000070470477777577074757757777777777775675775701520510521001431500010000000700040056103121312103233333332333333213333323333323333333733337333737373737373777744470000004041640560046747477757556777417677707777777776567467171353413001006143043401000000074000004640210101001033323033333231333333233333333333333733373737373737337373773774676740460000640646406756777477776775774675447407776774052467747257253143525012107100000000000464270047040121303121333333323333323333333333332333333333373333333333337337373377640444004000004004000046777770707756767775677777657574256477567057357057177171410507110100000000054640676740101001003033333132333332332333033333323337333337373737373737373777774040000600004640000470047677434475034774434774750676705657740400645717377753430001214730000000000600004404042101301333323233333333333333333312333333333733733333733373373737376420000004006040420006406767767477042457707407047765774067764740064163717575251010000573500014425604450000046500210130333131323313233333333333333333373333733373733737337373777745400044004040000405447747747577774050604077447747465765044747604776445777775200010101350102467406470640000046041030113233733312333323323323323333233337333373333733737373373774664400000004000000460467767676776770675424770747725046565677654004476064065351777777777770005470474004000600470001012031323333333333333333333333333333333737337373373337377777000400000000000040000006767477676777765702576004765406770464004604700440000577777777777777750076000000000007407646001211733330332332313333333333323333333733333733377373737373744040000000000040647400477676765657656564047645076567656440756425674004704047777777777777777710400007647600540044650030123333333331333233233231233333337333373733737333373737777000040000000000040004000445740400676472470041674004740400042447560470424747677777777777777777760004047044064600000640171130337303233333333333333333333333733333733737373737737765400400000000400046004600064000400400540470047040076000470047646404004740004377777777777777777040077047707400740000740121333331373323333333333333233333333373733373337373733777046400040000000640040074006004367400407601647400764045607404650470576474040654777777777777777770404400746440044674046002117303137133133233231233233337373337333337337737373777704640000040004040000004400440674400046764064740040410065247000006746645647704427777777777777777700600047004704670400674013031377032323333333333333333233337333373733733373773737400000000000004040074567202400460000007400564706776656065646406004007247044046577777777777777777040460057706000400005674001137117313330333333333333333333333373333733737373377740400004400004000004464044047004747440046564006004454045640474654004744064760006777777777777777777400400674147700707604060307032313733333233233213233333373373337373373737377737740004000040000040400070004406640460707656475004006020064047441600474007476500077777777777777777740000000047464064074004400117313073333333333333333333373333337333337333737373770600460004604000007006464640045061046404650640560056440540064674070465647400406477777777777777774000420000760000434007060003313753533723331333333333323333337337373737373737777704700040640004000044050065000460460074004604006544640046700470640470744006647040047777777777777000400404007704000467444044013073312713330323323323323333373333333333337373737377466400404400654060006460460447474050060000460046064740004474400564464024045240640004777777656744000640074047777047446056700053531713733333333333333333333337373737373733737377774400000000047676404746540000746447465440047406704504004467404046746540470564004740046567765656424064040060777744040610674003312731353333333333333333333333333333333333737377777400004440000464640004044604464647676766746560404046000476776767677776004646400404656676646464644400400640404777600004400460011713000000000000000000000105000000000000e0ad05fe, NULL ), 
( N'Confections', N'Desserts, candies, and sweet breads', 0x151c2f00020000000d000e0014002100ffffffff4269746d617020496d616765005061696e742e5069637475726500010500000200000007000000504272757368000000000000000000a0290000424d98290000000000005600000028000000ac00000078000000010004000000000000000000880b0000880b00000800000008000000ffffff0000ffff00ff00ff000000ff00ffff000000ff0000ff00000000000000113330735737777704000000000000006060000252000014131315311716037070021240161075371617637506357172512171357170173537160000025214002070000012436167777777173333737171773737377700001111131330131357737700000000000010000050040006331131313310705073430040000003070761617433514356537571773171771716167170604076776775677064253437177777737357531737373753537337113313111111113131235777000043712006767773677777711131531311777377077043125361707171177773563737373563777177371374735716771707717735637700016777476777737531333733537371373717531111313130131316131112163035371350007753477177311137133171331777777770734772516177777717777352575777357377717537533173777160277767777777043635673717737533337171353735737353773713111271131130317013111111131131670073677776771733113113135137777777771470777616777777777175377375377357177773573757073577775677777677770365635777677533753537337371737353377377313111123130131313103131313131711770477670777353533133531331177777777763777177717777777777735357377757777737777353353553737737777777777761771637535733533333135317373753371317371271131111313521313310112131171337003717377771313117113171131777777777177716777777777777777777735353773777777777775773365777777777777767160677747673173717117337335373777177775311123103121113130371131317113313143047765767171715331313133137777777777677777734377777777777437577777357777777777737357530735777777777776071777737317371733733531737177313733737131113313113303511130153311311317343077777773131331171353153137777777735377777777777777777777537737177777777777777777737777767777777777717061617717331337313173371737737373573773103111313103132130133071311311313000617277173171731331313111137777777777757175377777777777736527577173757775777775257537171777735361777253525616717373535333171371737717173753713313121011313113113153131131371310000604167113131171131713131177777775353737736535777173773753752767757377737737777736757777177777776165206353735331317337133335373753737373773111311131311301312130331303113131701070127013353133131713113113171773737773571753773527657765274371717737737777773773753637177777707177716535273533173731713717133717377317177373121131111121130313131031313313531600076507711317153131313113117777777717163763777767753717373136161634777577177757757777567075717776353613437473353131737313313353373731373735311131103111131111301731115313313131120012507317133317131713113137773577737753753435373777675756537535736173777737773773577377736777777677617437173337331737313353353753771335337131111110131303121731073131071313134107612771313535313531311313573757373535375377777567743527253473434357677537577375777735717771717171771707167317131733537317311331373337137131103331313113111113113312133131313503071650131313131531311313173757377757777737437773717377775367343717773537777375773737777777777777777167736535333373173731313133537311313313311111121353011303310335313111331312161677373135373133131135311777377777373717537717777777777725357343634777777777773757757777777777777777716573733171317171733313713317331331313331331130313311113311133173311531371753777717131171117173131311777777777757737717777777777777776347757737777777777777377377377777777777777773777173133333373531313313313331331311121773313311031341373053105313171773777771313537133713131311137777777777377777777777777777775357777775777777777777777777777777777777777777777773313713535373313313131331110103131137701710113113131317331333131337777177731731311311317171131177777777777777773717777777777377737373737777737777775777777777777777777777357777131331313331373131313113111010111773371600771213011305313171143171137777777131713131731313171131777777777777777777777777773577737777774770737777173737375777777777777777777775737331313313137353113103113331111117701677000071513131331353133131331177737753131313531371313131117777777773777777777353535777377771773773775737177777775377777777777777777777377735313313131313373113110111131113171607777000072111111134337113131133771777735317113371310117113177777777777777775377777773777535377357177377777777537777735777377777777777777777133313333131313131101011131113111677077700000000003373131013353533713777373131313135135313631317777777777777371737573773777373737717337317737537373773777773777753777777777777737331311113133133313111131353353137777343400000000000113113111312111717357713171313133131717531177777777777375377773771771717171713707531753573735371777373777173777773777777777713173133313113013313131113377377177701353700000000003113713121313131317371371311317173171317131377777737357377735371771373737371771333533723171735373777577777777773777777777777733133113111113101313131757173173343410111313410000041371353135313537375335131731713117135377177777377757377577173773777773535333171713531117373537173537373777737171737777777777313313113131111111311173337357131353131301111343035363131317133113317137133313113313313531631177377753777773313717353121013131717171312113331313312113777753737777777573777777771331333111000101111130311771733110111111110311317525753173113153035337713535317317315313171533157773773735375353717353113313131331310110110131311313101313773573737773771773777771133131311111131331131371373713131313013111311313737371173713131317137713131315317313531373513353577757771337317313133313121111313110110131111111111313033173753773777773577377733133133331331331331011171717311111111303111131353537737113312171313713713135333713713171173711313737331371731313313111111113030101210111110010101011111110313371353737753077777313113131333133131131313373775313011031113013131317777713371713131131311353733171371313107171131131135777137113111101011011011111311113100011110101000010111121131377777377307377131311331013113133713131117131111313503113317035303177353131713171131731311171137131353131213171153131137313313010101001011010101110101111000111010101010101101111317377357757077111131101013313713331133110171031131352115213131313131317131353031311353373371137171313131713133131131331310113111131130121111110313101211310011010101010101100011337177737737173131111101011173735333533331313501013111631131735353173533533313135313135317137313313171713111111111111101011010121012111110101011011131101011001101103710112110101117373773777653113101103137173133533353133131313171313113073130331213353135353131303531733711535353131311313131313170101101111113111101010101101101010311010110110351310153501011237175377771377111130111313313353335373311013113101213713103131131317335131352133533171711733313313131311111111211331130110101010110110101000101101101013030010131031131313531011137337135370527131111333331353335333171313177307335112153171725353711131713313513530337331717317171131313113311017521012110101110010101001101000101111211111101013170170103031210135337377737147131331311133317335373731113111711533113313331131310317131311713313171537171371713131311331311011313113111011101011110101100100110101011131301317010113131311111113331713317777323131131003131331333131337307131130310311213533173131131317173171253133353137131313131131110101353531010101110101101010100111010010101112101101313131310101010312111113351731777507111110313133133113373111711103131135371713413107112111313131311353571373537131311103101013531131211110101010110101010110001011010110111101310101130113111311113010311331733537707331111310113113313171131173171533131313133173133713121713535312133171173533531313111111031121111301011101101010101110111010011010131031310111110112101010121013110311331737737707713111113313013013131103113131013131313111353171353171353131113517137317173173773301013113130311111010101301030112110101011010110103101010101010111101211111312111031173131717127731303311210101313173171311131701616017337335331331313317130353373531733317717311113113011131030301010110131111011010111300101011311131110100110100101101010113101133317173777077775775311111130117113170706070700005200101731731535351731171353173171757733717310313011011011111311110111101031013110101300001011010121010110010110110101100101311111313353177577737737713131111371311777777777716705347253531731313313731135353171373317753311351011101011101010010110101311013101011011101011013131110100010100110101001110100230011311377137037777777777777377770707725777777610634305277353535353731737137137137177731310131331310111010111111310113111011101131011700101101010110110101001010010101000011031371011373131717777077737575775777777777773677761071777520735373713171773535353717313713131013011111011001010101101031101011010110101073113110111011010010100101010113010311301107333013313773770777747773773437577725777777777707767036571737753735371353137353731713731101311303013775311011101111101111011010111111710100010101101111010101001011011131121100331311011311171771777375777777537777776776776777707716537371713717135377377171713533111331113011111313377751001101011100101011010101013311111010101101010011001010101010121101100110101011033735377777777777577777777777777777777070773535373773737735317177373733113131101711300101101113733100101101110101001010111011010101010110101011001110311010111101100110012110103117377527777377777357776776777777777770525313371717353713171737335371713311133133110111110131310357710010101010101100110101701110101101001010101110001101010010100111011111010010335317777574777777775377771725707777772531715373737373717377535771737351311111011310100111010310313371011010100100110010103101010100100101010101011131111011010111211001011311111131237777375777757777777704725707436531713737177173753535377637371713331313111101111101301111131011133010101100100110110111010101101110101111101013013011011010011011111011101313011753777737777777771725073520717753431353537317351373777071757373311111111301110101110110310113101013110100110110011011031001010100110110301111301101101101011001010101101110101071371777777777771704720742577634367125313531717377575707737375311131313131101011101011011013010111010111011011011301101101101010010111011110310110110110110101131310100101011113117177717577753577073512753471777707531753773717737737735357777731113113133101010101011011011110011010101001010101110101100010101010101010110111010110011010101113130110101101013031777773437777770742616343061617707672717177777777777767377371713113111113110101101001011101111011010131011010101010101110110111010111010110101010111011011010111110103101101211771777777577777712755257777777770735357677777777777771735735737313111012111010101101111100110101001010111001011101101010010010101111010110110101010011011001031011010100112111177377777777777757616327777777777777567773577777777777777537773535313100111101101100110010111010111100111010111100110010110101010110101111011011103111101010371713101113111011107313537771717577775257507777777777737377777377777777777773777377331310113121130100110011010001010010110101011010111011010110010111010101013013121101610101217130110101010101103131717771777777171727777727777777777477777777777777777777771735375331010101121110110111010111010111010101010101010001010100101010011101101011011101311371311525110110101013101111310317775257377777507776577777777777777777777777777777777737737137131310171110010011011110101010001010101110101011301010110101011101101011011101131311111703130310110101010110101031753777775777777727353777777777773777777777777777777777353753713571013121011101101101010101001110110110001011110111010000101110110110101010313010112121353411011011011111211113153775375377535776574347777777777757777777777777777777773713331313353535131000110101313110101100010101011101100110101003110110110110110101111011352111531113701101101001011130113317775777777777353774377777777777737737377777777777777757717131777317331031110101101101110101111010111010101110113111577777370110110101100101013131613536111305301011101011010317017737777777774347034167361757772757777777777777777777737313133111371531113111101110110110101011310101011101010301077377377710110110101110113111531353113635130171010173101131713777577777777774373436756572773757737777777777777777773737131011311713101035010101011011013107101011101100101311117737775773130001011101013101213317134311113717217073110113131317777717777777034141617373777677737777777777777777777777777131310303103131131773730101011101313111010110110101010137737727170131101000101101311311037135031701315313152111013112757777775777773436216167567535777777777777777777777777717373531311153110110737777537131031311777713110110110111110737521717310101371310101110311017101131431315311713313011013113737777777777741615250716352773777777777777777777777777777313130107301031013513353173511111035331717017010101001011713537371011135377510101011101713110353171301301110111011101357775777777777216102527777777777777777777777777777777773735773513111111101101315335317301035130101311311110101117727773777710112112537371301010330110317131135311113071121013137775777777777775250753477777777777777777777777777777777775733133717730101121101031535121331134111301711212511121713513773531312113111305377771735110101213170101303011121171101013777735777777702527673477777777777777777377777777777777737717113317531121101311131121711521131215131251113031112513411777701111010311310135371121031117152131310111011103171331357735777777777753473743777773777737777777777777777777777371737353533101110101012107111031110111133111312111103013103121331310101011010533531121113101213111110110101101353131111377777773535777673757777777777777777777777777777777777777773131313305311011101311311213101211031251031011101351710101111010011011101311351317111301531113012111011010101311301257777775777773773747763477777777777777377777777777777777737777131315301011301311131211101311131111131011101370130351310101111071103110130310313161713121013110101011010131301111377777777577777757737573777737777777377777777777777777777177353101311313010110121051303101121012130111010777173111210731101011031101130111310113131211113101112101011031101121071777777777717577763572757777777737777777737777777777777777777777131317101111031111315310101111111011011377353117121177101100101170101111030131211111121301101011117017521113113137777777777777737577257277777777777777777777777777777777773773731121735310101013030130531130301211301777717171303110310110111131371100101111101113030110110301010731713112111735777777777777777572775357777377377777737377377777777777777737753531171717010111011110113130111311101137777131171110357713010101011130111101010111011110113011111310173717110131737777777777777777257276353777777737737777777777777777377377177373713537313510011010131010131010301101777371731121110373053510111010113121101110101010110111012101311173137313031777777777777757775355717777777377777777737777777777777777773777713137717131311011011003111011311110177735331071152117771313210101011010110101010101010310101011101437113717353137777777777777777276373777377377737377737777377777377777777735777313171312535301101101111301301101037771731153121211735311435112111301013131101101011111011131121313310301371311777777777777777775717777777777737777377777777777777737373737737777130317113031710110110101101100101771731521311111317731213112112101111101030110111010101010101105015315301377137777777777777777773777777777737737377377773777777777777777777337777531313111131312110010101101110117771731131303110173111010717117112101101111030103110111011101131211313171313777777777777777777777777777737773777377773777377373777373737371777773131350307105351011101101101010773121121010110017211011313130311251310101001111312113013101301011121371313777777777777777777777777777777777373735737777377777777377777777737777777112131113130107110110110101137112110111011013771101014352535211130713111131271011101110110121130113137357777777777737777777777777777773737771737737777717373777717373737717777773113573773531310351011011101713111011001101073570131313113131213113152121051111101111010111110135711153777777777777777737777777777777777737373437737737777777377637773737377777777313173573535310311211010173010111011100111773171035253143151707352111113121031101211130101735737373377777777773777777777777777777777737717353577777777735737737737377737177777311177777317353535311121110111010011001131077735303513101313131311113030101113103135121413131733757357777777777777737777777777777777773573737377777777777777777771737373773177777173733531735371307030111031001011101110503171521711213531703703130311111313105314103531316113715331737777777737777777777777777777777773772737370777777777717777733717377777177777311773771531735317110101101101010103013113773111211713121311110110121210101121131713535317313331737777737737777377777377377777777777770753573534357777377771717752737377777777777731531731735735317312101101101031111013410717031701107111303110111111311121125371773535371711777777777777735377773777777777777777777377373727373734377577777771737377777777777777773173531737173535351330100111103013101311211101130313030110110103010101113537137177377171377777773777377777777777777777777777777777707773534365737716375357163717377777777777777777313771737753535373513171010101110131071112113011101111011010111113103071717753717717335377777777777737373777777773777777777777773707167335327777714177371727377777777777777777777711335353737137153717177711110311011130113011303101011073711012103113131313353773771737777377777377777773777737777777777773777773737376335353517730115073537377777777777777777777731537353537537371737137370710131030130113101101101033717735317177571615353353573777173777737377737377777377777737777777777737773435317237277735341617317377777777777777777777777773535373537177171717537731313017113513050310110117575773535353713731331357373371317777777777777777737777777737777773777777777773363735353773777535371637777777777777777777777777713137717177713735373573534307121703035371031037773737173735373777171171331317527777773777773737737777777377777777777777377777777170736357353032525637377777777777777777777777777777513737737771773533573531717171753537173537537173537753577717137173131171637177737777373777777777773777777777777777377777377777372537236353533531377777777777777777777777777777737353537531771737537773571777731373537173537537153717373335377173537170675242477773777777377377377777777377377777777777377777773712717737252163777777777777777777777777777777777577737737773173513717353777371435753717173713173735375357533133317373001024107343777373777777777737773777777777377777377777777777371210101217377777777777777777777777777777777773677753537317131371735371777713773335373571717717171737733113100137100000100074347735777377377377773777777377777777777777773777777773737377777777777777777777777777777777777773471757373717707175371735373711757357537173737713737335353531216174213000000000160137737177377777377777777377777777377777777777777777777777737777777777777777777777777777777775773472777573717707025371735353733717337173537531717175737373171706353471000042107162473637376373777373737377773777777737777377777737773777777077777777777777777777777777777777737753577777777770735317171737371753735717353713773737333531370070714253600000010616150377177177377377777777737377377777773777737737777777777307777777777777777777777777777777777777767177777777775040603121317177377173311317777131311010343107347435341041061061777276536363717737173737371677377737777777777777777737773777017377777777777777377777777777777777777167777777777727371707576713177377311060131313371763434340347737767761207161007077573713173771776375675271735377777377777377377737773777707677737777777777777777777777777777777777177777777777525677020753673135311677166072147777140774340377677777741676167077773767776172723377373737377377777777737777777737573777370761737777777777777777777777777777777777777777777777777773577527777172531770167107757375676372537734777777777275347712777677777037017757137373735235237377537773777372777353537777173577737773777737777777777777777377377777777777777771776172577777777607077070777677777314775610477777777720536710657777777770503303323743707073773577733637777377773436777670007677377777777777777777777777777777177777777737777777774176142770776777307077070773776777430637270777777777512416370376775777727765301703353737371212537771703774371773535213170001077377737777777777777737777777777777777777577777777736012147777753574007052525777717763410505003437707176012140505717727035001000600343303030035353637163775377763477637767007000375273773773777377377777737377777777777777777777777610400030707276301000000072504761700020000077410776701600210063600534720000201006304343037020071707707127525353703170716100007737777777777777777777777777777777777777777777777101073001675250534060030104352430170507016125703676010000050002714177043401401400751437070500143163740707703727343767070700001437735373777777777777377377377171777777777777777777777777705207772521014060707617767070305204036571717771610012415636707371423000210727052572002007707307007707163701010070760002053677777737773737777777717777777077777777777777777777777775307077560210110717617167761615314172776707761670717271610707671507014252572572570500740700434300707161677677770107001671737373773777773773771677777717171771777777757775357777777525252105060601671616170105204216357071770101034725777777771060701610777777777252070307077700071616177777777770707707373777777777777777777373777777777777177777777777777070777777777770707171777777777777773573577777777777777773577777777777717770777777777775257770434000000000000000000000105000000000000e1ad05fe, NULL ), 
( N'Dairy Products', N'Cheeses', 0x151c2f00020000000d000e0014002100ffffffff4269746d617020496d616765005061696e742e5069637475726500010500000200000007000000504272757368000000000000000000a0290000424d98290000000000005600000028000000ac00000078000000010004000000000000000000880b0000880b00000800000008000000ffffff0000ffff00ff00ff000000ff00ffff000000ff0000ff00000000000000777777777777775773775737773773777777577777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777173434716174361735707353436571717377235700007777777737777737777737653777757377177737537537777777777777777777777777777777777777777777747657252103060206042434777777777777777777777777735777375374361705253432163617075727777777737777777737777777777777757775777773573777777777777777777777777777777777777777772524141210000040604004000000000004061677777777777777177763534736175370773527577757777737577777777773777773757717717717717373737771777777777777777777777777777777777777777777127052430200400604200000000000000000000000000077777777777771776773717237077052707271735735677377737357775773577737777777777777757753777777777777777777777777777777777777775251076502410040600600000000000000000000000000000000000007777777777171756757577307371717076734737177777777777773577777777377777777777777777777777777777777777777777777777777777777676107412042000000000004000000000000000000000000000000000077777777773773637075352525617357737576177357777357777737577777775371735737777777777777777777777777777777777777561600000016700604004004004000000000000000000000000000000000000000000777777777177777377677773765725772737777777777737777777357357377777777777777777777777777777777777777777776536177777777650060000000000000404000000000000000000000000000000000000000077777777757377671717075377777577573777377777777777777777777777777777777777777777777777777777777777777172577777777717777040040000200000202004004000000000000000000000000000000000000777777375775777777727171777373577777777777777777777777777777777777777777777777777777777777777777567537775767775600247142006040404040404000000000000000000000000000000000000000000077777777737370707567677774772777777777777777777777777777777777777777777777777777777777777757572536577727757700000164250400000000000000000000000000000000000000000000000000000000007777373775673773717353773577777777777777777777777777777777777777777777777777777777777756376357616767577777700000025020000000000000000000000000000000000000000000000000000000000007777777777174347777775352717777777777777777777777777777777777777777777777777777777777374357635737576167061652007560400000000000000000004020000000000000000000000000000000000000000777757377737716177767757777777777777777777777777777777777777777777777777777777777765374357434777077752161257003434246040000400400000000404004000400000000000000000000000000000000477377347563777071737377777777777777777777777777777777777777777777777777777777775161434243652527777756140007403400004204000000000000000000200200024040000000000000000000000000000377757737356177777756777777777777777777777777777777777777777777777777777777761636342707165256775777777777777000000000425200000040000000040040400402004000000000000000000000000000077373525617271617735377777777777777777777777777777777777777777777777777771775414340564167014707777777343576100000000004752440004000400000000000004204240000000000000000000000000077567773615777725777777777777777777777777777777777777777777777777777777770736340703167047025200777757202172507060000000652060004000400404004004000000040004000000000000000000000077352353634371737177777777777777777777777777777777777777777777777777777670504250746014304004043434275710050725100000000047004000000000000000000404000200000000000000000000000000077775743537477476777777777777777777777777777777777777777777777777777071072435274212420424200240041427060030052473400000000420000000000000000000000404040000400000000000000000000077172353653717353777777777777777777777777777777777777777777777777177477043425010410400004040043607404140061253043612000000040640000000000000000000000040400240400000000000000000176775253777777777777777777777777777777777777777777777777777777776537043471724202420424003043405607024240040243043416100000000060000000000000000000000000240000000000000000000000735077253434353577777777777777777777777777777777777777777777777773467743424014040040000604306521604000000000000100216034000000042500000000000000000000040004000000000000000000000527014343537072777777777777777777777777777777777777777777777770743535360500606034034070434702040000000040040042410501434020000000656504000004000000000004020400000000000000000003714363527707357777777777777777777777777777777777777777777777775347765160610014024072452400504042000400000000000200203030506000000000616160000000000000000400000000000000000000001634107107717777777777377737777777777777777777777777777777577767347724100424204070452521602002004000000000000040004000030314700000000042470040000000000000604000000000000000000061527077316703777777777777777777777777777777777777777777773752577716524612500563472524040040404000000000000000004000404004212520000000000047002400000000000421400004000000000000172016125613757777777777777777777777777777777777777777777765677741607521040256056152434306120102040000000000000000000000000040357340000000000650040000000000060000000000000000000705253573757277777777777777777777777777777777777777777775371777760524747025617256250004404464040000000000000000000000000000000000716707000000065242040000004074000040000000000000725363757257777777777777777777777777777777777777777777765671671702503244707657050656125212120350000000000000000000000000000000000001616520001060546006000002070400000000000000070707577277777777777777777777777777777777777777777777777371677564652645217771616070216525674774301000000000000000000000000000000000700712107700112034610000040470000000000000000170707257753777777777777777777777777777777777777777777776565352535214120747774343417470753537531000010000000000000000000000000000000070041650030677400046000253640000000000000007070737773777777777777777777777777777777777777777777777717374240607420547356534343743773676573000000000100000000000000000000000000000057252121013577777000040643740000000000000007071757777777777777777777777777777777777777777777777777656534343416520347736747343743571777741010000000001000000000000000000000000000217010000203177777742041677740000000000000725242737537777777777777777777777777777777777777777777753737470042430476770571734775376777177300000100000000000000000000000000000000034161001210102777777750000567704000000000003525375776777777777777777777777777777777777777777777777765743004341043177177365777167571677770000000010010000100100000000000000000000003002100010617777777600600000425600000000056102527377177777777777777777777777777777777777777777775363742524242147576525365777772773576710100100000001000000010000000000000000000000100210211037777777007000000000424000001200614357176177777777777777777777777777777777777777777775752542505252167537565372573577577357300000000000000000000000000000000000000000000010010201077777770077000000000000000025300020216177777777777777777777777777777777777777777777727772142525042536743534757777772777774100000001000001010000000100000000000000000000001210121777777700000000000700000000704034175777737777777777777777777777773777777777777777777577054252420356771776777273477777477710010010000000000001000000001000000000000000000000012107777777400000000000000000434303403434341577777777777777777777777777753777777777777777077025241504252563575257577775777177300000000000010000000010000000001000000000000000000001217777770000000000000000000000701612537363777777737773777777777777777777777777777777777167061626143473576377727573777777747100000010010000000000000000000000100000000000000000000357777770000000000000000000000761612535777777777777777777377777777777777777777777777776714161416007076175673572747377777730001000000000000100000000100001000001010000000000000000277777000000000000000000000000170777763777737357353757357777777777777777777777777777753422507241707716437757757775757777500000100000000000010000000000000000000001012400000000000021776000000000000000000000006707343575777777777777377777777777777777777777777777777767450615242506717653672771777377737010000000000010000000100000000000001000000001000000000000404070000000024000004000000016107777377357777777777777777777777777777777777777777777173070625042516705657757767167575770000000100010000000000000000000000000010000001010000000000000040100000176000377000770352525347777777777777777777777777777777777777777777777777656071425252435635270777777772777710010000000000000100000000011000000000000100000000000000000040252400007610004740007077602537737777777777777777777777777777777777777777307757775307406160043463527577757753577707000000000000000000000000000010000000000000010000001000000000025240000007000037000007761757777757777777777777777777777777777777777777774716773776502534165241756752707677767757770000000000000010000000000000010000000000000000010001001200061420000000000000000000003161207052777777777777777777777777777777777777377717617747777702436125260743657753777777257730102100001000000000000000000000000000000000000000001001000061400000000000000002506061657127052777777777777777777777777777777777775770777065707776561405601416165252765777577777100010000000000000000000000000000000000000000000010000102567060000000001773774352100001206107357777777777777777777777777777777177777073701752756177347360560605257653563477777070000100000000000000000000000001100000000000000001001010216100000000000606043437777777777535771677777777777777777777777777777777777775777720253617056704076161425241652577736577710100010000000000100000000000000000000000000000000000001636160000000000000000000424343437763071777777777777777777777777777177777777721747570257077717725036163425243652525777777700010001001000100000000000000000000000000000000000000101404000000000000000000000000000001757277777777577577577777777777777777735773577737051207430653524507041425241616525074743101000000000000000000000000000000000000000000000000010202020600000000000000000000000007477375777777773773737377777777777777775773576777752025070161347770240724340160652567371773300101001000000000000000000000000000000000000000010001040040000700000000000000000000077767777777577777777777377777777777737777777717161743507076146161657070524176050065256563673730000000010000100000000000000000000000000000000001002040075017700003740000020000077772507777773777773573757777777777735777737777007007342100170352573657070524016070024343571733733210100001000000000000000000000000000000000000001000077760077200007600000750000743756173777777773777357373777777735777777765307701635250610616070052725242525607043410706074773773610010000000000000000000000000000000000000100000777777700774000177000017600077774216775777777777737735357777777773777707534160060070521061001725250577752520140707060407434373333321000001001000000000000000000000000000000010137777770007700006770000777005777425621777773737777717373737777777743777777034177171030060125614165252552752576034043470702434277773732301000000000001000000000000000000000000000377777770017200017700003770027777001567377775773537351717537777777705053770436143434070104030612101612416070757434343434707056173773737321210000000000000000000000000000000101007777777430000000035700007761657777023057737736153434370703777777753027777072534341603436737410707061613611616252524340610707256173773737361000100100000000000000000001000000000177777777000000000000000075425367700456375773717273537073171777777361417777050616030141410041271527170040065255352534161460525024377377373337312000000000100000000000000010000103777776740000000002020340702576770612734736157777577577174341777770521257772171616577273430034020142534352101207614216167376167534217337377737631210001000000000000000000000100377777777700000000000140000252753470434717717235377363777373771777770525277576507177775001412535160342100052405205214704175070177777777773337333733733000001000000010010000100007777777576700720000002102141652752430525637777777535757375775277770702525777773777717120302050767050104777253721610610212527416777777773777737773772733312100100010000001000003777777777770057400000056000200256341402527535377353773735777377774030050177677177777772514101200103777777775705050161241470412707777573777373773337337373733250010000010000010177777777767700272000000374000175770002016752777557671775777375775377470276717177777773712037400142057740217737727060041020003040775773777357373377737737372373333431010001010037777777765776105750000007770006027740012452777353353771737177777377737775357777777777657571763002100212710612410535161061434343000737777577777777337333737377373733332303003037777777777777576002700000007740305057730003052557677771777477717377775777777777777777757373070104104000417651251243420107072534000437775737717377377737773737333373736373373377777777775777727770371000000777000026777400006357353777176717353775777777537777771737777377740170000630000377025724103416000057052573775737777777535733773337373776373733337377777777777777477577000000000003770002517772000534727771777717777777777773777777777775717777571270030010750304161407100617070012006100777737753535737773777377737373337333773737777777777777777777777000000000000300142437740002437577177777717357353717777777777777777777773751734000007614300037707010074010401000703717773777737435353717373737377337733777777777777777777777767765200000000300030303474340107437777777777775735777777777717777777777753567721737000000037430070707352037421000125075761777177717737271737373737337731437777577777777777777777757700000000000000404043076120001747777777777777777777777777777777777777777730507430001000753401000006004143100340003773777537712771717535277373717531343777777777777777777777777774100000000100003034307410002567377777777777777777777777777777777777777771752013410025037700000100104002016070000001771737753757172713617116352733077317777777777777777577774777772016000006000007000743600012074777777777777777777777777777777777777771612052412410735700772000000030100010170100070775717371736173753737353711653107057777777777777777775777777750275000016000007000347000074377777777777777777777777777777777777375377775210241277727777050000000000000000700000375363743563537152317071253731357317377777777777777777777777777061760000770000770024370000035677777777777777777777777777777777177777771421434120500143417007006005000000001600017527357377353716375613535352534331707777777777777737777777777776174300007700034740535770003473777777777777777777777777777777777773534163503430752142100025001010206000000000003073717717535341735133573617353531743177777577777776577777775777700374000077700077702476710043657777777777777777777777777777777777577672507701617742104371020060000100100000000000707352712737371736532535343172521343777777777777777777777777777740770000777000777012577600143777777777777777777777777777777771737761743700161614100630407050107050610020102500017716353753525361713533533172531717117777377777777777577777777774300000000700007770607775004256777777777777777777777777777737777770017171700000030601750300216100210061412517211473471735377173534352570347153170707677775767777777777777777657730000000000000017270537760021617777777777777777777777777777777771710024361614000001700250757576014070121612745763771372573433053713753177132352171311774377777577777777777577777430000000000000005027060000525677777377777777777777777777775771671600015300031200000010003002016030052410417320177774173437577070712352117153070352707777777177777577777777777777420000000000000205007030000435777777777777777777777777777737777161001020502404116100700700351701403001243524177777537073713137171751357216357171351377777757767577775277777777770105000000000000125614000161637377777777777777777777777775777712716000012100300600610601617206060340704100617777777253535256517343136131735121214325777357677776776777757757757616720000000500002070200000027477777777777777777777777777377717050705000400100101010071610404101100120120701777773771617037313725307717251123717335167777777775737771777737677777007700000027000014070000025017777777777777777777777777777737773010300001242520002000000030300607740165100777777777771617147707135301717367510714325377777737737757777677777777777475600000077000030770000024247777777777777777777777777757777340200030301010143414003416500010161034020773777777777771707331352717375215313671635101777717577777775777577577777703677000001770000047740000107377777777777777777777777777737534100100000020030201021343212177060002503177775777777535770731475251617031736161101016367777777657777277777777771777077340000077700000375200016074777777777777777777777777777777730000010001010001021000153534317173412147717777777777737771073031631617070517036373614177777777774775761777776775770054300000377600007777000250077777777777777777777777777775735701000001000001001003012153535637173577357777373777377777777071611613435272035014010337777717717777777777734777777770200000000777001007770001607077777777777777777777777777377773000100000010000000100017013531353572717737177775777771777717161631611201017037737775777777677777777537775773577777061000000000000020077700007007777777777777777777777777775773500000010010000010010001213343175727353773577757777377177777776173052163577777777777777777775347753777657777777776776100000000001070000024000700777777777777777777777777777773777000100000000010010001001715317031717757177173737375777777777712141253577373775737777277777777737675777776375777717716000000010020000030521430601477777777777777777777777777775373100000000010000000000121303535371713737177357575773735777777752173773777777737777775777777777577777577177776717777616000000200001210002402417423777777777777777777777777753777700000000100000000010000116152135073752577356737373775737777777777353777357377777573777777777776357276377777777777777017000010000024000052503402547777777777777777777777777777770100100100000000010001010311313437305317125373567175733477777777777771717735777777757777777777357777775777707757677706774000670001434005200342704377777577777777777777777777771734000000000000100000000035230533111735737737173537737577777777777777777737777777777777777777757707757777657777737577707770001775020777205274305216777737735377777777777777735777130000000000100000010000111531417251235017153537525737137777777777777777717777777777717777777777777771617777777577777052770027767403775600774704257577777777777777777777777773777000100001000000000000103030121301375137352370713737537577777777777777777777777777777777777777765727777777775367777770775216177703477761657770705237737777777777777777777777775301000010000000000000000013517171717013615357173757717343777777777777777777777777777777777773777537577777771777777777616563407777442577524377707027777771777777777777777777717373500000000000000100001001312303112317351361307153313717177777777777777777777777777777777777757777777777775777777717777012142147772106776106776524147777777777777777777777777774352101200000000000000000000111116116112351353533747717335377777777777777777777757777777717777777777777757777767777777756042142052142507706107770707071777777777777777777777777317016161100100000000000000016125213513515361353453313635707777777777777777777777777777777777777777777777777777777577777734304343252052052050617070607777777777777777777777777101521613016134301000000000001713531701212121116171335757171357777777777777777777777777777177777773577777777777775777777777400434344047025205261602434167777717637717777777777777702503507107010521210300000035371161735753534312134530317353777777777777777777777777777777675777777777777777777777777777770703434034307504361420410706177777777577771637777777777753503016107030505250103000071673535331361735717133517107103777777777777777777777777777777373757777777777777777777777777770600616034202704161430612506717677773777777577777777777777775210703503031216101717171163525677171723527507343712577777777777777777777777777773577777777757777777777777777777777401771616005614306025070416017777777777777777777777777777777777771410307041610777777777717171103525357353735371717777777777777777777737777753777757777777777777774777777777777776167760414777070615706003601677777777777777377777717777777777777777774101301777777777777777777771717015253437161777777777777777777775777777777577375773773777777777777777774777702570772430776061427741605261777735371777757777777777777777777777777777761777777777777777777777777777771717107127777777777777777771777777777777377737777777777777777777777777777742400412477775243477341615067777777537173777777777777777777777777777777777777777777777777777777777777777777717577777777777777777777717577777735677777577777777777777777777777777053761610077705243777600260135377703677777737777777777777777777777777777777777777777777777777777777777777777777753757777777777777777773777777773537777752577777777777777777777740276160607770425257740165016777577753177777577777777777777777777777777777777777777777777777777777777777777777777777777777777777777676777777777777757772777777777777777777777777705070501607721605277342032407703777777377773537777777777777777777777777777777777777777777777777777777777777777777777777777777777753535677277775773771753617777777777777777777777200020601400401240160104052777757777771437777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777773535757377777777075777777777777777777777774343430703430705216070612410777777777773777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777377777777707377777777777777777777777700040040240060420400000007067777000000000000000000000105000000000000d6ad05fe, NULL ), 
( N'Grains/Cereals', N'Breads, crackers, pasta, and cereal', 0x151c2f00020000000d000e0014002100ffffffff4269746d617020496d616765005061696e742e5069637475726500010500000200000007000000504272757368000000000000000000a0290000424d98290000000000005600000028000000ac00000078000000010004000000000000000000880b0000880b00000800000008000000ffffff0000ffff00ff00ff000000ff00ffff000000ff0000ff00000000000000777777740043734074373737370737777043707777777777777743777777777000534040673577777500740000400050040042500000777770004217073737373773777730040407073377307373725000043374053000003737373777377604074377777347737377047637777777777777547777777777400750250573177777505350700050000000040004000577770404033773737373773370400040407071214377373736100372000073777777777777377704404427437307377777734341777757777757477077577777771040075000777577777040614340000000040000000003777700007773737737737377040040000007061637373773536173040004003737737373737520404040453774777737373777777767777777777705777777777770004770477737777770051004100000000000000000047777700737373773773737200004004040407173737377373737340004000777777777777736440406404247073737777777737777577777777745761777777777750017770777537777750065000000014000000001040005777733737373773373771604004004000063773773737373730000004040737373737737700406040604007777773737737777777757777777770742777757757777777757777577777601734000000213000000040004167777763737373773773021400004004005373737373737373400404000007777777773753652444040404737373777777777767567777777753475757777377774077777077713777771561410504351750000000000000017771000437373772007003040000400737373737373377240040000040473737373776345340042440573777777377377777577777777777767527077357777717737775775777777770140040037077100000000000040477770703373772253733704304000071637737373737603104000404000777777773617370744044043777373777777777777775777777777577757477737777717777777737177777740000005753176001000000000000077710007373351273773334304037361603737773773506000400000407373373653773773734040772365777373777777777777777757777756770577577777705776177777577777005000127357710040000000000400077705011340361433071214015730001061733770003717000040000377777765343763770704077344032737777777777777777777777777775752777377771377704777737777773001057517375000000000000000007777001340004373737370033723710360273773173733733434004037373640436777377070773734537477777777777777777777777765777525257777777175754007775717777740070030777700000000000000050477775377310000073773207373376004005336036007256352000033507765060470737737707377772407073777777777777777777775775767775417577777737600017737117777101400573777000000005000000000007734170771371052371337373337010033404017373337253434372040430440475617707777737352507775277777777777777757777775775637777777777771404077777357777003537157700000000000000004340007734351005021050077373777373773700004007177373003737370060440440427603737373777777773465657777777777777777777777565547777777757770000077717777775007167375000000000000000000100577515335701507130036373333373340040400436334307773735300440040060471777777777377373746175767777777777777777777777716377357774277040417773777777710731717700000000000500000040000750072571173053711001067777324000000400435430773373723440444044040463737377377377743475677777777777777777777775375657757777714074000617753537777715731775000000000000000000140006734150163413041405031100337004040400400423077377737373040040044041777777377777737443475657757777777775777777567477777777777737434005747777777777777777701000000000000000000000017737350141741030017521110100000000400400437337373737374044444040773737377737377761674367767777777777777775656757777777777777400405521077371777777777771000000000500400000041043775775214170171413710052177111040400440053737737373737340040004376377777737777752574577575757777777777777777771777777777777753540436040777577777777777100502500000000000000104167527101507006121477105010713040000040007377373737373716444074407354241737737372777772567767777777777775777757565775777777777770714054050777357177777777010050050000001000004707573517040350514140717010711771310040040737337373737376300004016777365347737777573737777565777777777777777777767777777777777777777707016177377373535777770500160004014040000015707777071357300717152503537700103610000337024253737373014074407737374074327771636777777777777777777777777775777577777777777777775353757757657777753777777710143505000000000000420077505357314141361050341510153533000707700500273737043233016773777734004776167717777777777777777777777777777577757777777777777777777777735704777735777777052050000056100000000504573417215614170516135170077352700373373042125377352373577737773737737773534407777777777777777777777777777777777757777777777777777717777407707777737777701050000400014000000050030753751701016153050434037135310137377352104037304250732373777777737737772404406572777777777777777777777775777777777777577777777777777777045177777537777701000500050400073040070577053653507317053171714177534316373373734317304000303737773773737773772444061652775777777777777777777777777777777777777677777777777777775067577377777771070050014000077141017500773141250714705257371304712411017377733637724000404343717777777777377040407440657777777777777777777777777777757777777775777777777771777770572777777777771052500400007104040470077714105073531505346525035353104313523773370004040000340273733737377174042443470747777777777777777777777777777777757777777777777777777777770571771777777770014300007314000010140534107014143560734110505107173117703161137004000004040301777777777776377440641474377777777777777777777777777777777777775707777777777777777777765777777777710014005054000000404007717053430501141416350167125776143535377100000404000040773737737371616525341464077777777777777777777777777777777777777776577773777777777777704077735777777771401420000000000000771752140410716100715371711507010000705734340040000400033377777777563773736442537777777777777777777777777777777777775757717477777577777777777507105777777777700040500004004005271456105313410415351040507170100571050143410024000400017377737371736173777753544777577777777777777777777777777777577677657743477773777777777777057604353553777040170500000000005473116535441710430701313507173100071016110037100400403736337777760416773737763777777257777777777777777777777777777775777756543577777777777777777075070402741470004070400007504071457717731061770415061701161775014014017340336030000370034271730406635377761777377347777777777777777777777777777777777757777756777777777777777777743040057121741405000005500007700370571414141051734140534135301731421410037713005377003001760440440576527377777777777777777777777777777777777777777757777561635777775777777777704354100177717353400050520070577144007061735305301531073417770141040143000000347733330040020406044042437757777777777777777777777777777777777777777777777777775777777737777777777507377770377757771004377750525305335711507535377042561717101710350140053053100003777610040340444004040407377777777777777777777777777777777777777775777777575775657777777777777771777777777577737774005770061775254177721703405171010141712500404250143750414000100037361353044044424404777737777777777757777777777777777777777777777777777777777377777777777777777757171737353577700376107577771034351570514176053416077141301001104141000001004000737373204004400440563777773777777777777777777777777777777777777777777775657757777777177777777740257777577677377357414773777777514043052412511241710535035101070004100711250031003737204044420444243777377777777777777777777777777777777777777777777757777767757777777577777777055614016141014014707617571777777717107113414341530417101430417171300001071351410173714000400472405773767777777777777777777777777777777777777777777777777757577777777773577777770061616140164400071417773531743777777577414341041410716101410000471711400050031007373210400444041773743527377777777777777777777777777777777777777777777777777747577777777777777147141450706100165065675353435357077777701617134301570510700005710040043115004140002405200072407773774256577777777777777777777577777777777777777777777777577775777677777777777770434343070414147707173537753777717177777775353410467313050100053050010000401000015013303504041773777375616177777777777777777777777777777777777777777777777775777757777777777777750541404050404165047171653717777777753537777771711107507170521414070140100007100030077372007773777377737777774257777777777777777775737777777777777777777777777757757777777777777070043434252177165377531353717777777777571777777777173516530570101050101710417104103307353073777377737777776174767777777777577775777577777777777777777777777777777775753771771777057041405057416717171775353357777777777777174765777170253501071404340561013710000073733200777377737777372416477777777777773771777777777777777777777777777777777757777777775067774707143077257771777077137714777777777777777735173477535140407400101000104050000005343250177377737777377454657575777777777577773777177577777777777777777777777777775777475707575735707354145735371717357717371777777771734777777753507777311403140540505010000010002143027377737773777773652477676577777737777575777777777577777777777777777777777777577725707725675747777377775377717353715377737775775735775777777717174001571003100005610007710402007737737773777356165257747577777777757357773535777777777777777777777777777777777757577757575377571311177777761757357731177577173777771777777777777717161035040530001710510000053733737773777376737777756777777777757777777357777777177777777777777777777777777777777777777737753361037717171177335371107777737775357777777173777777717537571001041140040004000377373773777377717773777775777777777777577375371777777777773777777777777777777777777777777775771375113117717177175735737717777577777717777777571756571607573431405040000110000172137373777377436727777777777777777777737357775357357771777757777777777777777777777777777573737771133513137777177375734117371737717371717777777777717505170541401210171043500036373637377377700453577777777777777777777757777334357777777571771777757377775377777577377777357535177152103577777717537537701777571775777735777777777707352052070535050404173037100003737377430464367737777777777777777775737715153717717773777777777775777777577377777573571713117310311313735371773753771177777377537353077777777777775757715000143100130103724000073737700440404407777777777777777777737717734357777753571771753535371717777777537753777370171301711311017771717171717537357177537757775352577777771776717771571077300510733100700303720464040604745777777777777777777757771735353573753171773777735377777537177753751775373015311210313117777377777713517777177537371735352567777777717750773700571412513772300007340040404404524277777777777777777775377573537777357375357177771717535773757777353777531117131731533010717775717117752713777777757577137153177077777777104144353000751273373533700000040640460475777777777777777777777537357717535771521737573535353773775353577771753371713073503151137771731753771371477735375373717712714717577577777310000411410303737373360000004404140474377777777777777777777177757717537773173171717171716171757731073775377357130371753710370177775777375377173175777371757713717717052537177777771110061041737373360404000040466340477767777777777777777777717777737153577177175777713531071717771171775317357171171717711310777737175375317171371757573717717537777050547535777777710171103737375300004000140475253777577777777777777777771777753537777357717735371713171173753537771335757317173303711310117777777377175737177777737757770531773777770107677777525752570373737020000000406340527777777777777777777777777175777371753535371353537573017017315373753177573731713511535370311377777535717733531257353577773137373047377377771505043504005017737200105004000075257777777777777777777777777777173575716357771775353753153717171731353737173757171713033531110301777777777735753571377777753757535350004377377777777140105300373610373320000400527737737777777777477777777777757177773515353571371713773717113035775357173577353537171531437111177777777177737713175353537757337535314000377341273777361005343243043343734000037777777777777777577765777777777735717773617777375373757753535301537135317537317131717131353173031777777777717753716377777753735753530704044204377777377777735004004337333000373737737777777777476757577677777771773757771573717317571737373130121717531713753531053530107317513107777717771775353535377757373571373531000003537373737737773400000437432700137343777777777777777756767775777777775757377573577757137377575173511535313531253713413103113115313711377777771717737717375777375753775173530404043737373773773640040400003352177373377777737777777777757576777777777777357773537777357175173735013301317130313535713177117103710353217777777777717535717377777773775377171700017373737373373730040000404040012337373377777777777777777767757777777777775735353507517317777171373515311717115153530353533503111035211177777777773777731717777577777537534371007327373737377342504004040000037373736373737777777777777777757777777777775773577371731371775317177111321703130312135351313571313503531317777777777757377177777777371713717371521720500737373730301600400004003737373737377777777277777777777777777777777773577357535171701735777177771511353510116171310112131103111353135777777777377177717777777777757735173173700300373732161733400004007773737373373777773747477777777777777777777777773717353735301717317777177373771313135317171731717171313071301735377777777577377777777757777371735341373004003725240372733704002120063737373730777244345657777777777777777777777575775757134353715777777777177171617101137371121130131015353137777757777777775777777777777177535121737214001730000127337340003737003003737730003747434727777777777777777777777777737537371711135773777777717537171711312577133513713171331330757357377777777777777777777777753103571733733732040040613730034373500404373732013344346454750747777777777777777777777537575353716135356177753773535313035111352513711711350171117377377377377777777777777717153737171333773737040000000343430733736300003372000272434707256776777777777777777775777777537377717317125310177771535371715137305313153713712135330707537175775737373777777777737357577357773373700000000040000737773737030370040000336454745614757777777777777777767777777757535735711535317717073537011313411137171211351353531175353757737377757777777777777775737317333377370000404000000733733373733770004004037307257165677777777777777777777574777775373537571373130171711353751371371373571315353125313713537777373757737775753753777777773775773777307000400000400537377377377370004000000000745677725777775777777777777777777777777573537377177517170535353131071511053534331353535710172571357753717577373773777577577675033373337030710000000021237337337337000000404004007165747777777777777777777777777757777777777535777173135133531353571123713353135530353137313573767353777773777753577537437737070073777003733250040021373737737377316000000004000377727377777777777777777777777777777777775353537757171733513175271317151351357133535317111777171717775353777577777737773535753007340030733437300003724000323737300401600000000037747777777777777777757577777777777777777177777717737175351343531152531337135373171313535373707771771737777773717371717177737377733000030373730073771000007373702533121000040613737377777777777777777676777777777777777777737717517757125371353171353515113435353535353313571771770775653537577775777377171657173573400437233070373270000037342503363707000031343077777777777777776757575777777777777777775757737717777135357353171312312513133537173171703471771771637777777753737175377173377173773500005030373373303407340002527373000121720000777777777777777675676767577777777777777777777571717717107135352171715353710513113177161771347167171753537537375757377137757176170773700030737373737373300000043713250727372004007777777777777777567757576777777777777777771753773771731713535317073537131131251347537177175737717777377757777572735717771737717735357340373737373737304000040000605233737215000277777777777777777756776577777777777777777777777771717471753537531153513516113161337567177637571707175717736173757563707173535217537717170737373737376000400004000303773737321211777707777777777777756577777777777777777777537175775313531317777773533752137153175773574175737371717377777577577353575352527535737537763737373737373300000004000007733773737373607777777767777777777777777777777777777777777777777777531775777535313571317113317177577377537575670716177777352537777165753517172516153535717337377034014000400005733773373737300007777734347777777777777777777777777777777777577171753175713773771757173531735777777375734347371171617617575777757016133134361615217277173752737303703000400002733377337733734000777775674756777777777777777777777777777777777777773775303753757171377177171777717175775775174777071717763777534357715756717535125017137343737021633737300404310242337733470000007734241434757777777777777777777775777777777777777753777153757317775353353777777777777735734371771617717577773577357020115213434171257417353535001733730700037700004337733032420075676564743647777777777777777777477777777777777757775717717125777735353777757775752535767577576171771773717777147707152527571007055213735373730061673700373730000033610403713100241450470745357777777777777565747777777777777777775373771753537177173777753777773777776117717717707077175775707370535211357000505321756171617050033030377373600005340002372372006564773464767777777777777777767775675777777777777777753573717537177777575775777777534157434717757717167737737757173531525353410125570716135317304043437737373735320000405373310150473775341777777777777777775747675477777777777777777773573737577777577025677777577777353534357375777175775771616516503134353434121534357434315300073733737333734000400020342063773477434777777677777777777777757477777777777777777567777757777777777707571775777757525257357075776177737177141753713040535251000572515235315235173737773737770000000040004017333775773777777477777777777777770743777777777777777777756577775777577777753675777577737753525707777717753757734004005340017253505035251637512521163033733373733120004000004033337777437477773773717775777777777777777775777777777777777777657777577777757775777777357753747734100775701657370400005341153415343005071071410710507115063777373560000000040000377733773737777777777777670747777777777777727777777777777777757777777777777775771435777757775357534175377751774340000007342161617141000570161710712527031003373712134000000001373323737477773777777777741674777777777777777757777747777777777777777777577777777777777577377177735716107577377775100000014105141707107000000101071351117140377250073733000000360307373737777777777777761765453437577777777777777765777777777777777777777757777775777777775756717563475777657717534000004770506170716500100014303125306736037000007372730000173000003373773777777377777560563647467777377777777777536577777777777777777777777757777575777777735763753535717347777400100001536514175010140505211141507510517340040437373730033270000037207777737777773636561441641773777777777736464756577777777777777777777777777777777777775771757777770755353537500404167536170177710100005250003103712500040000043700037731300003000077777773777747573464344377777777777736753574356747777777777777777575677777777777775377077777577775277747743452525353516156150741410001000304341250040004040000737732736331200000737743777737737377504437563477777774757746065670777777777777775657677757775254777777717717357757535705371757341757765251617275100040000100517165000004000004373773373733120000007773743737707777703737776173437777777737357561477777777777777777775757675777734757777737757776376777775777357350717175071757524050100100052050100404000004006377377373372000000043770377604737377747737374467777370737777725477777777777777777775677675777757770757174757753575357717725257657756756177161613531214015000050040003304004003717337373377000000000743777704061677343737777737173706577777774773773775377777777777777565777777775777277731343777774735771757705770735717056140561405001700041000005373030403720727737377300200000000377700404043714377777373777744656277373737777774767777777777777777777777777777575757574315777173577775075773577571653535257170500534001100400337340003171000013773720031000000077707440442404277737377777340614045077747737777773577775777777777777777777777777777777535777777577765777373477537775256525507414341710406500016737370737234040273370177273040000700406160040405377777377377704607064343777777773777774725677777777777777777777777577536525735771077561775753567525775375707143705376501010400030400373737300007340060335370014137440604454040737737377737434740544144777377773777736161475757777777777777777773777777753416567167707176576757357577777525716141735710040400040403777373737737704004075737203633606160100600437673777773563434042424637377737777777456576706777777777777777777475777777777771714141414753571775737252777571657177525705040004000737337373773340000000020201737373604437340443700047373772537737404417477777773773617252414750777777777777767477767677777777777777777770777774165475757773477377470521400004000433737737737374004040404070737373730100737003737070027742563737717707737070737777477777756740777777777777777757475757077777777777777777574757777737773774161037373073773160000537527737373770034000040000073737373737347700737734043770406177734707373742563773743737371614377072777777777375253434257777777777777770707070737737773777352407740407073237000343600000377361073434004040717373737373737077737373737370000404361773777777356177044377777777777777757777777777777747475777777777777777474565654657777777737373700000007373703173373000037302527373300400030233737373737700000000000000000000000105000000000000e5ad05fe, NULL ), 
( N'Meat/Poultry', N'Prepared meats', 0x151c2f00020000000d000e0014002100ffffffff4269746d617020496d616765005061696e742e5069637475726500010500000200000007000000504272757368000000000000000000a0290000424d98290000000000005600000028000000ac00000078000000010004000000000000000000880b0000880b00000800000008000000ffffff0000ffff00ff00ff000000ff00ffff000000ff0000ff00000000000000733431247777777777777777777777777777777777777777777777777777777777777777777777772577777777777777777777777775677750043507777777717677777776343737737172736373635337373373727300002407477737777377377777777777777777777777777777777777777777777777777777777777777777777777777777777776767777677777775247757777776775761707373737237372737173717377373777363737733477777777777777777777777773777777777777777777777777777777777777777777777777377777777774777777377777777776777767677760104357777775673372737373737737373737373737337373337173732407777377777777777777777777777777777777777777777777777777777777777777777773777524000000000000004165777777777777777527750435677777773734737371737373173737373727372736334737337377777777777777737777773777777777777777777777777777777777777777777777777736140000000000000000000000000040507777777777777770041757777777733737273637376373736373737373713733737637777377777777777777777777777777777777777777777777777777777777777777777734000000000001404160746740040000000040657777777777775241677777377737373737373373727377373737353773737237377777777777777777777777777777777777777777777777777777777777777777735210000000044767773777577353777777652040000043777777777774161577777737725373735367373737317371737233373737737377777777777773777777777777377777377777777777777777777777777774371600000006177737534247043414747416171777737000004077777777770043777777773737373737337371737736372737776373733737777777777777777777377773777777777777777777777777777777777756370700000004577616506461407404740043406060407437760000005777777775241777777373737363737737373633737373733335273573737777777777777777777777777777737777777777777777777777777312777700000407773052507005040400000040040414052525041775340000537777775340777777773727373731737373773737373757337373637777777777777777737777777777777777777777777777777777753434777000000077757047040404004000400040004000404040406524177704000477777774177077777377353772773637373373737373237737373733777777777777777777757777777777777777777777777777437243772500000477725242404000400000000040000000000000400050412407772000057777777407477777737373337337363736537343737773373737377777737773777777777377777777777777777777777775373607346750000047750404140004000004000400000400004000000004040443400577700007777777001477777737277737737353733637373733377363734377777777777777777777777777777777777777777176372577747770000077725257040404004004000600606070745424040040000000400561617700004777777403777737737337337173737737373727771325373737737777777777377777777777777777777777763617253476347370000067745040400000000406574757577577577777577777704000000040040407770001777777754777777737537727372733737373733367373657477777777777777757777777777777777777535375361767356776000047710343400040042456535377777773752713637777757774000000004043430770004777777037777773773633737373773737337177735657727377777777777777777577777777777773537270365763565252710040775644040040042457373765725730577757757577577777777640004000040450776000777777414777777373773737373172527536725727373577777777777777773777777777777373436071675364743363770000077205340040006577707161775735476177343777373776773777740000004000434170400777777434777777373373737363733736717737776563477777777777777777777777770325253437767164733256577400047705404000004753520712577073527717707775252572537575775774000000040042573001777777057777777777373525737747773770771737373777777777777777777777352137563767743706733565777700007714742000407573672171657617161753770773537357357757777777776000004004050774000777777077777373716373737743737167077273434777777777777777777737716376562570752743712567776776000477600144000256171353435753707167370753073435257743727737777577400000004250376007777777007777773737477773776577737717773737777777777777777750730707077576772703725777747776700007705640000057177071253437617343572534771717077717353531653737777700000040040577005777777757777777773716577373727537772377733777777777377301273472777616312171774777567677770000770561040004347712165617561340177353473563435752717073431307171777400000004340370007777777077777777777673635365373673757773777777737163434767747374161631676765677667747776000077524004000534712161731347317037725347172153772710725343574716167177500000404004770007777777517777777773777777737737377337377377777727073777706347436373477777767675767776570007700534000004716774352164357075053534363717257713770125352131616107037600000000700770057777777657777777777577737377737377737375337164177474617716303434767675675675767577437000077564040400034353316171356371237773057170717717703073527074777777777757700000050601740077777777727775757477777737377377737737377727077607273630716777777577567767676747237760007702014000004770774317070757071407307277353653631717143577777777577777774000004041403700577777737575777777737577777377163763576374177670734307076657677676777676775370737461000570655600000061177130707165217121770775317075377143434377757317177775777770000000040477100777777777777777773753777737737771777735777601271616777777767477476767757363437073770007341600400004576174353160177707525371737613777316317177777357736134361677770000004161077007777777777777737170300777735673773737777670761677776776567777677776567347163477477000477041400000037716334343170537103525356535616357316167770537305070537171777770000000040077007777777777773507140500777773777777472731271777567475656776767727037352736752707630043707560400004547357435252077416343036373721775325217577072534373172534361757740000004340770047777777773052500100005777775617617357761677676777767777656350343761674775274731400074040000004056371753121735701735171715717177733535773713535215257053437173773700000404107700777777775705210434770007777773773777777777577476767777257316377341765770725321633041734304000000775772765343521763532070737677375343436570761253725217343107252577400000042407100777775210705070057750007777777777777777676767777652707306716407665361635325333700077054704000007525351734303525172553035253534737353577731743071717053167153173777500000141077005777775615250575257770007777777777777777477773435270724735673725326121633736173000734214000004756572737571613472573257125777273171257713430353521613707316361616176000040060530027777771614377725437741017777777777777767774347361437573467342530713373361337300067425400000401653715257303425357705302537717577617776161735252535241736534171737750000004106700577777777435477752577704777777777777777773337325277462567134312733727353373733400171443404000741745635217753524735737171637773713777717161435353431360512712073577700000004217300777777771603577743077700777777777777774346164775637572126127373633733273370733006721040000000747375735250717134731707031527565703757725363434361655372510717073077400004054075007777777775743477747077750777777777777337357736473402163713731733573537316333700017547040000051617436525377616571743717563577377775737170153537171325052070707147375000000001720077777777777051777705777005777777777776164625653343337373373273273233633737373004770605000004060471753752171770367125752317777537167771617637053436503735371737335700004007427100777777777777476577500777007777777777757735733252373731327337335337373523731734007701424000007147430743717071755707737357707777777771721613537073513752525252525777000000401437007777777777777053577614774047777777777625620707373361727336137337335333731723300037525004000007057717147677072705353434375735775775375717617073527703717173533521774000000400730077777777777777456777403770077777777775733737337353733731737327336336373723737300772434000000447675637717177153652757737073577777777737731743577170750707052503577000000402407500777777777777777251777147770177777777720703333613273363363733732533735233371730005705405000005357177170743416365351271577356377777771653565317217371273735271777704000000050532007777777777777775467776017740777777777737336173377317317331271373373333537323700067007244000004776574173577355734777172357375357775773763737635634375353435370777000000404002710477777777777777777147775077700777777773333337373337237337373363373072732717733700177141000004034717372532516375734352541257377773777777177535735735271617070777740000000025057000777777777777777776147774077704777777736177336374337336327337373273373373323173000716064040000473617577053617527757773375375307177777177737773734377173753777175000000000404330077777777777777777777077770577437777777337333713333631731733633137337317373737270043705500000004775776175301712557765357432525777777777737657257537707161677577770000004040033400777777777777777777774177770777077777777336363377373723733371372735732733631733320047406040000005723573077770353253177273573737177717777753735363753777771777303400000000050471007777777777777777777774077770777577777733713372336173732730373373323733613732737300017014204000025707170014774353043417753575777776777777777777577777777777774353000000040403700477777777777777777777775077743777777777363373173733371373737327373731733733733517000770605400000477716527021775707353771763736573535357777777777777757317777530740000040020070007777777777777777777777770577747777777373372336333536336132733533163363373363172270004350500004000571205710170120775735077170717253777771775777773707374775743070000000004507100477777777777777777777777770777773752536773177337363733737371633727337337343136175370005704244000000775207770052501030437177777777777567777777777757756177777352500000040400071007777777777777777777777777777777763777757336337137333713337333733737137123347436327570007705340040004375301772102161430525071717775363717777777777777777777352017400000002401700077777777777777777777777777734373577777777337723635363727127373731323612547323575716300053404044000004770707170014121043035377773537577777777577777777777775251700000000450070007777777777777777777777777370777577767727337133373337333733737300272561252361756363637400077007000000005771616570612525352527753777777777777177777777777771725364000004040007100677777777777777777777777534777776777353756723673353633773733030735073076777776777735773700437405604000004771610771701020353717677577777777577775777777777773537100004000404370007777777777777777777753736777777737257777773373372333730312163434261677353535737775777773400437005040040000771630777775753757617537475777757145735777777777777774000000400017000777777777777777777773775777777161757777767773353373733437256143737163534372737573777777777000570524140000045775771614361674217343563777777534735777777777777714000004040407710077777777777777716353653677753437776777767777372334330343704307234256352737353773757377377777000770416004000007777577777577535747773757377516043577757777577753400004000005370007777777777777777777777777772777777777777777773373336161720736714737357737537373777277777777777000572407404040007777775777777773731777374777753557577777777757741040000650427100077777777777777777777777473757777767776777767734334072525734716300077371737737353773735777777777400353416050000407777777775777777473475377753502537577777577777361040400407710047777777771657777777777777777777777777777775337336137252721630616737717673633437361773773777777777040770407060400057777777777757777753777575752757757777537717775004161400771004777735256161352535777777777767776777777353637474072725256163073733752773317173737737177377777777777000777054142400077777777777775717777777777175535777536575757534704142573100776150505001050041430375777777777777777257677777737253525236177173477771353737317131737377777777777777400177206414240047777777777777777757405147537777716553577777405256053700007150000000040041001414125377777777737177777777777725207337177372373773777353014307471657075373777777777424057516414340000577777777777777000065217575777616757177707074017770006500000000000010000100210525275777777777777572534333525737373337337377371301201637737373737725477577777777500077701654045042525743452540500400534577777775751777750474057770005010000000000100001050215050105177777777777763773737707333707377273773737525034373731737777771513707757777777740007774006524004000000000000000007507357577771777754707017370000100000000010000010100001000030712107577777777537377373737373736335370343533125373501434143113170755757657777777774004377500416504040434000000000043565737777742570525405775000040000000000000100000010140121411053503177777373773237373707373737336172777043731003471077756740010217717777777777777004137770416165240404040400400043575757775756164007773000141000000000000100010110010100501421052507177777773775737373737371725616252127530047741647077657777435005775757777777777400407773404054165210207040404247177777534004537771000460000000000000000000000001000010121143017107137737777373727373730636163735717753057777064704775357477706135777777777777777740000577771600404444540525041404757752407573752000447140000000010000000000101010011410416105710713577773737373737371671437170763653007004374014707764652574404431577777777777777777400001777773500000004040600000001757777740000477740000000100010012011000001001000121103530171053117777773737330631637436370343743704074774060565735656571606470757777777777777777774000041777777776716350747777777725000004477777400000000101010510010350101041034143501537171070737737773737671477073616177770340416007706560077440617764040435377777777777777777777440000004161753757775352507000000407777777700000010110121013013525201705103501210712507071171773773772731637212525777777075000610477040056775775776504746475777777777777777777777777404000000000000000000000404777777777770400101001201010701210111171013041035070351717127147777377173777077777777777770524041470775076005761474756765777677777777777777777777777777777765616442406146567477777777777777410010101010101010105112530172053171417155071717503177377737373212577777777777735004200420764054065767470757776577771777777777777777777777777777777777777577773577777777777777734010000101010000000000010035153101731713071352513543777737737377777777777777774360404041457704204074543474765677656577777777777777777777777777777777777473043547777777777777777410001010000000000000000001403016171071653161717752177737773637377777777777777735040004160077004702524246056565765656777777777777777777777777777777565173516170034173777777777771000100000000000000000000000105010001711317170735017737773737373777777777777777470040400070774000404004147677775777775777777777777777777777777777777777052710734537575777777777771014100000000000010001010000001061520343435353537017773777373777777777777777777354002404040770400474256157577777757347577777777777777777777777777777777150705010527771775777777775210100000010100001000001010001000140151435357153073773773723777777777777777777004040016016040040005057677757675775734717777777777777777777777775374347070034273417347777777777777530000000000010100010100201601014134303534307705374373173577777777777777777752400040640404004140524775775775777535553575777777777777777777777707535712016531750774737377577777777740001000101020014010011101125030411753411711077737567777777777777777777777712404040160404424240534175376175357563743525777777777757777777777000473417013400301717574577777777777775000300001010010014004004101413061071701077377777777777777777777777777777752400040525024141700434165757075347577577577777777777774777777770071403016701250077073737707575777777777700170500410010010101030521615171307777177757737773737777777777777777777300040000406502524141435716175717537573743757777777777777577777025420350011077006516174771777777777777777750010011041043016161052141034377777777767727777377777777777777777777777174246740440750050343570717521617757575757777775757577777777777503505000000734717217717577717777777777777777161000100105010105214377777577773777773777777563777777777777777777777014777777700050304101034161755705277777757777777777716377777777740300000401413714770737057735777777777777777777770716125252525777777777775777773777717373777777777777777777777777125777777570340102407537161617775417577777777777777757077777777104034000720407217714717365771757777777777777777777777737777777777717637737737757357777777777777777777777777763536535074752050014251716757173565777743757577777777777777535777756010010037053505771771657717677377777777777777737377377777777772536777777777757377777770777777777777777673717176777034347205007061125071307545773777775737777777777777777773777703400007041272125367165341773575777777777777737777777777773773777777377777377377777370777777777777775253747776776777735075703414104025347753731757357776577777775777777777757777410000171005714734177177743577767737777777777777777777777777777777377537367777677347777777777777673677657776773717074777714710034375373312301610307707577575777377777777777773773474040061730037716170773776177177577777777777777777777777737773775737777777673577777777777777777577577777253475677777767771067377337107351171310110713577777775777777777777757752100000173407750777077357717777737757777777777777777777777773777377777771735777777777777353673676772763617767767776776573425736530712730303601013031165375777777777777777777777605200716152570177716534777775177577777777777777777777377377577177777773777777777777777737777577777773757657777777776777571773533377731713101173011103125375777777777735777777777005721712073706136173525347767707737777777777777777777777773777777772577777777777375737777776777437477777677767677777776077373563167723010767753031101134377777777777777777777777701703417161177417761777177177077577577777777777737773773777777253777777777777775377775677777777777777677767777767717617725363353713111771110101410310135357777777757777777775770340147350167701673577707737777757737757777777737777775777677377777777777777277377777477177437776777767777777371716761771737135361774765213031713371431016777777757777777777777774034217236530777143761772577177377577777777777777777777735377777777777772737167767167337677777777767777767757677777343737037635330135771011101215073537353777777777777777777377377041605753053770757177752577757707777777777777777777737777777777777377375777777577737477776777777777707777677767675775277717325136127773012115301102114353777777777777777777777777353731257770177307771777073777777777777777777777377777777777777376377777677673725777777777777437777777777753717327537177735373517157741311210125311613077771777377777777537777735671477730077716571277717757777537777777777777777777777777773717357747777171765777677777777777776777770737363737577373637103016330371770121313530567101777567575777777773777377777167301677716377347571773437777757777777777777777777777377257677777773737777777777767777477777777773373437372733735253127353710534371353101017713533125777777677777777777777777777716771771617771737077577707777777777777777777777777774377777777677365777677777657377777777777353743733737173727773353530343773135161253531277030103527777777777777771777777777777717670777741677525723757771777777777777777777757353777777777717347776777777437371777777737257273737773737373577716303771717170121311727031731135312577777777777771777777777777777771771717377177773577377577777777777777777773727777775763527777777777777373707677777773477737373737336373737377331734770307353177163513177503031253777777777777177777777777777777777072777716177177057777777777777777777757377777777277177777777777732537347777727737777373737737637773727373343523131371307773477353703437313431477777777777125777777777777777777777570707777167777376177777777777777737377577777477377777777677637773657777735773477377777737373737373737367373561343071703477375301713101713167777777770125777777777777777777777777773752537171777177777777777775737777576777773757776777777735737577777347637777377737373567353737371737337373316131371173773537730353330350717776101577777777777777777777777773737775377776772577777777777753777747776777352777677777773437737677737776371777377773777773737373537373537735335731352536313572163531234117077771717777777777677777777777777777777777777716173757777777777773777777777737737777777767777377752777377761735777777733753737373736372736372733363730525373535273173173435137253677777777777753777777777777777767357777777767777577777777777753777767777767735677777777735377172757757725377777777773773773737373737373737373763731731125737331343152173727101057357777777753777737777777774377377737777737177777777777775637777777777737177777777777737736167777777361777777777773753773773727373737373737373373727352112521637336377353116167777777773637777777777377773777757777767527777777777777773737777777775370777767777671771707777777572343777777777775373777373253735373537353713735373736377250575350531710705617377377376177577777377776573577773777767737777777777777772777777776777377777777777777376377777773772357777777777777737773777377373727363727327363736373737337333016177161071737777776356177773737377775373776777776777717777777777777373771777777775377767776777775277717677773752177777777777777253637373377377373737373737737373737373737317373737074377777737252177377737777756717377777777774734377777777777777275271777747743767777777777776375347773770743777777777777716357375777377737377373737373733737373737073034725616527377434361617377733737773737373777777777373737777777777777773707377767767373777777777777712717277736577373777777777777713737737737377373777373737373737373737373737377773773773737773737373737773777737377777777777777777777777777777777773777777777777737777777777777373777777777773737777777777777373777777777777737000000000000000000000105000000000000a2ad05fe, NULL ), 
( N'Produce', N'Dried fruit and bean curd', 0x151c2f00020000000d000e0014002100ffffffff4269746d617020496d616765005061696e742e5069637475726500010500000200000007000000504272757368000000000000000000a0290000424d98290000000000005600000028000000ac00000078000000010004000000000000000000880b0000880b00000800000008000000ffffff0000ffff00ff00ff000000ff00ffff000000ff0000ff0000000000000033273373337373373373172177765677143477212657777776567776777777747077777777777777777777757777754757777777777777777777377777777777777777777777377777777777777777102136770007770000373373373233373373372173613777767773617717725777776777777677777777771777777777777757777777707746757777777777777777777777777777777777777777777777737777777777777752412576706033277337317373737237337373303763470777675672730737677777677767777777777777777777777777775777740447575677777777777777777777777377777777777777777777777777777777777777771252637616373333733733373333733737337373137377565777574777271756777767776777777777777777777777757777706070047565477777777777777777777777777777777777777777777777777777777777777777701043777337733732737317373373233737337375236377276777617677374347777777676777777777777777577777777405771065772577777777777777777777777737777777777777777777777777777777777777777777300333733732733737237373173733737363373535275752777775367377774777777777777777777777577777777404177774065746577777777777777777777777777777737777737777777777777777777777377777777770733773773373373733273373773733373373733123375656767574737377767777777777777777777775777406546746750074756577777777777777777777777777777777777777777777777777777777777777777777773732333337337333737337333233377377373737734373777776777477737357777777777777577577777560654257757750475656577777777777777777777777777777777777777777777777777377777777777777777773777373732733773337333773737337333372733737343707777777616577737777777777777777777760475604047770640465756567777777777777777777777777777777377777777777777777777737777777777777333337333733733373737633373737337376373773737373770776777777777777777777777777777770045253404047475240434756152767777777777777777777777777777777377777777777777777777777737777777373337273373372373333737337237327337373373737377377717777777777777777577757757774040404645256561764571656747671374767777777777777777777777777777777777777777777377777777777777737333737337137337237373733733737373733737373737737737777777777777777777757777771404250041435614044406774475475277635177777777777777777777777777777777777777777777777737777777377337273337337237337337337273773737337373737373733737737737777777777777777777777642404040040404044000447770477465635267252477777777777777777777777777777777777737777777777777777773737373737337337317337337333733737373736373737773737737777777777777777577777741450404241000000007440777770475747475257353701777777777777777777777777777777777777777777777777777773333373337337337336337337733773373373737373733377373773777777777777577777704067000014104000000740067775740474747765624721676577777777777777777777777777777777777737777777377777373737363733733633737373733373337367373737377377737777377737777775777777770474757645650000000444005776563704657452777752567312047777777777777777777777777777777777773777777777773373337373273733373337333727372737337373737737737737377777777777777777774052474775347050100557000477757447750076544347772524677300677777777777777777777777777777377777777777777737367737373333737377337373737373737373737733737737777377377777777777777006440424675747446577604077774607446774476564342477717077731257777777777777777777777777777777777777777777337333337373733733337237337373373737373733773773737377777777577577777404704250450476400247400407777405440045704056547707047677404673025677777777777777777777777777777777777377777737377737373273363737373733737373737337377377377777737377777777777400474040405246750045404040757040640045426504674763736342567773447312107677777777777777777777777777777777777733333333737373373373337337373373373736737737377373737777777777777740045404040464144244343440577644044040060456714074454775256347477256256313077777777777777777777777777777777777377725213737377377373737273727372737337733737377377773777575777770004061604040564044047440777740040000444040444654565275677365267347356346243066377777777777777777777777777777773333737721235337333373733333737373737733773737737737377377777774004240474104340404004750775674074004140000040407706565477767537124765674716527135677777777777777777777777777777725217470773733733777333777773737373733377377373773777777577774004414043414004770040047777465047504070400004074757744656565777652532126167653652463150767777777777777777777777777737773773470723730337773333373737373777737377773777377777773400004647751000004740000467774164074000500000007404777714742567677777656116347747677167273705777777777777777777777777470163573777561735323577773737373773373777373773777737777740434004041601000016400005777704157700414000000040477777604756565677777776617307247167734203630357777777777777777777773777743675273776727173333737373773777373737777377377777740000470004351140004440007760746576770400000000004077777775504654747676767477765325727756565743070727777777777777777777163572777437577717777637753637737373737777777377777777770004047416405040000400005774054056507440040000044424777657652447565257674767646777430347656376347632531677777777777777777743353437777252773537656371737777777773737377773777777000000507471401100000400776140424075600770040004000577575750657006565647765777776777777737274074771643673134777777777777772777737125277777476777377777737377373777777773777777777000404404743400004000477547465140005405640044000477764774250756506565677767776747677777701277160677743466330147777777777353473777737132537777177777777777737777377773777777777777000000040040004400057706704100000561404040000457760536047740640456474767764765677676767761216770043777114636334176777777737777373777777771777777777777777777777773777777777777771000040004050400047777444410400004044000000057671457654565340477047474356777767647677474777610036764647673652437213677773773337773777773777777777777777777752544644647777777777771000044004770004774340007410000400404250747775440675000044000477447437271667777765777676777773531212716471673707243177777377777773777777377777777776756040400000000000657677777776000004000400177454740001000001400404777777737400770000040404770567473475375677767777656777767470712616674747657343063337733773737377777737777775250000000000100500400040147777771000040000577407604044140000070000077777414440475010000000077774047747276167347767675675646767677251213434717274767377777777377777737777777765000040500725656572571414004004537770000044716565604500401000000404005777750640057105000000447775704776775616735636567767676777747677767343732667477356733776177777777777777775000400070775777777577677777525000405770000004774041406470700000070004064777740040247105000040777770400775677671663570747777676777747477774761617136346657777377373777777777775000002577775774757776575656757777741600570000004704040414040500000440005074477140044041100000077774400043737765675743632342771656766767665676767616137353676177777777777777771400007777656565777773577765475647577774140470000004042407404400000040004774405676564004100000007754000007377771777767765656353077674777767567777677776530343377377777777777777040007774747775777757056175357640757675777701040000004040447340050004004474040065750400471000004750400007777777777070756565361607603436747776677574767777677337777777777777777740000747774145770775311110535375744654567775765000000005040047740400404034074161440675040044040757440000577777777777776372765677761743613716777676776576767464777777777777777770000777744776452577525343010105071741650575777777450000040400440404000004465406560045640040000777400000067665677677777756753774360767253652716056776776756777776777777777777777000177543474453457757115115014100165665676565657777000000040040040000474047500040045000474004757400000054745064040604656777674377574707675247273734677777677777677777777777777100457756744045657775315773701211400157575757575777777500000044000007577404710400005240043777574340000747664646476474464042407777406373465436734342437147677656665677777777777774003776054656161657775771775351521014377777777777565777740000004405047473404400000044160447616504000044747475675656476566546404467770437327657474773432737167657767777777777777000577056404047577757735775571353510015777777777777775777710000000777407446100000000074400775404000056767656674664676474566474424064776035307276676567476163437277777777777777740017747475675774757777773430014116171077777777777777776757740000044750605014100000007040475040400047747474656477475656666747467464046475727307135256353617253617477777777777771004770747477577177777775351117113105105777775357757377575777700000004740560400000004754707504000005674767677777767767677574746746546400066435332523725665765670723030777777777700077775777177177177777775071010141107127777777717777777777757740000007704071000000414604740400004677777777776767777777767676774746656464047663733703071725661671747677777777774007774775777176175357777711075531305105577757175717577777777777700000045704461405040405714400000777776776776777776776777777776767656656474040561733373030721765467253677777777700177577777177535377777771035312150110127775737370753517775657577740000074400040060407740400000777777777777777777777777677676777777765665646044642737373372163127345765777777770047757771717717777577777701515715310300577777754153534775777777777000000470004004047754040000777777767777777777757777777777777767676776566564600470733337333312525272567777777500077675777735717573577771103031710514100775771731356571717775775777000000040040405777400000077777777777767676466656747477677777777777676566564640463737337173733321252777777777007775777535707773577177761511430713012102777775534317775635734775775400000470400777540000077777777777656404405416414707407460656777677776566565604460737033363737373303777577700077577753771717577356177530161151715351057535773515777711577475777770150000405777400000077777777776400441753777111373511701454206467776776506746400452337373333233337337777775004777777775075777375711573117111214311110777777150377717077775777577704770000044540000077777777764004167377777710535751305157335501044677776640656540663733337335373533777707770077757571735717575777771056111715315707017717157357753471757477167777700770000000000007777777764000535357737773131173315121717533757100406777746066400473372536333233633775077500777777775701772535777777157141215217500007777357777413575357477577577505770000000007777777774014171717375777771121753121525733513317711404776756164640407333337337333737770770007775777531771517573577777731315131530011075777777773777307777757757776007770000005777777760407773131617737737131113351151173153051713771004277674674404633737333733733377507700577777717057053756357777777141717077501000177577771715715757575677777750577770000777777764053577115171353777753010377101217351313131353177300467764067404373733163352337770077000775775771317161715777757757170717537011100177777775735777777777575777700777773477777777412537177312135357377331111311315353311511050117357710007777446044333277373337337700770047775777575017571777715353757175753501070100577775775725771777577777577705777747777777440513537371117131335377112117311130357131311317153737737004767065044373333373337377007700077477757353573577775121514377173750351010017777777777577475777777757775077777777777740713712575730311435137313111035301115331011011503717113535006776442407373737273733770077004777777775357757777531510135757775357507103777777777777353527577577777704777767777764171371535337111131303531713013131134337113135303171701711777000767640433372333332377700770007717575777777777773010034131777777773101157777777777757504153777775777705777577777517371113537737312531713433111015131111517111111153531131537377500774640673371737173377007710077777777777777777751711010415377757575177765743577777773534747777777775167777777744357371703111171711311111053131037121303131313012173111103577373700677440173373333373770077400777577775737777777131001011205777777777770171715347777741417175777757760577777774173735121153737331310121101316113753111151111011717310301773317577104767046373373637337710771004777777177575377750100100501577777777777417501534157775350747777777777157777777413535737113131101171113112111111353735103134353131311111173115353777106764413336333732777407770007757575377777777171010013101057777777701777701010015735250153757757774077777734171733713141053171035317313134135371773110113713535312103171301353777107762437337173733771077740017777775075357777171001075317137777577577775340311025775340757777777754777775431311753711313111131131357717131031737777131713773771111173111301353777006740437333333737770777300077577177177777711101005315014577777753777530111400537534110777775777417777743535371371731111210113101373311111173573731713743157131107111311535253777007643337373633377747775000777775715257777170101173503173777777377710153701300753515257775777711777770311317137373110301131315377315313035317353121071317337101311301113131757775076073732373373777377771000771537771177777170053510150157777775747105341141101773705357765777647777541735213530353311110110131117331111013737313513135311577717311312134173777770065233737373377775777770000777575756177777710153100050357357761710717101370065757165777777775177776171313533171353313131311073717121313103533512153535313777771211115135777777775265233333373377777777700004756377375757771753010010315375775110531717161517737357737775777507777705353531353131311317711171113731311111353713111213130777777771130537733535373700703507173373777777777700005304735171777147710105001435047137351741410117777575737575177752577770537313131211312135771103105371153112131331301137173535313131131013531151317577146742333216337777777777700004004577017743105310111011161077505301101014357777777577767777741777543717135171131311037771111301173313111101711112113173313110131117773171314317177106374247313277777777777500004000537417101005710001071540473525357100017761775777577577775177777013737133133111311717373011131153113131317313117373111111311010177113110715377537014377342061777777777777000004000753504110771011353561317751050012177757175777577657777507777701713533113110311173737111131013110771101777101735313130110131137713510351351737770673434356167777777777777000040004775311657170777410110477777535757775777107777755777764177777071713435311131013353537301011311053713377353537531110113013113571713135135277577700343473616377777777577777000005000617571777577751757751177777777777777057753576777775517777741313531316133171353133531311010101373735317337773111313153117077731105137135173777506363061617777777737277777400061000425655377777701777765777777777777757053577557775700777777525713153131531131352513531311010153735737317135371301113353317777735317175735777777417163563607777777777536773000057000441657577771777777104777777775774777770747777560577777770533171317133113113113170171031311253533135313135771135271315351753531737331737777770277352341677737757777771775000007500044753771417775750407777575777577553575777716153777777437117125313110312101353113017125135373717131351177313131101121131377373511153575777717737735373777733777777777737000000771004465753507770142407777371753573747177777450777777777477313111313531111171303111311130117371335311301257011131131111101577711312110313777003733333377757773437377777777140000577300042571153750054465775771770541177777040177777777750771713131713131301131153011311110335371313711311317131131011213533771301111311141777433777727333773373716777767777300000057535014304351005243543477474071777777404177777777777707113153101313101133413111301031017173134311311131313512131371353571311110130170113501373733737773477373737177775777740000007777535011000464444644450517577775040435777777777770771353317130113135311311301131101737317331130103535353335317135373331112533511113577127327373333373337273737253736777735000000477777735315141615353777777770404001777737777777770171315213135311135311211310101317317311113131317737335317135131775112113513737713174007134377377377737373737370735735773700000004057777737777777777777744040005777777777777777561335313517131313131311311131101775717371311111777717135313131577737113533511535777771216337257337233737373737333723527377770000000004056575757474440400000017377777777777777777057113153335353501773531031113177573313131310177731131131716173777713513101313073777007634605327737377373737373773773372537177700000000000000000000000000567777777777777777777770731705315113131357773113105311577371311210137773113103111177777531311311131115357770773561362533737337373737373373377373736371773521000000000000041074777777777737537777777777704711131336317111373535351331130375775311131737353713113121157777131131131112101777506167374356377337373733737373373373737373727777777770707134373777777777777777777773772577777707731141111113017777331011170117131177375777531313713113113017737171161135111101776072525276377337737373773732737373373737373733077777777737671777767777777777777777777777737775077713135313111357735171371131433531357777713105111135311301057713131113533530177717352527525237373373737337373637377737373737377307777777777776537373777777777777777777777773770477713111310131373713011013113353101771337711131213733131111377353537377751111771477777352161737337372733737333736333373373737337737077756777777777775375777777776777777777777730777353301531171171311317311317313111035110353111110177531301577737353531377777770777777777373373737373773737733737772773737377733737343773477377675777737777767777777777777777714757353131171121171711111301735353313131311353131131037371107777373313110177777477777777777737373737373372733733733373373737333773737370347374777776777773477777777677777777777433735317133131113131031311173573311111131111317131101353131377735311300115777750777777777777737373733737737373773377377337373773337737377333433073777777777737377777777776777677057131713511101017131110173373331731307113010731711311173537777131130111217775277777777777773737337373733733732337337337737373377733737337373737352352777777777777777767777777777037531310313110217131313177171731111137311111531311121177757733131537311777765777777777777773737337333773773773737377337337373337737377337373737377373437777777737777777777777775013535311110111371711177373371373107173531037171311110171317531031777711777077777777777777337336337773333373373737337736337376333737337373373373337373734356777777753777777677760713131131010351131373717171331113533713101177317131131311113113177531777707777777777777777337313723337777337373637733737737333773737727337337377737373773735775777777343777767710771717113135303513535313173533313177131137577717173531521301315737777771777777777777777736336363163712337737373733773733737373273733733637736333737373373737273677777773737777740773717353731713103131353113535371317713512577717173531111101337777777747777777777777777313777176163737337337373773373733737373737733773337337737373773737737353736777777771767760753507353531113107171117103531371317773713577313537135311105777777770777777777777777776363737777752527316737373373373763337373733773377337733737373373733373737171777767767173100753535373531711131313311113171131135353151253111107131131137777776577777777777777777777177476377377756733173737377373336737337377337333733377373727737277737373736161757777777400711535313121107135351130107313121777315305351030117353113577777717777777777777777777737737134347777373567133737337373733733737337737273377337373733737333737273737373637777677700773535353131317131253131117371111375311311371110017317101777774777777777777777777777476777773725277777376753437137373733772737733737373372737373737377737273737377373752735637740771311353111317131311101017331307737715341351310017131137777077777777777777777777737137373737737167737735273327237373733373733773737363373737373735333737337373337373373433477300777131313053535351353111735310117771701315331101617135777547777777777777777777777777770737373777373477777756537430373737373773377373737373737373733773373737377737377337373307500477711111301313131311333531311777173171537110101777777540357367777777777777777777373737677577777377347727737473774343537373377337373737373637373373357373737333737337733373733730077773535353711171310573711113777353112157110077777734376347377777777777777777770733437033237377373737527773767377727032353337737373737373737367373373737337733737333777373737370006773131111353011131713713011777353513773110177770457436343436177777777777777737677777747537377777773716161777773777757273733733737337373737337363373637323733737733317373737371214375313531311317565351311177177311357775377700063767757777716252773777777773437716577372761716373777737373436747737725252173373737737373737737373733373737363732373637327332737000435713111131537773121013777753535777777550475353617676777271634343434777777777737074771772737373737377773713707477777777072373533737373733737373737337733733377373337337373733730000757777577577575113577777777777776740247677761707375675674777616732617716577777370777777747743477373777773737343773777756172733737373773737373737333733773337373737337333737373700050577777777777577777777777777010747777677767765271671676347774770727737777777773434743737373725361737337773777074736377252521637373373737373737373733373733733733737373373373371240441675777777777777735614045676777676767776777763434354776076576577777777777777737377777777777373777773777737737777777777773733737373737373737373737373373373373337337337337337333161434565747475656561616377777677777767777677777677637257777677777700000000000000000000010500000000000092ad05fe, NULL ), 
( N'Seafood', N'Seaweed and fish', 0x151c2f00020000000d000e0014002100ffffffff4269746d617020496d616765005061696e742e5069637475726500010500000200000007000000504272757368000000000000000000a0290000424d98290000000000005600000028000000ac00000078000000010004000000000000000000880b0000880b00000800000008000000ffffff0000ffff00ff00ff000000ff00ffff000000ff0000ff0000000000000021312121001212103012101120511213001003031000000000001001201000031434130127125003036131617112161707121633525212434101612140103000000001000010000001000000000000010000000000000000100102120005212143012525002070011030101770000000000001001200070431030521125306171134303436170643125351431717043523421052136001002010020100200001020100010000000000000100000021310316114104031050307010303401035203003073000000000001002101000031071430161771407072535353717341752534363761634352153525252411700000002100000100000100000000000000010010003000100114211021201343030103430100312121010301710000000001020010001007007021316161302717353434371734367377371717173525257616137171360000100104002100007000000000000000010000200000100316211203104250103016101125061614121201437600000000000103003004101313534313177500717373535773534717535377777174071301216516165170070600030100000000100000000000000000001000000014211251007100212107012306121001303410301371000000000000001001006124252134343137437775373737777707737775375377370477777532735327124010100000001000002001001000000000000000001000211230303112041352101214130106121071211037500000000100010020102043513353437177703753737753537773477777377737537563010103471634716412520210121020001001000000000000100000000000001251014304204120016125013016001413001243772000000000012001012054303614353717371747377777377777347777777777777756357777777177171610252141060000000000000000000000000000000010210130303030311006171212130305210121341301317710000000000000120010025351734353777770777777777777777577777777750602004000000016124371675252161010410002010000000000000000001000000000014316100253000125050030301204120300341377000000000300100121034070361373753777377777777777777767672525004241447420704046004100400435353070212000400000300100000100000000002100003030310351204352121217050341420150350337770000000100010210103007171375357377777477777777777752705464464604766640446464644606460704024347125001000010030000000000000001000010003016100021021001214130103030120013021037577000000012010010121610657375737377777777777777774040644466567600406400040006000000476746424400212534120430000000000000000000000000003000310313521705241212016310161003503143533770000014010030216101341735737777777777777774740404647460406040042040004620040000000440240467504040025000000000001000000000000000030000000021001001200214316110701030402143031777700000212010010107161347737737777777777727000606676764000000047047640000444644640002040000466464040020041200012000000000000000000001010013523121311041310112530303042112035373770000001010201034312170773777777777777600444664404040070416000000750000000000000000046400560000046744004200001001000000000000100000002000001000525060120430612011610015217135377700000520001121011071737777777777774040476767400000206400640425675200000000000000064000046440000046767400101000000000000000000001201010043121312121124131031215201216025125371770000024012120161637353477777777770464676440000700004740400777777700000000000000000007747600674640000446740002000000000000000000001002000000520012121006030011211201007021317377700003070010121311717353777777524476777600067046404006730331777716101031000000000000047777704040000000044664014121000000001001000000100421312113041706011413705205312101350717373000104030120534371717347777444676460420000464006421171531537133131313133130100000000077700000006740000067400002000000000000000000030041000012241130001321300121130404034333717100000603016113137173775775647767400047400470000703417133113313713131135313133100000000160000000000000650467460010000400000000000010000020013041302112430520712161033007135353637000131430314343537371737674766765000420476000065713337113301311317337333737313110010000100000000000000640046540000002000100000020010001010241101306110431110353125013002537351710000161410331353535377747664004067607400404777521111113101353313337737373337333301011300110100000000000000006620100000000001000100200020001302305112003161212102533404353353737000137061371535373777764677000702444660000077760103131212133337311773737377717310313130130213011000000000000476400060100000000010010040010001300121216142125350713001025335371700003703173173737777767777640046740000470527777012112101317352710033773331773001331371011011101301113000000006774000000010000000201200121020305116125000351210330107124137173527000713547357377777777746464000006460000677777730113111203131311300013777373172101073131030121301313011200000004674004000000000001000000000100121301031250215214136103106117173531001733717377777777676400000075000000057777776101313311133737337310003777377317271373130113101310312111100000004460000002001000003004210000016121031304071211213012507017373617000371753777777777767670006746460000773737377300131373733773001717000003377733721037310131213131213013031300000006740000010000001200010003030301007061002121025341703300737171700017537277777777777767400074006777377170737735013137773373100000330000017177773103373013101303031311301110000060474000300000000301000200100001031131121417017110303114343537373016333771777777777664000066470171331333331737720013177773770000000730000002003773737330003121131313331303310000006764000000001000000041002010007060021520013012730707210073777771017533777777777675000000002533131737173737337100113377773773310100110000010001043735300101133133735371101210040047764000100000030001200100210131135132106107251013101777777777073713777177777747760066000173307371313331337373000311377773777770017200000001000331031000031313737731000131012774066400012000001000020120030000021012010612310123716173716577717171777717777777776006500077317133333373733737710013133777777777310031000000000131303130001313373750000000101304600474000000000000007010101001035131215300114313501210370712530777373737777777666440764617337333017371313730333700013113370737777301170100000013131373010001337377300000000310000000460100001001200000020021020012021210706030612353017710712531377777777777777400064001737131373213337331371733000013013510437377773332101007770131343000001777371710170000030040476520012000200041210010000101215141210013011215213710131253075777373717777760000000073733737371217133521333770000100313000347777307310207777100600010000131777373737310013104607764000000001000100061201200021213030300705321521435207701347777777777777766704760007333533733335313313337173300010010312000103773731031177310211111700000127773777777001210070067600010010000420210101000100141203150430120512121370070077131677377777774776007461033733733717333335317133337000000013113000053717731003375311303373700003113777377737101004670447400200000000101020000300303030142130433130717037001701700771177737777766000006043173733733737371303033525373000000013113131313331031177731311153777710003031000077733714000400642000000000012041012100000003152112103050031211770070070077007377777776400474404333733731733331331313132133331000000013131130311213037773131333377777771311021001373773000000076410100000005001020000210100142111250241307125377103107701700377737777740000060031753353373735337130303013353530000000011313311131131377313537377777101107003112121777300600027640000010000020303012100020002112341304170314313770077073037007737777766700067427533373377333337137131313352333531000000131311333123537373313137377777373713103011100070067600474600200000010100400000010100011250301202170307317300701700700137777777777400040442153773337371333131303052317121212100000001311131133137773313777373737737717133313100040047000674101000000202121030120020000341330701407035317770073070077007737377776400200000053333373737337173130313313312131030231201301213523173377111217377773737737733111210000645644046600200001004110102040010100400301010300313521737205701701701773777777460047400601317177373313713313371361371213002113173130331303353337733333137373337373723734331001000066427641001001200210602010121000020330703431140703171771031063077003757777767400246407643737337353733371711131331335213112030217313071301337777310103123777737337370330101001000400465603000000001201050020000200410010303072121717373702560500700173737777767004006046013537333313531333330731731213030317131212353303737337717313131113230717735350733100101000000764000300000001021210101210401213431103100431217177053017037007173777774676470000700533737373733373171731333131303530303031313210313333713731210130311010313133333130100310000064003010000000702500002000000034003070710613353737301300700700173777777767406464046653353735331317137333132712521313211313035311337373731217371000000000000000000103010005600054404300205210210010012000100243413103111210417353535007012071037373737777640006700004217313333737333537317313131303011730301231230133133131213773000100000000000000000420064046676030535301001021212010142041012200710217302412173730300710300435377777765600056400744737371713137313317335313031713231313331331337137131311337777003500000000000000007406400076434777777777773500016030100006015011211210143371217007013007053173737777767000600064072531333373713737337333733121311030310331217133313131337710001003000000000000560040670004677777737337373777353001002000413421217307034215071710700700700317353777774764000052006653535353373373333733531353312133135337131333313131353770000130101000000000466460000600247773733373737337336165102500601200121210117104333173001030042143717377777767000006650040033333371337373533733733313713103033112173131313121333000177773301100000016400077404444777373373333333333337326100010301430007032121214127171070030140313035377377764000000600005735373371737373733731717331373131123312133131313133771137777777721300024600004660067673737373373737373373333107202410421070117110710433512103035000007161737377777400000046460463533135333733733533733331731333733131313073121131373377777777733131110400004640004767777373373333333337337312301401203007012121071243341253070100702317173537777747600250000000771353733373373373373737173121731353533131310076037177777773421713131201240007000067777773737337373737333312330020160500707010713031041371343134310505303173537737766704640400066121273735337373317137333313131373333353031771771002777773770001313101000000046146777777373337333333333327206676160120121021071217070250361343130700305352173717777576000006700041111353337333735337317373735303353131331377777770017777070110313131311101000476777777737377337373733367764747476764106161403031013004335170307071021734317353773776640047606000131271237337373131733737313131313337121035777737701677700016131313131000300006777777773737333733333376767656476747416010030317073701631433031713125052131635373777774000064000003011313533737333731373137337333537313131777733777740100000013131313000310000677777777773737373737276767767767676765601243400013010301433143431617006316171735377357776604000067053073133353337353737373737313533313313137777771777700000000001313111310160647777777777777737333337770746776777777760341212103701711600523131613037105317034377177377756700000006000161053371733333337331337313133353130013733137770600000000000012301316777777777777777777777777575652105274777677740250400010301271073516161343500612527173537357477764600076400007117373333717373537377337335353130017373707310040000000000000311130676777777777777777777775252000040705010677764705203000711635004301235317171253171717353717737373560000640404771331371713335333335333533533313121231131313000470000000060004003447777777777777777777772524040406170707061057776124100041271037125371521612534247373717377737477777744000007600135371333737331737333733313113131001137171057200674056000400067746777777777777777777777440442400004070707165207474030000035005030425231713713716171753777777777777777747640040007131311713537333317331717333717121021121200064004604600000005666777777777777777777775652560404004124143507175707074000430037133516135353071253714373777777777777777777746700000717135331313137171735373331513331101000040006500670067404204467777777777777777777777765646046527424470743707070706021402005030150243534373535734637777777777777777777777746000024373313513173537333333135133371012121000675004646560042777466777777777777777777777764564654746440407065254525257750000010133512335061350353731735777777777777777777777777774404400071313313113313171717133171707000464064460067006000047667777777777777777777777774776565646142400041525273535253774020000150215307073371717777777777777777777777777777777776767600000113537353353313131171060000007604700000040047444677777777777777777777777777777777777746440604061615067617057734161202335721607171737373777777777767677776767676677767774465600007117353371313313132006504640000006000000007766767777777777777777777777777777777777777774740402525637141747257700014115303171617177177777777777647777767677774747766776777464047776025335313171317750076467000000000666040666477777777777777777777777777777777777777777777404041653450772535777701202721617125373737377777777677777777777767676767777677677777464674001731313137004600000046004000007777647777777777773777777777777777777777766676567777777774065257274357707770205013171735205371777777777777777767465445465446506447677676777774646476775210476400004762000676744664677777777777737373733737377777777777720456446474676777777075257174717157750020017121735373737377777477777746476766767466746652704667677677777747647465467674206476740447464767777777777777777737373773737777777777720456444747665474777746165705253676777701012735273707777777777777777476777775777676774765644470047767767777774776766746465447464764765777717777777777777373773737337377777777774046646676765646464777707560725771517770207001735353567373777777777476777777664765656465644767474000767767777774777777777767672574567773777777777777777777373373737737377777777004654656767665646444677563570573472777750106173703733537777777777767777747654765647656065644646476444247677777777777777777177576727137777737777777777777773773773730707777777740076647676767664746404477562537473557777030300353571743773777777767777774764264424244406424740656446765647767777777777777167707717536537773777777777777737377274340577777777774006656767676764746442460656156743143777752505213733373353777777777777746466404402465427650424074240474765007767777777777016750770773753567777777777777777777414121437777777777000765676776767674644644040771635356777772010321471747374777777777777764670404720744067406470004656560464767407767777777756777360777753763577777777777777777616034103077777777740056767776676746465464464640775774357777417070521373317377377777777767464400004446700467400656706606474240767647777777777007757177777761742577777777777777765010121410777777777024667766777676776666464440460734357777770203030527374737177777777774760000464420044474646744642474577065064777427677777770757767774752577173737777777777776121216030301777777747567776776766766674400000000047577777774010141430117373777777777777464404600002466067067476464747466646566540677647777777652775775737377617756777377777773010104101050167777771676776767676677675000000000000077777772000252020343737173717777777746400474606444044040046440046046147416740670477527777770077737737057017727737777777777750306030252120177777647656777777777767664000000000000777777410010000140143777173737777776564020640407600000000006056424066706465724470677477777752477747573077077177017773777776100101011010520777771657677777742460000000000000000007775610000010100212073717735777777746406440060440474241200046460404744470724477465676477777007077773777107716776777777777710342125203021013777567767775402050004014000000000000061430020100202001000173733777777776400044246404604665424000004656476467656452742564777777774747777771710637777517737377773020105010141101257760776776020605224707421604200000000042014100214010000057735753777777747400240040604707466456000004656647647677656740770774777737777777737731777136743777737341052120302124210777756777040414524570617461670700040000010020310010010000233773771777776046074740044424464467601000004656465640477600700646777777477777777777703776537771717776121010150510110703770777740016724724256425641474700007001250100612030030041753773777777754604464600606406470440464000000647467042763476525756777770777777773373377733743173733753403430212030201057547760017605434165070520742434760400000030701014007000303771373777377660472000614040646464706072000000046746174147616476677777777777777777777777775737353175200300101001410102736370056760562506506076474257425700470010000125210300070473775375777775474444044644004044046440640000000037777776747477077477777777777777777773777372517377737500010217030216105756561614163416470616052435607424760670030107100210061031373737377777764600064000607400060076745676100000337777777777477477777777777737777337777777773617137737214210001010012121770047607407430434075250461643560704740042007000430061605375371777377740046706064464006746406046004200004777777765406747767777777777777777773721377353737753744001070120010000167043650743470463434424427074346165647301010301012040301337377177777777460044446446060474404006774761000710677777767677767757777777777777777775014777737527377700000012503021014352525270343434341643430745616434706574000250002010071434371737357377774470604650654042464240046464047100671077777747567476777777777777777777733133573573577773700000000104102034607470564742434060743465261653461656771210303010061021037177173657377376465624644644644004600424065246301277077777676565777777777777777777777737773173773771777560000002112150135616526160743434343461605652470743477701000000010071034037353717377777746564406760674240647407000464777040577777777476167777777777777777777777377777657375377737140000000000212461616507074340656146165770470475256775242101012061025031173673477737377706400676404604404060244052677765330777777776774776777777777777777777737777771335737736770606100000301005356461647006165216705256043063424077721014200004016112143717173437777777446004440604006000444424645667777731777777774076577777777777777777777733777776521617716165752561614161764253461605745275641674252565147077777521210121007212052373477357735377737164002404656444646460464644567777731377777774676777777777777777777777777777737537703353063773777777777756470343420204025250614052066340477743050240103001413050173435253537737777470404740640065646444040606476777713737777677477777777777777777777777377773712501705252573771617617435607444652547525000605256056140077777161211303040703043037357525277773777777646466440006646000600464650477777347776774747777777777777777777777777777773070372525247075271771342570442700056200605670524203616047777706134124050030301303435253347137171737375744000024454040040400044666077777777746776777777777777777777777777717777773070503121437735370377070374240642005470725052535654007777770135216113200414160521525257077173777757367764560406600740766400004506460677777676747777777777777777777777777377777771032506161435370357071470314040404200404024242400025747776120417136141212030130523347307077353737375737576600040464644442464076406574477777654777737777777777777777777777777777325052317063536177217302171634000404002104000500776567774116153212512300417012012157071707134735735727573744406400042000047402440656647777777727777771734777777777777777777777737012341420707253521771657061010400004040612570674657656161601205071614043121705214307030613531731733563773777747604740000046440604644746777777457371777735777777777777777777777015250123505371361171210303112521000000040442467477525252121125303003300352501211211707616563434735734143353775347564600240400604004246746777776377771735737777777777777777777777210270503607071725275346160703071300100000640507472420105025001617141000212161205230611003113531612527375371737736165644740664074644756357737616717373530777777777777777777771705251030340713521735324215130141024070210420170703010052021103161212300615214305301616534707343071371617136173617056577734765416567173635371771653734717371747777777777777771021030343435025252170530501632070212140305021017021050041201104216113434071120121030431003001310317070140617535353737037353435373777073717135275347377137343527077777777777777761525350343025435316172573061053071250210121003021103030210142131030603100016170143413034703424250313136341230370317124437253734353771473716735337047357135307134217537777774777302120352171302525312533070163010010304250121001421701000710300070113143043012170303430001300711214242510061535035617102517352535271243170711635720735234363537004730737737137750714170353070434316173525306107071241000121412121121030400030171034207104216121034130143424070125031311206112303703124253734353073525216171277170142537537153616173071777343046321033034307170713735252534010303000134252102001016107002103143003031530201012507103052000714036130070525053614341716105252531617343704352125217356072530703617100717173773352010507143530703024343431712125630503030000212110307212100012502125341403014303611212143043070124112532132120003310321213407171613071717061353535343314173531713037060703273070316030302100713571435353431617001430341071050500610010510300410341301231343000501201252103004036434350152516142505251525070243061707034370070343070347025252160707502431705347171404341716170343242703421743524343070303024212121210712030012030305251425316070341705214340724110121030301210003121212103005317130713537007135307135310437135313531241352130312120030121213071735071353170312100301010101001210101030301000001010121303130000121030121030030434300000000000000000000010500000000000094ad05fe, NULL )
GO
INSERT dbo.Customers
  (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, LinkedIn, RegionCode, CityCode)
VALUES
( N'ALFKI', N'Alfreds Futterkiste', N'Maria Anders', N'Sales Representative', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany', N'030-0074321', N'030-0076545', NULL, NULL, NULL ), 
( N'ANATR', N'Ana Trujillo Emparedados y helados', N'Ana Trujillo', N'Owner', N'Avda. de la Constituci?n 2222', N'M?xico D.F.', NULL, N'05021', N'Mexico', N'(5) 555-4729', N'(5) 555-3745', NULL, NULL, NULL ), 
( N'ANTON', N'Antonio Moreno Taquer?a', N'Antonio Moreno', N'Owner', N'Mataderos  2312', N'M?xico D.F.', NULL, N'05023', N'Mexico', N'(5) 555-3932', NULL, NULL, NULL, NULL ), 
( N'AROUT', N'Around the Horn', N'Thomas Hardy', N'Sales Representative', N'120 Hanover Sq.', N'London', NULL, N'WA1 1DP', N'UK', N'(171) 555-7788', N'(171) 555-6750', NULL, NULL, NULL ), 
( N'BERGS', N'Berglunds snabbk?p', N'Christina Berglund', N'Order Administrator', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden', N'0921-12 34 65', N'0921-12 34 67', NULL, NULL, NULL ), 
( N'BLAUS', N'Blauer See Delikatessen', N'Hanna Moos', N'Sales Representative', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany', N'0621-08460', N'0621-08924', NULL, NULL, NULL ), 
( N'BLONP', N'Blondesddsl p?re et fils', N'Fr?d?rique Citeaux', N'Marketing Manager', N'24, place Kl?ber', N'Strasbourg', NULL, N'67000', N'France', N'88.60.15.31', N'88.60.15.32', NULL, NULL, NULL ), 
( N'BOLID', N'B?lido Comidas preparadas', N'Mart?n Sommer', N'Owner', N'C/ Araquil, 67', N'Madrid', NULL, N'28023', N'Spain', N'(91) 555 22 82', N'(91) 555 91 99', NULL, NULL, NULL ), 
( N'BONAP', N'Bon app''', N'Laurence Lebihan', N'Owner', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', N'91.24.45.40', N'91.24.45.41', NULL, NULL, NULL ), 
( N'BOTTM', N'Bottom-Dollar Markets', N'Elizabeth Lincoln', N'Accounting Manager', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', N'(604) 555-4729', N'(604) 555-3745', NULL, NULL, NULL ), 
( N'BSBEV', N'B''s Beverages', N'Victoria Ashworth', N'Sales Representative', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK', N'(171) 555-1212', NULL, NULL, NULL, NULL ), 
( N'CACTU', N'Cactus Comidas para llevar', N'Patricio Simpson', N'Sales Agent', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina', N'(1) 135-5555', N'(1) 135-4892', NULL, NULL, NULL ), 
( N'CENTC', N'Centro comercial Moctezuma', N'Francisco Chang', N'Marketing Manager', N'Sierras de Granada 9993', N'M?xico D.F.', NULL, N'05022', N'Mexico', N'(5) 555-3392', N'(5) 555-7293', NULL, NULL, NULL ), 
( N'CHOPS', N'Chop-suey Chinese', N'Yang Wang', N'Owner', N'Hauptstr. 29', N'Bern', NULL, N'3012', N'Switzerland', N'0452-076545', NULL, NULL, NULL, NULL ), 
( N'COMMI', N'Com?rcio Mineiro', N'Pedro Afonso', N'Sales Associate', N'Av. dos Lus?adas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil', N'(11) 555-7647', NULL, NULL, NULL, NULL ), 
( N'CONSH', N'Consolidated Holdings', N'Elizabeth Brown', N'Sales Representative', N'Berkeley Gardens 12  Brewery', N'London', NULL, N'WX1 6LT', N'UK', N'(171) 555-2282', N'(171) 555-9199', NULL, NULL, NULL ), 
( N'DRACD', N'Drachenblut Delikatessen', N'Sven Ottlieb', N'Order Administrator', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany', N'0241-039123', N'0241-059428', NULL, NULL, NULL ), 
( N'DUMON', N'Du monde entier', N'Janine Labrune', N'Owner', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'France', N'40.67.88.88', N'40.67.89.89', NULL, NULL, NULL ), 
( N'EASTC', N'Eastern Connection', N'Ann Devon', N'Sales Agent', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK', N'(171) 555-0297', N'(171) 555-3373', NULL, NULL, NULL ), 
( N'ERNSH', N'Ernst Handel', N'Roland Mendel', N'Sales Manager', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', N'7675-3425', N'7675-3426', NULL, NULL, NULL ), 
( N'FAMIA', N'Familia Arquibaldo', N'Aria Cruz', N'Marketing Assistant', N'Rua Or?s, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil', N'(11) 555-9857', NULL, NULL, NULL, NULL ), 
( N'FISSA', N'FISSA Fabrica Inter. Salchichas S.A.', N'Diego Roel', N'Accounting Manager', N'C/ Moralzarzal, 86', N'Madrid', NULL, N'28034', N'Spain', N'(91) 555 94 44', N'(91) 555 55 93', NULL, NULL, NULL ), 
( N'FOLIG', N'Folies gourmandes', N'Martine Ranc?', N'Assistant Sales Agent', N'184, chauss?e de Tournai', N'Lille', NULL, N'59000', N'France', N'20.16.10.16', N'20.16.10.17', NULL, NULL, NULL ), 
( N'FOLKO', N'Folk och f? HB', N'Maria Larsson', N'Owner', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden', N'0695-34 67 21', NULL, NULL, NULL, NULL ), 
( N'FRANK', N'Frankenversand', N'Peter Franken', N'Marketing Manager', N'Berliner Platz 43', N'M?nchen', NULL, N'80805', N'Germany', N'089-0877310', N'089-0877451', NULL, NULL, NULL ), 
( N'FRANR', N'France restauration', N'Carine Schmitt', N'Marketing Manager', N'54, rue Royale', N'Nantes', NULL, N'44000', N'France', N'40.32.21.21', N'40.32.21.20', NULL, NULL, NULL ), 
( N'FRANS', N'Franchi S.p.A.', N'Paolo Accorti', N'Sales Representative', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy', N'011-4988260', N'011-4988261', NULL, NULL, NULL ), 
( N'FURIB', N'Furia Bacalhau e Frutos do Mar', N'Lino Rodriguez', N'Sales Manager', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', N'(1) 354-2534', N'(1) 354-2535', NULL, NULL, NULL ), 
( N'GALED', N'Galer?a del gastr?nomo', N'Eduardo Saavedra', N'Marketing Manager', N'Rambla de Catalu?a, 23', N'Barcelona', NULL, N'08022', N'Spain', N'(93) 203 4560', N'(93) 203 4561', NULL, NULL, NULL ), 
( N'GODOS', N'Godos Cocina T?pica', N'Jos? Pedro Freyre', N'Sales Manager', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain', N'(95) 555 82 82', NULL, NULL, NULL, NULL ), 
( N'GOURL', N'Gourmet Lanchonetes', N'Andr? Fonseca', N'Sales Associate', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil', N'(11) 555-9482', NULL, NULL, NULL, NULL ), 
( N'GREAL', N'Great Lakes Food Market', N'Howard Snyder', N'Marketing Manager', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA', N'(503) 555-7555', NULL, NULL, NULL, NULL ), 
( N'GROSR', N'GROSELLA-Restaurante', N'Manuel Pereira', N'Owner', N'5? Ave. Los Palos Grandes', N'Caracas', N'DF', N'1081', N'Venezuela', N'(2) 283-2951', N'(2) 283-3397', NULL, NULL, NULL ), 
( N'HANAR', N'Hanari Carnes', N'Mario Pontes', N'Accounting Manager', N'Rua do Pa?o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil', N'(21) 555-0091', N'(21) 555-8765', NULL, NULL, NULL ), 
( N'HILAA', N'HILARION-Abastos', N'Carlos Hern?ndez', N'Sales Representative', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela', N'(5) 555-1340', N'(5) 555-1948', NULL, NULL, NULL ), 
( N'HUNGC', N'Hungry Coyote Import Store', N'Yoshi Latimer', N'Sales Representative', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA', N'(503) 555-6874', N'(503) 555-2376', NULL, NULL, NULL ), 
( N'HUNGO', N'Hungry Owl All-Night Grocers', N'Patricia McKenna', N'Sales Associate', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', N'2967 542', N'2967 3333', NULL, NULL, NULL ), 
( N'ISLAT', N'Island Trading', N'Helen Bennett', N'Marketing Manager', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK', N'(198) 555-8888', NULL, NULL, NULL, NULL ), 
( N'KOENE', N'K?niglich Essen', N'Philip Cramer', N'Sales Associate', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany', N'0555-09876', NULL, NULL, NULL, NULL ), 
( N'LACOR', N'La corne d''abondance', N'Daniel Tonini', N'Sales Representative', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'France', N'30.59.84.10', N'30.59.85.11', NULL, NULL, NULL ), 
( N'LAMAI', N'La maison d''Asie', N'Annette Roulet', N'Sales Manager', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France', N'61.77.61.10', N'61.77.61.11', NULL, NULL, NULL ), 
( N'LAUGB', N'Laughing Bacchus Wine Cellars', N'Yoshi Tannamuri', N'Marketing Assistant', N'1900 Oak St.', N'Vancouver', N'BC', N'V3F 2K1', N'Canada', N'(604) 555-3392', N'(604) 555-7293', NULL, NULL, NULL ), 
( N'LAZYK', N'Lazy K Kountry Store', N'John Steel', N'Marketing Manager', N'12 Orchestra Terrace', N'Walla Walla', N'WA', N'99362', N'USA', N'(509) 555-7969', N'(509) 555-6221', NULL, NULL, NULL ), 
( N'LEHMS', N'Lehmanns Marktstand', N'Renate Messner', N'Sales Representative', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany', N'069-0245984', N'069-0245874', NULL, NULL, NULL ), 
( N'LETSS', N'Let''s Stop N Shop', N'Jaime Yorres', N'Owner', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA', N'(415) 555-5938', NULL, NULL, NULL, NULL ), 
( N'LILAS', N'LILA-Supermercado', N'Carlos Gonz?lez', N'Accounting Manager', N'Carrera 52 con Ave. Bol?var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', N'(9) 331-6954', N'(9) 331-7256', NULL, NULL, NULL ), 
( N'LINOD', N'LINO-Delicateses', N'Felipe Izquierdo', N'Owner', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', N'(8) 34-56-12', N'(8) 34-93-93', NULL, NULL, NULL ), 
( N'LONEP', N'Lonesome Pine Restaurant', N'Fran Wilson', N'Sales Manager', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA', N'(503) 555-9573', N'(503) 555-9646', NULL, NULL, NULL ), 
( N'MAGAA', N'Magazzini Alimentari Riuniti', N'Giovanni Rovelli', N'Marketing Manager', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy', N'035-640230', N'035-640231', NULL, NULL, NULL ), 
( N'MAISD', N'Maison Dewey', N'Catherine Dewey', N'Sales Agent', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium', N'(02) 201 24 67', N'(02) 201 24 68', NULL, NULL, NULL ), 
( N'MEREP', N'M?re Paillarde', N'Jean Fresni?re', N'Marketing Assistant', N'43 rue St. Laurent', N'Montr?al', N'Qu?bec', N'H1J 1C3', N'Canada', N'(514) 555-8054', N'(514) 555-8055', NULL, NULL, NULL ), 
( N'MORGK', N'Morgenstern Gesundkost', N'Alexander Feuer', N'Marketing Assistant', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Germany', N'0342-023176', NULL, NULL, NULL, NULL ), 
( N'NORTS', N'North/South', N'Simon Crowther', N'Sales Associate', N'South House 300 Queensbridge', N'London', NULL, N'SW7 1RZ', N'UK', N'(171) 555-7733', N'(171) 555-2530', NULL, NULL, NULL ), 
( N'OCEAN', N'Oc?ano Atl?ntico Ltda.', N'Yvonne Moncada', N'Sales Agent', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina', N'(1) 135-5333', N'(1) 135-5535', NULL, NULL, NULL ), 
( N'OLDWO', N'Old World Delicatessen', N'Rene Phillips', N'Sales Representative', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA', N'(907) 555-7584', N'(907) 555-2880', NULL, NULL, NULL ), 
( N'OTTIK', N'Ottilies K?seladen', N'Henriette Pfalzheim', N'Owner', N'Mehrheimerstr. 369', N'K?ln', NULL, N'50739', N'Germany', N'0221-0644327', N'0221-0765721', NULL, NULL, NULL ), 
( N'PARIS', N'Paris sp?cialit?s', N'Marie Bertrand', N'Owner', N'265, boulevard Charonne', N'Paris', NULL, N'75012', N'France', N'(1) 42.34.22.66', N'(1) 42.34.22.77', NULL, NULL, NULL ), 
( N'PERIC', N'Pericles Comidas cl?sicas', N'Guillermo Fern?ndez', N'Sales Representative', N'Calle Dr. Jorge Cash 321', N'M?xico D.F.', NULL, N'05033', N'Mexico', N'(5) 552-3745', N'(5) 545-3745', NULL, NULL, NULL ), 
( N'PICCO', N'Piccolo und mehr', N'Georg Pipps', N'Sales Manager', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', N'6562-9722', N'6562-9723', NULL, NULL, NULL ), 
( N'PRINI', N'Princesa Isabel Vinhos', N'Isabel de Castro', N'Sales Representative', N'Estrada da sa?de n. 58', N'Lisboa', NULL, N'1756', N'Portugal', N'(1) 356-5634', NULL, NULL, NULL, NULL ), 
( N'QUEDE', N'Que Del?cia', N'Bernardo Batista', N'Accounting Manager', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil', N'(21) 555-4252', N'(21) 555-4545', NULL, NULL, NULL ), 
( N'QUEEN', N'Queen Cozinha', N'L?cia Carvalho', N'Marketing Assistant', N'Alameda dos Can?rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil', N'(11) 555-1189', NULL, NULL, NULL, NULL ), 
( N'QUICK', N'QUICK-Stop', N'Horst Kloss', N'Accounting Manager', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany', N'0372-035188', NULL, NULL, NULL, NULL ), 
( N'RANCH', N'Rancho grande', N'Sergio Guti?rrez', N'Sales Representative', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina', N'(1) 123-5555', N'(1) 123-5556', NULL, NULL, NULL ), 
( N'RATTC', N'Rattlesnake Canyon Grocery', N'Paula Wilson', N'Assistant Sales Representative', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', N'(505) 555-5939', N'(505) 555-3620', NULL, NULL, NULL ), 
( N'REGGC', N'Reggiani Caseifici', N'Maurizio Moroni', N'Sales Associate', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy', N'0522-556721', N'0522-556722', NULL, NULL, NULL ), 
( N'RICAR', N'Ricardo Adocicados', N'Janete Limeira', N'Assistant Sales Agent', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil', N'(21) 555-3412', NULL, NULL, NULL, NULL ), 
( N'RICSU', N'Richter Supermarkt', N'Michael Holz', N'Sales Manager', N'Grenzacherweg 237', N'Gen?ve', NULL, N'1203', N'Switzerland', N'0897-034214', NULL, NULL, NULL, NULL ), 
( N'ROMEY', N'Romero y tomillo', N'Alejandra Camino', N'Accounting Manager', N'Gran V?a, 1', N'Madrid', NULL, N'28001', N'Spain', N'(91) 745 6200', N'(91) 745 6210', NULL, NULL, NULL ), 
( N'SANTG', N'Sant? Gourmet', N'Jonas Bergulfsen', N'Owner', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway', N'07-98 92 35', N'07-98 92 47', NULL, NULL, NULL ), 
( N'SAVEA', N'Save-a-lot Markets', N'Jose Pavarotti', N'Sales Representative', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', N'(208) 555-8097', NULL, NULL, NULL, NULL ), 
( N'SEVES', N'Seven Seas Imports', N'Hari Kumar', N'Sales Manager', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK', N'(171) 555-1717', N'(171) 555-5646', NULL, NULL, NULL ), 
( N'SIMOB', N'Simons bistro', N'Jytte Petersen', N'Owner', N'Vinb?ltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark', N'31 12 34 56', N'31 13 35 57', NULL, NULL, NULL ), 
( N'SPECD', N'Sp?cialit?s du monde', N'Dominique Perrier', N'Marketing Manager', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'France', N'(1) 47.55.60.10', N'(1) 47.55.60.20', NULL, NULL, NULL ), 
( N'SPLIR', N'Split Rail Beer & Ale', N'Art Braunschweiger', N'Sales Manager', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA', N'(307) 555-4680', N'(307) 555-6525', NULL, NULL, NULL ), 
( N'SUPRD', N'Supr?mes d?lices', N'Pascale Cartrain', N'Accounting Manager', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium', N'(071) 23 67 22 20', N'(071) 23 67 22 21', NULL, NULL, NULL ), 
( N'THEBI', N'The Big Cheese', N'Liz Nixon', N'Marketing Manager', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA', N'(503) 555-3612', NULL, NULL, NULL, NULL ), 
( N'THECR', N'The Cracker Box', N'Liu Wong', N'Marketing Assistant', N'55 Grizzly Peak Rd.', N'Butte', N'MT', N'59801', N'USA', N'(406) 555-5834', N'(406) 555-8083', NULL, NULL, NULL ), 
( N'TOMSP', N'Toms Spezialit?ten', N'Karin Josephs', N'Marketing Manager', N'Luisenstr. 48', N'M?nster', NULL, N'44087', N'Germany', N'0251-031259', N'0251-035695', NULL, NULL, NULL ), 
( N'TORTU', N'Tortuga Restaurante', N'Miguel Angel Paolino', N'Owner', N'Avda. Azteca 123', N'M?xico D.F.', NULL, N'05033', N'Mexico', N'(5) 555-2933', NULL, NULL, NULL, NULL ), 
( N'TRADH', N'Tradi??o Hipermercados', N'Anabela Domingues', N'Sales Representative', N'Av. In?s de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil', N'(11) 555-2167', N'(11) 555-2168', NULL, NULL, NULL ), 
( N'TRAIH', N'Trail''s Head Gourmet Provisioners', N'Helvetius Nagy', N'Sales Associate', N'722 DaVinci Blvd.', N'Kirkland', N'WA', N'98034', N'USA', N'(206) 555-8257', N'(206) 555-2174', NULL, NULL, NULL ), 
( N'VAFFE', N'Vaffeljernet', N'Palle Ibsen', N'Sales Manager', N'Smagsloget 45', N'?rhus', NULL, N'8200', N'Denmark', N'86 21 32 43', N'86 22 33 44', NULL, NULL, NULL ), 
( N'VICTE', N'Victuailles en stock', N'Mary Saveley', N'Sales Agent', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France', N'78.32.54.86', N'78.32.54.87', NULL, NULL, NULL ), 
( N'VINET', N'Vins et alcools Chevalier', N'Paul Henriot', N'Accounting Manager', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'France', N'26.47.15.10', N'26.47.15.11', NULL, NULL, NULL ), 
( N'WANDK', N'Die Wandernde Kuh', N'Rita M?ller', N'Sales Representative', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany', N'0711-020361', N'0711-035428', NULL, NULL, NULL ), 
( N'WARTH', N'Wartian Herkku', N'Pirkko Koskitalo', N'Accounting Manager', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland', N'981-443655', N'981-443655', NULL, NULL, NULL ), 
( N'WELLI', N'Wellington Importadora', N'Paula Parente', N'Sales Manager', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil', N'(14) 555-8122', NULL, NULL, NULL, NULL ), 
( N'WHITC', N'White Clover Markets', N'Karl Jablonski', N'Owner', N'305 - 14th Ave. S. Suite 3B', N'Seattle', N'WA', N'98128', N'USA', N'(206) 555-4112', N'(206) 555-4115', NULL, NULL, NULL ), 
( N'WILMK', N'Wilman Kala', N'Matti Karttunen', N'Owner/Marketing Assistant', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland', N'90-224 8858', N'90-224 8858', NULL, NULL, NULL ), 
( N'WOLZA', N'Wolski  Zajazd', N'Zbyszek Piestrzeniewicz', N'Owner', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland', N'(26) 642-7012', N'(26) 642-7012', NULL, NULL, NULL )
GO
DBCC TRACEON(460)
GO
INSERT dbo.Employees
  (LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, [Address], City, Region, PostalCode, Country, HomePhone, Extension, Photo, Notes, ReportsTo, PhotoPath, EmailAddress, TaxID)
VALUES
( N'Davolio', N'Nancy', N'Sales Representative', N'Ms.', N'1948-12-08T00:00:00', N'1992-05-01T00:00:00', N'507 - 20th Ave. E. Apt. 2A', N'Seattle', N'WA', N'98122', N'USA', N'(206) 555-9857', N'5467', 0x151c2f00020000000d000e0014002100ffffffff4269746d617020496d616765005061696e742e506963747572650001050000020000000700000050427275736800000000000000000020540000424d20540000000000007600000028000000c0000000df0000000100040000000000a0530000ce0e0000d80e0000000000000000000000000000000080000080000000808000800000008000800080800000c0c0c000808080000000ff0000ff000000ffff00ff000000ff00ff00ffff0000ffffff00ff0cb0c9000b090900000a009009000000000909a09a900b09000a90a00000000fffefffffffffffffffffcb9cfcfefaffffffffedfffedeffdefefcffffdada00d900009009009000000000090a00090bc0000900900000000a00aca0e0e0e0f0e9ca9000a9cb0c00009090e0000009090b0000d009009000000900009a000ffffffffffffefffffffffcadebdbdfdfdfffffffffefedfffefffffffefcaf0c9a0a0d00009a0000000000000009090a000b009a9000090000900c0900900900fa90ada00090b00b000000009000090000009009a9b009009a00000000c000bffffffffeffffffffffffcf9fbcbefbffebfffffffefdfffefdffcffefff9bc0b00909000900009000000000000900000909009a0c0b00000b00009a00e0e0e0efcada0c90000cb009000009a9a09a000b0090090900d00a9090009090a0000fffffffefffefffffffffff0f0ffdfedadfdfffffffffefefdefeffcfdefec0f0c9ac00a00a09000000090000000090a900a00009090000a00000ca00c09009090f900da009a9000da00d0000009c090000090b000a9a9b090000000ac00000bffefffffffffffffffffeda9df0ff9fffffff0fffffffffdfeffdeffefdff9a9a0090909009000900000000000090a9000909a9000a90d090000a9000b0e0caca0fae9a9ca000a99a90b00000090b000909000090090d00009a900009000009fffffffffffffeffffffedadebcfdeffdadadffffffffffefefcbefdedbefcad0d0e00a000000900000000000009009009000000009000a000090000000009a900df090ca9009090e90900b00090a9009000090b009a09a90909000090b0009fffffffffffefffffffffd09e9cfbfbf0fffffeffdeffffffffdffdfebfefda90b0a90900a9009000000000000000000000090900090a909000a0000acb00b0c0e0af0f0bc09000009ada9090000090f0000900909009909a9a0900000000000fffeffffefffeffeffffea9e9fbfdedfffdfffdfffffcfffffefefedfcfdefc000d0000900000000000000000000009009000a0090090000b00900009000c00a09c0ff0f0bca0b0a00090f0a9a900090b0900900090000b0d090a900009a000bffffffffffffffffffffd0f9e9f0fbef0fafcbfeffdfffffffffdffaffaf9efbc0a9c0a00909000900000000009000000000900000000b0000000a000000b0c90a00f0b0f009c0009000b009c000b00ad000b0099a909a90b00990000009c00fffffffefffeffefffffca90f0fcffdfdffdfffdfdbefffdfffffefcfcfdfefc00900a9000000a090000000000000000b000900900000900909ac90000a9000a0c09cf00f00da0090000909f0b909c0099a09009a00000090909a0090009a09fffffffffffffffdfffee99cf0fdbe9efafcbe9efbefffdebfdbfffffff0fedf0a90ad0009009090000000000000000090090000000000009a00900090000da0900a0afadadb009ac900000009000a9009ad00090090909bcb09c9900090009afffffffffefffefefeffdacb0fdadffbdf9ffdfdfdfdffffffefffffefcf0fbed0e9009c0000000000000000000000000000000900000000009a00000090b0c00e9c00fda90e9ac9a0a90a90a9a909ad009b900ad0a90009090b0a90000090bdfffffffffffffffffffc09ad0b0f0bedafe9efafbebfdafdfffdbffffffffcffe9009a0b00000090a90000000000000090090000000000090009b000000000b0000ad0fadeb9e9000d00090090d0b099a9a0f09009009090b09099000000009effffffffffeffffcffc0f0dafcf9fd9fdf9ff9fdfdfeffffefdfedffffefcffede9e09000090000090000000000000000000090090000000099c00900000f000090000fdbadcada900a9000000b009ca9c099a00b0090a9e900b00a0009009fbfffffffeffffefeffc0b09ad09adebefe9ef0fcbef9fbdffffffffffffffffeff000900090000900000000000000000900900000009009009a0a9000000900000aca0afaedabf9ada900da9c909e9a99a9c9a9990900900909909900000000bcfffffffffefffdffcbc0f0da9edbfdf9ff9dfbff9fedffebdffedbfffffeffffec09acb00000000909000000000000000000900900000090009000009000a0000000d0fdbedacfbcbcba09a0a00909ac9ba99e0a9a90090b00bca9000000009bfffffffffffffeff00909e9cb9edafcf0febcf0fe9fbcfdffbffffcfffffffffffe09009000000a0000000000000000000000000000000009a0909000090900000000bffe9fdbc9e9bc900909900b09b0d9a0999c00090909a0909000090090ffffffeffffeffffc90a900b0dadbdfbffdbdb9fdbfcffbffedfdbffbfffffffffe900b0c009090900900000000000000009000000900000ad090a0009a000000909a09f9ffebebebdadbad0bca09c0bcb0bc9b00a9090b0f0990b000000000b9fffffffffffdefca0c9cad0dadbebedadbedafcbfcbdbcfdffeffcfdffffffffed00009a9000000090000000000000000000000000000090000090900000f0900000dafeadbfdbdf0fad0a9090b0b0090b0bd0b990000090000900000090090ffffffffeffefffd09a0090b0f0fdf9ffedbfdfbcbfffffaffbfffbfbffffffffffe09000000000900000000000000000000000000000000900900000909000000a9a9af9dadafcbfbcbf9f0b0f090b9a9c90b90e909090b909b0900000000090bffeffffffffefe00909ad0bcbdafe9fdbcbe9ffdadafdf9fdfdffcf9fffffffffc000090909000b009000000000000009000000900009a009a90000000b09e0900c90feadadfbf0dbdaf0bc090f90000b0b0db90b00090000090b0000000009ffffffffffefff090c0ac9adbdafdbfebeffdff0ffffdbffeffbffffeffffffffeb000000a0000000000000000000000000000000000b090000009009a9000000090a9f0dfaf0fe9ebebdbe9b0b0bc090bd09a9a9009a90090b000000009009bffffffeffffdfc000a9090f9efbdbedbfdf9fe9ffbdbefffdbfcff9f9ffffffffd000000090009090000000000000000000000000009c0000a909a0000009009a00a9cfea0d0fdbfbc9cadbf090d0b00990b09b9e90090b009090900000000000fefffffffefef00090daf0f9ededbfcfbfe9ffadfefdfcbfffffffef9fffffffe90000900000000090000000000000000000000090b000009000000b0f0a0000f0d0bfdffafafedbfbf9e9ef0ba9ada0a9c9ad09a0900090000000000000009bdffffffeffffe0900a909f0fbfbfdbfdeffffdffbdfbfffe9fdbdf9feffffffffc090000090000000000000000000000000000000f00000909a9090090909ad000000fbefdffdbfe9e9a9b9bd09db90d09b090b909009000b090900000090900fffefffffffed000d0cbcbdadedefffff9fdaff9ffedf9fdfefeffff9f9fffff9b00000000090090000000000000000000000000b090009000900009f0ac00000a0bcfcf0bedaff9f9adf0ffa9ab00b09e9a9a9e90090900900000000000000fbefffffffedf009009b0f0fdfbfbfcbdffeffdefedfbffefbf9fbdf0ffefffffe00000000000000000000000000000000000009f000000009bca900b00909a0ad0d09fa9ec9af9ef0adbad0bdf9c9f0b09090999a900a09000009000000000909ffffffeffefc00b0e0f9ffafdfdffffafdbffbdfbdfcf9fcffdfbffbdbfffffd9a0000b0000000900000000000000000000bcb0b000009a0090009e9e0000900a0a0ffcbfedaf9bfdadbbf0b0bb099da9f0bcb0d0009009090000000000090b0dfffeffffff000099f0f0fdfafebdffdfffcfffffebffffbdebcf9fcbdadfffad0000000000000000000000000000000000090d000090090b009f09090b00c090d09febfcbadbef0bdada9fdbc9fa0b90090099a909000a00000090000000009afedffffefc09090e9f9fbebdffffbffffffbde9ffdf0f0ffbdfbefbffdbffff0900000000000000000000000000000000b9a9a00090090900fa0bca0000b0b0e0a0f0f0bedfef9bcadadfa9a9a9099e99b0b9a900009009000000000000009adffffdeffda000f0bdafcfdfff9ffcffe9fffffff9ebfdffadebfdbcbcbe9ef09a00009c000000000000000000000000090c0900900a900b0f909000900d000c090dfacfedaf9f9ebdb9a9bdbdbdb0b9a90990d0b09009000900000000000909adefefffef009009f0f9fbfcbfeffff9fff9fcf9effdaf0fdbfd0fdbdbd9f9ff009000a00000000000000000000000000b090e9009090b9c9a00e090c00a000b0cb0fdb0f0f0fbe9cbcf9eda9a9adbcb9ada0b0909a9000900000900000000009bfdffffffc009acbdafdebffdfbdbfffdeffbff9fafdff0f9ebfbefefadadbe9000090000000000000000000000000009a090000090b0abd090900b0a900f0cb0e9f0edaf9e9e9bbcb9ebbdbdbdb09ad0999090090009000000000000000009a0fffefef00000dbcbdfbfdf0fbdeffffbffdedfefdfadadfe9fcbdbd9fbd0bd0b0000cb0000000000000000000000009c90a900a90bc9d00a000b0009c0b09ac090f0b9adadbf0bcbbcb9dada9a90bda9b0a9a09a00900090000090000000909dbeffffde090db0fbfbedebffffffdadfdfbfbfbdfadbffadbcbdadbef90bd009000900000000000000000000000009a000900999a90b0a090b9c90f00bc0ac0b0efb0c09ada9fdbfcb9ebb9bdbdb90b9099c900990090000000009000000000adfedfef0000a9f0fcfdbdfdfdfbfffffbefdfcfadfbc9adadbcbf0f90fbcbe9ac000ac0000000000000000000000009a090e90a09e900900bca9a00b0090090009fdbb0f09f0b0b9bcb9c9e9b0bcb9cbda9b0900b00090000000000000000090a9fadfef0090e9f9faffbebebfdffffffdfebfdfbcffedbdadbcbdafd0f90909000090000000000000000000000009009090099e900f00909909c900000a9a9e90fbcdf0be9bdbdadb9e9bbdadb909bb090900090909009000000090000009090fedfed009adbcbe9fdadfdfffefdbdedbfdfcbfcbcbdadadb0f9e99af0bda00b009000000000000000000000000900900a9b00909b09ada0e00a00d0b0d0c0000f09ba9f9bcbb0f0be9bbcbf9b0f9ad90b009090000000000090000000000009e9ef9e000d9adbdfdafffbf9ffbfffffffafbfcbdbdadadacbdadbcf99e0d090000a0000000000000000000000000b0009000b09a000000900000000c000b00a9ffad9cb0f9adbbdb9f0dbf9adb0b90b99a9a00b09090090000009000000090b9e9ef009a9adbcbebfdbdeffffdfffbffdfde9fcbe0f9e9dbcb9f0b0da99a000000d00000000000000000000900900009a90900000090900909090b09a0000900f9fabbdb0f9ad0bcb9b09af9a9bcbbcbc90900900000000000900000000000009e9cf009e9adbd9e9febfdffffffcfdafbfffafdbdadbe9cbcb0f0be9e9da09000000000000000000000000000a9090000009000000a000a000a000009000090ff9fdfbe9bf9bf9b9e9fbd9bd9cb9090b090900090009000000000900000090b09eb009c90f0febdfbdfdbffbff9ffffdfcbcf0f0f0f0da9e9cb0d0909a09000009a000000000000000009000900000909000000909000909009000000090dadfafffadbdadbf0f9e9badbbe9ab09f9b90b0009b009000000009000000000000dad0d0a09adbcbdfadfbeffcfdeffff9febdf9f0f0f0da9e90bc9ada9e0900000000000000000000000000009a009a9000000000000000000000000900900b0bf9ebfff0bda9fbdb9ad9bcf9b99b0b09e9009000000009000000000000000909ada00090f9adbdadfafdffffffbff9febfdbefcbdad0f0f09e90f090990f0900009000000000000000009009090000000000000900009000000009a090a9bdbffbdf9fff9ffbdbebdbbcbb9f0f0db9b090900909090000000000090000000000009e00090cbcbffbdfbfbdbffffffeffdfadbcbcbcba9e9e90f09e9e0b000000000000000000000000000000a0090090900000000090009000900009a90bcb9ffebeffb0fa9faf9fbd0bf0fa9b9a9e99a9a90009a000900900000000000000090bc909ac9b0f9e9ebfdefffdffdffffdebdfebdbcbcdcbc9eb0da90900d0b009000000000000000000090090900009000000000000000000000a909090f0bfeff9f9bf0fb9fff9fbcbbf9f99f9e90b9e90900090009000000000000090000090ac000009a0f9e9fdfdbfdfffffff9fdbfdfe9dacbcb0a90b0d0f009e09a90000000000000000000000900b0900900000000000000000909009090b0f0b09f9f9fbefc9f90fb9bf0fb9f9e9bfa99f99090900900090000900000000000000000909000900d90f9fafbeffbfffffffffeffaf9fef9e90f9e9ca0b09e090000090000000000000000000000000a00090000900090090900000a90b009090dbfbebffdfbfebff9cfdbf9fadbfbcbdba9adb0b0b009000909000009000000000000000000009a0bdadbdffdbfffffffffffffdffe9f0f0fa0d0a9d0cb0900b00900000000000000000000000090909000009000000000000900900009ada9a90f9f9efa9edbdb9ebbaf9abdbe9db9b0db9a99c9090009000000090000000000000009090000a90d0bf0fbcbfdfffffffde9f9ef0ff0f0f0de9ad0a9a0f9e90d000900000000000000000000900000000000000000000009000b00909e909c9af9e9e9f9ffafbefdbdfdbfdbf9fbe9e9b0bdb09a900090a909090000000000000000000a00909c9afc9ffdbfffffffffffffeff9fdadad0da9ac9e9c9c90000a090000000000000000000000009a900009000009000909000090090b0090b0bf9e9adaf00bdbf9bbebfadbbdab9f9b9e9da90b090090009000000000000000000000090900000b0d9be9affdfbffffdffff9f9efafdada9a9c0b00b0a9a0bd090000900000000000000000009000009000900900900000009a090a9c0b0f0f90f0bda0bf0fadffdf9f9fbcbfdbe9e9b9a99f90b090a90009009000900000000000000000000090b0e9ffdbffffdffffff9efef9cdadbcf0da9c09e0d0c9c0a009a000000000000000000000000090000000000000000009009009cb090909afb0f0f09f0b0ffbfbfebfbdbf0bdbbdbc9f0b0b0d0b09009000900900000000090000009090009a9c9bdadbedbfffffffffef9f0fbbdaf09e0d0a9e09a0b0b09c90090000000000000000000000900000000009009000000a0900b90090b0bbd9cb0f09ef9adb9ffcb9ff9ebdbdbedb0bb099f0909090900009009000009000000000000000090009adadbdfffffffffffdf9f0fbcdaf09e0b0ad00900d0d0d00a0900000000000000000000090009000900000000000909090a900a9a9c9fdafa9bcbe9f0f9fe9bfff9ebdbbebf9bf909f0b09a9a9000909000000000000000000000000900009f0f9fbefbffdfbfff9fbef0f9cbad0da0d0d00d0adb0b0a0b0900009000000000000000000009000000009000909000000090e9090da9a9ad09fcb9cbe9af9fff9aff9fbdbdf0f0beda9bcb90990b90000909000900000009000000090000000090f0dbdf9fbffdfffed9ff0f0d0f0bcb0a0f0a900c0c90d0ca9c00000000000000000000000000000000000000000090b0090a9cb09adbdaf00bca9fb09fe9a9ffdbfe9e9fbb9f9b9bc9b9cb00900b090a0009000909000000000000090009a9ad0fbfaffffcfbfcbdbe90bcb9e9ac9c9c900d0e90b0a9a9090a90000000000000000000090090000000009000b009000900090b90bda9a90bd0f9ffd0be9adebdbef9fbfbe9f0fcbc9a90b0a99c90900909000000000090000000009000900d0bfbcfdfe9fbfedbfdad9eda9e09c90b0b0cb0b00b0c9c00a09000000000000000000000000000000000000090000000900b90b0cbc0bcbcbdaf9fffb0bdbdb9ebfdbfadbdbc9b9b90b9cb99da0b00009000000900000000000000000000009ad9adbbf9ffff9fbdebdbe9a9c9da9e0c0cb00c090c90a0f0d0e9009000000000000000000000000000000900009090900a90e9c9b0bdb9e9fedffffff00adadbdbebdf9faffbcbcbf90b90f09909090009000900009000900000000090009009ad9fcfef9f9fffff9ff0df9ebcbc90b09009a90e90ad0900a900b000000000000000000000900000000000090000000b000909a09f0adf0f0bfdfffff0dbcbf0f99fbef9f9f9bf9090f0b909a090b009a009000009000900000000000000009e9af0f9f9fffffdfffe9fb0fd0f09e9c9a0d000090e90a0909090c090000000000000000000000000000000000b000b0009da9a99e9f9a0f9fdffffffb0b0bf0fbefadbdafbcbe9a9eb909c9ad9a90090090000090000900000000000000909a90f9fbfbffffffffdf9fedff0bdbe09a0c9a0d0b009000dac0ca0090000000000000000000900000000090900900900009a009c9e9a9ebdbaffffffdff00dadf0f9bdbfbf9fbd9bdb9da90b0900909009009000000900000000000000900000d0f9e9fdfffffffffbff9fbcbdebc9f0d0bc09a00da00f0009a90b0a0b0000000000000000000000000000000000000909090b09a9ad0bdadf9ffffffff0a9fa9f0fcbdadbe9fbe9e9a99f090b9bc0b09a900909000009090000000000000090b0adbfbffffffffffdffedffdbdebcbdad09e09c0090009a00000c90c000000000000000000000000000000009a090000a00909a9f0bbcbdafffdffffff09f09e9e9bdafbf9f0f9b9bdaf09a900099000900900000909000000000000000000009dbdfffffffffffffff9f9fadbddf0f9ada90e9a90cb00c9ada900090900000000000000009000000000090900000909090bc90f0f0d9fa9fbdbfffffb09e9e9a9bfaf9f9edbfadada999a9c90b9a09b009a0000900009000000000000009099fbffffffffffffffffdffefdffeb0fdad909e900ca90090000000a9a00000000000000000000000000090000009000a000b00ada9e9abe9fdfbefdffdf00bf0bdac9f9fbfbbcbdb9b9cbc90b09000900909009000090900000000000000000ebffffffffffffffffffff9f9fadbdf9adacf09ada9009e0b090909c0090a00000000000000000000000000a90900909090d0909adb0bde9afb9edbfffff000bda9fbcbedbcfbf9afcb0b9a909b0909090b009000090000900000000000000099f9ffffffffffffffffffffffdffcbde9f9b0f0909cbc090cbca0e0900ad090000000000000900000000009000000000000b00bcb0f90bdbdadeb0e9fcbe0009adadabdbbfb9f9fdb9f90bd0bc090f0009090a90000090b000000000000000bbffffffffffffffffdfffdfcf9ebdbdadf0fcd9adada09bca9009090a09000000000000000000000000000000009009090b0009090f00f9ade9a90f9ebfeb009adbdad9fadf0f0fa9bcb0f90b909b09099a900900009000000000000000000bdffffffffffffffffffffffbfbfddadedb0fdb0ad09ac9ac090cbc90009c00b000000000000000000000090900900000a00090900bcb0bb0f0b0f0f0fefc0f0000a0bdbe9ffbf9f9fadbd90b090b0090b0090a9009000b09000000000000009bffffffffffffffffffffffdfdfdaff9fbcf0bcbd9ad0bc90bca900a0f00a90000000000000000000000000000009009090b000a090b9c9cb0f0f09ab0fdbfe90bc900bdbe9fdaf0b9f0bbe99f0d090b0090909090000900090000000000009ffbfffffffffffffffffffdffffcbd9fe9fbdf0fcbe9ad0bcb09d0f0d00900009000000000000009000009000000000009000909c0b0dab0bcf0b0bc9cb0adab0c0b0a9e9e9fbfbdbde9f9c9be9b0b09090a90b09a900000900000000000009fbdffffffffffffffffffffffffdbffef9f0fa9f9bc90da9cb0da0a09a0bca9ca00900000000000000000000900090009a0a900009009a9cbcb9cbc0b0b0fdadf00bc0dbcbfbdaf9eb0b9b0bf09900909009900909000090900000000000009bffffffffffffffffffffffdff9ebfc9f9edf09fcbc9ada9cb0da9e99e0d009009ca0000000000000000009000000000900090000b00bcbcb0f9ea90b0e9e9a9af0000b00b0dafdff9fdbe9f90bca99a9c9a009009009000000900000000009ffffffffffffffffffffffffffffdf9ff0f9a9de09adadbc9f0dad09ca09adacb00090000000000000000000000009000009000090009090f090e990f0f9b0f0f0f009c0bc9a9fbfbffbe9f0bf9b99a0d0b0909a900b00900900000000000009bdbfffffffffffffffffffffff0ff9e9f9eddab9e90b90e9a0b09ada9c9e9090c9a00000000000000000000000000000b00a900009000b0b0e9bcaca9f0e0f0b0bb000a90a09e9cbdf0f9f9bd0f0dad90b0900090900900000090000000000bfffffffffffffffffffffffffffff9ebf0f9abd0f0f0c0f9cbd0dada9e9a9cbcb9ad0da90000000000000009000000009009000900a09a0d0bd0a9db9e0b9f0bc90f0a09cb0da9ebfafbdbfaf0b09a9b0b09a9090900900000090000000000bdbfffffffffffffffffffffffffdbdad9c9090d0f009e9b90ad0fada9c9a9ca9000c0b0000000000000000000000090000000000000090090bc0a9da0e9f9e00b0befc900bc0bcb9f9f9fbcbdbdb9f9090909c90000b0090009000000000000bfffffffffffffffffffffffffffff9d9a99a090909f090cad9af09e9e9ada09e9e9a9009e900000000000000009000009009009000900090bcb0d0a9f9adad0f0f09b0ac90b0da0daf9f0fbcbcbcb0f9e9ada909a9009009000090000000009dbdfffffffffffffffdfffffffffdbe9c90d9d09a0009e9b0ad09e99e9e90dbc9a9c9e9e00a000000000000000000000000000000000090a009cb09da0fbf00b0b0f0d00b00f0a9fa9fafbf9fbf9f9f0b909090bc9090090000000000000009fbfffffffffffffffdbffffffffd9fc9f9bda90bc9d09000c9c0f09e9f09e9a0bcbca9009090d00000000000900000009009000000900000909a009a0bdbca9e09e900a09fcb0099e9cbf9fdadbdb0b0b9e90b0909000090000000000000000bbffffffffffffff9fbfffffffdbdff9f90d090d9090000909a9b0bcb0f0f0f0d0909dacbcbca0000000000000000000000000900900009a900e90da0f9e9e9f09e90f0d000b0f00a9bf9ffaffbdaf9f9cb9bd09a909a9009090000900000009dfdffffffffffffffffdfbfffdbdb99c9e909090090909000090c9cbdf0f9e90bcada009000909c00000000000000000000900000000900000900b0999e9e9e0da9a000b0009e9e90e9fadbf9fabdbe9a9cb0b9090b090900000000000000000bfbffffffffffffff9fafdffdbd0d009990f9cbbc9e0909090090a90adbcbdbe90d0dad0f0f0a0b00000000000000000090000000000009090a909a0e90f0b9a0f0c900da0009e9ac9a9fbfdfbdfadbdf9b0f9cb090900009000000000000009bdfffffffffffffffffdbff90009a9fbefffef9cbe0900000000090f9adbcbc9e9a9a90b0909d000000000000000000900009000009000000090bc909adad0e9c090000a9a00b0bdb0bcbdebbffbdbfa9b099ab090da9090000000000000000fffffffffffffffffdadad090099bf0fffffff9aff09e0f00000000090f9ada9a9c9e9cb0cbc0a0f000000000000000000000009000009009090f0b0dad0f0e90b0e0000f00009adade9bfbffdf9ebdb9f0f0bd9da9090009090000000000009bdbffffffffffffffffbda900000fdfbfdbfebc9e9e0900000900000adafdbdcd0b09a9ca90a9c90000000000000000000900000090000000da090da09a9009a0c9000009fa90c09a9bc0ff9faff9fadfb9bd0ba99a909900000000000000000bffdffffffffffffff9ff9cad0090b0dad9bd0b09090090090000090909adaabcbcbc9e9dad0a9e9a0000000000000000000900000090090b090a90909da9e0d00000000e900a9ac9e0bf9fbffdbffdbade90b9dbc90b0a9000000000000000bdbfffffffffffffffdff9e99909090999000090900090009000000000bc9add9ad009a90a9a9c900d000000000000000000000000000000a000f09acb0a0c900a0009009b0a90009a0bf9effcfbff0bd9fb9bd0b0b9090900900000000000009fffbfffffffffffffbf0ffffff99090f09bd99c900900990009a90dad00bdb0ad0bdbc9e9c9e0a0f0a00000000000000900000090000009090909adb090db0b0c9000c9ef90a9adad000fb9fbdf9fffaf9bcb0bdbda9e909000000000000009b9fdffffffffffffffdffbdbfffffdf99bc909a909d0bc0c90bc0da090bd0bcbd0f000a909a099c909000000000000000000000000000b0000a0bcb0000b0c0090000b0f00fa009a9ac909efffbfe9fbdbcb9db0b9a90900b000000000000000ffbffffffffffffffff9ffadfffffffffdbdbc9fda9c9b9adadb00d0e00ad0bcb09f9c9e9e9e0a9ac0f0000000000000000000900009009090909adbc90c9a9ca0a90cbcbf00b0a00a9a00b9fadfbfbdbfbda9ad9adb9a9090900000000000009bffbffffffffffffffff9ffbfffffffffffdff0bdfbde0d0900da0b09f9adcb0f000b0909099c0d0b0000000000000000090000000000000009a9a090a9ad0b090ca90a090b000b0d000b0ffffbdbcbf9cb9f99adbd090d0000000000000009ffdfffffffffffdbfdbf9fdbdfffffdffdfffb09fcbcb099e9e9a9ad0f00dbb0d09e90d0f0f0e0b0b0c000000000000000000000009009009a9e9c909a9000bc0ca0f0e90fa00a90b0bc00dbff9effff0fbda9adb9b0f909a909000000000009bfffdffffffffffffffdebffffffffffffbffc9e9bdbc9e0900d0d09a9dbac0f9e99e9a090090900c90b00000000900000000000000000000909abcb0c00f09a9adfaf00b0da90a00b0b0a00bff9f9fbfda9f99adadb09a900000000000000009fbfbffffffffffffdbf9f0f9fdfffffffdffff9e9f0b090a9b0b0f0da0d9bd0a9e909cb0f0cb0f09ad0000000000000090000000000900900bc90909a99000d0affdfbc0fa90a90b0dad09adebffebdfbff0bc9b9bbda909090000000000009fdfffffffffffffdfbfdf9dbffffffffffffdbd09f0d09e9c0c90d0b0db0f0bfd090f090d09a9c09e00bc0000009a0000000000000000000090b0f09e90a09a0bdfffecb0b00a00a00b0bca09bde9bdfbff9bdbb0dbd0909a900000000000009bfbdfffdffffffffffdfadbfcbffffffffffbfcbe909e0000b9ad0b0db0f09c90b0f00bcb0a9c0b009f00090009000000000000900900090bcbda90f09ac90cbcfffedbcacb00b09a9af0f0f0fbfffa9e9ffeb0dba9bf9e9009090000000000bdfffffffffffffffdbfbdbc9bdbfdffffdfffdbd9e9009090000b0d0bcb9cbbcbc90bd090c90b00da0009c0090a000000000000000009000090a9cb0bc0bcb00f0fdfacb0bcb00a00090b0f0f0f9fedbffbf9fb0dbcb09909a00000000000000bdbffbffffffffffffdf9fbc9bdffffffbfdfbff99e9000090c90b0d09cb9c9bdbcbcada9bc0d0b09e90a909e09c00009000000000000090b0990bc9cbc0bcb0bf0e9f9e0eb00a0a9a0a0f09af0fbdbcb0f9fbdbb99ffb0b0990900000000009bfffdffffffffffffffff9db9cb9fbdfd09b9fdb0f9000000090009a0f90f9e9e99cb909c09b0090c90e90b00900b000000000000000000009e9e90b009ada9e00bca0a09900b0900009a9a009fadaff9ffffdad0ffb90d0900000000000000bdbdbffffffffffffffdbdbe9cbdfffff99f9fdb0fd0e99a909a90dbc990f9e9cb9ebd0cb0b0c0f0a9a09000cb09f000000000000009090909e9a90b0cbcbcbcb0b0b0f09afb000a0a0a09ac9e09fffdbedafbffbf9a9fb9ad0b0909000000009bffffffffffffffffffffdf9b0909ffffffffffdbfbdac90f0da0009f0f0f9fbde9d0b9c9cb090c9009cada90e009000000000000000000b09a9ebcbe9adacb0a0ca00a000fa9009090a09a09a09afadbbfdffbdbf9f9e909009000000000009dbdbdffffffffffffffffbdfdf9f9fffffffffffdadb9ac90b0d09a90bdbcbc9ada9fcb9a9cb0b009e090090909e0f000000000000000900bc909cbcbcf0b0e9cb09a90b0f00a0a0a0a90a0b0090f9fffdfbfbdfe9fbe9f9a900090000000000bffffffffffffffffdfffdfbf0f0f9fffffffffdfffcd99e9cb009c9e9adbdbfdbdba9c0db09c09e090a90ca09a09009000000009000900909ada900ffacf0b0a00a00a0090b00900900a090adaf0fbcbfaffffbdbdbdb90909a900000000099f9fbfffffffffffffffdffbfdf9f9ffffffffffffdb9b0e9cb00b09e9fdadad0bcbc9dbdb0cb0b090b0d0a909e9d0f9e000000000090009a9ada9acbdadf0b0f0b0bcbcb0fa0a0a0a0a090a90b09adbffdfff9ffbfafbf0b0900090900000009bfdfffffffffffffffffbfdfbffdbfffdfffffffffede99ad0c90da9da9fbdbfdf9febcbc9bc9ca9c000d009090a90000000000000000b0d09a9c0bdada0fca00e9e9e9ea0f909009000a00a00a900cbfbf9ff0fff9fdbfdbc9900000000000adbffffffffffffffffffdfffdfbfdbdfffffffffdfdbde09a9009ada9f0dad0b0f099db0f0cb0900bcb0a9ca00b0f090f000000000090009ad9abdafcada0bdbb0f0fafdff0a0a0a0a9a09a09a9e0b0bcffffbfbfdfbbf9b09a09090000000099fdbfffffffffffffffffffdffdfffffffffffffffbda9dac0b0bc90f0fbdbfdf9ffe9e90f90dada090900a9c90d0bcb000000000900090b0bed0bf00900f0a0cb0f0d0eab00b09009000a09a000900fffbffffdfbf9edbcb909000900000009fbffffffffffffffffffffdbffffbfffffffffffffde9da099c9cbbff9e9dadabcb090f9f9adbc909cac00900009ad00090000000009a0b09f9afc0d0ebda9adbacbeafbdcb00a0a0a0a090a0b0b0e900fff9ffbffbfbbf9ad09090000000009bffffffffffffffffffdfffffbdffffffffffffffffbdad9e00b09c90f9ebdbfdbdfff9e9ad909ada099a0090b0000bda00000090000900fadad0b0a90c0f09a0db09000abcb09009009a00900b0b0eb09afffffbfdfdfbdb9a9a0909000000099fffffffffffffffdffffffdfffdffffffffffffdfcbda09b9cbcbf9e9dadf0fda9daf9edae9e90da0c900000909009c900000000900909fadac0090b0b0f09a00e0bc909a00a0a0a0a00a0a9a00b00cadfbffdf9fbf9adbc99090000000009bffffffffffffffffffbfdbdff9ffffffffffffffffbdadbc0cb0b09e9ebdb0f9adfad9e9bd9e9adad0b00000000009a9a0000000000b0db09a9a90cac0f00bc9ad0b0a0ae90a0b090b09a909a09adada09bdfbfbfbf0bffb90a900909000009cbfffffffffffffffffdfffffffffffffffffffffdfcbc9009b0d0de9f9dbcfdadfa9daf9e9e9ad09a90c00000900909c0000000090909abcbc000a090b00b00a90b009a99e09000a00a00a0a0b0b0a9000ebffffda9f99b0f99090000000009bdbfffffffffffffffffffdfbfdfffffffffffffffff90f0f0c9adb9e0fedb0bda9debd0f9e9adabc9e9a9000000000a9e00000000000f9cb0bc00d00009ac9adac0f0e00a9a0a900b09a9009a0a0b0e9090dbfdbff9bf0db9e9da90900000009bdfffffffffffffffffffffdfffdbdfffffffffff9eff090b0d0acbdb9befdafda99ebdadbde9da9e9c000000009090909000000090b0abc0009a000aca0b09a9a9a90b0da090a0a00a00eb0cb9ca90a000bffbff9e90bb9e99a9000090000909fbfffffffffffffffffffffffbffffffffffffffff90f0d09a9dbc9efc90bd0bde99cadacb9e9cb09a900000090000bc000009090009d0b009a0090090900e9edac0ac0a90a00090a09a900b00a9ca0900bcbdbffbdb90db9a090090000900bdbfffffffffffffffdffffdfffdfffffffffffffde9cf09a0a9dacbad09bfecbda9acbf9bdbcbcbc9e9c000000000a9c9a0000000a9b0a00cb0c900c9a0a0a9a9a09a90bda00a9a0a9a00a0b09a9a09a0909ffffbf9ad0b90f99090090000900b9ffffffffffffffffff0fafdbebdfdffffffffffffb0d00d9cadbcdadac099bc9edb9cbcbcbcb09e9a000000000909a0c0000009000c9a900000a9a0009090dac9e0a00ad0b0000000b09e0eada9a09a0000bdadff9b909b9adb090009000990f9bfffffffffffbdbe9fdbcbddfafbfdfffffffdbcdb0b0a0b009a9dadbcac0a900fa9cbcbdadfa9c9e9000009000c9b00000000090b0c0bc0b0c09a0a0a0b09a0090b0f0a00b0b0b00ea0b09a0e90adada9affbfbe9e9a9c9b0900900000009b9ffffffffffdfdff9f0bc90a90d9edbffffffffffbc00d090c9e0ca900909090b90da9dbc9f09cba900000000090b0c900000009a900b000900b0e0900090a9cb0a0000b00a000000a909aca9a90a9a900cbdbfdf9990909bc9a9000000099f0dbfdfffffffffbf0fcbd0bc90f9adbfffffffffcbc9090ac0b09099c0bcbcac0c0cb9ebcbac9ebc9ca000090ad0a9cb00000090000cb09cb00f009a0a9a0ad0a0bc90af0b090b0a0b0a0e0b0e9a99e9acb00bdfaffa9b0b09b909b0909000099a9bffffffff9fdff9bdad09a90090f9fffffffffdac0a09090009e0ad00090b090b0e9cb0dbad09e9c900000909cb00b900000909a90ca09e9ada09000909a9ad00a90bc00a00a90090a90e90a0eb0f0bcbc9adbdbdad09cb0bc0900000909a9dbcbfdbfffbffbcbc009000909adb0f9fffffffdf9900d0bc9cb09000090000000090b09e0d0bcb0b00000000a0b0f0c000000000da9bda0000a0a0a0a00a900a900a0cb0a09a00a0a09a09ad0b00a0b0b0b0bffbff99b0909db900900000909a9bdbffdbfdf0f0909e0a9c0b0d09dbfbfffffffaca090a00b00dad0b00000000090009e9b0f0bcbcb0000009c90d00b000009a09a9ca09cbe909009090b00ad0e0bc9b0b00a09a9009a0be0abc9a9f0f0f0d0bdbdbcb09b09a9a090900909b99bf9fbda9db0909e0000d009c90adb0fdfffffdad909e090900f0000c00c0090000090f090e90d0f0c000009a00da90900000009a9cb0f0b0000a0a0a0a00a90a9a00af009a9a00a0a00000bc0aad0a9aa0b0f0bfbfb9f0090909b000000009ad09ebdbda0090fff00c0000a009009fbffffffffa000900c0090bc000000000000000009e09eb0f09a00000009a90000000009009ebc90f0a9a00090000a90eb0009e90fa0009a0090a9a000b09a0bcbd9bcb0f9e9ff9b90b09f00f090900909b9999ebd90009bffe0000ac9e009009f9ffffffdfda009a90000ef0a00000000000009a09f09cb0f0d00000090c0f00f0000000bc90bf0ad0000b0a0b090a900e9a0a0f00b0a00b0a00009a00e0cb0b0aacb0bcbfbf9ebf9090099090000009090bcb9fbe900009c09e0000009009be9ffffffff09090c000b09000c0000000000009a9ca0bcb0cbca000000009a0090000090909afc0e9a0a0b000000a00a0b00090009a0a09a000b00a0090b0b0a0cb990dadbdbffbd90f099a009a909090b0bdb09ff9d0b0000000000009000bc9ffbfffff0f0c00b0090000000000000009009c0cb09da9cb09000000009a0900900000009afcb090009000a9a0a09a0900b0a0bfa909a009a00a900a0a0ca00b00eabadbafdbf9fa9090009a090000090d90bdb9ffa90ff0000000090009f9bf9ffffffff0b0b009c009e900000000000000a9a9cbcaca9cac0000000009c090a000090b0f9000a0a0a0a000909a000a0a000009e0a09a0a0b00a09009a90f00b090cb09dbbfff9fb09b090900b090909a99090b9fdf909e9c00090090000fd0f9fffffdfe9c00909a0000f09000090900a90c9a90b99cb90b000000000b0000900000090af00c90900909a0a0a0a9a0090a9a0f0b00a009000b00a0a000a00a00a9a9afadff9fbf9f09000090090000b90f9f09ffbeda909a909000009bdbebfffffdfebd0b09e0a9c09000e09e000009c0e9ac0f0cabcad00000000000dad900000900bd000a0a0a9a0a0000090009a0a00000b00a09a0a0b00a00900b00b09a9a9ad09ffbfffdb09090900090a9099090b0b9f9f9bfdad00ac0909badbcbdf9f9fffbd0bc0090d090000909009a909e9a90d9b0cb9c09a000000000009a9e00009a0bc0000909a9000009a9a0a00a00090a0f0a09a09a9a0a909a0a00b00a0a00e90b0bff9fbffb90b000900990000b099d90bfffdebfbff99bcb0d9e9f9bcbfffbfcfad0f0000a0f0bc00a900cada90d0f0ac0bca9f0c0000000000009f0000000d09a09a0a000a0a9a000000a900b0a000ad0a00a000f0caa0009a00a0909a90be9f9fffffbdfa909900000a99909b0b0b99b9fbdf9f9fef0bda9e90bc9bdadff9f9da90f009000009a9cadb9cbcad0b0d9ad09e00b00000000000000000000900bc0009a9a0b09000a0a0a90a00000a009a90b09a9a0ba9cba9a0a90bca00a009ab0ffbf9ffbd9b009090090a090d099c0bdfbdbde9e9909009009f09e9adbfcffbe9f090f0090000009000e9e9daf0f0ad0bc9dac000000000000000000000a90b00ca00cb00ae0b090d00a09a0b009af0a000a00adad0a000009ca0a09a9a9ebc9fbdfffbf0bc9b00009099909a9b09bda99cb09a9000009009a09f9bdfbdbfbc9fcbef090009000000909009a09c9ad0bcb0a0900000000000000000009090bc00b0b0b0ca90900a0a0a90a00000a0ad0a0a0a90a0ae9a9a9a0a909a0000a90bbeffbfbdff9b909000000bc90990b9099eb90b09cbc9cbc9e9dbdadf0bdfffdfe9bd99cbcb00090090a000b0d0f0bcbc0bc0da000000000000900000000b0f00cb0c0a00b0a0a0a0b0bc0ac9a0a0009ab09090a0909a0ca009a0a0a9e0b09af0dbfffffbffdad0b90000909a9a99cb9ad9cbc9cb09a990bf9a9adb0ffdafdaf9fcbefadadcb0f0da09c900c9a90f0f0bd0b00d00000000000000090009009ad0a0b0b0f00e90da90000b00a00c9adabc0a0a0a9a0a00b09a0a0f0bc00b0ac00ba9fbfdbdfbf9b90d090000b909cb9099bfb9b090f9c9afdafdff9ff9ebfdbfdfbbdbdfbdbbdf0fadbe0e9f0adfe9f0f0ad0da0000000000000000000900f0f0ad0a00a00b0a0a0acb0e0a90b0b00a0f0a900b000b00b0aa0f09000a0b0c0b0f09ffdfbffbfdf0a9a0000099c09b90b0fadbcf0bf9e9bfdbf9f9bcf9f9f9bdff0fcfde9defcf0fad9e9f9bcbdf09f0f09da0b00000000000000000000009090000a90b09a009a090b0a9a9ca0a00a900b00a00a9a0a00a0900a0a9a9a0a9a0a0be9faffdbcbfbd909909a009b900bd9999bdb9d99f9f0dbfdfbcff9effdeff0ffdbfbfebf9f9f9debdf0fcbe90fe0f0bcad0c0000000000000000000090adad00b0ca0ca09a000a0000000a0900b0caf0b00b00a090b09a0ab000a00900a900909a9fbfbfbf9ebf0bc909000099b0b0b0d9bdabcb0f9b0f9e9fbdbf9f0f9dbf9fbcfdbdf0fedaf0debcf9fdfff9f9e9e9b0b000000000000000000000a90b000a0b09a90a00a900a00b0a09acb0ca90be00a0a90b0a0a00b000b000a0a00a0a0a0dadfffdf9ffdbd09a009a99ac0999db0bcbd9b9f9c9f9fbdbdbcbf9fbfadfadebdadadfdbfdbfb9dbfcbe9e9e9e9e9c0d000000000000000000009009af09ad000a00a9a900a909a0090a0a00b00ad09a0900a0a9a90b009a000b0090b009a09a9bfbdbabdbbf9a9090099e99bda9a9099b0bcbcb9bf9e9fafdbfcbdad9f9dfbdbfffbfbedbcfcfefcbe9f9e9e9e9ca9a0000000000000000000000dad00e00b0a90a90ca0a0a0a00a0a0090a0a90ba000a0b09a000a00a000a0000a000a090a0bc9ffffdbfdebdb0090009a9099f9b09e9f99bf9e90f9bddb9e9bcbdaf9ebc9fcbdbdedfadbdbf9dbfdade9f0f9cb9c00000000000000000000009a90f009a000a00a0b0009000a9000b0a9090a0cba90000a09a0b0b09a09000a00a090a00090bcbff9e9bf9fbff909a099f9a9a9d09090f090b9f9bcfb9ff9fdbdbdaf9fbeb9fedbfbdffebcfebcbdfbdadbcbaca90000000000000000000000a9e9e9ac9a900b0000a9a0a9000a90000a0a000bc9a0a9000a09a00a000a0a900900a000b00a09bdbfffdbfbdbdad09000b0db9fb9a9099bdbd09adb9ef0bdbadadf9dadf9fef9fcfdfadbdbdbdfbe9eadbcbc99c00000000000000000000090d09a000b000a000b0a000090a9a00a9a00009a0f0a0000a0a90a00b00a00000a0a0b00b000b099efffbdabfdafb99a90099fb0db0090b0f09a9bbdb9f9bdbcbdf9f0bfff9edf9efbfafdfdedafe9edbddbcbc9e0a00000000000000000000000a0bc9cb00a0000a0090a9a0a0000a00009a0a009b00b00090a90b00a90b0a00000000000a000a09a9ffbfcbff0ffada99a09dba9f900099f9dad09e9e9cbdbda9e9ff0f0ffbff9fdfdbfafbfdbdf9edabcbc9a9c0000000000000000000000909f0ba00a09a9a09a0a000900b0a090a0a000000e9a000a0000a00a90a00090a090a0a0a09a09000dbfdfbfdbdf9fdbdad9e0bddb9f9900b0b99b9f99bf9bcb9f9bdadbdf9fcbffbebfcfdfdafcbef9fde9e9eda909000000000000000000000a09fc0b00a000000090a0a0a0009a00900a0b0a0bf0b0a00a0000b0a09a0a0000a0090090000a0b9a0bffffbffbe9ffadab990ba9eb0b0909daf0b0fbc9da9bcbcfbdbcbbcfbde9fdfdbdbcbf9fddbe9e9f9e9ac0a000000000000000000000909e90bca900a0a0a0a0090000a0000a0a9000000e000090090a9a0009a0900a0000a00a0a0a00900c9ffbdbcbffdbfbdbd09e9bdfb9d090b9a999cb909ba9fcbdbbcbcfbcfbdfbfcbfaffeffcffebe9f9f0e9ad0d000000000000000000909ac9ebca00000a900900000a00b0000a090000b0a9ab9a0a0a0a00000b0a0a0a00b0a00000000900a0b000ffffffbfff0fbcbdb9e9b9f9a909cbd9e9bda9e9d0b9f9edbdbfdfbdafcfbdff9f9f9f0f9fdefadf9eda0a90000000000000000000090a900c0b0b00000a000b0000000a09a0a9a000000cb09000000a0b00009000900009a0b00b00a09009a90bfbdbdbfffdf9abcb9e9e9f9e9a90ba909ad99a9f0f0f9bcbdaf9efdbfdebdcfef0fff9e9f9cfada9ed90c00000000000000000000090bc0b0000a00a000a0000a00a900000000b00a00bca0a090a00000a0b0a9a0a00000000000a00a09ac0bdfffebdadbfafdf9f0f9fbcb9099bd9f0990be9f0bd9bcbdbe9febdafdbfdfbf9ffdadeff0ff9fade9acb00900000000000000909a00bca000a0a09a00a0900a0900000a0a9a0a00a900da9000a09009a09000000000a0a00a0a0009000a0900bf9fbdbfbfffda99a9b0f9f9e90bcbe90f0bc990bd0be9f0f9fdbdff9fe9fafdfcfadfbd0ff0f0df0bc900000000000000000000009da9009a9090a090000a0000a0a0a000009000000ab0a0a000a0a00a0a0a9a0a9009000900b0a0a9009ad00fffffcbdbdfbfefdadb0fbf9ac9b99a99099a0f90bd9e9f9ef0ff0fe9fedfdafbdf0fcbfa9fcbf0bcb000000000000000009009c90ad0ca00a0a0000a9a0000a00000090a0a0a9a0a00cf090b0000000009000090a0a00a0a00000000a0000a90bdbff9ebbcf9fbfdadb9daf99adad9a09e9990bd0adb9cf9bf0ff9ff9fbefdfcbff9fcfde9fcbcdac9e90000000000000000a00a90a909e9000b0a00000a090a9a0b0a090000009000b00a000a900a9a0a0b0a000000a9000b0a9a0009a9ad00bff9ff9fdbfff0fbdbcbbdbe909b9ad0b9a0c900b9adab9edff9cf0fefdbdadbfcbcbf9ebedbdbad9a0000000000009000009009cbc0aa0a0b00090a0a090a000000000a0b0a0a0a0acb0000a00a00000000000a90a000a9a000009a00000009e9fbebfcbf0f9fdadafbcbf990f9e90909c9b0e9d0db9cfb0f9efbfb9dbeffbfcbdff9efd9f0e0d0ac90090000000000900900b0b09ac909a00a00a90d0a0009a0b0a9a0a009a00000bca9a09000b000a90a0b000009a0000a0a9a00a0a9a9c09bdfdf9fa9fafbffbdbdbd0fa90b99f0b0000990a9b0fb0df0fbdcfcfadf9edbffebcfbdaf0f9dac9000000000009000090a09c0dac90a0a0f00b00a0a00a0a00000000909a000b0b0b00000a0a000a90a000000a00009a0909000a090000a900ebfbffbdb9dbcbdfadafb9fdaf9e900db09000900c90db0bf0fbf9bdfa9f9fcbddf9edbdadacb9b0f000000000000900090ca9a09a0d0bc00a00a90b0a9090a9a0b0a0a0a0a9a0000cb0a0000900a00000b0a0b00a0a000a0a0a900a0a0900a09cbfdadfcfbc9fafdbf9ff0bc9a9a9f0000a90009b0dadbc9f9cbcfadfdefafdebfedbcf9e9f0c00009000000000000b00090009e0ca00a9a90a0a0a00e0a00000009000090000a0ab0000a000a9000a9a000000900000a0009000b0090a0a900bfffbfbfa99ebdbfe9fe9bfdbdad90009090009b00b0909ebcfadbdadaf9f9ebdadbedbcbd0a9090000000000909a900a90a9da90b00b0000a09009cb009a0a0b0a0a0b0a0a0b090cb00009a0000a900000b0a0a000b000b0a0a0000a00900f909fffdfbdef9cbcbdf9bfdb9eb900a9000090000d090cbc9cb9dbcbdbd0f0f9efdef9f0f0ac9ca09000000900a000009c09c0a9e00b00a9a090a0a0a09a0009000900000009000a0bc0a000000a00a0a0b0009000a000b00000900a000a09a00e0bdfbcbf9faf9bfaffdbfef9cfbc9009000000b000b09a99cacadadaf9fdad9a9f0f0f0d90a9000000000009009c90a90a909e9cacb00a0a00009a0a00a9a0a0a0a9a0a0a0a00009a900a000b000009000a00a0900a000a0b0a0a90a900a09a909afffdbffdbe9fdbcbe9f9eb909a9c0009000090000000e9999adad0f0adafde9f0f0f0ac9009000000000009a00b00090bcbca900a00090a9a00900b000090000000900009a0ae000000a0000a9a0a0a90a00a00000a900000000000a09a0090fdffbebdafdfcbfff9fbfbd0f090a009000090090909090acac909a9adbc90b9e9f00909000000009090909009b0d0f0f0f09000a909a0a00000a0a000a0a0a0b0a00a00a009090a0a09000a000000000009000b0a900a0a0b0a0a000000b0e00bbdffdbdbfbffdbfffcbdab0bc09000000000000000009090bcbc9c9009e9c090090e00000000000000aca9e0c0a90b0f0bc0a900a0000000b00900a0900090009a00a9000a0e90000a00009a0a9a9a0a0a0a0000a000900000900b00a0090b0cbfbdfebdedbebf0fbfffdf90b00b009000900000000000090000a00f009a9e0f0e90900000000000b090909b090f0f90000000a00a9a09a00a0a090a00b0a0a00009000a000bca90000a9a000000000900090a0000b0a0b0a0a0a00a90a000090fffbdfbfbdffdffff9fbe9e909000000000000000000000090909000900090009000000000000900c0bcb009e90900f0f000a9000000a0000900a000a000900a0a0a0a09a0cb00a0a000000b0a0a0a0a0a0a090a0000000090000000000a9a0f9fbffbcbcf9fff9f0fff9f99e00909a0000900000000000000000090009000900000000000090a099b090c9e90bcaf0900a0000a00a0000a0a0a090b00b0a0a90000000000b0000090000a000090900009000a09a0a0b00a0a0b0a000a9009000ffdfffffbe9bffffbcbfbcb09000090000000000000000000000000000000000000000000009c9a0000a9a9ad0bd9ac00900a09000000090009a0a0a0000900a9a009a0a0cba0a00a0a09a0b0a0a0a0a0a900a009000a900000090a900a0a0909afbdfbdffedaffffffdfbcbcb00000000000000000000000000000000000000000000000000009e9c9c9c09ad0ac0b000a0000a09a0b0a0a0a09009a0b0a000009a00090bc090000900000000009090000e900a0a0000a09a000a00a00009a0e9fffbffbdbdbdbffdbebdb909c90090000000000000000000000000000000000000000090a9a9090ba9ab9e9ebda9c0a0090a00000000009000a0a0000000b0a0a00a0a0c90a00a00a0a00a0b0a0a0a90a9a0b0009a0a00a00a00000090a00090fbdfdbffffcbcbfffdffbcbca000009009000000000000000000000000000000000009a09c90f0bc9dadcb0900c0b0000a09000a0000a00a0b00900b0a9a00000009000ba00a90a0000090009c0000a00000ca9a0000900090a0a9a0a000b0a90fafffcbffbffdbffbf0f9b090900000000000000000000000000000000000000000000f0b0f0f9bebdbb0f0f0b0000b0000a000a0a09000000a0a0000000b0a9a0a0a0cb0000090a09a0a00a0b0b00a9a0b0000a9a0a0a0a090000000b0009a09fbfbfdadffbefdffffbc9f000a900000000000000000000000000000000000000090090da9bcf9f0fc9e9f0c09eb0000a00a900000a0a90a00000a9a0a00000000000bc0b0a0a00000009a0000009000000a0f0000009000a0a0a9a000a000bc0fdffbfbfdffbfff9ffbf09f090090900000000000000000000000000000000009e90f0bdfeb9e9f0be9bcab9e9ca0a900000a09000000009a00b000900b0a0a9a090cb00000009a0a90ac9a0a0a0a00a9a9000a0b0a0a0b00900000a090a900b9afffdedbffffffff0fcbf000000000000000000000000000000000000000000000f0f0fa99edbe9f9fc0bdcf0a9000a9a0000a0a000a0a009a00a0a0a00090000a0b0a00a90a0000a09a09009000a9000a9a090090000000a0a0a900a00a0b0e9affffbe9fffbffffdbc9ad09000000000000000000000000000000000000900bda9dfbdeffadf9ef0bd0fa0f0a9a00000a000009a00000a0000090090a0a00a000e90b00a00a0900a00a0a0a00900a00000a0a0a0a9a0b0009000a000000090990bffdfbc9efdfffbebdb0f0a9000909000000000000000000000000000000000fabcfb9f9faff9edaff0f000000a00a009a000000a09000a0a00a0a0900a009a09e000000900a0090b009000a0a009a0a9009009000000a00a0a90a9a09a0a0e0dbfffcbf9fbffffdfadb09c0090000000000000000000000000000000090dbc9dfbdefeffdf0ffbfda00a9a00090090a000a0a00900a000090a0000a0090a000e90a0b0a0a000a0a000a0a00009a00900a0a0a0a0a0a090a090000000000090b0bdbfffcbcffffffbfdade9a900000000000000000000000009009000900b0bfebcbff9f9ebff9ede0cb0009a00a0a000000000a00a00b00a0900a0000a090a09a000000000a90000b00000b0a00000a0090090000900a090a0a0a000a090a90f0fe9fbfdfadbffedebf9bc9ca90900000000000000000000000009000bc0fcbdfff0ffeffdadefafb0000a00a000000a0a9a000000000a000a009a0b00a0000e9a9a0a00a00a0b0000a0900000a9009a0a0a0a0b0a000a00000900b000a00a09a9bfedef9ffcbdfbdfcf0b09000000000000000000000000009a00a000b0bdebcbff9ff9efff090c0f0b000000a00a9000000b0a09a0009a00b00000000a0a0bc00009000900000bca90a000b000a00000900900000b000a9a0a00000a00000a09ca9fbffe9ffffffbf9fcbcbc90000000000000900000900900909090dadabdbfdfef9ffda09e0ba0000a9a00090000a00000000000a0000000a000a090000cb00a0a0b0a00a0a0000000a000b000a09a0a0a0a09a000b000000a0a9009a0b09a09ffdffffe9effedefa9f009a000900000000000090000da0d000000ad0bdef9ebf9ef9a0da09c90a0a0009a00a0a000a00a00a0a0900a0a0000b000a09a0b0a09000000a90909a0a0a09a0000a90a00009009a000a000a0a00900a0a0000000b000bffffff9f9ff9fdf0db0da9000009090900000009a09a0a9e9e9d0fcbdafdf0f9e0fa000a0a009000a00a00000a90a0000090a0a0090a9a000b000000f09a0a9a0000a0a0009000000b0a000000a9a0a0000a90b090090a000000a00a0a000b0009f9ffeffffffbefade99cb0b09c0000a9090f009f090d0009aeb9f0bdafbfcbf90f09e9a90a0a9000000a09000000a9a000000a000000a0000a0a009e0000000b000009a0a0b0a000009a0a9a000000a9a00a00a0a0a00a90090000000a90000bcffffffffffdf9fb9acb0d0da0b09090e0909a90f0f0bdac99cfadfedbcbf0cac00a0000a0000a0b00900a000a090000a000000a0a0090a0009000e90a90a0a00a0b0ac0000090a0a0a0000000a9a00009a09a009000000a0a09a09a0000a900fbffdfffbeffffededfbda9a090d0ada99f0bdef0f0bcabdbefadfa9bcbcbcb090090b0a900a00000a0a000a000a00a000b00b000900a000a00a0a9a90a00900090000b0b0a0a0090900b0a0b00009a0a00ca0b0a009a0000000000090a90000009fbeffdffffffffbdbedbd9e9af99cbe9fcbb9f9fdbddafdbcbcfde9e9e9e000a0a0000b000b0a000000009a000009a00a000000a000a09a0000e0a00b0a0a0a0a9000009000a0a0a000900a0a00090a90000000a00a9a00a00a00a0000a90a000fbdffffaffffffedbebfadf9feb9db0bdfcf0f0bfafdafdbdbe0bcbdac9e00900b0a000a00009a00a0b000000a00000000a0a00a0090000a00dbc9a0009000900a9a0a0a9a000090a0a000900a0a090a9ada9a0000000900000a00a0a900900009ebffffffdbfffffdfcfbefe9febcffafbfffffcf9afdafedbfcbca09a00b0a00090a900a000009000000a0a90a00a0a009000900a0a00900a00ac0b0a0a0a0ada09000009a9a0a9000b0a0a90000a00000000b000a0a09a0000090000a00000009ffffffefffffbfffbfdbdbdbdbf9ffdff9e9fbefdaff90fcb0f0dac0000090a0a000b00a0a0a00a0a000000009009000a00a0a00000a0adb00b000009009000ca0a9a0a0090009a0000900a0b00b0a0b0a000a09000000a90a000a0090a0000009fdffffffcffcbdfffffefeffffffbeffffedbdadbcff0bc0000000b0a0a00000a0009000000000009000a0a0a000a00b0000009a0000acb00a0a0a0a0a0b0b090ac90a0a90a000a00a00900a0009000d0a000a00a00900000a9000a0000000000af9fffffffffffffff9f9fffffffdbf9fffeffeff0e0cbc0000b0009000a9009a00a0a90a0b009a0a00000000a000000a009a000a00f90a090900000900000a009a09000a00b009a09a0a009a00a0a0a90a000900a00a0000000a00b00a00000900f9ffffffffe9f0fffffffadfbffeffffdfff0bf9f000a0a900a0a0a900a0000a000000000a00000b0090a000b0a0009a000a0900a0e900a0a9a90a0a0b0090a000a0a90a000a00a0009a000a090900a900a0a000000a000a090000909090000f0bc9bfffffffffffffffdfffffffffdebfc09e0e0cb009000a9000000a00a09000a0a00a00000a0000a0090a00900a000a090a0af90ca000000a000900a0a009a9090a900a0000090a000a0900a0a000a900090a00090a00a000a0a0a009a0000cbfcbcbf9ffffffffffffffcffdfea9f0f009fdb00f0a0a900a9a0a00090a0a0090000000a09000a0000a000a0a900a900a0000cab00b09a0000b00a0900b000e0a00a009a9a0a0000a90a0a000cb0000a00a000b00009000a090000a0000b0090ad0fcfffffdedfffffbdbfffe9fde0fca00bedf000000a00000900b0a0000a0a00b00a900a000000a000a9000a000a0000a90bd0a000a09a9a00b09a0a00b09ada909a0000900a900000009a9a0a9a0000000a00a00a000000a09000a9000b0ad0b0b0bca0fbfffef0fefcbc9e00bcb09cbcbfada9a9000b0a0a0a0000b0090000000000000a09a090a000a9a00b000b0a00ac0a090a00a0000b00a0c90b0fada9e0a000a00a000a0a0b0a0000000009a00a000000000a90a000a0b000a0a0090ac900cbdfbcb00909e90bcbc00bc9e0eb0bdada0000a0a009000000b000a0a0a00a00a0a000000000090ad009a000a0009a0bb00a09a900e9acbe9a9af0f9ffff09c0b09a009a00900009a0a9ada0a00009000b0a9a000000b00000a009000a090acb0000000000000000000f000a9090acbda9a0a00900a0a9a9a00a9e90000000000000b00a000a00a9a0be0be9000a000cf090a00a090a9bdbcb0dbffffffffa9a0ac09a000a0a0a00090e00090a00a00a000000b0a0a000b00090a00b00a0a90000000000000000000a00bcb0a0a09a0ac0009a0a090000000b00a9eb0b0a90a9009000000a009a00f00bdcbe9e90a909a0a090e90a09adbff0fffffffffffcf09cb0a00a9000900a0a009a0a090a00a00a0a000009000a00a0a000a0090090a9a9a0000000a0900b09cb00009009a090b0b000000a09a0a0000b0f9f00000a00a0a00a000000a0da0bfcbff0f0a000ae9e900a90a09adfffcbdbffffffffffa9eba0da900a9a0a900090a09c00a0900900900a000a0a0000000000000a00a0000000a0b090000a0000a0a0b0a0a0000a0000a00a000a0090a9adfbf0e0a0000000000000a90a09abdfcbffdffada9a0b000a90a09ca9abdfbf0fbffffffffbdf9fdfa00a000000a0b0a000a0b000a0a0a00a900b0000b009a00a9a0a00a00a9a00a090000a0b009ada909000009a0b00b0a000900b0000a0009a9fcb0900a00a0000a90000090ac9ebffffffdf0e000dba90a90a0b00dafbcbbedfbfbfffdfbfffffdad0a90a90000009a9000a9000000a000a00a00000a00090000900009000a90a0a0a0000a0a000a0a0a0a00000a00000b0a0000a9000a0a9e9bca000000000a0000a00a009ab9e9fdffffff9f00bc00a9e9cb00b09f0f0c9bfde9fbebfdffff9e9a000a00a9a0b0a00a0b0e0b0a9009a000000b000000a00000a009a0a09000000909a0f0909a900090090a00009a0b00000a0000a09000dada090a09a00a90000a00000a000e9ffffffff0e0a0ca9e90b0b00b0bf0f0dbbe9a9b0f9f9fbfffeda00b090b00000000b09000000000a0000a9a000a00a000a0a000a00000a0a0b00a0a0900a0a00a00a00a000a9a0000000b009a0a00a0a9a0b0f0a000090000a000000a0900f9fffffffbce9090b9a9af0f09ac9e9ffbef0dadadf9eb0bdffdbada00a0aca0a0b0b000a0a0b0a0a0000b00000000900900009000000a900000000000a0a00000009000000b0000a0a00a000a00009000009fff9f000a00a00000a09a000a0b0abfdfffedb0a0a0cf090a90e09a9bffff9ffbdbfbfbdada0bbedb009a909090900c0bcbc0900009009a000a00a0a0a000a0b000a90a00a0a9000a0b09090b0b00a0a0a0b0000a00090a90a0000a00a0a9a0a9ffe9e9000000a0000000090000bc9bffffdac90000ba9af9eb90a0ffffffff0fadfdffcb0bdfdbf0e9a00a0a0a0adabcb0a9a0b0a0a0a00a09009000000a00000a00a0900000a0b0000a0a00000a90000000a0a90a000000090a0090000009bfffff0a00a00000a90a00a0a0a90bedfefda0b0a9a09daf90b0ca9fbfffffda9f9fbffdbe9fbffffcb000a9e9c9adabdfbe9e0000900000900a0a00a00a00000a0000000a00a000000a000000a000000a90a09000090a00a00a09000a00a00bedf9f00000900a90000000000090ebdbf9fa0f000000eb09ebcb09a9ffffffff0a9ffffff9fffffffbc0b090babe9bdfffdf090b0a0a0b0a0a0000009009009a00b00a9a0000900b0a90a900b00b0a0a00a00a0a0a0a00a09a00a00a00b00b009bbe00a9a000000a00a09a009a0a90ebcf0da0a0a0009eb90b9e0a9adfffff0dbca9ffffffffffffdfbc00ac9dbdfffffffefa0009000000090a90a00a00a0000000000009a00a00000000a0000009009000900909000900009000900000000a0c09a900000a00000000000a0090a900b0a0909090a0f90e9e09a9cbbffffbfa09bfffffffffffffff0b0b0bbfffffffffff9cb0a0a9a0b0a0a00a00a00a00a00a00a00a0a00a00a00a00a00a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b09a9a00a00a000a00a00a00a00a0a9a0b0a9a0a0a0a00b0a9a09a00b9ffffff000b0fffffffffffffff9e00bdffffffffffff0a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000105000000000000b4ad05fe, N'Education includes a BA in psychology from Colorado State University in 1970.  She also completed "The Art of the Cold Call."  Nancy is a member of Toastmasters International.', 2, N'http://accweb/emmployees/davolio.bmp', 'Davolio@northwind.com', '123456789' ), 
( N'Fuller', N'Andrew', N'Vice President, Sales', N'Dr.', N'1952-02-19T00:00:00', N'1992-08-14T00:00:00', N'908 W. Capital Way', N'Tacoma', N'WA', N'98401', N'USA', N'(206) 555-9482', N'3457', 0x151c2f00020000000d000e0014002100ffffffff4269746d617020496d616765005061696e742e506963747572650001050000020000000700000050427275736800000000000000000020540000424d20540000000000007600000028000000c0000000df0000000100040000000000a0530000ce0e0000d80e0000000000000000000000000000000080000080000000808000800000008000800080800000c0c0c000808080000000ff0000ff000000ffff00ff000000ff00ff00ffff0000ffffff00f00000000000000000000000000000000000000000000000000000000000000000000000000009ffffffffffffffffffffffffffffffe000000c00bfe000000a9000ffffffffffcfffffffc009ffc00000000000000000000000000000000000f0000000000000000000000000000000000000000000000000000000000000000000000000009fffffffffffffffffffffffffffffffdb09f00000000fcbffe9e0bffffffffff0ffffffc09fffe0000000000000000000900000000000000000f000000000000000000000000000000000000000000000000000000000000000000000000000bfffffffffffffffffffffffffffffffffffe000009009f09ffc0bffffffffff0ffffffffefffc00000000000000000000000000000000000000f000000000000000000000000000000000000000000000000000000000000000000000000009ffffffffffffffffffffffffffffffffff0f0b00000ff0000000bfffffffffffdffffff0f9fe0000000000000000000000000000000900000000f00000000000000000000000000000000000000000000000000000000000000000000000000fffffffffffffffffffffffffffffffffe09fffc0a9f0000fc00bfffffffffffebffffcffefc00000000000000000000900000090000000000000f0000000000000000000000000000000000000000000000000000000000000000000000000bffffffffffffffffffffffffffffffffff009cbe09c00000000bfffffffffffffdfffcbfc90000000000000000000000000000000000000000000f0000000000000000000000000000000000000000000000000000000000000000000000009fffffffffffffffffffffffffffffffffffc0009ff0bfa9f0a9bfffffffffffffeffffffc000000000000000009000000000000000000000000000f000000000000000000000000000000000000000000000000000000000000000000000000fffffffffffffffffffffffffffffffffffff009fcbc0dffffdffffffffffffffff9f0fc000000000000000000c0000000000000000000000000000f000000000000000000000000000000000000000000000000000000000000000000000009ffffffffffffffffffffffffffffffffffff00af0000000000bfffffffffffffffefe0000000000000000000d000000000000000000000000000000f00000000000000000000000000000000000000000000000000000000000000000000009ffffffffffffffffffffffffffffffffffffffe9fc00bf0090bffffffffffffffffdfc00000000000000000c00000000000000000000000000000000f0000000000000000000000000000000000000000000000000000000000000000000000fffffffffffffffffffffffffffffffffffffffd09ebfc9adafffffffffffffffffffe000000000000000000000000000000000000000000000000000f000000000000000000000000000000000000000000000000000000000000000000000bffffffffffffffffffffffffffffffffffffff00000000009fffffffffffffffffffc00000000000000009c0000000000000000000000000000000000f000000000000000000000000000000000000000000000000000000000000000000009fffffffffffffffffffffffffffffffffffffffff0bfdbfffffffffffffffffffffff00000000000000090000000000000000000000000000000000000f00000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000f0000000000000000000000000000000000000000000000000000000000000000000bfffffffffffffffffffffffffffffffffffffff9f9fdb9fffffffffffffffffffffffe00000000000000000000000000000000000000000000000000000f000000000000000000000000000000000000000000000000000000000000000000bffffffffffffffffffffffffffffffffffffdfdbfffbfff99fffffffffffffffffffffc00000009000000000000000000000000000000000000000000000f000000000000000000000000000000000000000000000000000000000000000009fffffffffffffffffffffffffffffffffffdbbfff9fdfbdfff9bfffffffffffffffffff000000000000000000000000000000000000000000000000000000f00000000000000000000000000000000000000000000000000000000000000000fffffffffffffffffffffffffffffffff9fbffdfbdffbfffbffff9ffffffffffffffffff0000000000000000000000000090a0009cb0da9a9af9e9be900a00f0000000000000000000000000000000000000000000000000000000000000000bfffffffffffffffffffffffffffffff9ffffffbffbfbfdfbfffff9bffffffffffffffffe00000000000000009ca90a90f00c90bda9ada9ff9f9e9bd9b0c9c0f0000000000000000000000000000000000000000000000000000000000000009ffffffffffffffffffffffffffffff9ffffbdfff9fd0f9f9dfbfffff9fffffffffffffffc0000000000000dada99e09cb0f9bcbdad9f9bdb0bcb9adafcb9a9ff000000000000000000000000000000000000000000000000000000000000000fffffffffffffffffffffffffffdfbffbf9ffbda9f0ad0b0a09db9bfffbffffffffffffffe0900000009cb0b9bda99f9bdb0f9b0b9ab0f9adf9bdadb99bcbda9f00000000000000000000000000000000000000000000000000000000000000bfffffffffffffffffffffffffdbfbfdbfcf0f0fdfcbdad0d9f0befdfbffffffffffffffffc000000000009cbcf0bcb0f0bdb9e9f9e9db9e9b0f0bdb0fe9b9adbf0000000000000000000000000000000000000000000000000000000000000bffffffffffffffffffffffffdbffff9ff0f9ffbcb0bd0f9a9e00d090bdfbffffffffffffffc0000000c0b9fb9b9bdb9f9bda9e9b9e99a9e9adf99f9adb99f0f9ef0000000000000000000000000000000000000000000000000000000000009fffffffffffffffffffffffbdbdbdadeadbda9c9f9f0fbdada9db0f0f9e9dbfff9fffffffffe000000b09da9cbcf09e9a9e9f9bd0f9adbdb9f9a9e9adadbe9f0f9f000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffbe9fbfbe9fdbdbcbcbfbc9e9f9e0dbda0db09e09e9cb9fffffffffffc00009000a9fb99b9f09f9f9b0f0b99e9adada9e9f9f9b9ad9a9b0ff00000000000000000000000000000000000000000000000000000000000bfffffffffffffffffdf9fdfbcdfdada9e90b9c9cbfbcbfdbf0f9fbc9e99e9ad0ffff9fffffffe0000c0dbdb0dad0f0bc9bcbcf9bcbc9bdb9bdb9f0b0f0f9be9e9f9f00000000000000000000000000000000000000000000000000000000009ffffffffffffffffdbbbffb9cfb0bcb0f09fde9fa90db9cbd0f9e9cbf99e90f9a90bff9ffffffc00000b9a9adb9bf0bdbbcb9b9bcbdbbda9eda9e9b9f9f0bc9b9f9af0000000000000000000000000000000000000000000000000000000009ffffffffffffff9f9bdfcb0dcb0dbc9dbdbf0a9e99ff0fcb0fb9e9fbc9eb0f09edbcf9bf9bffff000909cbdbdb0f09bcb0dbdadadb9a9cbdb9b9f9e9e9a9bdbfcb0f9f9f0f0d000000000000000000000000000000000000000000000000000ffffffffffffd9bf9ffb9fcb0bcb0dbe9e90dbdb9e09cb09ad0dbda9dbd9c99e99e9b0f0fffffffc0f0a9bcbcbcb9f0b9db0b0f9b9e9db9b0f0da9f9f9f9e9a9b9db0ff9f99bbf990c000000000000000000000000000000000000000000000fffffffffffb0bff0fbcdadbc9e9bcb0d09af09e0d9f9a9f0da9e09d0a00f0bcbda9f0f0f0fb9fff00009cbdb9f9bcbdf0b0f9f90fcbcb0f0f9bf9f0bcb0f9f9f9eb0f9fb0bdafdbcf9ad09a0cbcb0000000000000000000000000000000000bfffffffff0bd9ff9f9c9ada09f09c9cb0bfd09e99fa9ad9e9f9f99f0f9f99bd9b0fd0ff9f9e9ffff009ada9b0f0bcb9b0b0f9e9af9b9b9f0b90f90b9f9bdb0bcbcb9db0f9f0bd9a9b0f90f0db909ff000000000000000000000000000000009fffffffbc9f9ef9f0f0bc9a9da99e9a9cbd0bfd9e90dfda9f9bcbcbcbdbcbedbedf9bf99f0f9e9bffc00009c9f9bdb9e9f9d0b9f90f9e9e9f0db0fbcf0bcbc9f9bfc9a9fbcbdabdbc9b9eb9badbfa9af0000000000000000000000000000000ffffffe90bdadbf9e90d0bc9e90e90f0f90bd0ba9ffb9a9f9e9f9f9f9f0dbdbcb9fbe9ef0bf9e9e9ff009090b0bcb0d9bcba9bcb0f9bcb99a9f0bd09b9f9b9ba9e99be9a9ff909dadb0db9dad9bc9dbd9c00000000000000000000000000000fffffd09bdfb9f0bc9e9a9c9a90f9cb090bda9f9df09fd9fdadbcbdbde9bfbdfbdcbd9db9fdffbfd9fe000e000d0b9fbadbddadb9f0bcbdad9f0bcbfbcb9e9e9db9fad9bdbf9a9fab90da9f0b9adb9be9abc000000000000000000000000000bffffcb9bcfb0fd0d0a909cb09cb9cb0fdbcbdf9ebdbf0be9bdbdbf9e9bffd0fbdfbf0fb0dbf0ffdbe90009090b0b0db0d9a9a99edad9bda9bab9f9b9cb9e9f9f0bcbdbada9f9da9d9e9b9e9bc9fa9e99f9cbc00000000000000000000000009fffe99dadb0df0b0bd00f0b0fa9c0b9db0dbda9f90f9fffdbdbffdff9fdbdbf9fbfdbff9fbcbf9faf9fbc000ac00c9adb0bdbdadb9b0f0bdad9cf0bcfbdf9b0b0f9bdad9bdafabdabd9adb9e9bc9f99e9af99b0000000000000000000000000fff99ebdbdfb09e9c00f09fc90dbdb0f0dbadbd0bff9f99fbffdb9b9ffbdfbdbf9f9fdbdfdbddffdffafdbf090090009a9f0bcb9adadb9f0bdab9bdb9f0b0fdbdb0bcb9ad0bdf9da9dabd0bdbd0b0f9e9bd9ad0f00000000000000000000000bff09e99adb0db0009a99f009bdbcb0f9a9cdbcbfdbdf0ff9bdbfdffff9ffbdffdfffbfffbffba9fbf9f9fcbc009a090e9c9bdb9cb9f9cb9f909dadada9f9f9adadbdbf0f0bcbbda9fa9d0bcb9ab9f9a9bcbe9bf9b0000000000000000000009fe09f9dad9ada0d0f0d9e09ff0f0b9f9e9dba9dbdb9ebfdbfdffdbf9f9fff9fbfbf9ffdbdff9fdfbdffdafbfb0000000909ada9cbbcb0bbcbcbeb9bdb9f9e9adb9bc9a9f9bdb9dbda9dbaf9bcbd0da9f0db99e90d0f00000000000000000000ff99bcb0f0e90da090b0a9db09f9fde9e9da9debdadffdbfdbfbfbffffff9fffffdfbdfbff9ffff9ffbdbfdbcff009cb00ac99fb9c9bdbc9f9b990fcb0f0f9bdb0f09bdf0bc9adfcb9e9d90f9bda9bda9f0da99eb9bcb000000000000000000bf00db0db9b0f0090bc9d0bcbda9a9b9e9a9fbf9f9fb9fbdbfdfdfdff9fffffffdfffffdfbffbdbfbfdbefbffbd9f00000900ac9fabc9adb0bc9e9b9bdb9f0f0f9f0fa9a9f9bf9afb9e9bebd0bdadbcb9f0b9f0f99e9bdf00000000000000000fc0bd0f90d0d00f0d09a9f9bdadbdf0f9f9f0d0f9fbdffdf9ffbfbfbffff9ff9ffbfdffbfdffdfffffff9fdbdfbebf0090c0909b0d9b9f90f9bf0bcbcb0f9bdb9e9bd0f9f0f09e9f9e99e990bdadb0b9e99bdadb9e99f0b0000000000000000bf0bda99ada0b0909a9f0f09e9fbcb9f9cbc9fbf9fbdfbdabdbfdffdfdf9ffbffffffbf9ffffbfbfdffdbffbfebffdf0000b00a9adba9e9e9b0f09dbdb9f9ada9e9bda9bdadb9e9fdb90f9bcbcbdb0dadbcbcb990f9ea9f9f000000000000000fc0dadbc9009c9e0f9cb9f9f9f09fdadbf9fbdbdff9ebdbfdbdbff9fbfffffdf9f9fdfffffbfdfffbffbfffdbdf9faff0000909c9a9dbdb9e9f9f9a9bcf0fdb9f9f0bdbcb9f0f9b0bedb0f0b090bdb9db0bdbdaf9a99da9ebc9000000000000bfc09d09ad0da0099a0bcb0f0f9f9bdf9cbf9e9f09ff9ff9fbdbdbff9fdf9f9fffbffbdfbdffffbdffffffdbffbdfbdbdf0900c0009e9a9e99a9e9f9e9b9b0bcf0f9f9a9bda9b0f9ff9b0f9bd0bdb0f0bdbd09ad9e9f0b9f999ac00000000000fe09a9bc90b0090f0d9dbdbdbdbfcfbb9b9c9bdbff9fdbdbdbdbdf9bdbfbffff9fdbdffbffbdf9ffbdbfbdfffdffbdffbfe00b09a9c90db9f0dbdb0b9f0f0f9b9bda9e9f0bdbcb9e9fb0f9bc0bcb0f9bcbda9bf9a9b0f9e9adadb0000000000ff0da9f09000c9e9adb9eb0fbdaf9bbfcffcbbdadbdbcb9f9fdbda9fdbf9ffdb9ffbdbfbfdbffbffbfffdffbfbfbbdbff9ff0000000b0fbadadb0b0f9e9f9f9bcbcb9f9f0bdbcb9e9bdf99adbd09bdbcbbdbdad0bd0f909bdb090bd000000000fff09c9e09e9b09f09af99f0f9f9fddbdb9bdfdbdfbdbdfbdadf9bdb9f9f9fbdfbdffdbfdbdfbdbdfdbffbffdffdfff0ffbdf0000d00909db9a9f9f0f9f9a9adbdb0f0f09e9bfcb9bcbcf9da9a9cbdb9d0b0bdbdabd0fbc9adbdbcb9000000009ffc9b0900000f09f9dbe9f9ff9fabdbbcff9be9bc9ffbdbd9b0fdadbdbdf9ff9fbdbfdfbfbdfffbfbfbfffbfbfbf9ff9ffbff090a09e9a9e9d0bcb90b0f9f9f0f9f9b9fb9e9bdbcbbfb9a9dbda90bcb0bdbda9bd0b9909bdb0b09f0e00000000bca09f0c90d090f0fbc9f9f0bfddfbfc99bedbfdbf9d9ebfbdb9f9bdbdb9ff9fdfbdbfbdfffbdbdfdfdf9ffffdf9fb9ff0fdf000900009f9f0bdb9e9f9bcbcbb9e9ada90f9f9adbd0f9e9fada9cbdbdbcbd0b9e9bdbe9af9e9c9fb09000000000099f00b0b0be9bdbc9f0bf9f0bbbdf9bffdbdb9f9fbbf9c9f9f99fd0bdfb9ffbfffffdf9fbdfbffbfbffff9fbfff9ff9fbfbc0000d09e9b0bda9e9da9e9b9bcf99f9f9f9adadbe9ff9b099bd0b9e9a99a9f0dbc9a99f90f9b0a9cbc0000000000cb0b000dbc9cbc9bfbfc9f9ffddf9ff9bbfbdfbf9fd9fbf9f9ffbbdb999f9f9f9f9bfbfdbbfdbdffffffffffbffffbffffff009a0a09cbd0b9f9a9bdb0dadb9af0bcb0f9bf9bda9fedbcbcbd09bdbcbda9f0b9e9e90f9ad9d9b99bc900000009ad9c0da09bf99bfdbd9fbff9bfbbf9ffdfdbf9f9fbfbdbdb9f9fd9f9ff9f9f9dbdfd9f9fdfbfffbdbff9fbfdfdbffdbbfdbff009009a9ebd0f0f9adadb9f9e9dbdb9e9adb0f0bdadb90b9f9a9e9bc9a9f90bda99bdb0bdb0badaf09ac000000099a0909dad0f0f9bcbfbdadff9fdbfbdbfbdbfff9fdfbdbff9f9bf9f09f0f9ebdb9ff9ffbfffbffffdbffffbfbf9fbfdfbfff000c900999a9bdb0dbdb0f0b9fa9adb9f9bdb9f9e9fbcb9e9a9cb9e9b9db0bda9fbcb09cb0f0d9f99e900000009cbc0b0f0b9f9fdadf9fdbdbf9fdbfbdbdfdfff99bdbbdbdf9fbffd9f9f9f9f99f9ff9bfbdbdffbfbffffbdbdff9fffdfbdfff000b00b0fad0f0bcba9adbdbcbdbdb0f0f0f0f0f9bf99e99bda99f9e9eb0f09f909f9e9bdb99ab9cb9f90900000b909c99bc9a9fbdbbdbf9bf9ffbfdfffbfb9f9fffbdfbffbf9f9fbfdbdbdb0ff9f9fbfdffffbdffdffbdffff9fbdbfbffff9ff00000c909bb9f9bd9fda9adb9bda9f9b9bdb9f0bcbe99e9e99e0b9bd9f9bda9fb0b99e9adad9cbbcb0f0a90009cbca9ac0f9fd0f0dfbfdf9ff9bdff9f9ffdbff9f9fbfdbdbffff9fbbdbdbd99bdbc9dbf9fbffffbfbdffbdbfbffffdffffbfffb09c90ad0d0f0f0b0b9f9f9e9ebdb0f0f9bcb9f9bfdbc9b9bc9bdada9a9e99f0dbde99bdb9b0b9cb9f9f9cb909b9090d9b9f0bbdbf9f9fbfbdffbfbfbfbdff9bfff9fdbfbfdbf9ffdfbdadbc9cb9bfbdbfdffffbfffbfbffbdfdfbffbf9ffffbc00a0090b0b9f9e9f9e9a9e9fdb0fdbd0bcbda9e9fb09be9e9bdadb9f9f99eb9bf0b9adada0dbcb9e9a90b0c0bda09e9adadbdfdbdbffbd9fffbdbdbdfdbf9ffdb9fdbf9fdbfdbf9f9dbdbdbfb9fdbdbdfbffbfdf9fdfdfbdfbfbfdbdfffff9ff009090bc9bcb09b9e9bdbdb9a9f9a9abdbda9f9ff9dad9f9da9dbc9adbcb9cbc9bdadbdbd9a9bd0bdbdbdb90dad009f9f9f0b9fa9dbdfbfdbdfffffffbfdbdbfdbfbdffbffdbdfbfffbdbdbd9fdbdbdbfdbdfffbffbfbdfbffffffffbffbffff0000e00b0f9f9f0f9f0bcb0f9f0f9f9dbcb9f0b0ffa9a9ba9da9bbd9a9bcb9fbda99a9a9ad9cb9f0bcb0bcb0990da9cb0f9fdadfbfdbdfbffbdbffbfdfbfbf9bff9fb9fdbdbfbdbdbd99f9dbdbdbd9fd9bfbffff9fdbffbdbdbdbfbfdfbdfbfff0090909c9a9e9b0f9f9bdb0f9f0f0f0bbcb9fdbf09f9fc9da9f0da9dbcb9e90bdbc9dbd9a9b9e99f99f9900be9a9cbdb9e9bfbfdbfffbdf9fbff9ffbfffdffbd9fbdf9fbff9fbdb9ffffffff9f9fb9bfdfffffbffbfdbdffffffffffbfffffbf0000ac9a9f9b9cb9e9e9adb9eb9fb9bdfbda9adf9f09a9ba9fbdb9eb0b9cb9bcbcb9be9a9cbc9bf0bf0f0f9c90c9b9cbd9fd9d9bfdb9ffbffdfffffffbdbb9dbfbdfbbfdb9f0df9fdbffdbdfdbf9dffdbfff9fff9bdbfffbf9ff9ffbffffffff00090909cbcbcb9f9f9bdb0f99f09e9e90bdbdbfb0dbdbc9cbdada9dbc9bde9f9bdad9bda99bf09f09b0909bcb9acb9faf9bfbfdbfff9fdbfbfbfbfbdfffdfbdf9f9fd9f0d9b9fd9bdb9f9bf9fdfbdbfffffe99fffdbfbfdffffffdfffbf9fff900c0a0b9bda9cb9e9adadbdbe9bf9f9bfcbcb0bcba9adb9b0f9bda9f9e9b9a9e9bdaf09dad90f09f0dbd09f00d9bcb9dbcf9fbf9f9dfbbdfffdffdfbfbffbdbbf9fbf09b9d9f9bd9fdbdfdbdbf9ffdfffff9009f9bd9fbbfbfbfbfffffffbdfe09a90c0f0bdb9e9bdb9f0b0f9f0f0bcb9bdbdbdf9dbdbcadb9fe99f0b99e9db9f0b99fb09b0f9bda9b0b0fb09a0dbdbbdb9e9ff9ffb9fdfbf9fbdbfffdfbdbdfdbd9dbd9cb99bdbf9bdb9fdb9dbd9bd990000909adbf9dfdfdffffbf9fffffbf00000909bda9e9bcbcf0f9f9adb9f9bde9a9adfa9adadb9b9f099e9bd0f9fb0f0bdbe909e9f9bcb9f09cb9c9e9dbf0fda9fdbf9fbfdfdbfffffffff9ffbdf9f900000909b9cbd9d99c90909090900909009dbdcbd9f9ffbffbfdffffffbfffff009cb0b9e9bd9adbdb9b9f0bdb0f0bcb9bdbdaf9c9b9ad0dadbda9ada9af0db9f9ad9bda90bcb9e90db09f0099a9dbf9ff9bfdbf9bfbffbdffbdbffff9fbdb900b090900909009000909c9ad09099cb09f9bdbbdbfbff9f9ffbfbf9fffdfbfff000000cb9e9adbdba9e9e9fda9f9bdb9fcbcb9fbbc9f9b9bdb0bd09bd99bf0f0bdbbcb9dbdb9cb9e90090bf9ad9f0fdb9edbdbdffdbdbdffbffff9ffbfdfbda9d9bdb0d90d0909b9dbd9bd99f9f9f9dbd9f9fdbf9fdfbfbf9fffffffffbfffbfc09a9090f9f9a9ad9f9f9b0bda9e9ada9b9bcbfc9ba9f0f0bdf9a9f0b0f09b9f909cb9e90b0fb9e90000fd00dabcb9bdf9bdbfbfbfdbfbffffffbffbdfbf9f9fbfdbdf9bdb9dbd9f99bd9f9f9bdbdbbdfbdfbff9ffbffdffff9f9fbfbffff9ffb00c0a0f0b0f9f9be9a9e9ff9bdbdb9f9e9e99b9bc9cb90bda9ad90b0dbdbfcbcbfb9e90f9db9c9000099b09b9db9f0f9bdbf9dbdffbfdfbdbf9fdbdbff9f9fbfdbf9bfdb9fbdbdbdbdfbd9dbd9f9ddbf9fbdf9ff9ff9fbdbfffffdfffdbffffc09a9099bdf9e9bc9f9f9bcb0f0f0bcbcb9bcbfd09bbdad0b9f90fbd9a9bc9bdb090f9f90abc9b9f9f90e90bc9adf9fcbff0ffbff9f9fbfffffffbfff9fffffdbfdffdbfdf9dbdbdbdbdfffbdfbdbfbdbfffbff9ffffffffff9fbfbffbffffbff00000cbcb0b9f9fa9a9adb9f9b9bdbdb0fcb0bebc9cb9b9cb0f909ad9e9bf0bcb9f0b0f9d9bd9fdf9f99e9cbf9a9e9bd0fbd9dbfbff9fdbfdbdfdb9ff9fbfdbdbf9f9f9fff9ffdbdffffffffbdff9fffffff9ffbfdbfdbfdbfdfdfbffff9ffbf009cb00bdbcb0f9fdbd9adf0f0f0b0bdb9bdbf99b0b9e9cb9f9e9f9ba9f09f9b9e9bdb09a9dbffbffff090a90f9f9f9bf9fbff9fddbffbfbffbfbfff9fffdbff9fffbdbf9ff9f9ffbfb9f9dbdfbdfffbffffff9fdbfffffbffbfbfdffbfffbdff000009b0f9f9fa9adabdb9f9f9bdbdadada9f0f0d9e90b9e9a99a9c9da9fbcbcb9e90dad9ff9dffdbf90f9df9e9ebdf9f9dbdfbfbbf9fdfbdf9fdf9ffbdbfdbffb9ff9f9f9f9bf9fbdfbdbff9fffbfdfdbff9ffbff9fbfff9f9fffbfffbfffff09a09f0f9b0fbd9f9bd9af9e9adaf0f9b9f0db09ab9f9cb9f9e9dab0bdb0db99cb9f9b9bf9ffbdbffdf09e9ad9b9cb9f0fbfbf9fdffffbdfbfffbffbdffbdbdbfdf9ff9fbf9ff9fdf9fdbf9fbfbfdbffbf9fff9f9fffdf9fffffbffdfffdfbffc09c009bc9fbcbe9adaf9e9b9f9bdb0f0f0bbdbc9da9a9e90b9a9d9f0bdb0fa9bcb0f0d9ff9ffbdbfff909f9ad9fbde9f9fd9ff9bf9fffbdbdbfdbdfbdbdbffd9bdbdbf9dbf9ffbfffbfdfffdfdbdfbfdbff9fffff9fbff9ff9ffffffbffbffff0090bc0bb0dbdbd9bd9f9f0f0f0bdb9f9f9fb09b0f9c99bdbc9f0b0bda9f9dadb9f99fbdbf9bdf9fbf0db0bdbc9f9bdbf9bff9ff9ff9bdffff9fbfbfbfffdbbfd9e9f9ebdbff9ff09ffbffdbfbffbdbfdf9fbdbdbfffdbfbdfbdbfbffffff9ff00a009bd0fb9f9af0ba9e9bdb9f9f0f0bcbf0db0db0b9bcb09b0f09da9db0bdb9e90ff9dbdfff9dbfd0b0fdbcbbf9f9f9ffdb9f9ff9ffffbdbfbdffdfdf9fbddbf99dbd9f9f9ff9fbdbdb9bfd9f9ffdbf9fbdffffdbdbffdbffff9fffbffffffc090f0da9bdeb0f9f9df9bcb0f0f0b9fdb9db9cbb0d9e9bdbc9f9fa9f9adbcb0f9db9dbdb9f9ffbdf0dbd9adb9d0bdbfe9bbfdbf9ffbdbdfbdbdbdbfbfbf9ffbdbbfbdbf9e9fbdf9dbf9fdfdbfbf9fbdff9ffb9fbffbfdbffbdffffffff9fbfff0000b0fbcbbdf9b0fab0f9f9bdbbcf0bcfada9c9ba99adb0b0b09da9f9a9bdb0b09fbffdbff9ffbfb00bdb0dabdf0f99fd9fbdbf9ffbfbfdbfffbd9fdfdbd9fbdfdf0dbdb9d9bfff9efbfbfdbdffdbfbdf9ffffdbdf9fdbdfbfbffbffffff9ffa0900909bd9a9e9f9dbda9bcb0d9b9f9b9fbd0b9c9f0d9ad9c9f9a9f09dbcb0dbdbd99bff9fff9fdc9f09f0bd9a9f9ff9fbdfbfdbf9fdf9ffdbdfffbbfbfffbdbdb9fb0f9fbfd9f9f99dbdfbfffbfdbdbffbdbdbffbfbfffbfdfffffffffbdbfc000dadbcbf9f9f9ebdb9f0f9fbeda9e9ef90b9e9b09bad9a9b9e9f09fb0b9da9bdbfffdffbfffdb0b09f0bdbe9f9bf9fbdbbddbfdfffbff9ffb99bdf9ff9f9f9fbdbdf9fdbdbfff09cb0f9fffbd9ffffdbdffbdf9fdfdfbdfffffffffbffd9ff009a090bf0f0b0fb9e9cb9b9ad9b9f9f99e9c99ad9ad9b0dada90bdb0d9f0b9fdfdbdbf9fff9fbf09fe9f9e99f9fcbfbdbfdbbdbf9f9f9ffbdffffdbf9ff9f9f9f9db99bfdbfd99f9b9dbf999ffbdbdbfffb9fbfffbfbdffbfbffbffffffbfff000090f9db9f9f9adbfb0f0f9be9e9e9bf9a9eb9ad9ad0b09bdbd0bdba9ada9bbfff9f9ff9fffdbd009adb9e9da9f9fcbdbfdbf9ffbfff9ffbdf9bf9dbfbffbf9fe9dbfd9bdbf009fdb9dbfc0909bdbdbdfffdf9f9fffbfdfffffffffbffffbfd009e90abda9e9f9f09f9bdbc9bdb9f0ffe9099e99adbbdbc909a9f09dbd99dfdbdbf9ffbff909f0bdbdb0d9be9fbdb9fbdbf9ffbdfdbdff9ffbff9ff9fdfbdff99b09dbc0009db9b9ffbdfb99f9dbf9ff9bdbbfffbdfffbfffffffffffbdbdfe09a00f9dbbdb9e9bff0bcb0bf0bcb9f9b99f9e9dada9c90b0bf9f0bcb09a9fbf9ff9df9fc909fb0dad0fd9be9f9dbfdbdbf9ff9dbfbff9fff9ff9fbdb9fbdfb90f9fdb09b9d9ad9ffdbdbbfff9fbffffb9fffdfdbdbf9fffffffffffffffffff0000909afcb0f9bcb99f9f9f9fdb9e9bfcb0b9b09bdb9ad9f090bd9bdbc9fbdff9ffa9f9909bfda9b9b0bad99bfbf9bff9ff9fbfbdf9fffbff9ffdfbdf9fbdfdf9ffbdbdbdbd9bfd9fffdff9ffffffdbdfb9bfbfffffffdbffffffbfffbdbfff0090e9bf9bdf9e9bcbe9bcb0fa9adb0f9f0d0f0f09bcb9a99f9f0bc9a9a99ff9dbffdb9dbfdbfc9cbde9c9be9da9ffd9bf9ff9fdfbfff9ffdffffbdfbdbbdf9bdbdbdbffdbcbd9fbffbfbdff9bfffff9bddfdfff9fdbdfffbfffffffffff9fff90e900d0f0b0bdbdbdbcb9f99fbdadb9fb9a99b9ada9f0da90b09f9adbd9ff9fbff99dbfff9ff9a9da9dbfc9fbdf9bfff9f9bfbf9fdbffffbfff9ffbdbddbbfdb9fbdfd9bf99bf9fffdffbffffffff99fbbffbdbfffffbffffffffffffff9bffc0909a9b9f9f9adabf9bda9af9fbdbcbf90dbcbc9b9f09b9cbd9f9ad9b0bfbdbdbd9fbdff9ffd09da9be999bf9f9ffdb9fbfdffdffbdbdbdfff9ff9ff9fbfdf09fd9fb9ffd9ff9fffff9ffffffffff9fffdf9fffdfbf9fffffffffffbffbdffbf00ac09edada9f9bd09e9f9f9e9cb0bdbcb90b09f0f0f0da90b0bc9b0d9fddbffd9bdfbfffdbf0b0dbd9bcbdbcbf9fbdfbdfbdbf9f9ffffbdffffffdbff99f9f99ff99f90bf9ff9ff9ffdbffffbff9ff9ffbff9fbfffffffffffffffffff9fdff0909a9b9b9bdaf0bff9bcb0f9fb9fdbfbcbdbda99b99b09f9c99bc9ba9bfb9ffbf9bdf9ffbff9cbbcbe9f9adbdbf9fbdfbdfbdbfdf9f9fff9fbdffff9ffbdbdb09bfdbdbdbf9ff9fbdbdffffffffb9ff9ffffffffdbffffffffffffffff9ffffa0009cadada9dbd90bcb9f9bf0f0b0ff99090b9cbcbc0f90b9be99ad9ffd9fffdffdbfffb9fd009c999f09f9fbdfbdbf9fbfdff9fbfffbdbffdfbfbdff9fffbd9f99bcbdbd9f99ffdbffbffbdbf9fffbfff9ffdbffffdfbfffffffffbffbffbfd09e099bdbdba9affb9f0bcb0f9fdb9bda9eb9cb09b9b90f0f099e99bdb9bdffb9f9fdbfdfff0bdb0ff0bf0f99fbdbfdbdfdbbdbffdb9ffffffbfdffbf9fdbd9f09fdb9f9dbf9ffdbfdbffffffff9fbfdfbffbfffdbfffffffffffbfffbdf9fff0009a9e9a9f9f9f90f0bdb9f9e9a9ff9c99c9a99f0d0cb990bcb90f9ff9fbffdfbdbff9f99f090fb09f9db9ffbdbdfbfbfbdfbd99fffdbdf9fdbfbdfdfbfffbdbda9c9f9a9dbdbfdbfffffffbdbffdfbdfffdbffbffffffffffffffffdbff9ff0090cb9f9e9e9f0bf9f9adbe9bbde9eb9a0bd9e90b9b9cb0f99adb09bdf9fffbdfbdfffbff9f0d9f9f9ebdb9f9ffbd9fdbfbdfffbdbdfffbfbfdfffbf9f9fbdbdbdbb90f9f9fbdbfdbfffffffffffbffbf9ffffdfffbfffffffffffffbffdbff9a0a90f0b9f9a9fdadadb0dbcda9bff9c9d0b090f9e90b9d0b0d099fff09fbfff9f9bfdf09f09a90f9f99bcb9fbdfbf9bfdffbdbdbfbf9bdffdbf9fdffbffdfffdbddf99f9f9dbf9ffffffbfffff9ffdffff9ffbfffffffffffffffffffdf9ff0d090f9bd0bfdf9adb9bcbbdbbdbcbf90b0b9dadb090bd0b09da90f9b99fbdfffff9fff99f00dbdbda90fdbdff9f9fbdfdbdbdffffdbdbdfbdbfbdbbf9fd9bfbf9f9ab9fdf9fbfdfbdfffffffffffbfbffffffbffbfffffffbffffbffbffbdbff0009b0f0ff9b0bf9ade9bda9cbcbdbe9cbcb0909dbc0bd0f9a9a99fdff9ffffbdbd9ffcb9f9a90f9bf9b9f9b9fbf9fdbfbfffbff9bdfbfbdbf9ffdf9f9bf9fdbf9f9df9b9bdf9f9fbfffffffbdfbdfdbfdbffdbdffffffffffbffffff0bdbffc09acbdb9b9e9fd0f9b9adbdfb9f9bd9a999ada9a99b09a900d9d09bf9f9bfbdffdb0bfd9f00dbdbc9fd0b9fdbdbdbfbdbdbdbdbdffbdfdf9dff9bff9ffdbdbf9fbdb0bd9f9bdb9f9fbffff9fff9ffbfdfbfdbffbfdbffbffffdfffbffc99dbffe0909bcbcbf9abf9e9f9a9a9f0bcbbf90e9d09c90e9dada9b9a00bff9fd99ffbfbfd99bf00009e9b99ad9ebbdff9f9fdbffbdffbfdfbfbffbf9fdbdbf9b9f9dbfdbdfdbcbdfbfdbdfffffbff9bff9ffbbdbff9ffffffbffffffbffffff09bffd090ada9f9b0f9f0f9f0f9ff9adb9ff0cb99a9b0bf9b0999c9c9b99ff9f9bffbdfffff0f900c9bdbdf0f9bd9cfb9fbdbbfdbdbf9f9fbdbdb9f9f9fbff9fdf9fb9f9bdb99f9f99dbffbffffdf9fff9ff9fdfda9fdbf9ffdfff9ffffffff009dff0f00db9f9adf9f9f9a9b0f90bdb0f9db90be9c0d9090bcb0b0bc009bf9fd0bdff9ffbdf9f09009ada9b9f9fbb9fd9fbdfdbfffdfbff9f9fdf9f9f9f9ffbfbf9dbdbc9bcb9f9fbff99fffbfb9fbd9f9ada9b9f9fbdbfbfbffffbfffbfbff09bff00a9a9f0bdb0f0f0f9e9f0fbdadbcbbcbd09b9a0f9ad09c9c99b909ffdbf99bbdf9ff9bf00000999fddbda9df9bf9fdbbf9f9bbd9bdadb0b0f9ebf9f9bdbdbf9f0fbcbdf9dbdf9fffbffffdbdfbfcf9bdfdb9f9fbdbdffdbffffffffff0099ff0d009e9fcbf9bbf9bcb09b9e9f0b9fdb00bc9c990bda9b9a9ad0d09bf9fdbdfdfbff0bfd00e900f99a9f09fb9fdbffbdfbfbfdfbfdbdbdbdf9bd99dbfdbdbdff9f99f9b9fbdb9fbdfffff0bff9e9bdbdb9bdbf9f9ffbffbfffbffffffbf090ff0009e9b9bdaf0dbfcbdbcbdfb9fda9bc9bd9b0b0bd090dad0909a90ffdbfd9bfbfdf9df00900e9bcfbdb9f9fdbbfdb9f9d9fdbb9da9f9f9f9bdb9eb099bfdbdb9f9f9bfdadbdff9fbfffd9fc9bd9f9bdbfffffffffbfdbff9ffffbffffc9ffbf0a9e9bcbcbd9fbf0b9b0bdab0f0b9ffbc00b0d0d9a9f0b909cbd009bff9f9e9ffffdbfb0000900db9dbcf9e9bdbdbdf9fbf9bc9fbdb9fbdbffbdf9dbdad9afbfdbdbc9dbdbdbdbff9bffadbb9f9f9bdbdf9bdbfffffbfffffbffffffff0b9ffdc909bdbdb9fa9cbdbdad0bdbdbdadbdb99adb0b0f9090da9a90b90f99ff9f99fffb9fdad000e09adabdb9f9f9f9ffbf9dbdf9bf0dbdbdbfdbdfbdbf9bdbd99dbbdadb9bdbdbdbdbdffff90dfbdbd9ffdbffd909a9ffff9909f9fffffffad0bfa9e9adadada9ffb9e9adb0dadadbdadf9e0990d0900f0b99c90bc090bff99fdbbdbdf0bd00009009b9da9f9fbdbfdbdfbf9baf0db9bcbdbdbdb0dbd99dbdbbf9fdbdbde9bdbfbdbffbff09fbfdadbfffffd90bdbdfbd0000bdbfbffffff00bfada90d9bf9bdf0bde9bda9f9b9f9af9bf009bcb0b0db90d0f0bc99b0b9df9ff99cbdf9bda0000009dedb9f9ad9fbdbbfbf9bd999b9e99bc9ff9fdbf9fff9dbddbdbdbdb99dbf9dbfbfdff9bf9909909090000ffff900000f9dbfffffbff09e90c90dabaf9ada9bda9bcb9f0bcf9ad9bcdb9c09d00b09e90b0909ad09c9bff99e9bdbf00900000000b9adbdbdbfadbdfdbdbdbcf0d09f9ff009f9ff9f090be9ebfbfbfbdf0bd9fbdfdbffe9dbc09fff00000909fff0009090fbfdbf9fffff09e900a99d9dbdb9fcbdbcbcb09fb0bdbadbbcb9a0b9c9f09a9dbc909a90b099ff9bdbfdbd00090009000f9bdadbd9f9fbbff9edb9900000999bf0000009ffd9999909fdbdbdf9bf9fbfbdbfda99bb09ff009fe000fc009fff099dbbdffbfffd0000a9ca0be9e9e9bda9f9b9eb09f9e9dfadf9c09d09a90bc9cb0b0e990f9f00f9fdbda900000000000090d0bdbdeb9f9fdb9f9bc9e9900000bfc0000090fffffd099f9bd0b9bdf9f9f9fffffd0fd9d09000090000000fbff090bbdfbfdffff0adbc9009c99bf9bdabdb0f0f9dbc9adba99bf0b9b0bc90f990b09d099e9090099fb9ffd0000000000009cbb9f9bdb9fde9bfdbff9b90a9c9c0000009fc00bff000bdbdfdbbdfdbbfffffffffb09bfbfbdbd0c009009f9ff000bdbdfadfbfbfe09b000a90a9af0bcb9db0f0f90bcbbf9ad9efbd000d0bcb90e90db0b0b9e9ad9a009f990000000000000009cb9f0bdfbb9ff9fb99fcbd909a9de900009000000ad99f9bf09db9bdff9ffbf9ffdf090d9dadbf9fffff9bfa90b9fbff9f9bffff9000e0900d09d9bdbcbe9f9b9af0b0d0bdaf9bfbd9a99090f99a9ad9c9c9909a9c90000009000900900909009cbdbdbd0f090bdfe9bdbedb0db090ffdbc009bc99bf99f09fadbdfbdfff9fffdbff9e9a99dbd9fbffbd00d09f9fc9fbfff9fffff09f9e090a00a9da9bdbcbde99bc9bbda99ad9bd0ad9e9cb09e9c9b0b0b0f90c900000000000b0c000000a0dbbd0f9fbfd9bdf909f9f99bbdb09cb99fff9ffdbffdbcb09f9f9ffbdbf9fffffbff9f9bd0b090b990909bf9bf9fbff0f9cbffbffbc00f0dac90b0f0f9e9bf9a9f0db0d0bdad9bef0b99a90b09f9a9b0d09c900b9b0000000000000b00009c09bc90f9bf9dbada90bf9e90fdfcbdfbdda909ad09ad090909f9f9bdbdbfffff9ffff9fb0d0fcbdbc9edbdbfdbfdad9e9f9a9bfffffff09fb009000d0b9cb9f0f9f0fb0dabdadbaf9f90f0da90f090d0d0b90bcb99c0b000000000d09c0900000f0bdb9fcbfa9dbdad9009f9f09bdfbdfbdbfd9bbd99f9f9ff099e9f9fffdbfffff9ffddfbb9909f9b9bffdbfdbfdbfbdbfff0dbffff00bc0f009e90bdabdadb9e9b0dbad0b9ad9cbbf90b99e99fa9a9b9cb0990e9b00d0c09000000a0000909009cbda9bd9ff9db9a0d9e909f099adb9fbdbffdfbff90b999fbdbdbf9d9fffff9ffbfbbc9cb9f000c9009bdbf9bd0900090009bfffff90f09fe000a00d0bdbcb9e9f09dbdad9ab9ff9cbc9e90a99c909e90da0b90d90a0000000c09009c00a009f9b9fdbfbdbfad0d9a090f00bf0d9e99ffdb9fbd090f9cb09da9bc9fbbf9f9fff9fdfd9090d0ad0000000000c00900d00009fffbff00bf0f00909c9a9ada9bde9b0bcb0bdaf9da9f0b09b90f9da9ada90b09d90f0ac90000000900c000009c9a9bcbdb9f9fbc9fb00090f00bd09bf0f090b0d0000f090b0c9b0df9bffdffffffffffbfbe0000900900000090000acb0a909bfbdfffe9c09e90e00a0d0db9fda9bcbdbcbda909adfbd0bd0e909ad9009f9c9a9e99090090090000000900900b0dadbdafcbdbd9f9df0000909009e0990f00d9000000000c900c990909bfbdffbfffdbdbd990000900f0d0000909090909c9bfffffff90bf09e9000900a90fa9f0f90b09b0dbcbdabfbd0b99b0f9adb9090b0d09e9f00000000000900a00000c09f9ef9bdbfda9fb0bd000000d009c009090a00d09f090090090a09ff99fffbffbdfffffff099e000900000c0a000f0c09a9fffbfffffad0bf0f0bc0090bc9da9f0fbcbcbda9b0bd9f90bc9e0d9ad00dbcb09a9a900900000000000009c0b090b0bdb9fdbdb9f9bdfdbf90009000009e0c009c9a0c0000000000d9ff9fff9ffdfdfbffbdbff9090c000009099c9fb09bbc9ffdffffffd09adf0f0009ac009bad0b909b090bf0dadaff0bc9a999ad9b9b090d099c90f000f0000000000000c0a0dbcb9f0b9e9f9fdbf9ad9f000009a9099a90000090900000009909bfffdbffffffbfffdfff9ffdb900000a09ebf009dadbffbff9ffffa9e9fff09c000900f0d9f9e9e9cbbd09a99f9bd09b0dac9a9c0cbda9ada9a90000009000000900090090099f0dbdbdbff9bd0bdbe9bd0009febcbcbc909000c9000909bdbfdf9ffffffbfffffffbdbdbfffffbdbd9df990bdbe99fffffffbfffd0b0bf00f0b000090b9a9a909a9c90bc9cb0bfbd0db99bcb9b9090909090d0bc0000c0000000c0000d09acbdbf9fdbd9ff0fbdbd9edbf90909f9090bcbc0f000099dbdfffbffffffdbfffdffffffffffffff9ff9ffbfffdf9f9bfffffbffffffa9c90ff0f00d000000e9ada9c9a90f0b0b0f0da0b09e0990f0dbcbcbcbcb0900900000000000090000a0d00a9fe9bfff99f9fadbf99fff0009000090bf9b99f9fffbffbdfffffff9ffffffbffbdffbfff9f9fffffbfffbfffffffffffffffffbda0afbcbcb0a00000909c90da9c9e09c90d09bc909e99f0f09b0990909090e900000000000000000090c9b99db99e9b90f9f9fdb09fbcbfd09e9fdbdf9bdffbdbffffffffffbffffffdffffffffffff9ffffffdbfdfdfffbfffffffbfffbffff09bd9cb0f0c00000000000000000090000000f000090000900000000000090000000090090000009000900f0bdff9fdf9bf0f9bfdad9f9bff99db9ffbdfffffffbdfffffbdffff9ffffbfffdfffffbfffffffbfdbffbfffffffffffffffffffde00fafd09a9000000000000000000000000000f000000000000000000000000f00000000000009000000090d0b09fb9ad9dbdf9bdbbf9ff9ffbfff99fbdfbdf9fffbff9ffffffffffbffffffbffffdff9fdbfdbffffffffffffffffffbfffffb90090be9ede00000000000000000000000000f0000000000000000000000009000c00000000d00000000bc09bd9fbdfd9a9fbdedbdf9ff9f9fdbdbfffffbffbff9ffffffffffffff9ffffffffffdbffffffffffffffffffffffffffffffffff9cb009f0b9a9e9c000000000000000000000009e000000000000000000000000009a000000900000c000900b009af0db0bdfbdb9bff9ff9fbffbfbdff99bdfffdbffdbfffffbfdbfffff9fff9fffbfffffbffffffffffffffffffffffffffffbcb000bcbdedf00000000000000000000000000e9a09000000000000000000000c0000900000000a900090c900d099db9fdbbcbffdbdb9bdbdf9fdbf9ffffbdbfffffffbfffdfffff9fffffbfffbfdfffbdffffffffffffffffffffffffffffffbc009f9f0b0bcb000000000000000000000000bc00a0000000000000000000090009000000000000000000ad0bd0bf0f9bc9f999f9ffdbffbdfbfdffbdbdfffdbfdbffffdbfbffbffbffffdffdfffbffffbffbfffffffffffffffffffffffffda90000be9f09f0c00000000000000000000000cb00000000000000000000000000000000900009c009000909000bc9bdadbf9ffedfbdbfdbdbfdbfbfdfffbffbffbfdbfffffdffff9ffbf9fbfbffbff9ffff9fff9ffbfffffffffffffffffffbf0090bc9bc0bc0b00000000000000000000000bc0000000000b00000000000000c000c00000000000000000fac909bc9dbd9fdb9bbdbdfbfffbffdfdbfbffdfffdfffff9fffffbdbffdffffffffffdbfffbdbfffffdfffffffffffffffffffbd00900fdac0bf0bd00000000000000000000000cb009a0c00000000000000009e0900090000000090000000009f09c9ba9bfb0bdffdbfb9f9bdfdbfbffffdfbdfbfffffffbffbdffffffffffffdbdbfffd9fffffbfffdbfffffffffffffffffdaf0e09af9f00f0dae0000000000000000000000bc00000900000c00e00a000009000900000000000000d000900b90bc9f9c9fdbf9bf9dffdfbfbfdfdbf9fbffbfff9fbdbffdffbffdbffbfffdbffffff9bf99dbfdfbfbfffffffffffffffffff909009f00adbf0bd00000000000000000000000e9a0000a00000b009009000000000000000000000090a0090009e90b90fbda9f9fd9fbf9bfdfdbfbff9fffdbdf9ffffffdffbdffffffffdbfbffbff9fde99fbf9fbffdf9ffffffffffffffff9e9a090db0d0f0bfe00000000000000000000000bc0000000000000000000000000000c000000000000090000d009bc90f909fdb9fbfbfdbfdbfbffdbffff9ffbfffbdbdfbfbffffbffffbffffdfff9f0099e99ff9ffdbbfffbffffffffffffbf0bc0f0a00be9bcd000000000000000000000000da00a090000000aca0000009000009000000000000000c0900bc90bc90bf90bdbf9fdbfdfbf9fdbffdbdbfbffdbdfffbfffdffbfffffdfffffbfbd090b9f99f9fff9bfd999c9b99fffffffffcf0900090d09c0be900000000000000000000000e9c000000000009000ca0000000000000000000000000900a09adc9bbd9cb99ed9f9fdbdbfdfbff9fffffff9fffbdbff9fbfbfdfdbf9bff9f9ffc99099f09bfdbf9ff9bfe9000fbcbfffffff9f0090fc0bf0bcf00f0000000000000000000000f0a00000a00000000b0000900000000000000000090000009c09a909c0b9f0f9bf9bf9fbfdbdfdbffbdbdbfffbffffdfffdffdbfffdfffbffff0b00fbf09fdfbd9f09ff090b9d9099ffffff9a0bc0a90bc009b0bc00000000000000000000000ac9000000000000e0000000000000000000000000000000900009cbc9b9cbdb9fdbfdfbfdbfbfbfdbdbfffdfbdff9ffbffbffffffbffdff0b00909b9d0bbffbd9b09f909090ca00ffffffff0f9c909cb0f09ac9d0c0000000000000000000000da00c00000009a090e0000000000000000000000000909000bd0a90b9cb9cbd9fbc9bdfdbdbdbdfbffdf9fbfffbffbff9fffdbfffdffb9f9d9900c9f09df9d0b09fbdad0bc09009bfffffff900a09a0c90bc9b0a000000000000000000c00000f9e0a00000900000009e00000000000000000000000000000009c090fbcb9bcbcbff9bfbffdbfbdfdbbffdf9ffdffdffffffffffb9b9f900b0c99bf09f09fb9fda9f000900b0009fbfffff0f09c0bc9ac9bef0f9f000000000000000c0000000f0090000000a000ac0000000000000000000000000000009c09f090f09f9e9b9f9dbdf9f9fbdfffb9fdfbfbff9ffbffffbfbfff00c09009f009af909b9ff09c90900909009009bf9fffffff000b000099ac90da0000000000000000000000c000e00e000000000009a0000000000000000000000000000009000bf090f0bdbcf9fbff9f9fbdbbd9ffffbf9ffdfbfffbfffdffbd099bd0bf09dbd9c9f9e9090b09bc90000bc909e9fbffff90909c000d0ac9f0b0d0000000000000c0000000000f090000000000000000000000000000000000000000c0ad00a0909cb909e9db9f9f99fbffdbdffbdfbdfdfbfbff9fffdbfbff099bc9a9c9d0b0b09bc9900090bc0000090000e9bffffbf9e00000090a90b00bc9a000000000000a00000000000f0a00a00000000000090000000000000000000000009090f090c0090fd09a9f9f9fff9f9bfdb9ffbdfbfbffdffffff9ffffd0f00ff9cb9a009fd0b00a09dbc00900009a90a90b9ff99fff9000000e900c9f09a9c000000000000000c00c00000ad00900000000000a00a00000000000000000000000000000009a90da9bf9f0fbf99bdbfdbffff9fbfdf9ffbfffff9ff99f0b09f90099c099f000d09d90a09090009e0c009dadf900bff000da00900000b00e0da0c000000c00c000000000000da00c000000000000000000090000000000000000900000090f09cb09de90f9bde9fffbdbf9f9fbdfdbfff9ff9ffdbf99f09c9e909bc0009f99db0b00a09000000b00909c0b9fa09ff0000900900009dbc0b99b0000000000000000000000000ad00a0000000000000000000000000000000000000009c000000a09b0b9df9fdf9f9f9fff9ffbdffbfff9ffffffb0bcbf00900900c0b00bca0000d00d0d09dad0d0d00009b0f0909f0909a00000000a00900ac0f000000000000000000000000f0a0000000000000000000000000000000000000000000900090d00d9cba9e9bbdbfbf9bfdb9fbdbdb9ffbdbfffdbd99f0909bd0909000999cb0900b0000e90b0b009a9e09f0f09f90a00d0000000909000d9b00000000000000000000000000f0d00000000000000000000000000000000000000900000bc0000b00b09db9f9fbd9dbfdbffffdbffffffdffff0090f00000f0000ac009ac0900009c090b00f0c9cbad099be900f00c909a009000000e00f0acbc0000000000000000000000000a0000000000000000000000000000000000000000000000000909c909fb0f9ed9ffbfdbdbdbdbfbdbdbdbf9f9090f9090f9000090909c90900d09a09e90c90090b0d9adad90bd0009000000000909090f00d900000000000000000000000000f0000000000000000000000000000000000000000000900900c000adbc0df9f9bfbdbdbfbffbffdff9fff9fff009f90c090000900f0009a00000ac00000909ada9c9ac99b0e90a09000a90d0000000e0000b0ad0000000000000000000000000ad0000000000000000000000000000000000000000000000000009009b0bdadf0dbfdad9f9df9bf9ff9bffbfc0909cb00ad000009000b00d00900909000000900090900e9b9c9000909c00000000a900090d90a0000000000000a00000000000da000000000000000000000000000000000000000000c0000900900f0db0bdb9fbdafdbf9fb9ff9ff9fdb9fd0b0da900090000090009c0900000d0000000000090000bf90c0a009a0a0900a000090000b0a0ad0000000000000000000900e000ad0a0a0000000000000000000000000000000000090090000009e0090b0dbdbdf9bd9bfdbf9ff9fbbdbfffd090909c009000909c00900900900000000909000000ad9c9c009090c9090a00909000c0090c90d000000000a000a000090e000000da0909ca900000000009a000000000000000000000000009000009000db9e9fa9fdbff9f9e9f9f9fdbfbdbf0bc9a09000000000000090000000909090000000f09000b00b00009a0c0d09c00000000000000b000000000090090000000900000e9e0a090000000000ca0c9a0c000000000000000000000000000000909e99f9f9bdf9bf9bdbffbdbfc9f9fc9900d000090000009000090000900000000000900009000f90e90e0090a00000000900000090bc00000000000a00a000000ca0000f0090ca00c000e9a0909a000b0000000000000000000000000000000009f00f9fcb9fcbdff9f9fbfdfbdbf00a0d000900000090000000000900000c00000a0000000bd0009009090e90090000000090f00bc00000000000000000000090000000f000b090a0b000c0a0a00f0000000000000000000000000000000000009f9bcb99e9bdaf9bdbdfdb99ff099c9a90000000090000009000000000900090d0090090bd0ad000f00e90009a000900000000bc0b0000000000000000009e0000000f000000e090c0b0a9c00d00000000000000000000000000900000000090009f9f0f9fdbd9fdbffafbcbd900a000000000000000000000000000900000000000000f00000bd0090909000009000000009009000000000000a00000000000000000f000090a0a90c90a09a0a0000b000000000000000000000000000000000900f9f9f99eb9adbf99d9f9bcbd09090900000000000000000000000000090009000000f090900b00f00009c000000009a00f00f0000000000000000000090000000f000a0a09c00a0a090a0090f000000000000000000000000000000000000009da9e9af9dfb9f9ffbf9fdb000ac000009000000000000000000000000000000090090000e9bc9f00000a09000900d009009f000000000000000000000000000000a00909c0a0b0909ca00d0e0000000000000000000009000000000000900009adbdbdbdbbd0f9f9fdadbc0909000000000000000000000000009000000000000090000090c0b000ad009ac0000a000009e000000000000000000000000000000f0dac00a09000aca00d0a0000009000000000000000000000000900000000009bda9f0fc9e99fadbfdbcb0000090000000000000000000000000000000000000bc0000bc090c00900f0009a0009009cb0b0000000a0000000000000000000000da009a00a0a0d009a0000000000000000000000000c00900000000000009000c09dadb9f99e9fdbf9f9bc0090000000000000000000000000000000000000000000909000a9009e9000000c090000a00d0000000000000000000000000000000ad00a00d090da0bc0000000000000000000000000009000000000090000000090a9dbdafcb090fbdbcbc90000900000000000000000000000009000000009000009a00009000b0000090090000c9a90f0000000000000a000000000000000000f0b0c09a0a0a0000000000000000b0000000900000000000000000000000000009ca9e99bc9bf909c9000090000000000000000000000000000000000000000900000009a9e900900f00000b00900c9000000000000000000000000000000000f00a9a0009c90f000000000000a000000000000900f000000000000000000009000909bc09c00ad0b0f90000000000000000000000000000000000000000090e90000000c00090e900000000000b09a0000000000009000000000000000000000f000dada00a000000000000000009c000000000000009000000000000000000000000090a9090bc90000000000000000000000000000000000000000090ca900000d090b900e9000090bc90090c00d0000000000000a9a00000000000000000f00f0a00000000000000000000000a00000a0900000000000000000000000000009000000d000d00bc90000000000000000000000000000000000000000090000090000ac00d00000ac000000ca90a0000000000000a00c000000900000000000f000000000000000a000000000000009009c00b000000000000000000000000000090009000900900000000000000000000000000000000000000000000000c90c0009090b000bc090a09a09a90090000000b0000b0cb0a00000a0000000000f0b0a900000000000090a0000000009a00000000909000000000000000000000000000000000000000000000000000000000000000000000000000000000009000000bc0ac090009a0090000c000f000000000a00009a0900000000000000000bc0000c00c00900b00a00000b0000000000009000000fe0000000000000000000000000000000000000000000000000000000000000000000000000000900000000090090000cbc09c009c09000900000000000000e09aca0000000000000000fa90ca0b009000a000000000000000000c90ac0000000c00d090000000000000000000000000000000000000000000000000000000000000000900090000000000000000909a900000000a000bc00000000a09000090e09000000000000000009c0a90000a00a00000000000000000009000900da00900000000009000000000000000000000000000000000000000000000000000000000000009000000900e9000000ac0000090000000900000000000000a009a0a9ac00000000000000000ebc000000000090000000000000000000000000000000090000000000000000000000000000000000000000000000000000000000000000000000000000000900000c9090b0c0000b00f0009c000000000090000009c09a00000000000000000da9a000000000a0000000000000000000a000b00000000000000000000000000000000000000000000000000000000000000000000000000000900000000000000da0000000900a009000cb0b0000000000a000000a0ac000000000000000000f0c00000000000c0a000000000a000000000000e900cb0000000000000000000000000000000000000000000000000000000000000000000090c00000000000090009e90000a09c00000b0000000000000000000a00909a00000000000000000da00000a0000900900000000000000000000009000900090ac09000000000000000000000000000000000000000000000000000000000000000000000000009000090000909000090009c0000000000000a000000900a0000000000000000000f00d00009a0000a0000000000000000000000000000000009000900900000000000000000000000000000000000000000000000000000000000000000090000000000000c0ac90000cb00000000000000090000000a00000000000a000000000af00a00000caf0000000000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009a90000000b0000000000000000000a000a009a000a9c0a0000000a000f000000a0900000000000000000a0000000000000000900000000000000000000000000000000000000000000000000000000000000009009000000000000900009000c000900090000000000000000000a0000900000000c0a090f000b09c000c0000900a000000000009a000000000000a00000b00c0000000000000000000000000000000000000000000000000000000090d00000000000000000000000000e0bda909e0900bc0000000a00000000000000009a0000b0a900a00000ca000f00000a0000000000000000000000000000000000009a00000000000000000000000000000000000000000000000000000000000009000000009c00900000000009c0000e0000bc000000000000000000000000a0000a000000f0c00000b0000ad000000000b0000000a00000000000000000000000009000000000000000000000000000000000000000000000000000000000090000000000009000000000000009009009000000000000000000000000000000000090a9e00b0000000ebc0da0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c0000000000000000000000000090900bca0009acb00000000000000000000000000000a09e0c009a0000000a90a0a900000000000000000000000000000000000000000a0c09009c00000000000000000000000000000000000000000000000000000000000000009c00000000000ad00900cb0900000000000000000000000000000090a0b0b0ac000000900f00da000000000000000000000a0000000000000000000090a00000900000000000000000000000000000000000000000000000900000000000000000a90009ca0f090b000900c000000000000000000000000000a0b0a0d0000009000000ada000f00000000000000000090a00000000000000a000a0900000f00ac0b0000000000000000000000000000000000000000000000000000000900009a000000009000000d000b00000000000000000000000000900c0cbca0a00000a000000000f00f0000000000000000000c90009000000000000000000a0900090000c9c00000000000000000000090000000900000009e000000900090000f000c9c0a90b0c00bc00000bc000000000000000000000000000ca9a9009009a0b0000000000b0000f0000000000000000b000ac0a000000000000da00a0900000000090000000000000000000900000090c0000a0000000090900000000009000900009c0000b090000b0f000000000000000000000000000a0a90000a00000000000a9009a00a0f0000000000000a00000b0090000a00000a09a00c900ca00b00000000000000000000000000009000090009000d00c90000000000000000090a0b000090000000090c90000000000000000000000a0000009000a00000a0000000000a0c000000f0000000000000d00000ca0c0a000000000000b0a000000000b000a090a0d0000009000000000c000000000d0000000000000000090000000000090ac09c000dbcb00000000000000000000000000009a00a00000000000a00000000a0bcb00f00000000000000a00000090a90000a00000000000cb000000c000900009000a000000000090009000000000000090000ad0000900000d00e090dada9000090f000000000000000000000000a000900a000000000000000090000e9a9000000000000000000009e00a00000000009000000000b0cb000009e9a00000000c0000009000d000009a00c0000000000000009000bc0acb0f00a0900000000000b00000000000000000000000000000a00a0000000000000000000c90a90cac9a00a0f00000000000a09009c0000a0000a00900a000000000000000009a0000a900090000000a90e0000090c0b0000f000000000000090000900000000000009000cb0000000000000000000000a0900000000000000000000c0a00a000a09a00a900f0000000000000a0c00a000000a000000000000000000a00a9e000c0b000000000090a9c009000d0a900000900000000000000000000009000c90900f00da900000000000000000000000000e00000000000000000ac00b09a9ad0da00000000f000000000090009a0090c090000000a0000000a90009009000bcb00000000b000e0000000000b00000090e0000900900090900009000c009000000900b0000000000000000000000000000000000000000000909a00b00ca0c0a0a0000000a00f000000000a000000000b0e00000000000000000a0a00000ebc00000cb0000090000cb000a0c0009c00a09000000000000000900000090000a9e0bc0bc00000000000000000000000000a0900000000009a9ac0e00b0e9a090a90000b000000f0000000e9000da000000000090c00000000000000900000a90a9a00b000b000a090b000bc9090a000b0d00009c09c000000000900000a900d00900000000000000000000000000000000000a00000000ac000ab0b0c00000a000000000000000f0900090000a000000000000a09a00000000000000000009e9c00f0000c0090c0ac0ada0aca090da0c0000c0a000000b00000000d09000ca000000000000000000000000000000000000000000a00b000b0e9c00cb09a090000000000000000f00000a000ad00000000000000000000000000000000000000a0b00000b000a09a00bc00d090ca000900b09090090009000900f00a0a00090000000000000000000000000000a0000000000009000000b0009a0b0a00a00a0000000a000a00000a0000000000000000000000000000000000a900000000000b0bc0a0000000000090009a0a0a900900a9c0a000c0a0000c0e0b00bc9c0000000000000000000000000000000000000000000a00a090a0009a00000000000000000000000000a0f000a00009000000000000000000000000000000000000a900c0a9c90009e000000e0a000c9c0ac0ac00000c0a90c0000a909c0f0a000a0000000000000000000000000000000000000000000000a0090a00a90a09a000000000000900000000f0f000cb000a00000000ac00000000000000000000000000b0b00a0a00a009090a09090e9a0009000090a90b00000000900a0b00f00000da00000000000000000000000000000000000000000000000a000000000000000000000000a0000000f00009a00a00900000000090000000000000000000000a0c0000f000000000a0090a0e00000b00a900a00000000a90000000c0e9000b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000f00ac00c9000000000000a00000000000000009000900900ada000000000b0cbcbca900000000000900da000090009a00090b00000c0b000a000a00000bc000000000000000000000000000000000000000a000000000000000000000000000f0090a90a0000a0000000000000000000000000a000a000a900000b0000b0cb00a09acb00bc00000a00a00000000000000000090000b0c000000d00000009ac000000000000000000000000000000a000a9000000a0000000000000000000000ada0000000e09000000000000a00000090da9ac00c000000000090000900b00b09a09000000009000000009000000000000a00e0a900a90090da00000000000bc0000000000000000000000000000c00000000000000000000000000000a0000f000000a9090c00a0090a000000000a90aa0c009a9009a000a9a0000a0000ad0cac9e000000b00a090090a000000000009090b09000f00a00a000000000a0900000000000000000000000000000b0900000000a00000000000000000000000000ac0000000a0a00000a090090000090ca9c9a09a00a0000000000a0900a9e9a0b09a0000000000c000e00000000000b0ca0cac0acb0000000000000000000a00a09000000000000000000000090c0a00000a0000000000000000000000000000f09a0000000000d0000000a000000a9a90a00000c000000900c0000000000000000009a09a0009a9a00000000000000900090bc900e90000000000000000000000a0c00000000000000000000a0bc000000000000000000000a0000000000000f0000000000090a000000000a90000c0ad0f00b0b000000acb0a90a00000b0f000bc00c00c9a0000c90b000b0000000a09a000a0b00a000000000000000000000000a000000000000000000000009e00000000000000000000000000000000000f0000000000a00000000000000a9a9ada0000000000000000000000000000000000b00b0a00000b0a0000a0000000000000b09c0cbc00000000000000000000000000a000000000000000000000a00000000000000000000000000000000000f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010500000000000089ad05fe, N'Andrew received his BTS commercial in 1974 and a Ph.D. in international marketing from the University of Dallas in 1981.  He is fluent in French and Italian and reads German.  He joined the company as a sales representative, was promoted to sales manager in January 1992 and to vice president of sales in March 1993.  Andrew is a member of the Sales Management Roundtable, the Seattle Chamber of Commerce, and the Pacific Rim Importers Association.', NULL, N'http://accweb/emmployees/fuller.bmp', 'fuller@northwind.com', '987654321' ), 
( N'Leverling', N'Janet', N'Sales Representative', N'Ms.', N'1963-08-30T00:00:00', N'1992-04-01T00:00:00', N'722 Moss Bay Blvd.', N'Kirkland', N'WA', N'98033', N'USA', N'(206) 555-3412', N'3355', 0x151c2f00020000000d000e0014002100ffffffff4269746d617020496d616765005061696e742e506963747572650001050000020000000700000050427275736800000000000000000080540000424d80540000000000007600000028000000c0000000e0000000010004000000000000540000ce0e0000d80e0000000000000000000000000000000080000080000000808000800000008000800080800000c0c0c000808080000000ff0000ff000000ffff00ff000000ff00ff00ffff0000ffffff00fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffb009a00a9009a9aa9a900009aa9abe9eb0b0bb09a0ab0a9a9b0fa0fa0cbfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbfe9a09a9ebebfbb0bb0ab09ac9090ab0bcb0ba9e9aa9a90b000009aab09009beb0bad0eb9e9f9b0c0b0fadb0f0beb0fcbc0bcbfb0f0bbe0b09ba0bbbfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0ffa9dabebfffadffadbf0bebbafaf0fbbab9adabadbe0ab0bcbfbc090e0a9afa9bc90bb9afabee0bb0fa9abebe9b0fba9ab9a9a0fb09e0bdafa0dbe9fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbfb0fabfffafafeabcbaa9f09af0b9bbcbe9ebe9ada9a990fab0000bfa9090b09e0baf00a9adab9bcbe9f0bcf0be9fa9eb9ca90fbeaf0bfba9adba9abfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff9fe99a9faffffebda9adbcbfa9ba9eafacb0b9af9a9afaeb0900bb9a0000a9af0bbcb0b9e9badafab0babebbbc9eaa9ebeabbe90b9b0b0bcbe9a9fadafffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbfbafba9bebe09abfebabab0f0f0f9dbfbbafab0faf0b090bcbc00090b0b0a0bbe9b0bca9af9a9bc9e9fad00abab9fa9cb9c90b0fabff09adbfeb00b9fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffcbe9abdefbdbbffcab0f0d0fb0bba0abf0fda9f0a90009a09a0b00000000d0bda9afada9bdbebfababbadabfbda9e0beb9ebabe9a9eb0fe9ab09fafbafffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff9b9e9fabadafeb0bbde9babba9fedbbf0bfabc0a900bfe0bc0900b090b0b0bfafe9a9a900a0b0e9cf0c0b0f0cadabf0f0abbcb0b0bcbeb0a9afa9a9e9bffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffaba9f9faf0fcbcab0be90edabbabcbfa090b090fbfef009a0b00a000f0b00b0be9ebaf9fbfbbbbabb09fabb0f9afa9fbcfbcb0e9b9a9fac9f0bc9f0bffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffcbf0da0a0fbebabbdef9afbbada9cb0a0bca00baf0bffe9ba9009090b09acbbaff0badb0a0badacbde9ca0bc0baaf0fbaeb00b0b9a0f9eb9abafababbebffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffb0ba9bfbacb9edab0baf9ae9a9fa90900090b0f0bfbfe000cb0a00009a9b0adb0be900a99adabfbabea99a0bf0f9af0ff0bfada0e9babbebc90bc9e0bcffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffa9e9af00fbfeba9ebbc9a09bca000a09a9abcb9bffee9af0b009090bafbeb9baf0baff9acb0bfacbdbbe0dbfaf9eb0b0be909a99b00bf0b0aabcbabdbbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffb0ba9afbcbcbbebbcabad000090909009ac90b0aa9ff090b0b00a0bc90f090f9ebcb0af9abf0b9baa9cb0a00faabcbebdafaf0e09be90fbf9cbb0bca0dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbf0fbda0babe90cb9b0fa9ab000a00b0a9a9a9f9ebfe0bc00090900ba9beb0babcb0fb0bcb0fbebdbfa9e9bfadbcba9a0be90bbb0e9afa90fa00be9a9bffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0a0b0ebfbcb9ebbaf0f0bc90b0090000909a9e0bbfee900b0da000900fa0b0b0bbe9b0beb0b0ab0a0f0bbc0a99abad0bff9eb0c009a909eba9e9f0bcadbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe9bdbfbb00be0bac9afa9abfe09a00909a0bcba9aebe90ab00a90a9abfbe9f00fc9aebc909adb9ebfb0bc0b09ae9cb0f0a0a90b9eb090fab0fa9a0fa90abfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffb0a000cbe9be99bfa90f090ab00000009090f0bfbfe0b0da900090bcba90ab0beb90bafadba0fb0ebebabebc9aa9a9abf90fa009a9eb09e9afada9ca9cffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffcb9fb9a9ae9befaf9a9abeb9ebcb00000a0b0be9aff0fa090b00a90b0fadb009bae9adbab0ffb0fbf09bf00b0d0f0eb00ab09eb0da90a9af0b0b0cb00b9fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffb0a00ebcb9beb0ba0f0b09ae90b00b00090a909fff09009a00090a0f9a9bab0b0bfada0d0f0b0ba9a9e00af0a0ba9bc9e909ab09a09a9ca9adaca90b0bcffff9ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe9b9bb0be9e9e909f0bcbeb90b9cb00900bb0faabee0b9e090b0bdbbaf0e90c9ae90b0bab09afdabe9adb9a909a9e00a90e90d0a09e0b09a9a090a00009bfe000909fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0cacbe0ba9a9ab00b0b0bc0bcab0b0000009afbe9a9e090a0009abefabbab009badaf09abe9abbdafbafa9e9ad090b0a90a0a9cb0900b0dadb0b000900bc90000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbb9adbe9fa9e9eb00f0f9a9e900bcb0b900f90fbeda9a09090a9a90bc0db0b09afb00bcbcb0bcbeb0bda9e0bc0a0bc090a9090b09a9b00b0a00009000900000000009fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00a9aa9a0bf0b0bfba90acb0b0f0b0b00a90abafe90ada0a0090dafb0ba0bc0afac0bcb0badab0b0feba90b00b0900bca9cb0a00a0000b09090900000000009000009bfffffffffffffffffffffffffffffffffffffffffffffffffffffffffe9bf0f9fada0bbff0e90a99abcb090b0e9000b9fe90e9009009afaa9a9a9f0a909bbb0b0bc9a9ebdb0b9e0bca9000ba009a0090b0909a900a0000000000000000090009ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffa9a9ab0bbf0f0b0b9ebdae90b0e0bc9af0b00e9f0a9a9a090a9a9fafcbb0b0b00faf0e9ab0b0bab0f0bbf0b0a9a909a9090a0000000009090000000000090009000000bfffffffffffffffffffffffffffffffffffffffffffffffffffffffffbcbe9af0f09afaf0a9ea90a90b090b09a90b0baf090009a0909be9ba9afbbc0a90f0b0a9cb0f0dafabe0000900000000a0a9090a9a900a0000000000000000000000009fffffffffffffffffffffffffffffffffffffffffffffffffffffffff09a9adbf0bbe9b0bbe90bbca909a009a9ac9a0beba0f0009a0bebbe09f0009a90babe090b0b0babbcb090b000090009090900a090000900009000000090000000009009ffffffffffffffffffffffffffffffffffffffffffffffffffffffffe9a9f0a00abe9b0fa09abc0b9e0a9f9ada9a9e9d00c90a9000f0bda0da0fbbe9e09f9fa0b0e0bcbcbad0a009000000000000009000000090000000000000000000900000bfffffffffffffffffffffffffffffffffffffffffffffffffffffffda9a0b9da9cb9eb0bdad0bbc0b09000a90bf0baa9a9a9009a90baaffabba0a9a9a0a0bdac9b09a9be9a909000000000000009000900900000090000000000000000000900fffffffffffffffffffffffffffffffffffffffffffffffffffffffe9ada0a09ab0a0be0b0a9e0b00b0b0b0a900f09e09000b000b0bff0b0f9f9be9a9e9bea9ba0da9e09e9000000000000000000000000000000000000000000000900000009bffffffffffffffffffffffffffffffffffffffffffffffffffffffe09a9bc9a9cbe9e9f0f0b09a9ad00b09c0b0b0bc9aa9a009a9adabfadaababcbcb09eb9c009a9a09b0a00000000009000000000000900000000000000000090000000909c9ffffffffffffffffffffffffffffffffffffffffffffffffffffff09a9c00a90a09a9a0a0bcba0d0a0bc9a9a900be9ac90090bcbfafabcbada9ba9a0a9bcab0f0b090a0090000090900000009000000000090000000009000900000000000be0fffffffffffffffffffffffffffffffffffffffffffffffffff9ffe90a9a90a90b090909a9a0dba0990b00b9e09f0a9a09a000b0bfdebe9fbebefad9000b0090a0f0bcb000009000000009000000000000000000000900000000000009000bf0bffffffffffffffffbffffffffffffffffffffffffffffffffebffa09000090090000000909a009a0a00b00a90a0f009a09a9ada0badbb0a9f09b9a0f0badb0a990bcb0000900000000000000000000000000009000000000000000000009fe0bffffffffffffffffffffffffffffffffffffffffffffffffa909090009000000000000000009a00909a09bc0bff09ac090090bff0fae0bf9abbee0b0a9f00a900a090090900000090000000000000000000000000000000000009000900bf09fffffffffffffffffffffffffffffffffffffffffffffff909090000000000000000000000900090bf009e00b0ba0a90b0a9afa9aba9bfabad00bff0900ba9da0f0b0b00000090900000000000000000000000000000000900000000009a9ed0ffffffffffffffffffffffffffffffffffffffffffffff0000000090000000000000900000009000000b0b0b0becbda0090cb9ebff0f009cbbab0bebe909e0a9009000b00090000000900000000000000000000000000000000000090000900bfffffffffffffffffffffffffffffffffffffffffffff00909000000000900000000000000000009009009a09bf0a090a0b0abbebefafebbcb9adaf00a9af090a9a9e9009000900000000000000000000000000000000000000900000090009fffffffffffffffffffffffffffffffffffffffffffff09000000900000000000000000000000000000a9a009fea9bca9090bb0ffffabf0bcbeab0bfeb09e9a0a90009000009000000000000000000000000000000000000000000090090090fffffffffffffffffffffffffffffffffffffffffffffc00000000000000000000000000090000000009000909af0da090e0f0fffebedfa9eba99af0bf09abe09009a9a09090000000000000000000000000000000090000000000000000000bfffffffffffffffffffffffffffffffffffffffffffff00009009000000900000000900000000000000009a00bf0ba09a99bbfaabffbb0be9bcba90f0fe090bca9a0009a000000000000000000000000000090000000000900900000000090d0bfffffffffffffffffffffffffffffffffffffffffffe9000000000090000000000000000000000000000090a0bc9ad00a000bfbcbcbef0bafbcbab0babcbaf09009a9a0900900000000000000090000000000000000000000000000000900a9feffffffffffffffcbf9ff9ffffffffd99f9ffffffff000900090000000000000900000000000000000000009bebe90a909e9f0bbffa9ebc9b0b0bcf09ef0bc9a09a00090000000000000000000000090000000000000000000000090090a99ebfffffffef9a9bf9ff9f9f0f0bdbfffb0fb9f09ffffe00000900000000000000000000000000000000000090bae900a90babbafafea9eb0baaf0feb00afbe9a0900909a00000000000000000000000000000000000000000000000000009c0a9fffffffb9dbdfdbfdbfbf9fbdbe999ddb9cb99a990ff090000900000000000000000000000000000000900009fbaf09a09e9e9e90bcb0e9ebdab0daf9caffe9e0b0a0090909000000000000000000000000000000000000000009000000b0900bfffe90db0fbffdbfdf9fbd9f9bffabdbfbdbdb0f90900000009090009000900090000000009000000000000a9e90a09f0bfafafebbcb9e9ebf0baf0ab9bafa9a0909a00000000000000000000000000000000000000000000000000000000bcbfc9909b0fbdbfff9fbe9daf9fdb9dbbdbdbcbf99ada00000000000000000000000000000000000000000009befa09a00bf0be9a9e0b0a9a9e0b009ef0e0fe9ac90a000900000900000000000000009000000000000000000000000000900b09009acbf0f9dbdaf9fbdffbf9adb9ffbcbdbdbf09f0909090000000000000000000000000000000000000009a9a909ad0b00adcb0f0900909a9a9e0a90bffa9eb0a090900090000000090009000000000000000000000000000000009000909009a09909f9fbfff9f9ff99f9fdf9fb9dbda9b99db0b9000000000000000000000000000009000000000000000af0e90abcbfbeb0e9a0b00a000900c90000bef0f9ada000900000000000000000000000000000090000000000000000000000000090a9f09b9f9bfbff9bff9fbbdbdffb9f9f9fabd9cb0909090000000000000000000000000000000000000909a90a90da009bcbb0f00f090900b0000b0009af0af009a9000000000000000000009000000000000000000900000000000090009009009bfbcbfdbdf9fcb9fbdf9fb9adf9f9b0d9a9b90000000909009000009009009000000000000009000009e0b0f0a9faeab0cb0b000000000900d0009009af00b000009090000900090090000000000000000000000000090000000000900090bdbc99fbdbfbf9fb9ef9fbff0f9f0f9adf9bbd9e9a90900000000000000000000000000000000000000a9a0bcb0ada009f0eb0009a900b009ac000000000009a0f0090000000000000000000000000009000000000000000000009000000900090b9afbdbffdbf9fdbdff9f9ffdbf9bdb9bd0b09000000900000000000000000000000000009000000900090009009ada0b90bcb000090900009c0d00000000090b0009000090000000000000000090000000000000000000000000000000090b9cb9dbff99f9fb9f9b9fffb9bf9be9f0bcbd0b9b9090900900000000000000000000000000000000000b0a9a9a9a09a9e0ad0b09009aca00000090090000009000090000000009000000000000900000000000000000000000000000000090909b9ebdb9fbffbcfbfffbdbdff9ef9f9fdbb9bd0d0b000000009000090000000000000000000000009090090000009a090900a000a9a90909000000c00090000000000000000000090000090000000000009000000900000000000000900900a9da9f9f9ff0f9bdb9f9bdbebf9bd9b9e9b9c99a9a09090900000000000000000000000000000090000a00b00b09a9a09a0a9a9090900090000090090900000000009000009000000000900009000000000000000000000900000000000000099a99f9b0f9bf9fdb9f9fff9f9ffffbedbcf9b0f9c9b09a00090000900000009000900000090000000000900090a00090009000000009090b090000000e000000000000000000900900900000000000000900000000000000000000900000000009e9adbbdf9b9b9f0bf9b9fbf9b99f9f9b9edbcb909c090900000000000090000000000900000000009009a0009090009000900909a00a0000000900009000000000000900000000090000900009000000000000000000000000000000000909ad9bdb9db0f9e9f9f9bdf9bdbfdef9f0fdb9b9b9cb0b9090090900000000000000000000000000000000a000a0000000000000000009090900900c0d09c09000000000000900000000009000900000000000900000000000000000000000000099bdb9eb9f9f9b0b9f9fb0f9f0bb9adb9b09e9e9a9090a00900000009000000000000900000000000009009090000000000000900090000009a090a00c0000009000090000000009000000000000009009000000000000000000000000090099a9a9e99db9b9bdbdb9e99f9a9bdbdf9afdf9b99c9b0090900000900000000000000000000000000090009000000900000000000090000909a000c0d0d0f0909000900000000090000090000000009000000009000000000900000000090000009db99fb90dada9b9f9fb9b9f9bdba9f99a9edb0b0d9a900900900000000009000000000000000000000000900900000000090000009090009090900cac0c0000000000000000000000000000000000000000000000000000000000000000009a9a9f990f9b99bd0b9090d0f9fcbd9f0be9f990f9b0a9ca90000000000000000090000000009000000000000000000000000000090000009000e0c0c9c909000900009000900000000000009000000000000000000000000000900000000000909d9adaf9ad0bd0bd0bdb9f9a9b90b0df990baf090d9009009000000009000000000909000000000000009000000000000000000000090b00f0d009a000c090000000009000009000000000009009000000900000000090000000000000000909a9bdb99099f0b90bd9b0b0bd0f9f9b9adabd99bda9a9009000090000000000000000000000000000000000000900900000000090090000900de900d0d000000090090000000000009000000000000000000000090000000000000009000000bc9bc9b0bda9090f90b0c9d90b90b09cb99d0b09cb90d0b00909000000000000000000000000000000000000090000000000000000000009adad00c000009c00000000000090000090000900000000000000000000000000000000000000000909b0b9c99090b9f9ab9f9b0bbd0b9f9b90b0f0f0b0f0b0909000000000000000000000000000900000000000000000000000000000000900c0dad090c90c00000000000000009090000000000900000090000900000000000000000000000090b90d9a9acb0bd0909c90b0bd90bd00a9cbda999099909000000000090000000000000000900000000000000000000000000000000000000009ecf0e00c09000090090000900000000900900000000900000000000000000000000000000090090f9bc90999d9a9ada9a90d09a9a9fbd0b909f0ad00bcb09090909000000009000090000000000000000000000000000000000000000000090009c90d0900009000000090000000000000000900090000000000000000900000000000000000009090b0b0b00b90999909a9b09c9090bd0f9a9990b00909a00000000000000000000000000000000000000000000000000000000000000000009e9c00cac09c00000000000000090000900900000000090009000900000000000900000900000b0b090099c9bd0f0b0f9f990db9bda909b90d0f09090a9c9090000000000000000000000000000000000000000000000000000000090000000900c09e9090000090900000900900000000900900900900000000000000000000000000000000990d009bda9a90b9bdb90b0f9b9adadb9e9eb9b09ada990b0000900900000000000000000000000000000000000009000000000000000000000000fc000c0c0090c0a009000000000900000000000000000000000000090000000000900000090090b9090999b9c999cbd99bc9f9bdbde909dada99090090090000000090000000000000000000009000000000900000900009000000090090000909c9090090009c0d000000000900000009009090909009000900000000000000000000000090b009be90f0db9be9b9adf9b9bdbbdbfff0b9bdac9a9a090090090000000000000000000000000000000000000000000000000900000000009000c00ac0c000c9009000000000000000000009000000000000000000000000000000000000009a099b099b9b90f99b9f9b9bdbdbdfff9f0fdada99a9c900b0000000000000000000000000000000000000900000000000000000009000000000909c9c9a90c9000c0e90090000900009000000009000009000000000000000000000000000090990b0d0bc9f9f99bdf9bdfdb9bfffbdfffb099f9ad90b09009009000000000000000000000900900000000000000000000900090000090909000ccac00c00000cb0d0c00000000009000900000000900000000000000000009000000090009a90e909b999b09bdbdb9f9bbffdf9fdfbf9fdfcb0f90a9000900000009000000000000000000000000000000000000000900000009090000000090b0c9e90d0d0b0c0cbc900090000000000090090000900900900009009000000000000000009099bd09fbdf9bdb9bdb9fd99bffffffdfffbfbdb0f99e9a909090000000000000000000000000000000000000000000000000000000909009a000c9f0c0cac00c09c9c0e090000090009000000000900000000000000000000000000000000909f09a9b09b9f9f9f9b9dbbfffdbfdbffffbdfdedb9e9909c00000900000090000000000000000000000000000000000000009000000000000090c9cc0c90909c9ce9e0c9c00009000900009009a0000000000000000000000000000000000900b09bdbd9f0f9fb9bdbdbfd9bdbdfffff9fdffbdb0f9bcb0b0090000000000000000000000000000000000000000000000000000009000090900cbca0f0cac0cac90c9cbc9e9000000009000000090090900090000000000000009009000000b9db09b09b99b9d9f9bdb99bfdbfbfffffffbf9fe9f0f0bc9090009000000000000000000000000000000000000000000000000090000090000909c0dc0f090d090e9cac0c0c0c900900000009000000000000000000000090000000000000090b09f0dbf0bd0bb99f9bdbd9bbdbdbf0db99fffdbff9bd9b0bc9000000900000000000000000000900000000000009000000000000000000900000fc0fc0c0c0e0c9c0d0f09c9a0000000090000900090000000009000000000000000000009a999b9b9099db9d9e90bda9b9d99f9e9fbdfff9fbfdbfcbadbc9a09000000000000000000000000000000000000000000000000000009000000000c0dec0dad009c9ca9e0c0ca0c09000900009000000009000000000000090000000000000909adad9e9f9fb0b9b99b909909a9b0999bdbbbdbff9e9e9bd909b090000000000000000000000000000000090000000000000000900000090000909c9e90fc0e9ec0e9c09c9009c9cad000a00009000090009000000009000090000000000000bd9b90b9b9b09dbe9dbcbb90f990d9f0f9fdfdbf9ffbf9f9eb9fc9e0000000000000090000000000000000000000000000000900000000000000000bccdc0f0d0dad0e9ca0c9c0009cad0909000090900000000000000000000000000090000d0b09f9da99bdb999b0999cbb9ebb0b9b9e9bff9fbdf9fdad9e9ab099900000000000000000000000000090000000000000000000000000000900000c9acbccadeade0d0ad0ac00d0c0d0a000090000a000000000000000000000000000000090b9f9a9b9f0db9adbc9bcb99d099d9f9f9bf9f9ffdfb9ebdbbdbd9fca0000900000000000000090000000000000000000000000000009000000009090edcccbde0d0c9cad0cd0bc00e9e0d009a00000909000000000000000000000090000090b9db9dbda99b9f9b99bf9b9f0bda9b09fffdffffffbdff9fbcbdbf0b90d0000000000000000000090090000000000000000000000000009000000000cd0bb0ce0fcadad00f000c0c90c9e0f000900900000000900000000000000000000000bd9eb90b09b9f9f09f9f999d099999999f99ffffff9fffbdb9f9fbc9f9e900000000090000000000000009000000000000000000000000000000000000daccc9e9c0fc0cad00dad09acbc0d00bc00b00090009000000000000900000000000000b99b9f9bd9f9b9f9bb9f9a9b9bd9bdf99f99fffffffdff0f09bcbf9cbda900000000000000000000000000009000000009000000000000000000000090dad9e9cad0bcf0dad0c0c0c90cb0e9c9a000900009000000000000000000000000009bdad9e9bf0b0bdb9bdd99999d9d9f999db9dbdfffffdff9f9bffbdbfbf0f0f090000000000000000000000000000000000000000000000000000000090c0dcc0e0d0ec90cac0e0dac90e90c9c0e90900a0900000000000000000000900000099e9b9b99f99bdb9bdb9b99f9990909999099fdfdfffffb9fb9f9bdbf0f9f990000000000000000000000090000000090000000000000000000090009000cbc0ad0f0d09ecbcbc9c0da0d0eda0bc900a009000009000000000000000000000090b9f9fdbf9bf99dbda99cb09999b9b09bf99999fffdffdfd90b9ffbdf9dbdbe90000000000000000000000000000000000000000000000000000000000009cf09ec0e0c090c9ca0f0cd0e90cdc00e9009000b090000000000090000000000000bda9f9bdbd9be999bdf9999900b9f9bffff099099dfdfbfbdbdb9ffbffbdadf0f0900000000000000000000000000000000000000000000000000000000900cdc9e9c90f0e9e0dc0cb0c9ce9a9ad00f00a9000000000000000000000000000909f9f9af9bfbd9be9b9909090b9bfbfffbffffff9d9b9fd90b90bffdfdbffffbf0000000000000000000000000900000000000000000000000000000000000f0c9e9e0ac0c9c0f0909cc9e090c0d00f0090009000000000000000000000000009f99bdf99f9dbad99cb090b9f9fffffbfffffffff00999bfbd9f9ffffffdbdfc9c90000000000000000000090000000000000000000000000009000000900d0cbeccd0d09e0f0c0cac0bc0f0e9e0bc0900090009090000000000000000000009a9af9b9bf9bbd9b9b909009bff9ffff9ffffbfffff0000999a99bdbfbf9ffffffb0a000000009000000090000000000000000000000000000000000900000edfc9e9ac0da9c0f0f009c0bc0d009c0bce9000090000000000000000000000000bdbdbdbf9bfdfbd0f090009bdbf9bfbc0bdbd09b90b909000990bdbdfdfffff9fdf99000000000000000000000000000900090009000090090000090000090000fe9ec9e0ccbdcd00da9cc9e0f0e0fc090090000900009000000000000000000db99bdb99f9b9db9090000b090090909990909909d0000009a09f9bfffbffdbffe9e0000000000000000000000000000000000000009000000000000009000ded09cc9e0d0bcca0ad0cce9a0d0c9d009e0000090000000000000000000000099a9fbdb9da9b9fb009000909909b90999b0f9bdef90999f9a9c9999bf9bdfdbfff9f090000000000000000000000000000000000000000000000000009a000dad0fecbc9cade0bcdcada90cdcadacacfc90009000090000000000000000000009f909f9fbdbdf9db90b9f090909099090999099999f9ffffdb09f0bdbfdfbbf9fdfbda900009000000009000000090000000000000000000000000900009000c0f00bcacbc0dccb0d00ce9a0f0cd0d00e0900009000000000000000000000000b9fb99a99b9b9b99e90b9f9bcb9da9db9fdbdf9fffffff9ffdb09bdbdbb9fddbfbedbd00000000000000000009000009009000000000000000900000900009a9dcfdc9c9c0f0e9cca0d09cc90cb0f0fc900000000900000000000000000000090f9dbd9bd9f0f9bc9bd9b9db99f999b9f9bdbffbfdffffff9a9db099bddb9fbfdffdbcb0000000000000000000000000000090000000000000000900000090ccad0ca0f0cbc0d0e90da0ca9acf0cc0c000090900000009000000000009bf0099bb9b9bfdbb9b9b99b90bc9b99f9dbf9f9bdbf9df9ffff9f0f99b9dbbdabfdbdfbfffe90090000000000000000000000009000000000090000000000900000c9ad0f0dc0f0c9cad0ca09c90cd00da9ede90000000900000000000000000bf000bd0f0f09b9c9f9da90bd99a9f9b9b99b9db999bbffffdff9f9f0d0b9db9d9fbfd9fdbdf900000000000000000000900000000000090000009000900000009cbcded000f00f0e9cad0d0e0e9a0f0cc090c00090090000000000000000000909090b99b9bd9bb99a9d9f9b09d09bc99f9da90f9d09b9fdbdf99a99b99f9dbf9dfbfffffbeda900000009000009000000000000000000000000009000000000c0c0e9efc90c90c9c0d00a0909c0d0da9ece90000000000000000000000000000000bdbd9f9b0d9f9db9b909bf9bd09b0b9b99f90b9fdfbdfa9f9f9f0db9b9f9ffbdffffdfdb00090000000000000000000900900900000090000000000090090d0d9c9c0ac9acb0e90cbc9cacadace9cc900009000000090000000000000000909b99cb9ad9f9f09b9ad09bd9090b999d99cb09b9ffffdbfdf0bd09bb9f9fbdffdffffdffed0900000000000000000000000000000000000000000009000000c0f0cadecd0c900d00f00ca909c0d09cb0c909000900000000000000000000000009cbb9f9db9b99f9d99b909b9b99e99a9b9090d9bd9ffdbdbdb9b99db9f9dbdffffffffdbbc00900000000000000009000000900000900000090000009009e9c0fcda9ac9e0fc0f0cf09ceda9e0de0cda00000000000000009000009000009090f9dff9b99f9f99b9bd9f909d9f99a99009b090b0b90fbdf9bd90f9bdbdbffffffffffffde9900000000000000000000000000009000009000000900000000c9c0bcfcd0e9c09e0da0de0900c9ca9cb09000090000090000000000000000000090bb99bdbf9f99f9bda99090b0990900990990bc90099db9bdb0999f9f9f9fdffffffffdfbca0909000000000009000000090090000000000000000090090d0e9cc9cbcad0e9e0dacde0dacad0e9c0c000900000000000000000000000000909a9bd9bdbd9bdfbdbdb9da9b909b09c90b099cb99f0909b9bc909b9f9b9fbffffffffffffed0900000000009000000000000000000900000009000009009ac0c90c9ebc0dac9c0f0c9e0f0c9dad0cada90000000900000000900000000000000090dbf9f9fbdb9dbdbdb9d09ad909b00d9b0b99f999bdffd9b9b99f99fffdffffffffffffdff00090000000000000000000000900000000000000090000c0dcbcdacdcf9c9acbc0f0e9c0f0ac0ad0d0c0090009000000000000000000000000009b99b9fbdfbdbf9bdbdbbd990b0999b09d99b99bdffffff0d09db9f99ffffffffffffffffcda90000000000000000000000000009000000000090000909c09c0cda9e0ca0cd09e0d0cbc0dc9ed0e0f090000900000000000000009000000090909fff9bdbdbdbdbdb9f9d9a999099bd9b9bddf9fffffffc9b9f9bdbfffdfffffffffffffffb00000900000000000000000000000000000900000009000a9ec9ebcde9f09c9a0e0dacbc0da9ac0f0dc00009000000000000000000000000900009bf9bdf9fbdbdbdbdf9f9b9db099ad9bdbf9fbffffffffdb9db9f9bdbdffffffffffffffd90d0090000900000000009000000000009000000000000000dcdaf0d0f0fcc0ac0d0bc90c9e0ccdad0e9ad090a00009009000000000000000000009a99f9f9fbdb9bdbdb9fbf9f90b0999bdbd9bbdffffffff0d9b9fffffffbffffffffffffffff00000000000000000000000000009000000000000000009adadc9ef0fcb0d09e0d0ed0f090b00dadce0c0a09009000000000000000000000000909f9bfbf9dbdf9f9bdf9d9f9bd990f90bdbd9fbffffffff9bdf9bdbdf9fdffffffffffffffcbf000000000000009000000000090000000000009000000000dafe9ef0fe000c0dad00e0cac0da0d0bcde909000000000000900000000000000000b0bd9f9fbdb9b9f9f9fbf9bdb9e999bdb9bd99fffffffd9bbbfdfffbfffffffffffffffffbd0900000000000000000000000000009000000000000000009ed0ff0ffad0c9adac0de9c9c9a0c9cacda9c000090000000000000000000900900099f9fff9f9f9f9f9bdbf9dbdbdb99a9d99f9b9ffffffffffdfdffbfdfdbdbdfffffffffffdf9e00090000000000000000000000000000900000000900900cb0fe0ff0ff90c00d0f00c0a00d0bcadf0cf09090000090000000000000000000009a99f99fbdbdbdbfdb9f9fbdb9bdbd9b0fb9dbdbdfffffffffffbfdfbffffffffffffffffffde9000000000009000000000000000000000000000000000909cff9fdafdac90e9e00da0d0c9ac09c00f0ce00000090000090000900000000000009a9ffbdf9f9fdfdf9f9f9bdbf9b9bf999dbd9bdbfffffffffffdfffdf9f99fbdffffffffffff0900000000000000090000000909000000000000000090cac9cafafdaff00c9c9edac90cb0c9acbcfce90900090000090000000000000000000009f9fdfbf9b9bd9fb9f9f9bd9f9f90bdb99b9dbdfffffffffdffffff9f9ffbdfffffffffffde90000000000000000000000000000000000000000000009c9ebdcf0bfcb0e9e0e9c0d0e90c9ac9cbc090000900000000000000000900000000099bdbdbbddbdbdbfd9b9b99f9f9b99f9a99f9f9bfffffffffffffb9f9f9f9bdbfbfdfffffffe9000000009090000000000900000000000000000009090de9ecd0ebcfcbfd00d0d0adad00da0d0e9cade90000000000000000000000000090090009bdbfdbbdbdbdb9fddbdb99bf9df9f9db999f9bffffffffffdedf0f9fbfffdfdffffffff9f000000090000000000000000900000900000000000000000c90bc9cdabcf0cf0acd0c0ecd0dac9ce9c0000900000090000009000000000000000090bbdbfdbf9f9bda9bbda9f099a9b09b99f9f9fdfffffffffcb9b9f9f9dffffbfffffbfffe9090090000000000000009000000900000000000090000090fcdcbcbcdcbc090dc9adad09ac0c9e0dcbde900009000000000000000000000000000009ffbdbdbbdbdb9d0909d09e9d99f9d9f9bdb9bfffffff99bdbc9090b90b9bdffdffffffd000000000000000000000000000000000000090000009000c0000c0c9e9efcac0a0cc0cbcc9e9e0d0ac00000000000000000000000000000000000909b9f9b9bdb9bd9a9a990b0990b0b9ab9bdbdffffffdd0bc990a90b090b9feff9fbfdfa9000000000000000000000000000000000000000000000000090dad0dad0fc99c9c9cb0f0c0bc0c0dacd0fc9090000000090000000000000000900000909fcbf9f90f9a99d99a9090a90909d0d9bdbf9ffffeb909a09909c99f9f9f9fffdbfbdb00090000000000090000000000900000000000000900000900c0c00cdac9ef0cac00c90dac0bcbc0dacd00e000900090000090000000900000000000090bbdbcbfb9d9b0b09099a9909090b9b9dbdbfffffd0e909000909a09b0fdfbdebcbdbc09000000900000000000000090000000000000000000000000900da0cdad0ff0d09e9ca0d0d0d0de0d9adf090000900000000000000000000000000090099b9b99db9a9d090b009000a909099fbfbdffffda9909090b9a999cdfbf0f9999b9a0900000000000000000009000000000000000000000009000000c90cd00de9ec0cac9c0cdacacaca0d0ecc000009000000000000000000000000000000090b9f0b0b0bd909bc90bd09990b090f99bdffffdf090b009090000afb0d099a09adbc900000000000000000000000000900000000009000000000000000c90ede9ed0f0d00ada0c9c9c9cdac9e9ed09a0000090000000000000000000000000000909d090900b0f00090bfa00909a99bfdbffffe99f00090f0009090df000099f9b0b0000090000000090000000000000009090000000900000000909c90cc9c0debd0cac9c0d09ac0fcbcdac9e9ca0d09000000090009000000000090000090090b0b90909090b0900009df00909099bbdbfff9e099090bc9000000a9009b090f0d0900000000000000000900000900000000009000000009090c0000c9a0cbcbcdcad09c09a0e09e00c0adf0ccb0da000900909000000000000000000000000000990b0b000bc0000f0be009a909a9f9ffffff99a09009a00909090009e909b90b000000000000000000000000000000000000009000090000c90f0d0c0d0cdcbe09c0e0bc0d0d0c9edadc0edbcde090b0c9a000000000000000000000000000909ad090900900909a090990090b9dbbdbfff9e009009000000000009e909e9cb009000000000009000000000000009090a90900000900000da0c0c000d0cbcbed0cbc9c0bc0ca9e090dcafdac0e9e000ab0c0000000000000000000000000000909a90099c000000900000900099b9ffbf9ff90909009009000009fe90a99a90900090000000000000000000900000009000000000000090009009e9c0e9cbc9fe9cac9c0da9c09ceca9c0edbe9c9f0ddeb090000000000000000000000000000909adb0b09090000099b009090f9b9f9ffbdf9ca090090009c9fbd00990bcb009000000090000000000009000900000009009009000000090c9c00c9c0c9cf0f90d0da9cadc0fca90dcbc9e0de9ecbfafc000090000000000000000000000000090909009bdad9cb9a0009a09b99ffbff9f0b9b0900909b0b9a0009bcbf0909000000000000000000000000000009000000000900090000c00009c000dacbcfccacac0ce9cafc09cfcac9ecde9ecbdafc090a000000090000000000000900000909a90b09009a0b000909009b09fb99f9ff9f00900900000900909a09009000000000000000000000009000000000009000900000900909090d0c090d0c9cbcb0d0dad09cad0ade009cbed0f0edbefff900d9c90000000000000000000000000090990d9e0909900900909909db99fbff9f90db0090909090090b09090900000000090000000090000000000090000000900090000000c00c000900e0dacf0fe0e9c0adad0fcfadede9c9adaf9edfbefef0a9a009000000000000000000000000000a9a990b000990900000b090f99f9b9e9b0900000009090090000000000000000000009000000900000000000090000000009009090d09c0c0ad0d0d0de9fc9cadcc00e0f0dadacadeffdefbfaffbdadfed0000000000000000000000009009099090a9090900000900009fb9bf9fff9f9dad000000000090909000000090000000000000000000000090000090009090900000000e0c00909c000c0f0de99cad00bcf0d0fef0e9debebebfefffffedfada09a09000000000000000000000000000909090000090000999b999f9fbf9da9b99a90900000000000000000000009000090000000000009000090000900000000000009c909c00c09cf0f0de9ee9c0fcc90dad0d0ed0e9fdffffbfffeffadfad009000000090000000000000000909b0009000900009090be9dadb9f9f9fb9f0f09000090090000000000000000000000000090009009000000000b00900090090009c000c00d090c00d0cf0ffcbed0bce0c0adadbede0cbeffeffeffbffebda0009009000000000000000000000909b9a09000090ca9c9d9b9b9f9fbdf9f9db9f9bd9f090090000000000000000009000000000000000000900d00d00a90000009009cd09c00c0c9c0c9e0f0fadcbec90dadc0cac9adcbcbfbffffffeffbfe0d000a900000000000000000000000909c99a9dbda999b9fb9fdf9bdbdbff9bbdb9e90b00090000000000900900000000000000000000000000c9a9fa9ed009090000c0a00c09c00b00bce9cdaddfafc9ede0c9e9c9edcbcfdfeffffbffffefe9000900000000000000009000009090b9b9b9db9bf9fbdfb9db9b9fbffff9ffdbdf9b9009000900900000000000000000009000000000009000fadfcbde90f000090090d0d00c090c0dc09cfadfeadbfe9e9cbc0e9e9eadc9afffeffeffffff9e90009a090000000000000000000009099adb09f99bf9fbdffbfdf9f9f9fff9bf0b9fc9009000000090000000000000000000009000000000900debfefbef0dcb0000c0000d090c09c00fcb0dfa9decbfebedcbc90c0dcacfc9ffffffffebfefefe9009000000000000000000009090b0d9bdbdbf9dbf9fb9bd9fbfbf9fb9ff9f9f09b00000000000000000000000000000009000000090000090dfbffe9edacc9ca909c000c090c00d00dcf0dfcadbf0fffabc0edada9cbcbebfffffffffffbfc9000009009000000000000000000909b90b9b99fbd9fbdffbfbdbdbdbcb9da9bdb0009000000000000000000009009000000000000000000000fafffbfdad0f0c9c0c09c900c09cdacd0e9ebc9c9ecfff0fcde90cc9efc9edfeffeffefffffcb000909a00000090000000900000909b09f9ff9fb9fbdbdb99f9fdffbdbd9a9d090909000000000000000000000000009000000000900009000dbdfafcfadad0c9c0c90c000d09c000dac9cbcfcbcf9e9ef0fa9edebcc0bcdadbfffffffffefbc0900000000000000090000000090909da9b99b9dbdfbdbdbf9f9b9bdbdbc9b09a90000009009000000900009000000000000000900009000090faffbf0fc0c9cac90c090d000ca0dc0dadedf0edacbcf9efdecbc9cbdccadcadfbfffffefffef00009009000000000000000000009a999f0f9fbbdb9fb9bdb9f9f9cb9a9b00909090000000000000900000000000000000000900000000c0000dffffff0fde0dc0cb0c000d0d0d00f0cd0f0fffadfcf0f9fafbcfaccadadadcfafffefbffffff0f09009000900000000000000000009a99b9b0ddbdbdbdbf9db9eb99f9d0090b000000000000000000000000000000900900000009000900909ebffebcf0c0d009c0c90d000c00c9c9cad0f0ffffafbfef0ffcf0cdadad0c0dadfefffffbefbef0000000000000900000000000090909da9dbdbbb9b9f9f99bbd99db09b0909009090090000000000009000000090000000000000009000000cbfffbdf0dad0e9c009c00c0d00d0c0cadcf0fffbfffefbffebe9ef0d0de0f9edadbfffeffffffdf0909009000000000000000090009a9bdb9f9f9dbdbdb9dbc99a9b0f09a000900000000000000900000000090000000000090090000009000bdffffebedc0d0c09c00d09e09e0dad0dadadf0fefffffefbdf9e9ebce0dccc00decbfffffffffafc0a090000000000000000000000090090b9b9bbdb9bdbb9b9bd0990909090090000000000090000000000000000090000000000000000090cbfffffcbcbc0d0c09c00e09c0d00d0e0d0f0fffffebffdfeebeffdedbdada9fcad9fcbffeffefff090000000000000000900000000909b9bdbdbc9b9f9bd0f9f9a9f09a900090009000900000000090000000000000000090000009009000009efffffbcbccbc0bcc09c9c00d0cd0c9de9cf0fffbffdafadbdfbfafacecadcc0d0ecbeffbffffadac090009000000000000000009009b0d099b99bdb9be9b9b0d9900900909090000000000000000000000000009000000000000000b009cc9ffffefbcfcc90c9c0a9c000cd00f00fce0de9fc9efcbedadafafeffffbdbdadade9c9cd0fffffffef9c00900000000000000000000090099bcbdbbdbdad99bc99a009b09000000000000000000000000000090000000900000090009000000bcfbffbfef9e9ed0c0d0c09cd0a9c0cd0d0de9efbe9ebc9ededfffbfffffefedadade9e0fc9efbefffafbc00000000000000000000000090a09b09c9b9b9bbd9bc999a090090900090000000000000000000000000000000900000000000900009efffffbfe9c00d0c0c9c00ad0c9c9acada9e9cfcfc9ef0fbfafffebfeffbfffffe9edbcbcbdffffbffca9000009000000000000000090999009b9bc9bd0d0b90b00900090000900009000090090009000900000090000000900000909000900cbffffffcbeded0e90d0ad0d0c9cacd0dcde9efb0f0fe9fbefffafffffbfffaffafffbedf0fefbfefeda90090000000000000000090000000a990d09bd9b9b9a900b09090090000000009000000000000000000000000000000000900000000dbffffffebf0d00d0cc00d0c0c9e0c9c9e9e9edbcf0f9ffefffbffffffffefffffffbeffbefdbeffffbffc0000000000009000000000009090900b9b099a909c9090900000000090090000000000000000000900900009009000900000000900adbfffffffcf0cf0d09ad0d0f0c9c9cadcf0deaffffefaf9fafeffffffffffffffffffffffbeffbfffefbf090000090000000000000000000909009cb0d9bda99a090090090090000000000000000900000000000090000000000000000900090efffffffbf0f0c0cc0c0c0c0d0c9e9c0e9ebdf0ffafbffefffbffefbeffffbfeffefffeffffbffefffbcf00090000000000000000000009000090b099a9c9900900090090000000000009000900000009000000000090090090009000900090dbfffffffffe9e9cb0d0dad0d0e9c0c9e9c9ce9fffdffcfbfffffffffffffefffbffffbffefffefffbfcfb0900000000000000000000000000090090b090b09a9009000000000090000000000000000000090009000000000000900090000b0effffffffffe9cd0d0c0c0d0e0c9c0cdadcfefbffaaf0fbeffafffffffffbfffffffffffffffffffbfefbfc0a0900000900000000000009000900900909a90b00900090090009000090000000000900000000000000900009000a0090090ad0fdbfffffffffffe0c0c9cbc00d0d0d0f0cda0dadadffbfeffbffffebfffbffffffffffffffbffbfffffffebf09000009000090000000000000000000900090909000900000000000000090009000000090000000000000000009090000000dadafffffffffffff9f0f0c0c9c90c0cad0dacde9cffaffeffbfefffffffeffeffffbfefbffeffffefffffffffc90090900000000090009000000000900009000090909000900090000000000000000000000090090000000900000000009009affffffffffffffffecd0c9c90cac9e9c0c0d0f0fbcbdfffbfffffffbfffffffbfefffffefbffefffffefbfafcbc0b0000000000000000000000000000000009090000000000000009000000000000000000000000090900000909ac9090009efffbffffffffffffe9f00dac0c9c9c0c0d0f0f0decbffafffefffbfefffffbffffbfffffffffffbfffbffffffbe9000b00000900000000000900000000909000000090009000090000000000000000900009000000000000900000900009000bfffffffffffffffffc0fc0d0d0c0c9c9cad0ccfadbfcbfffffffffffffebfffffffffffbffffbfffffffffffeff0900090000000000000000000000000000000009000000000000000000000009000000000000009000000000900009000090bdaffffffffffffffbfc0d0c0cb0cbc0e9c0da9cdacbfcfffbffbeffbfffffefbeffffafffffefffffefffaffbdac009000900000090000000000009000000000000009000009000000900000900000000900009000000000009009000009000cbfffffffffffffffedad0f0d0c0d0c9c0d0edcb0fdadbfffffffffffffffffffffbfffffefbfffebfffffffeffe90900090000000000000000000000000000000000000000000000000000000000000000000000000090009000ac0090b000dbfffffffffffffffadad0c0c0c0d0c9c0dac9cadedafffafffafffbfefbffbfffffeffffffffffffffffafffffad00009a00000000000000000000000000000090000000009000000000000000000009000000000009000000090909a000000bcbfffffffffffffff0dc0d0dad0cb0cbc0d0e9dcb0fdadffffffffffffffefffffffffffbfffffffffbffffffffefc00090b09090000000900000000000000000009000000000000900000900000900000009000090000900000000009090900bffffffffffffffeff0dac9c0c9cc9c0d0c9ccadedaffaffffffbeffbffffffebffffbeffffffebffffffffeffff0b0900000000009000000000900000000000000000900000000000000000090000000009009000000000909000909000000dffffffffffffffffbcf0c9e0d0e09c0d0f0e9ad0f0fcbdffffffffffffffbfffffbffffffefbfffffeffbffbfff0fc000909000000000000000000000000000000000000000000000000000000000000000000000000900000009000000b09fbffffffffffffffffde9ed0c9c0c9c0f0c0c9cdcf0fcbffafbefffffffefffffffffffffbffffffffffffeffffeffbde9000009000000000000000000000000900000000009000000000090000000009009000000900000000000000009000afffffffffffffffffef0cd0c9c0d0c0d0c9c9ce0f0fcbf0ffffffbfffbfffffeffffeffffffffffffffbfffffffbfefbca9090000900000000000000000000900000900000000000000090000900009000000009000000009000b0090900009fffffffffffffffffffbf0adac9e0dac0dac9e90f0f0fcff0ffffffeffeffbfffbfffffbeffffffebfefffffbffffffbcf9c0a09000000009009000000009000000000009000000090090000000000900000900000000000000900000000099fffffffffffffffffffffcfd0c9c0d0c9c0d0c0cdc9cf9adafffffffffffffffffffbfffffbefbffffffffffffeffffbefbca909000000900000009000000000000000000000000000000000000000000000000900000009009000909009090fffffffffffffffffffffebc0c9cad0c9c0f0c9cbcadebcffffbfffbffbffbfffbfffeffffffffefffffbffefffffbeffffcf90c009090000000000000000000000000000000000000000009000000900009009000009090090000000000000bfffffffffffffffffffffbcbcbc9c0d0e9c0d0e9c9de9cfbcbcffbefffffffeffeffffffbfffffffbffffffbffffffffffbfafb0900000009009000000900000000000900000000090000000000000000000000000900000000009000090909ffffffffffffffffffffffdfc9c0c9c0d0c9c0d0cac0de9cfbfbfffffffeffffbfffbffbfeffbfffffffeffffffbfffffaffffde9e0909000000000000000000009000000000090900009000000000000090000009000000900900009090000ffffffffffffffffffffffffade9cbc0d00d0e9c9c9cfa9ef0fcffffffbfffffffffffffffffefffffffffffffffeffebfffefbebe09000090000000900000090000000000009000000000000009009000000000000000900000009a9000000fbfffffffffffffffffffffebcd0c9c0dacdac9c0e9ed0dcf0fbffaffffffffbffffbfeffffffffffffefffbffaffffffffffffffdbda09000009000000009000000009000000000000000000000000000000000900009000909090000000090fffffffffffffffffffffffdfcadac9c0d00d0c9c9ccbceb0fedadfffffffbffffeffffffbffbffffefffbffffffffffffffffbefefadbc09000009000900000000000000090000000000000000000000000000000090000000000c90c9c90cbfffffffffffffffffffffffbe9d0d0cbc0d0c9cad0d0c9cde9fbfbfffbeffffefffffffbfeffffffffbffffefffffbffbfefbfffbfbdbca9000000000000900000000000000000000900090000900000009000900000000090000b000b0a00bffffffffffffffffffffffffefced0e9c0dad0e9c0f0ade9ade9edeffffffeffffbfffffffffefffbffffbfffbfffffefffffeffffffefe9009000000000000090090000000000900000000000000900000000000000000900009000bc0009fffffffffffffffffffffffffff9e90c9c0d0c0c9c0d0cdc9ede9efbfbffffbffffffffebfffffbfffeffffefffffefffffffbfffebfefbf9ef0090000900000000000909090900000000000000000000000000000000900000090090009090afffffffffffffffffffffffffffe9cf0c9e0c9c9c0dac9cbc9e9ff0fcfffffffffffffffffffffffffffffffffffffbfffffffffbfffbfcff9eda0090000000900000000000000000000000000090000000000000009000090000000090000dfffffffffffffffffffffffffffffe9cd0c9c0e9cbc0d0e9cfcbc0ffbfffffffffbffffbffffafffffffffbfffffffffffbffeffffffffffbeffad090000009000000090000000900090000090000000009009000090000000000909000090fbffffffffffffffffffffffffffffbcf0e9c0d0d0c0d0c9ccbcbcff0fcbfffbeffffffefffffffffbfebfffeffffefbfffeffbfffffffeffaffdbcf0c000000000000900000090000000090000000000000000000000000090009000009090cbfffffffffffffffffffffffffffffcf0c9cad0e0d0d0adacbc9cbf0fbffffffffbefffffffeffffffffffbffffbffffffffffffffefbffbfffbefbfa909090000090000009000000000000000000000090000000090000000000000090000bbfffffffffffffffffffffffffffffff0fd00d0c9c0dacd0c9c0fed0fde9ebfffffffffbfffbffbffffffffffffffffffffbffffffbfffffffffffbcfcbca000000000000900900900090000000000000000000000000000900090090000090cbfffffffffffffffffffffffffffffbfc0cf0c9c0d0c90c9cadd09ef0fbffffffffffffffffffffffafffffffbfffffffeffffeffffffffffebffeffbfcb09090000000000000a000900009000009000000000009000009000000000090900bfffffffffffffffffffffffffffffffef9f0c9e0d00f0cdac9d0ede9cfade9fffffbffbffffffffffffffffffefffeffffffffffffffffefffffeffbffcbc9c0009000090009090900000000009000000000090000000000000900909000acbffffffffffffffffffffffffffffffffd9e0c9c0dacd0cf00dace9cbcbe9fbfffffffffffeffffffefffffefbfffffffbfffffffffbeffbffbffffbffebffffbe9009000000000000b00900000000000000900000000009000900000000909bfffffffffffffffffffffffffffffffffaed0dac90c90c90cd0c9de9cf0dfcfbffffefffeffffffbffbffffffffffffbfeffbfefbfffffffffffffffffffebcbcbcbc0000000090090000009000000000900000000900900900e0009000000cbfffffffffffffffffffffffffffffffffdbcd0d0ed0cbcc90e9ca0de9efafbdefffbfffbffbffbeffffffffbfffbfffffffffffffffffbfffffefbffebffbfffffbe9ad0900900a9009090000090000000000000000000000090900009000dbfffffffffffffffffffffffffffffffffbedade0d00d0c90e9c0dcde9e9cdbcfbffffffffffffffffffffeffffffffbfffffffffffffffffefffffefffffffffbfbffff0b009a0990c9ac00090000090000090090090009090000009000c9fbffffffffffffffffffffffffffffffffffedad0c9c0de0d0c9c0da9e9cbdebefbfffeffbffffffffffffffbfffebffeffffbfffffffebfffffffbffffffffffafffffbfbfebc09facb9e9bc9000900009090000000000900000909000090b0fffffffffffffffffffffffffffffffffffffbcbc9cbc09c0f0c0f0cd0de9e9f9edafffffffebffebfffbfffffffffffffffefffefffffffffffbffffffbffffffbffbfffffbfb9a9dacb9ebfa9e0c0900000000000900000900000090090cfffffffffffffffffffffffffffffffffffffffffc9e0c9cc9c0d0d0dacf0de9ecfbfffffbfffffffffffffefffffbffffbfffffffbfffbfffebfffffefffeffebffffbffffbffffedabdbfefdade9fbca9a909009090009000009000000f0fbffffffffffffffffffffffffffffffffffffffff0fc9c9e09c09cbc0d0d0dade9bcf0fbfffffffffffffffffffffffffffffbffffffffffffffffffffffbfffffffefbfffbfffffbfbfde9fbfbffbffcbdac00a09000000000090009090f0ffffffffffffffffffffffffffffffffffffffffffef9e0d0c9ec9c0c0f0cbcbcf0fcfbffffffebfffffbffbfffbffafffbfffefffffffffefffffffeffbffffffffffbfffbfffffbffffafbefffedafebffedbf09c0009a90900000000acbffffffffffffffffffffffffffffffffffffffffffffbc0d9e0d009cad0d0c9ce9e9edbbcfbfffffffffaffffeffffffffffefbffffffffffbffffffffbfffffffffffffffbffffbfffffbffffbfbfbfdbdfafbe9ef0bdad00c0ad09000d09ffffffffffffffffffffffffffffffffffffffffffffffffce0d0cdcc9c0dad0f0dcde9ecfbdefffbfffbffffffffbfffffffffffffbfebffefffffafffffffefffefffffefbffbfffffffbffbfbfffeffaffbffffff0fcadaf0bfcaacc99afffffffffffffffffffffffffffffffffffffffffffffffff0bd0c9a009c09c0d0cdada9e9f0fbfbfffffffffffbffffffffffbffffffffffffffffffffbfffffffbfffbfffffffbffbfffbffffffefbfbfbffafffbef0ffadbfcbfcbfdfbfefffffffffffffffffffffffffffffffffffffffffffffffff0fcccbcdcfc0bcc9cadadadcfdafdefffffffeffbffeffffefbffffffffbffffffbfffbffffffeffbfffffffeffbfbffffffbffffbfbfbffeffebfffbffbffbcfbcebdebcfafebfffffffffffffffffffffffffffffffffffffffffffffffffffc9a9c00000dc9ac0d0c9cfadadebdbfffbffffffffffffbfffffeffffefffbfffffffefffffffffffffffffffffffbfbffffffffffffffbfbffffbffffffadbcfbdebdfbffbfffffffffffffffffffffffffffffffffffffffffffffffffffe9fcd0dedcd00cc9cbcbcf0dcbcbdebfffffffbffffbfffffffffbfffbffffefffefffffffbefffffefffeffffffeffffffbffbfbffffbfbffffbffffffffeffebedebcafcbfffffffffffffffffffffffffffffffffffffffffffffffffffffff0e9e0909ac909c90cd0cf0bcbdebdebffffffffffffffffffffffffffbfffffffffffbffffffbffffbfffbfffffbffbfffffffffbfbfffffffffffffffffbe9e9ebcbfdbeffffffffffffffffffffffffffffffffffffffffffffffffffffff0f9c0dcccc9eccacc9acf9edede9ebfffffbfffbffffffbffbfffffffffffbffbffbfffffffffffffffffffffffffbffbffffffffffffffffffffffffffafe9edbcf9edaffbffffffffffffffffffffffffffffffffffffffffffffffffffffffce9c00b09c909c9bcd90cf09e9fdfbffffeffffefbfeffeffffffffeffffffffffffffffffffffffffffffffaffefbfffbfbfbfbffffffffffffffffffdbde9ecbce9edadefbffffffffffffffffffffffffffffffffffffffffffffffffffffbd0fcdcc0ccd0cc00ecf0cfcbcbe9fffffffffffffffffffffeffbffbfefffefffefffeffebffebffefbfebffffbfffbfffffffffbfffffffffffffefbef0fcbde9fcbcfbffefbefbffffffffffffffffffffffffffffffffffffffffffffffbecf00090b09a090dd09cf9cbcfe9febfffbffbffffffbffbffbffffffffbffbffbffbffbffffffffbfffffffffffffbfffffffffffffffffffffffbfbcf9edada0f0ada9e9adbedbeffffffffffffffffffffffffffffffffffffffffffffffed90dcfccccccdeccacde9cadcb9edbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffafbffffbfbfbfbffffffffffffbfeffbecb0dcedcedcedcefce9edbfffffffffffffffffffffffffffffffffffffffffffffff0ec0009090900909cbc0ced0fcffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbfbffffffffffffffffffbffbfbedbfcfad9e9dad9e9dadbc9ecbfffffffffffffffffffffffffffffffffffffffffffffff9dedccdcccdccd0dcbdbdadadadebfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbe9e9cac9e0dac9e0dac9e9ffffffffffffffffffffffffffffffffffffffffffffffff0ca900b00b00b00e00c0c0dadadbfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdefdefdefdefdfffffffffffffff000000000000000000000105000000000000a9ad05fe, N'Janet has a BS degree in chemistry from Boston College (1984).  She has also completed a certificate program in food retailing management.  Janet was hired as a sales associate in 1991 and promoted to sales representative in February 1992.', 2, N'http://accweb/emmployees/leverling.bmp', 'leverling@northwind.com', '343454356' ), 
( N'Peacock', N'Margaret', N'Sales Representative', N'Mrs.', N'1937-09-19T00:00:00', N'1993-05-03T00:00:00', N'4110 Old Redmond Rd.', N'Redmond', N'WA', N'98052', N'USA', N'(206) 555-8122', N'5176', 0x151c2f00020000000d000e0014002100ffffffff4269746d617020496d616765005061696e742e506963747572650001050000020000000700000050427275736800000000000000000020540000424d20540000000000007600000028000000c0000000df0000000100040000000000a0530000ce0e0000d80e0000000000000000000000000000000080000080000000808000800000008000800080800000c0c0c000808080000000ff0000ff000000ffff00ff000000ff00ff00ffff0000ffffff00fdb9bfbffbfb9fbdbbbfdbf9fbfbfbfbfbfbdbfbdbfbbfbfbffd0000000000000000000000000000000000000000000000000000000000000000bbdbf9bdbf9bb9bfb9fbfb9fb9bbfbbbbfbbfb9f9b9fb9bf9bf9bfbbfbbfbdbf9fbdbf9f9bdbfbfbf9fbb9bdbb9bbf9bbfbfbfbfbfbfbfbfbfbfbfbffbfbfbba00000000000000000000000000000000000000000000000000000000000000009bfb9fbb9bbdbfb9bfb9bffbdbf9bdbdbbdbbffbfbfbffbbffbbf9f9bdb9bbfbbfbbfbfbfbbffb9f9bb9fbfbb9fbdbfbfbfbf9fbfbdbf9bfbfbfbfbf9ffbfbd00000000000000000000000000000000000000000000000000000000000000000bfb9fbb9fbdbb9bbfbdbf9bbbfbbfbbb9fbbdbb9bfbf9bbdbb9fbfbbfbfbff9bdb9fb9bdb9f9fbfbbfbfbdb9fb9bb9bfbf9fbfbdbfbfbfbf9fbfbfbfbfbf9fb000000000000000000000000000000000000000000000000000000000000000009bffbbdbb9b9fbdbdbbfbbf9fbdf9bdbfbdfbbfbf9bfbffbfbfbdbff9bfb9bbfbfb9fbfbbfbbf9bdb9fbbbfbbdbdbf9bdbfbfbfbfbfbfbfbfbfbdbfbfbfbfbf0000000000000000000000000000000000000000000000000000000000000000009bbf9bdbf9b9fbbbdb9f9bf9bbbfbb9bbbbf9bfbfb9bb9fbdbfbb9bfb9fbf9bdbfb9f9f9bdbfbfbbfbdbfb9fbbb9bbfbbbdbfbfbdbf9fbfbf9fbfbfbfbffb0000000000000000000000000000000000000000000000000000000000000000000bdb9fbb9bbfb9bdbbbfbbfbfbdb9bdbf9f9bff9fbdbffbfbbfbdbfb9fbbdbfbbb9bfbbbbfbbfb9bdb9bf9bfb9f9fbf9bffbfbdbfbfbfbdbfbfbfbfbffbf9bf0000000000000000000000000000000000000000000000000000000000000000009bbfbb9fbdb9bfbbbdb9f9b9fbbbfbb9fbbf9bbbfbfb9bb9f9bbfb9fbbdbbbdbdbfb9fbdb9ffbfbbfbfbfb9fbbbb9bbf9bfbfbfbfbfbfbfbfbfbfbdfbfbff90000000000000000000000000000000000000000000000000000000000000000000bf9bdb9bb9fb9f9fbbfbfbfbdf9b9fbbf9bbfbf9b9fbfbfbf9f9fbbdbbf9fbfbf9fbdbbfb9fdb9f9b9f9fbbdbdbf9fbfbdbbfbdbf9fbf9fbfbfbfbfbfbbbe00000000000000000000000000000000000000000000000000000000000000000009bfbbfbdbb9fbbb9f9b9bdbbbbbdb9f9bf9fbdbfbfbb9f9bbfbb9fbbdbbf9b9bbb9bbdb9fbfbbfbfbfbbbdbfbbb9bb9bfbf9bbfbfbfbfbfbdbfbfbffbdff90000000000000000000000000000000000000000000000000000000000000000000bdbdb90b9fbb9f9fbbfbfbf9f9fbbfbbfbbfbbf9f9f9fbfbdbdbfb9fbbdbbfbf9fbf9baf9bfbdb9bdb9bdbfb9bdbbdbfbfbfffbfbfbfbfbfbfbdbfbfbfb9a00000000000000000000000000000000000000000000000000000000000000000009bbbbbfbf9b9fbbb9f9f9b9fbbb9f9bdb9f9bdbbbbbfbb9fbbbfb9fbbdbbdbb9ebb9fbf9bffbbfbfbfbfbb9bfbbf9bb9fbdbbbdbfbdbf9fbfbfbfbfbfbff000000000000000000000000000000000000000000000000000000000000000000000bdbdb9b0bfb9f9fbbbbfbfbdbdbbbfbbfbbfbdbdbdbdbf9f9f9fbbdbbdbbdbf9f9e9b9fa9fdb9f9b9f9fbfb9f9bf9fb9bbffbfbdbfbfbfbfbfbfbfbfbbf0000000000000000000000000000000000000000000000000000000000000000000009bbbdbdb9bdbbb9f9bdbb9bb9bdb9bbdbdb9bbbbfbbb9bbbfbb9fbbdbb9fb9bbbbbf0b9fbfbbfbbfbfbbdb9fbbf9b9bfffb9fbfbfbfbfbfbdbfbf9fbdf9a000000000000000000000000000000000000000000000000000000000000000000000bdbbbb9fb9bdbfbbfbbdbf9f9bbfbdbbbbfbdbdb9f9fbdb9bdbb9fbf9fb9f9f9e9bbfa00f9fb9f9fb9fbbfbfdbbbfb9b9bfbbfbf9fbdbfbfbfbfbfbfbb0000000000000000000000000090bcbc9f0a9e000000000000000000000000000000009bf9f0fb9bfb9b9f9bdbb9b9bbf9bbfbdfbdbbb9fbfb9bbf9af9fab9ab9fab0b9fbc0000fb9ffbb9fb9f9bdbb9f9bdbfbfbbf9fbfbfbf9fbf9fbfbfbf9000000000000000000000000da0f0bcbf0fdf9fbfeb00000000000000000000000000009bb9bb9fb9bfbfbfbbdbf9bf9bbdb9bb9bbf9fbb9b9f9e9fb9b9f9fbdab9dbfa0000000f0b0bdaf9fbbfbbfbfbfbb9bfbdfbfbfbfbfbfbfbfbf9fbdbe00000000000000000000009abdfdffbdff9fafdf9fdffaf00000000000000000000000009f9f9a9fbdbb9bbdbb9bf9bf9fbfbdbf9b9b9fbf9abb9b9fbfa9b0bbdbeb0000000000f0000090b0bdadb9f9b9f9fb9fbbdbbdbbdbfbfbfbfbfbfbf9000000000000000000009effdbfa9fdfb9fdf9faffbf9f9e9090000000000000000000000bb0bf9b9bbdbf9bbdb99bb9bb9b9bb0bfbfa9a9bdbcbfa9a9bf9fbca0000000000000b000000000000b0fbfffbfb9bfbfbffbffbfbfbdbfbfbfbfb0000000000000000009bbffbcbebdfffadfebbfbdf9f9fffbffac000000000000000000000bdbf9bbfbdb9bbe9b0bfbdbf9f9fbdbf09b9bdbcbbb9b9bdbf0a00000000000000000f00000a00000000009a9bdbffbf9fbbf9bfbdbfbf9fbfbf9bc0000000000000000bedf9fdfdbdfbf9ff9bdfdfbffffdbdfcbdbcb00000000000000000000b9bbdb9bbfbdb9f9f9b9bb9bbb9ab9bbf9e9a9b0f9fbe9a000000000000000000000f000a0000000000000000b0b9fbfbf9ffbfbfbfbfbff9fbfbb00000000000000bc9bffebfbfdafdff9ffdbebdf9e9fffbffdbdbcbdac00000000000000000f0bbdb9fb9bfb9b9bdbbdbdbdbd9e99a9bdbfbf9a00000000000000000000000000d000000000000000000000000b0fbdbbbf9fbf9fbfbbfbfbd00000000000000bcbffdbdbde9bf9fadfbcbdbdfbffbf0bdf9bebcbdadb0d0000000000000099bd9bbfb9fb99e9bb9bd9bb0b0bb9bfbf0b00000000000000000000000000000000a000000000000000000000000009bfbfdbbf9fbfbf9fbfbda0000000000000adbdfdaffdfbffdfbdbadbfbdb9ff9fdfff9ffd9f9a9f0f0a90000000000000bfbbbf9bfbdbfb9f0fb0badbdbbdbe0000000000000000000000000000000000000f00000000000a0000000000000000bfbbffbfbfbfbfbf9fa000000000009c9f0fbfbfdbe9fdafbdffdbdbcbff0fffbf9ff0fbf0f9e9f9f9e90000000000000b9f9bf9b9bb09b9bbdbf9a9be9a000000000000000000000000000000000000000f000000000000000000000000000000fb9fbfbfb9fbfbfbf00000000000a9e9f9edfbfdbf0fdbfadbfff9fdadf9fdfbfbdf9f9f9f90bcbcbcb0000000000009a9fb9fbbc9f0fbda0000000000000000000000000000000000000000000000000d0000000000000000000000000000009fbbdbf9fbfbdbbf00000000009bcb9bcfbfbdfbdbfbffdfbd9e9f9bdbbffbfdfdbfbcb9e9ebdb9f9ad0f00000000009fbb9fb9fbb0b00000000000000000000000000000000000000000000000000000a0000000000000000000000000000000bffbfbfbfbfbff90000000000fcbdeff9fdfebdafdfbdfbdafbf9adb0fdbfdbfbf0dbde9f9d0bcbcbda09e00000000b9b9fb9f0000000000000000000000000000000000000000000000000000000000f000000000000000000000000000000009bfbdbfbdbfbb000000000009bcfbcbfaf9f9fdbbdebbcbdbd0bda9f9bdfbedadbf0b9f9afbdb9f0b9f09c00000000fbf9fba0000000000000000000000000000000000000000000000000000000000f000000000000a000000000000000000000bfbfbfbf9ffe0000000000e9bdfbdfdbfffbfdfbdfdbdadbf0bd00f0b0dbdb0dbdadad99e9e9bd0f0f0b0000000099bb9f00000000000000000000000000000000000000000000000000000000000d000000000a00000000000000000000000099fbdbfbfbb000000000909febfdafbfdbdf9bfcbfafbdbc9bcb9f09cb09a9da09099a9e9b9f0bf9b9e9e0000000bf9fb000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000bfbfbfbfbd00000000000bcbdafffdfaffaffdbf9f9c9e9bc90f09fbdbe9da9bdbfa9f090f09f90fcb90d000000b9bb0000000000000000000000000000000000000000000000000000000000000f0000000000000000000000000000000000000bffbdbfb0000000000c9fffdbdbfbdbdf9fad9f0fbf9e9fbf9ff09a909a9c9a90d0bbdb9f9adb9b9e9ad000000fbc0000000000000000000000000000000000000000000000000000000000000f000000000000000000000000000000000000009bfbfbfc00000000b0a9bffeffdfffbff9fbefbd0f9fbdbda99f0dbdbda9f9e9b9c9adb0f9adada9f0ac0000b9a000000000000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000fbfbdba00000000009ffe9f9faf9fdbff9f9f0fbfbdfadadbe9fbcbdbdf9e9bcf9bdbcb9e9bdb9e9bda00000f000000000000000000000000000000000000000000000000000000000000000e00000000000000a00c090c000000000000000009bfbfbd000000009cfef9fbfffdffbfd9e9e9f9fbdebdbf9fdbc9fbcbf0bdbdb9bcbcb9f9bc9adb9ca90000b00000000000000000000c0000000000000000000000000000000000000000000f0c00a000000a0900a000a0000000c0000000000009fbda000000000b9bfffcf9fbfbdbafbdbffbdff9dbfdf0bfbfdbfd9fdbdadadb9b0f0bdbf9adab9e0000000000000000000000ca000000000000000000000000000000000000000000000f0a000c00ac090c0000a000ac0ac000a0a0000ac000bfbf00000000a0fdbcbfbfff9ffdbdaf9bdfbcbfbcbbdfd9f9fdbfdbfdbdbdadf9f9f0f0f9f9de99e0000000000a000000c0a0000000e0000000a0c0000000000000000000000000000009000000a000000a00c9c0c900090a0900c9ac00000e9afb000000000daffffdff9fff0fdbdbfffbdf9fdbfdbfbffffbdfbf9f9f9f9b0f0f9f9f9fcbb9fa900000000000000000000000c0a000ca000c000a00000000000000000000000000000e000a000000a00000a0a0a0c0ac00c0c00000b00a000dbf000000000bffadbfe9ffdbfbbebffcbdfbffbfdbdbfdbdbdfbfdf0f9fbcbdbdbcb0b0fbbcdad00000000000000ac0a000c0a000000000ca0000000000000000000000000000000000f0000000000000000000000a000a00a0a0ac00c0c90a09be00000000fbdfff9ffbfadbdf9f9fbfbdf9fdfbffdbfffffffdbdbfde9fdbcb9f9f9f9fdbbdbe000000000000000000a00000000ca0c00000ac000000000000000000000000000000f00000000000000000000000000000000000a00a00c00c0b000000009ebfcbfbdfdfbcbffffbdffbffbfdf9ffdf9fff9fbffdbf9f9adbde9e9e9b0fcbbd9f0000000000000000c000000ac00000a00ac00000000000000000000000000000000b0000000a00000a00000000000000000000000000a00a00c00000000fdffbfdffbe9fbf9f9fdbf9f9fdfbfff9fbff9fffdf9fdbf9fdbcb9f9f9f0f9bddaf9e00000000ac00000000e00c000a0000c0c00a000000000000a00000000000000000c0000000000000000000000000000000000000000000000a00000009bffadffbcf9fbfdfbffbf9fffffbfdf9ffdfdfff9fbff9fdbcb9f9f9cbdadb9ffbf9e9000000c00000ca0000000a0000c0e00a0a0c000000000a00000000000000000000f0000000000000000000000000000000000000000000000000000000fbdffbdfbffbdfbff9fdfff9f9fdfbffdbffbf9fffdbdbe9f9ffdbcbf0f9f0f0bc9fbdf0000a0000a00000e0000000e000000c00000000a0000000000000000000000000b0000000000000000000000000000000000000000000000000000000fefbdff9f9ffbdf9ffbf9fffffbfdf9fbdbdfff9f9f9fdbdbd9abf9dbdbcbdbdbfbdbbcbc0000000000000000e00c000a00a000c00a00000c0009000000a000000000000f000000000000000000000000000000000000000000000000000000adbffebfebff9ffbff9ffff9f9fdfbfffdfff9f9fffff9f9fdafdf9fbcbdbdbcbd9fedfbda00000000000a0000000a00c0c0c0a0a000000000a00e00a00000000000a0000c0000000000000000000000000000000000000000000000000000009ffdf9fdbdf9fbffdbffbdbfffffbfdf9fbdbfffff9f9ffbcbf9f9fe9f9f0f0f9ebf9fbdad00000a00ca0c0a0c000000000a00c0000000a000000000c00a000a000000000b000000000000000000000000000000000000000000000000000000bbfaffbfffbfffdbfdbdfffdbf9fdfbffdffdf9f9ffff9fdbd9f0fdbdbcbdbf9f9f9fbdfbda0000c00000000000ac0ca0a000a00000000000000000000000c00000000a00f000000000000a000000000000000000000000000000000000000000ffdbde9fbdbdbfdbffbf9ffdffbffdbfbfbffffffbdff9ffbfbdbf9fbdbe9fbcf9e9fbdfbdbe000000000c000000000c0c0c000000a00000a00a000a0c0000000a000000f0000000000000000000000000000000000000000000000000000009fbfffbfbdfffffbf9fffffbfbdfdbffdfdfdbffdfdfbdfbdfdfbdadbcbdbdadbdbfdbdbfdad00000ac000a00e000a009a0b000a900000000000c000000a00a00000000000000000000000000000000000000000000000000000000000000009efde9bfdfffbf9fdfffdbdbdfdbfbfdfbffbffdbfbfbdfbdb0fbdbdbdbdadbdbdbf9f0ffdbf9e000000a0000000e00ca0c0c0e0c0e00ca0b0c0000000000000000000a000f000000000000000000000000000000000000000000000000000000bfbfedfbf9fdffbf9fbfffffbfffdfbfdbfdfbffdfdfbdebdf9daf9f0f9f9ebdbcdbff0bff9e9e0a0000000c000000000a0a000a00ca00c0a0a0a0a0a0000000c00000000f0000000000000000000000000000000000000000000000000000000fdbff9fffbfbdffffdf9fdbdbdbffdbfdbfdf9fbff9fbdfbffbd9e9f0f0f9dbfbfdbdf9fff9f90c000c00a00a00c0a0c9c0bc0d0a9ca9a0c0d0c9c0d0e0e00a00a000000b0000000000000000000000000000000000000000000000000000009bfe9bff9fdfffbdbffbffbfffffdbffffffbfffdf9ffdbdf9dffbdbdbdbdaf0fdbffbdbdbff9eb000a000000c00a00ca0a0c0a0ac0a0c0cb0a0a0a0a00009c000c0a00e0c000000000000000000000000000000000000000000000000000000fef9fdf9ffbff9fffdbf9fdf9f9fbffdfbdffdbdfbffdbff0fba9cbf0f0f0bdbdbf9fdbcbfdbcbd00000000000000009000d0a90c9ac90a00c0c00c00c0bca0aca0bc0d00b000000000000000000000000000000000000000000000000000000bdbffbffbdf9ffbdbfdffbfbffffdffbffbffffbffdbffdbf9fdfbd9f9f9bdbdbdffbff9dbfff9e9ac00ac0a00b000a0000a00c0a000ac9e0b0ada0e9ac000c900c00a0a0f000000000000000000000000000000000000000000000000000009ebcbdf9ffbff9fffdbfdbdfdfbdbfbdffdfdbfdfdbfdbffdbf9bdbebcbcbdadadb9fdbfbe9ff9f9e90000000c000c000e00000a000c0000000000090000aca0ac9a0c00c0f00000000000000000000000000000000000000000000000000000e9ffbfbff9fdbff9fbf9bffbfbdffdfffbffbfdbfbdfbdf9fdafcbd9dbdbdad9f9efbffdf9bdbffdbca0000000000a0000000000000a000a0c0ac0ac0ac9009c00ac0b0e9a00000000000000000000000000000000000000000000000000000a9bf9ffdf9ffbff9fffdffdbfdffbfbfbdff9fdbfddad0f99e99dbdebfadbcb9f0bf9fdfb9edfdf9ada9c00a00a00000000000a000a00000000000000000ac0000000000000f00000000000000000000000000000000000000000000000000000fdef9fbfff9f9ffbdbf9fbdbfbdfdfdfbdbedbf9fbdbd9ad99e9099c99e9bdadbd9ffbdff9babffdbf009000000a000000a0000000000a000a00000000000a00ac00ac0000f00000000000000000000000000000000000000000000000000090bbdbffdf9ffffbdffdbfdfffdffbfbffdedbd0dfdffffddad99dbc9bc9f0dbdadbf9ffbdffddbdbfd9fac00000000000a000000000000000000000a0000000000009000a0000000000000000000000000000000000000000000000000000000adebfdbfbff9f9ffbdbdbfbdbfbdffdf9f9d9fdbfffdf9f9d9ad0d9bc9a9dbcb9bcbdbdffbdbbdbfcbe9da0000000000000000000000000000000a0000a00000000a0000000f0000000000000000000000000000000000000000000000000009ff9fdbffdf9ffffbdfbffbdffbdfe9fbd0f9e99f9c9090d0b0d09a0c9c9d00bdadbdbfbdbdbfcdbdbf9da000a00000000000000000000000000000000000a000a0000000000a000000000000000000000000000000000000000000000000000adbfbffdfbffbdbdffbdf9ffbdffbdf0dbd0d9fd09b9fdb9bdfbfbdf9ab00bd09dbdbe9ffffbdbbdbdbebdbc0000000a0000000000000000000000000000000000000000a000d0000000000000000000000000000000000000000000000000009adfdbfbfdf9fffbdbdbff9ffbdff9df0d0b09bffdffbfffffffdfbffdff009e909bd9f9bdfffdebdfd9f0b0c000000000000000000000000000000000000000000000a00000f000000000000000000000000000000000000000000000000000ffbebfdfffbff9ffffad9fff9ff0df0900bdfffffbffffdbffffbffffbf0f0090dbcbfdfdbf9fb9f0bbf0fdb0000a00000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000009bf9f9fdbff9ff9ff9f9dfaff9ff9f9090f9ffbfffffffffbeffffffffbdffb0900b09bdb0bfdfbdfdbdedbda00a00000000000000000000000000000000000000000000000000d0000000000000000000000000000000000000000000000000adafffbff9ffdbfbdf9fb9f9ffbc90e9ef0fbfdfffffbffff9bfffffffffffc9e090dbcbffdbf9ff9adb9bda9fc000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000bdbdff9ffbffdffbfbde99f9edbd90b9ff9ffbbfffdfbfcf0db9f9bdbdadbf090c0099099f9ff9ffdbcf0fda9ac0000a000000000000000000000000000000000000000000000f0000000000000000000000000000000000000000000000000bcbfbf9fffdfbfbdfdf9bdbbf9f00a9fff9effcf9e9b0d9b9dbc90c90dadbc900a909cadbf0fbdfbdbdb9f9ad9f0a000000000000000000000000000000000000000a00000a0000000000000000000000000000000000000000000000000000bdbfdfdff9fbfdfdf9f9adafc9f090dffe9e9b990bd90d9e9cb09ad99e909090e9909a99be9df9f9f0fa9dadf9e0000000000000000000000000000000000000000000000000000f0000000000000000000000000000000000000000000000000adbfbfbfffdbfbfbfbdf9d9b90c00b09f099c9e9dadf0bddbdfddbad9bdadbf9f0f0dbc99fb0bdbdbd9ebda9e9bc00000000000000000000000000000000000000000000000000e000000000a000000000000000000000000000000000000009fadffdf9ffffdf9fdfbdbad0f99bd0f09fe9bf9f9f9fdfbfdbfbfdfbcf9f9cbdad9b0dbda9dfdbcbdbd90bda9eda90a0000a00000000000000000000000000000a0000000000009000000000000a0000000000000000000000000000000000cabdfbdbfffbdbfbffbf9e9db9adadbf9ff9bfdfffffffbfdfbfdf9f9ff9f0fbdadbc9f09a9fb9adbda9af9da9f9a9c000000000000000000000000000000000000000000a000000e0000000000000000000000000000000000000000000909a9bdfbfffff9ffffdfbdf9f9bcbdbdbe9ff9ffdfbf9fdbdfdfbfdfbfffdbdadf0f9da9e9bf9df0fdbdb9fd99a9e9e9ca0000a00000000000000000000000000000a000000000a0000900000000000000000000000000000000000000000000bffffbfdf9f9fffbdbf9ff9e90fbdbcbdffdafdbfbdffbffbfbfdfbde9f9adbdbdbd0bdb90d0fa9f0b9f0f9bcbd990f0bcb00000000000000000000000000000000000000a000000000e000000000000000000000000000000000000000009adbf9f9ebfffbf9fdfbdff9e9fbd9dadbdb9fbdbfdffbdfdbdfdfbf9fbdfffff0fb0fbfcbcb9bd9f99f9e9f9e9bdada9ad00ca00000000000000000000000000000000000000000000000b00000000000000000000000000000000000000000adffdfeffdf9fdfffbfdbf9f9f9c9abd9f9ef9dff9fbdffbfffbfbdfffdbf9f9db9df9c9bd9de9a90f0bdbdbdbdbc9bc9cbcb0d00000a0000000000000000000000000000000000a000a00c0000000000000000000000000000000000000000bdfbffbf9fbffffbf9fdbf9f9f9e9b9d9be9f9fbf9ffdffbdfdbdfdffbdbf9ff9fade90fbda9a9bdbf9bd9f9e9f0f9bcb0b0bc9a00a0000000000000000000000000000000a000000000000b0000000000000000000000000000000000000009fbffffdffdfbf9fdffbfd9f9f0f9bda9ad9f9f9e9fdbfbdffbfffbf9fdad9f09e9db9bf90bdbd9dad0f0fbdbdbdbdad9bc9e00fc00000000000000000000000000000000000000000000000e00000000000000000000000000000000000000adfdfbffbfbefdffbf9fdbeff0fbdfcbdf9a90f9f9fbfdbdb9df9f9fffbdb9e9f99e9fc90fd09cb0bdb99f9edbfdbdbdadcb09cb0bc0000000000000000000000000000000000000a000b0000900000000000000000000000000000000000009ffbfbfdffdffbfbdffffbf9f9f9dbb9f9ad9db9e9f9e9fffffbfffff9dfbcbbdada990b9f9a9f9dbd0daf9dbbdbcbd9f9bbc9ebc0da00000000000000000000000000000000000a0000000000e000000000000000000000000000000000000bbfbdffffbffbdfdfff9f9fdf9fbffbdfdbdf0b0f9f9f9fbdbdbdbd9f9ffadbdcbf9f9e09c909f0bad0bbd9ffbdfdbdaf0f9c9a900ba00a000000000000000000000000000000000000000000009000000000000000000000000000000000000dfdffbdfffdffbfffbffffbfbfdbdbdf9bf9bf9d0bdbdf9fbdadf9fb9f9f9fdfbf9f0f9f0b0f09d9dbbd9fbdbdf9bf9f9f9e9ad0f00d000000000000000000000000000000000a0000000a00a00e000000000000000000000000000000000000bfbfdffbffbfcffbfdf9f9fdf9fffdbffdffdfbf9cb0bdbdfff9ad0dadadfbf9fdff9f09f0f9fa9a9d0bc9fbdbffdbf9f9f9f9ad0adad00a00000000000000000000000000000000000a0000000b000000000000000000000000000000000009f9fdbfffdfffbf9fffbffefbffdbdbdbdbf9f9f9fb9df9fbc99fdbffbdbfbdfffbf9f0f9e99e99c9f0bdfbfdbfdbfd9edadadada0d00a0000000000000000000000000000000000a00000090c00c00000000000000000000000000000000000bfffbff9ffff9ffff9ffdbdbdbdbfbffffdbfff9fd9e9a9f9fbffbfdbdfffdffffdfff9f090fb9e9b0f9f9fdbfdbfdbff9f9f9f90f00bc00000000000000000000000000000000000000000a00a0b00000000000000000000000000000000000fdbdfffffbfff9fafffbffffffffdfdbdbfdf9fffbf9f9cbd9f9fdbffff9fbffdbf9f9e9f0f0de90db9f9fbfdbc90bdb9f9f0f0e90bc0900000000000000000000000000000000000000a0000900e00000000000000000000000000000000000bffbf9fffff9fefdfbfdbdbf9f9fbffffdbfffbfdf9f9b9eb9cfbfdfbdbfdf9ffdff9f9f0d0b99e90f9ffd0900bcbc0d0bcbd9f9e90b0e0e0000000000000000000000000000000a000000000000900000000000000000000000000000000009fbdfdffbfdafbdbffcfffffdfffffdbfbffdffdffffffdf9da9bdfbfdfdaf9fe9fbdfcbcb0bcbc09f9e90bcbdbdbdbf0bc90fada9cac09000000000000000000000000000000000000a000a00a00e0000000000000000000000000000000000fdffbfbffdfbdfffffbfbf9fbfbdbdbfdffffbffbff9f9f99adbdf9fdbebd9ff9ffdbdbdbc9c90b9f0f9cbdbdbdbfdf9ffd0f09dbcb909e0000000000000000000000000000000000000000000000b0000000000000000000000000000000000bfbdfdfdbf9fff9ebdffdffdffffffffbdf9ffdffdffffbffdbcb0f9bdbdbff9fbdbcbdadb09e9c9ad0f9e9f0fbdfbffd9fbde9a0bcca00000a000000000000000000000000000000000000000000c00000000000000000000000000000000000ffbfbdbdadbfffffbfbebffbdf9ffbdfbffffffbf9f0fdbdbdbdbcf0fdbdadfdfbdbdbdada90b0f09bcbdbdbdfbdf9fbe9f0bc9c0b9dac0bc0000000000000000000000000000000000000000000f0000000000000000000000000000000000bdfdffffbdbffbf9fedfdfdbfffffdfffdfff9f9cdadf9edbcbdadb9f9f0fdbfbdfbfdadbc9e9c909e9f9f9ff9bdfbff9ff9fdbf0bca0090000000000000000000000000000000000000000000000a0000000000000000000000000000000009ffbffbdbdbfffdefffbfbfbfdfbffbfffbfb9fcffbf9bdfbdfff9f9f0fbfdbf9df9edbdbc9a9da90f9f9ff0f9fffbdf9ff9ffbdcbc090f0aca0000000000000000000000000000000000000000000d0000000000000000000000000000000000bdf9fffcbdfdbfbfbdfffdffffdfdffbdfcdcbbf9fdfffbdf9fffdebdbdfbfdefbfdbdada9d0e9e9bdbe9bdbfdbdfbff9ff9bcbbdbde0000000000000000000000000000000000000000000000000a0000000000000000000000000000000000bffffdbdbfbffdfdfaf9ebf9fbffbfdff0bbfdf9f9f9f9fbfbdbfffdbdbcdbf9fdbfdbdbde9b909e9e9dfdbdbffbdf9ff9ffdfde9ebfcb0f000000000000000000000000000000000000000000000f0000000000000000000000000000000000fdbfbfff9fffebebfdfffdfffffffffe9fdf9f9fffbffffdfdfbdbdfebcbbdbf9ffdadada90c0f99f9fbfbfff9fffbff9ff0fbdbfdbdf0c00000000000000000000000000000000000000000000000000000000000000000000000000000000bfbfdfff9bfffbdffdfbdbffbdbdff9e9fbf9fbf9fbdfdbdbffbdffbffd9f9cbdffdbf9f909e9b0be9fbdbdbdbffdbfdbff9fbdbfcbcbe00ac00000000000000000000000000000000000000000000f0000000000000000000000000000000009fdffff9fc9f9ebdabfeffbdffffbef9fdf9f9fdbdffbffffbdffbdff9ebcfbcbf0ff9f0fda90c9d9f9fffffffdbfffffdbfbdfcfbdad9e0900000000000000000000000000000000000000000000000000000000000000000000000000000000bfbf9ffbfb0f9efdf9fbdffbdfffd0fbfffffbffbfdf9fbdfbfdff9fffdbfdbdff9ffdb00da9adadaf9f9ff9fff9fdbcbdadbbf9e9facbc0a00000000000000000000000000000000000000000000f000000000000000000000000000000000ffdfdffdf9dbc9b0beffdebdffbfdbffdfbdb9f9fdfbfffffbffbfbff9fffcbfbdbfdadfdbad0dabdbdfbff9ff9fffbffbfdbcf9e9e9dbc00000000000000000000000000000000000000000000a00a000000000000000000000000000000000bdfbfbffbcadabcfdf9fbfffbffdafdbfbdffffffbfdfbfdbdfdfdff9ffbcbdbcbfdbff0b0d00bddbdbbcf9fdaffbdff9f9adb9e9f9ebe9009c0000000000000000000000000000000000000000000d000000000000000000000000000000009fbfffff9f99a9cb0bffffbdffdbfdbffdffbdbdbdfbffdbfffbfbf9ffbdfff0dbdbfdbdbcb00d0badaddf9ebfdbdfbd0f0fdad0b9e9f09ec00a0000000000000000000000000000000000000000000e000000000000000000000000000000000fdbdfffffff0a9ed0fbfdfbfbffadfffbfbfffbffbdfbfdbfdf9fff9ffbbdfcbcbfdbcf9f0daaddbdba9bf9f9ffbdffbdb0bdad0f9e9f09a0000000000000000000000000000000000000000000000b000000000000000000000000000000000bfffbdffffad009abfdebfdfdfcdaf9ffdfdbdfdbdfbdbffdbff9f9fbdfdbff9fbdbffbdada9dabcbdfff9ffffffebdfadfc09b0bcbdadac0000000000000000000000000000000000000000000000c00000000000000000000000000000000bfdbffff9fdf09afadffbfefbfbfbfffffbfbfffbfbfffffdbf99e9fbcbdbef0dadffdbde9f09e9dfff9f9efdbf9dbdf0fda9bf0fc9fada900000000000000000000000000000000000000000000000b000000000000000000000000000000009fffdfffffbde000da9ffdbdfffc9f9f9fdfdbdbdff9ffffbdbffbf9dbfff9be9fb0fbfbdb09e9eb9f0fbd9fbcffef0bd0bc9c9f0bf0dbc000000000000000000000000000000000000000000000000f000000000000000000000000000000000b9fabfffffada0f0dafffffbdbfeffbf9bbffbfbdffffbdffcbd9faf9f9ffdf0dff9fdf9efdad0dad90caf9e90909ca9fcb0bcbd0bf0cbc000000000000000a0000000000000000000000000000000e000000000000000000000000000000009ff9fdffdbfdf0000bf9effbfefc9bde9edf9ffdffbdbdffadbdbe99dffff0f0ffbdfbf9e90000b0f0adb9c00e0e0009ca90d0bc0f09bf0000000000000000000000000000000000000000000000000900000000000000000000000000000000bd09fbfbffcb0000bf0ffbdffdbfbcfbfb9affdbfbdfefcbdbcbc99eb09b9fbda9cfbfda00090bcd9fdb0cf0f0900e9ca9c00bd0b09ec0c000000000000000000000000000000000000000000000000e000000000000000000000000000000000fbf09ffdbfbe900c0fbffffbff0dbfdfdfdbdadbdfbdbfda9f9f0f99fede9fe9ebfdffd09adadbe9bfffb0cade0000ad09a9cac9ca99a0e00000000000000000a00c00000000000000000000000000f00000000000000000000000000000000bdf9f09bed0d0e00b00fdbedfbffe9fbfaf9af9fffcbc000c0cbcb0f09b9bdadbdfbffbfff9f9e9ffffffda900000000000da90b09cac0900000000000000000900a0a0000000000000000000000000b000000000000000000000000000000000fbfcbc09a9a900000bdafdbed009ebdf9ffd9ad0a0c0a90a0bdf0d0bcf0dad0ffbdfbfdbde9fbdadfbffc0edad0ac09ada00cbcbcb000e00000000000000090c0090000000000000000000000000a0c000000000000000000000000000000000bfcb009ad0000000adaf9fad0bffbde9ff0bed0bfdb09cad0da0da9e9b9ebcbf9fffdfbffbf9edbfffdb0f90bcad09adac9cbc09000da00000000000000000a00e00000a0000000000000000000000b0000000000000000000000000000000000fbc0000000000000000a0fbfcffcfbfe9fd9bfdffffe0000ad009f9fcf9cbdfffbfbffdbd9f9bdbdbfedacbcbdacbc090a909e00e9ac9c000000000000ca00090000000000000000000000c0a00c0f000000000000000000000000000000000009a0000000000000000cbdebfebf0f9ffafe90bffff0f00000bcbcf9bcb0fbf9fdff9ffffadf9e9f0f9ff0f0cadbcbcad0e0000f0f9a0a0000000000000909e000000000000000000000a000000a0c00000000000a0000000000000000000000ac000000000000000bdbdafde9fff0fdadf9ef9fbfdfdadadbcbcb9edac9fdfffbfdff9bdf9be9f9bda9ce9e9c0000000090f9f9f0c9c000000000000000e0000a00a00000000000000c00a0ca000b000000000a00000000000000000000000090000000000000009e9ebfffbffdadebff9e99edffefadf9f0f9f9eda99fbfbdbdfbf9fdfbffdbf0f0f9f9bc0a00f0dbcbcf0f9e9eb0a00000000000009a000000000000000000000a0a0d00000c0f0000000000000000000000000000000000000000000000000009ffffcff9ebfcbcf0f9efdbe9dbdafd0f0e0f09cbe9f9fffbfdffbfbdbdbdf9ff9f0bcb9d9f9e9af9fbf0f9e90c900000000000000c09a00000000a000000000000a0ac0a0a0e000000000000000000000000000000000a0000000000000000a00bcfbfefdfbfcbcf0e9eadbebcfdae9f9f00e9bdfbdf9fdfbf9fdbdffbfbff9f0f9f9efadadbc9ad0dada09e9a0e000000000000a900000000000000000000000c000a00d00d000000000000000000000000000000000000900000000000009cbffbfdbffadbbcbdfbdfdfedcb9ad9e0c00f0fcb9ffbfbfbdfffbffbdfdfdbfbf9e9e999bdadbc9a9bf09f0000090000000000000000000ac00000000000000000ac009e0a0b00000000000000000000000000000000a0000a00000000000000bdadfefdadfcfffafdebfffdbfcedac90bdbdb9fff9fdfdfff9ffdbdbfbfbfdfdf9fb9fef0f9adadac09e0e0da9e000000000000000000000a00000000000000a090aca000ce000000000000000000000000000000009e00000000000000000bcbffbfbffbfbdbdfcbdef0fffcbdadbcbc9a9fff9ffbffbdbffdbfffffffdfbfbffdff9f9f9ff9f9f9bc909a0c0000000000000000a000000000a000000000000cac90c0ca0f00000000000000000000000000000000009e00000000000000009cbcfdedbdedbcbdbfbd9f9adbcbcb0bdbfdf9fffbdf9ffffdbff9f9fbdfbfdfdbfbdffffff0ff9fedbadac9a9e9e0000000000ca00000a000000000a0000000000a0a0a900b000000000000000000000000000000000a00000000000000000a0bffbfbfefbffbfbcbcbe9edadbdbdfdbf9fbff9fdffff9f9ffdffffffffffbfffdffbdbdbdff9ef9fcdadbc9e9c0000000000b0000000000a0000a00000000a0000c0900e0e00000000000000000000000000000000ad00bc00000000000000dadafdffbdf0fdedbdfbdbfbdbfbdfbffffffdfffffbf9fffbfbfbf9ffff9ffffdbfbdfffdbf9ff9e9bbf9acb00a000000000000900000000000a0c9000aca0000e0a0e0e00f0000000000000000000000000000000000a00000000000000009adbdffadfbffbfbffbcfffdffdffffffdffdfbf9fbfdfff9fdfdfdfffdffffdbfffdffbdbfdbfcbdbedc9edbcbd0000000000000000a00000000000acac0009ca009c0009a0f00000000000000000000000000000000b0c0009a00000000000000fb0ffbfe9ffdf9ffbdbfffbffdbfffbffbfffffdff9fbfbfbfbfbdbfbfffffffbfbdfadbfcbdfadbfbe9e9acac000000000000a000000000000000000a0a0000a0adac0c090000000000600000000000a00000000000a9a000000000000000a90ffbdedbff0fbe9fdfffbdffbfffdffffffdffbfbfffdfdfdfdffffffdfbff9fffdfbdfdfbdbfdbcbdbf9ef90b00000000000000000000000a0da0a000c0ca00c00000a0ae00000a000000a000a0000000a000000a9ad00c000000000000009cbdbcffbfdffffdfbffbdfffdfffffbfdfffbfdffdf9fbfbffbfbdbfdfbffdfffdbfbdfbfbdfe9adf9ed0f090ac0000000000000000000a0000000d0c0a90a0c0a0ac0f0c0f00000000a00000000000a00000000000000a0a000000000000000a9ebff9effbf9fbfffdfbfdfbff9fffffbdffffffffffdfdbdfdffffbff9fbfbffdfdbf9fdaf9ffcbdfbf0dac90000000000000000000000f00000a0ac0e0c0a90c9a000b0f0000000000a000000000000000000000e00c90000000000000000009e9bf9ffffffff9fffffbffffffdfffffffdbf9fbdbfbffbfbfbdffffffffdfbfbfdff9fdbf9fbeb9e9fa9a0000000000000000000b0c000aca0009a00a90ca0a0cac0c0b00a000000000a00000a000a00000000909a0000a000000000000009e9edfff0fff9ffffbdffffdbdfbffbdfffbffffffffdf9ffdfdffbfdbfdfffbdfdfbf9ffbfcf9f9de9fc9c0000000000000000000000a000009c9e0c0f0ca00c0cb09a0ae0000a00ac00000000000000000000a0c0ac9a0000000000000000b0a9fbe9fff9fffffffffbdfffffffffffbfdffdbdbdbfbfdbfbfbdfffffbf9fffbfbf9ff0fdb9e9febda9a00000000000000000000c0000a9c0a0a000a00a0cb00a0cac0cf0000000000a0000a0000a0000000000a00000c09000000000000000d9e9ffbfffff9fbdfffffbffbffbdfffdfffbfffffdfdbffdfffffff9fffff9fdfdffdbfdbef9f9bda9c0000000000000000a00000ad0000a0c00e9e9e0cb0ca9ca000b0f0000000000000000000000000a000009e9a000a00e00000000000000a9e9edbdbfffffff9fffffdffdffbdbffbfdbdfbfbfff9fbffdbf9fff9ffffbfbf9fbdbbdbdade9fda900000000000000000000a00000c009a900a000b0ca0ca0dacac0900a00000a0000a0000a000a0000000a000c0b000090009000000000b0f9fbffffdbfdfbffffdffffffffffff9fdffffdfdf9fffdfdbffffffff9fffdffffdedfbdadbff0a9c0000000000000000000ac90a0a0a0e0cad0f0e0cad0a0ca0900ae0000a00000ac000000000000c00000009a9ac000000a00a000000000c9afe9fbffffbfffffbfffbffbffdffffffbffbfffbffdbfbfffffbdbffff9fff9f9fbb9cbdbdb09d0a0000000000000000000000c00d00000b00a0e00b00a9cb00e0bcf000000ac00000000a0c00f000000a00ac0c900b0a000c00000000000bcbdbfcf9fffffdffdfffdfffdfbfff9ffffffdfbdfdbffffffbdfffff9ffffbffffbddfbcbdadf0a900000000000000000000000a0000bcbc0e0c00bc0e0ca00cb0e0af00000c00000000a00900000a00a000c90a00a0c090090090000000090b0f9fbfffbdffbfbfffbffbfffffbffffffdfffffbfdfbdffdfffff9fffffffdfbdfbe9f9ff9b0d0c9a00000000000000000a000000a0000a90b0f00a00b0ca0ac09c0b00a000000a000c0000a0a00c00000000a00a09a0c0a00a000000000000dadadbf9ffbffffffffffdfffdfffffbdfbfffdbffbffffbfffbfdfffbdfffbfdfbdbfdb0bcf0a9a0000000000000000000000000000cac0e0ca0cad0e0cb0f00aca0e000000a0000a00000000000000000a90c90c0000a000000000000000ada9fbfdfffffdffdfbdfffffbfffdfffffffffbffdfffdbfdfbfdfffbdffbfdffbf9ff9adfdb0f90c0000000000000000000000a9c090a90b00bc0b00a90a0c00ada0df0000000000000000ac000c0a0000000a0a9000b0900009c0000000009a9f0fdbebf9fffbfffffdbfffffffbdffffffdfbff9fffffffffffbffbffdbf9fdffdbdfa9a09c0b0090000000000000000000000a0e00cac9e00e0dac0e9ca0e00c0af000a0000000000a000000a00ca00c00000a9ac00cb0da00b0000000000cbdaffdffffbffffffbfffffffbfffffffffffdfffffffbfffffffdfffbfffffbdfbebdf9d09b000000000000000000000000000000b000a00f00a0cb00a09e9adad0d0000c0000a0c000000a009000000a0009c00c9a0a00000000000000000b0bf9fbffbdffdbfdffff9ffdfffffffffdbfffbfff9fdff9fffffbfdfff9ff9ffbdf9f0b00ac000a00000000000000000000000000c0f0dac0e9ca00e0cac00ca00aa000000a0000a00000000e00a000090bca00b000900000000000000009c90f9efdf9fffffffbfffffffffdfffbffbfff9ffdbfffbfffffbdfffbf9fff9ffbdfbfdbcf99000900000000000000000000000a09a0a00a00a00ac9e90b00f0a90e0f000a000000000000a00000c0000e00000b0c0a00000b0000000000000a0f0f9fbffff9fbffffdbffffffffffdfffffffffffffffffffdffbdfffff9ffbdffbdfadf0b00000000000000000000000a000000c09c9e0cbcbc9a00ac0e00e0ca9cf00000000000000a00c000a0000900e00000b0900e90000b0000000000090bcbcbdbfffffdffbffdbffbffffffffdffffffffffffdbfbfffffbfdbff9ffbfdfbd009d9e9000000a000000000000000000000a00a00f0000ac0ac9a09e09a0ca0f000000000a0000c0000a000a00a00900f0f0ca000000000000090000090a09f9fff9fbdbfbdffffffffdfbffffbfbfdbff9fffdfffdfff9fffdbfdbff9fdbf0f0eb0a00000009000a000000a900f000000000a0ca00e9e0b0dac0e00bc0e90ea00000a000000a0000a000c00000000a00000b0090000000000a000a0000d9f0be90fedffffffffbfdfffffdbfdffffffdbffbfbfbfff9fff9fbfdbff9ffbf0bfb9c09000a0000009000000000a0000a000000d0b00f0a0c0ca00a90ac0a9ca9f00a0000a0000000000000a0c000e000d0bcbc9c0a0000000000000090a00a0bc9ff9bfadbdbfbdfffffbffffbfffdfbffffffdfff9ffff9fffdfbfdbf9fdb0dbcf9ac0000900a0000000e00000000c000090a0e0ca00cba0a0cbc0e90f0cac0f00000000000000a00000900000090a0a0000a0a009a0900000000000009090db09ad0bdbffdffffffbfdfbdffdbfbfdfbdf9fbf9ffbdbff9fbffdbffdfbad0f0b0c900900a0009e00090000a09e0a00c000e900a9cad0c0d0b00ad0ac0a90b0d00000c0000a000000ac0000a00000090cb0bc9090c000000000000000000aca0dadaf9efdbfbdbf9fffffffbfbfdfffbdfffffdff9fffdbffdb9ff9ebdfd0d9d09a00a00d00d000090e0009c0c09000a00a00e9ca00a0a0aac0e00ac9acac0ea000a000a000000000000e0000a00e00a00c0bc0a0a0000a00000000009ad0909a0909cb9bebdffffff9fbdffdffff9ffffbf9fbf9ffbdbdbdbeff9f9da90b0a0ac00d00a000a0000a00000a09a0acb009000f00a09e0f0d0c9a90ad0ac900f0f0000000000000e000000000c00000000a9adaad0090c0000000000000000a0000f0f0bdedbdaf9ff9fffffbffbdbffbdbfdffde9fdbdafdaf9f99e9af9e9c09c9090a90d0b0000b0c900a00000d000e0e0f00ac9e0000a0a0ac0e00e90aca00f0000000000000000a0000a0000000009c000d0ac000b000000000000000000f00090f0b9e9f9ff0ffbdbfdf9ffff9ffedbf0bf9fbf9fdbf9e9fe9ffd0f09a0000ac90ca00c00000000090d0ad0a000900a0bc0a00e9e0cad0ca09e00e00bcb0f0000a00000a00000000a0c0a0000a0c000a0ad9a9a00000000000000000009009a0f00da9bcbd0fbdfefdbfff9e9e9f9bc9fd0bd09f0bf0f9f09f09ad00e090a0000a909a0009000a0aca0a00a0d0a0e9c0c0ad0e9a09a0a0b0f00bcbcbc00ea0000000a0000000000000000000000a0a090f0a0c0000000000000000ad00000ac900fadde9e9fbdadbdbf9f0f9f9f0bcbcb0bdaff0ff09e9adfadbcb0900000d09ad0ac009a0ca90c900c900000ac0000a0bc0a0c0cac90e0c00ac0000acb0f00a0000000000a000e000a0000a0900090adafc9a000000000000000000a000009ef0900b9b9e90f9bdbcfadbc9acb9cb0bcbda909f09df90da900090e0000000a000c900000000c9a009a00e900009a0e9e00ac9a0a9aca90a0e9a0e0f0ac0f000000000000000000000c000000e0000c0090ac9adaca000000000009009ac00090e0dac0ca9e9adacb90f00bf900e9c909e9cbf09faa0f09ca9f0a9000900090f00a000000090a0c0ac00000e09a0c9000f09ac0f00c0cad0b0c9a9a0c9a0d00000a0000a00000000a000a000000ada09acbdb0c009090000000000ac000090be909a09a90090f0db0e909f00cbc90b0f090bc90f0d9f09e09c00d00a0000a0000900000a00a0009090bc000000c0a00e000e0a00ada9a00e0e0e0c0f0e0da00000000000ca000a00000000000000000ac90a0e9a9e0ac000000000009000a0c90e0000000f0e90b0c9a9e0c9b09af0f0f0ad9adadbe0a009a00b0009c00c90f0000c0a09c90c90a0e000b000b00bc0e900e090dac00ac0e909a009a0a90af00a0000a0000000000009e000000a900a09a0e9e9ade9c90a9000000f00ac0000bfe900000f0009cadabc9cb0bc0e9c0db00f9a0db00090d000090ca0000a90e0000a9a0d00000a0c00000000000000b00aca9aca00b0e0b00acac9eac9cac0f00000000000000000000000000000ca9c00cb009e09afae9ca0000d000000009000fec09e00090a9c0d0be9cb0bc9a9e0cb00c9a0cbcbca09000e90000bc00b0f009c000000a0900b000bc000000cac0e90bc009ca0ca9c0ad0a9a00da0bcb0d0000000000a000a000ca00a000000000a0a90cbe9ae9c9f0b0da00000000000ac9e9a9000000a000b0ad0da0f0cbada9b00da90d0b09090ca00900009c009ad000f0000b0ad00e0000f000a00a0a900b00e00bcaa0f00e0ad0ac0cbca0ca00ca0000a000000000000000000000a00a0009c00a090c90baf0fca00a00a0000bc09a9fc0a00000c9cbcad0e9adadb0d0d0c0b090e0bc0a0e9000000000a0b0e000b000a9c00000000000000000009c0cac0e09ac009c00f0bc0acb0b0a9cb00faf0000000a000000000a0000c0000009caca9e09cbeb0e9c0f0bdad00000000000acbcbc0000b00a00909a9ad09e0da0a9ad0ca090009c90a000000000d0c09000c9a9ca9ac900a9000a00e009c0a0a090a90e0a0e0bca0c00e90e0cac0ac9e00f000000000000a000000000a0000000090009a0000cb0eb0fe0f0fad00000000090e9e9e9000090f0a0e0c0be09a0dad000b0d0e90a0000000000000a009a00da00ca90c00ac000c000900000a9cbca0c0e00d0b0c0ada0e90e09a0da9ca00f0d00a00000000000000000a000000000a0a0a0c00bcb0f00f09f0f0da0f0000000009e9e00c00cac00d090b0c09e0f090adac0a0000d00ad00000000090a00da00900000b09000000a0ca000a000a009e0b0f0a0ca9ac00e90e0bc0f00e09ea00a000000000000000000a0c00000000a0d09c0b0bca0f00f0af0e9ebed0a90a00000f0e900a0b0090b0aca0da9e0900e0d0090090000000000000090ac0d0da090ca90ac00ca00a000090009c0f00d0e000c0ac0b00ca9e9ca9ac0a00e90e090ff0000a00000a0000a0000000a0000090aca9e0c09adada00d0bde9c9ad0c00900000a9ee090cbcac0c090f0c09e0f090a000b00cb00b0000000000009a0a0000a000c900a0c09000000a0c0a00e0a90acb0ac9e0e0bca00ac0cbc9cb0ca9e0e0f00000000000000000000000000000c0900a9a0e090f0f0e0e0b0facbe9a0c0a000ad0900e9a0090a9e000b0e0900ca9cb0c0cb0000000000000a0000d0d000c000a0a09090ac0e0000d0a09a090cac9ac09a09c9e00da0da9a0aa0ca9ca0da0d0000000a00000a0000a00a0000a09a00ad0c0900e00dad09ad0e9cbc9ac90ac00000aca090d0f0ad009e9c090e0b000000b000000000000000000f0a0a00a9000d09c0e00a900000a00000c0ca0b0a0ca9e0ca0a0be00f0cac9c9e9ca0da00cb00000000000000000000000c0000a00f000b0e0a9afa9e0ad0e9af00ac9a09090c0bc9000e0a00da09e00a00e90c09e000000000000000000000000d0000000a9a0a0900c000b00900a000b0a9c0c0cb0e00b0e90c09e00a90e0a0aa9ca0bcbe0a00000000000000000c000a0009c0000a0c0900c009edbca09ad0bc9ac000c0a0000e00009c9e00f09ad0f00090a00000000000000000000a09a00000000c00c0d0ca0a9000c00ac000bc00c0a0b0ac00dac00e9aca0cbcac9e0c9c0ad0e00f0000a000000a0000000a0000000a000bc0b0e0f0a9e00adadbc0ad0ac9a9e0a0900009e9000a09ac0fe0a009e00000000000000000000000090c0da000090a09a00a90c00ada0000000c00a9a0c0cb0ada00ada0c0bcb0ca9a00b0a0f0a09e0d000000000000000a0000000000ac0b00090090009009f0ad0e9ada9cbac0090caca00000a0000c09a09c9ca0000000000000000000000a00000000000a00009c00000a900c000bc0b0b0000c00b0a0c0a0cbca0f0bc0acbc0cad0e9cac9e00bb00000000a00000000a000a000090000c0aca0e0a0e0e0adaadada0da0d0b0ca000900a000009a09ac9e0a09c0000000000000000000090c0ca09a000c00ca00a09e9c00a9a0ac00000c00a90a0c00e9a0da009c0ac0ad00a0bc0a0ca90a09e0e000000000000000000000000000e000b0009000d0909ada9cbcbda0cb0acb009000a000c0000c00cbe9c00000a000000000000000000000b09a0c09a090009c0000a0bc0c0909a9e000a0c00cb0e90ad0ad0ea0e90f00af0e09e9cbcac9ca9cf0000a00000000a0000000000a0000e0000a0e9a00e0000da00e0eda00f00cb0e0ac90c9a0000a0b000a000a000000000000000000000a00000c9a0c9aca90a09a0d000a9a0e0c0009a0900a00000ac0ac0a90da0e00e90090e00a00a9a0aca0d00000000000000000000a00000000000cb0c00c0b00a00a0da909adac00f00c90000a000000009c0f0d000000d000000000000000000c090e9a0c9a0c90ca000c0a0e90c0d00a0000c0e0bc0a0cbc9acb0cacac90e09e0e0e9cbcbc0c0f09e0b00000000000000000a000000000a000a000b00b0c09c0b0dac0facad09a00b0a0da0c0000000000b000a00c00a0000000000000000090b0e90c9a0c900a09c90a90900cb0a0b0ca0e0a9000000a00ac90cb009a0e90e0b0f00a0ac0b0a0ca09e000000000a000000000000000000000000c0ac0a0a000c0a0ba0da9ee0d00c0ca00000a0000000000f0d0000000000000000000c0bcad0e9e9ac9a0a009ca0ac00cacb00c0c09009090c0e00ad0cad0e0acbcacb0ca9ac00f0f0cb0cbc9ad0ef000000000000000000000a00000000000a00000d000a0000c0da0f09af0f0b009ada00c00a000a0ca0a0f0a000000900000009a0bcb9ad9a9e9ac90c9e000090b0a90ca90b0e0acaca0a000c00a90a90ad00a90ca9c09aca000b00e00a0ca00f00000a0000000a000000c0000a0000009000e0a00009ca9a0b0c90fad0a0acaf0c000900000000009c0000000000e00c0dac0e0d000c0a0c00000000a00ad00ac0d0a00ca000090000d000a90ac0e0cadacbcacbca0ac0bcbcacad0bc0e90f090000000a0000000a000a0000000000000e900900ac00000c00cbae0c0addf0d00fada0a000000000a09e0ad0ca0000a0b009a900ada9a9c9a9c09a0000900a0cb00ac90b0c9acacb0a00a000000a90bc00a00da009ad0bc00ac900ac0b00e00e000000000000000000000000000000000000ac0000a0a0a9e9ac9c9af0a0adacb0dac00d000000000000d00a9c900090ca0c00e90000c0a0ca0a0ca900ca0cb000090ac00a009000c000c000ca90e0cb0f0f0a0f0e0ac0a0e90e9e90e0da09ef0000000000000000000000a00000000a00a000a000000d000e9a0ac00d0f0e9aca0dada0ac0ca0000000a0f0a0e0f0e90da9e90adada90da9c900000e0009000bcac09ac0daca00000c000a0000e9aa0e000e900a9c0bc0b0ea0a0e90a0ca00f000a0000000000000a0000000000000000000000000000a0d0e9e9a9e0a009adada0da9c90a0000000a00000d09a0bcadacb0e0d00000e000a0e09cb09e0a0e0009a9e09a0090c0a000b00c090e00c9c0ada0e0f0e0ac0f0c90d0e00e9e90f0900000000000000000000000000000000000000000000a000a0bc0ade09cadac09a0da0e0a000000ac00c00c0a0e09c09ac90e09a0cbcb090f0090a000e09c090f0ac000ac0ac0a000a000000a000f0a0f0ac90b0c0bc9a00a0e0a90e9a00e00e000000000a000a000000a000000000000000a000000000000000f00be0b0a0bcac9acb0d0f0d0e00000000a9009ca0ac00a0900cb000c0e00c0ad00e0900b0e00d00ca900900090c00c00a0000f0a0da0c9acac0be0ac0e9cb0f0cb0c0cb0caf000000000000000000000000000000000a0000000000000000000e909c0f09cb00e90c0a000a09000a9a0900e0000d0a90d00ca00f0a0090a900a0090a0e090f0aca90c00e00a00a00000c00000c9a0cb0e090ac00d0a90a0c00a0ca9a0ca90f00000a000000000000a000000000000000000000000000000000000acaf00e00cb00e9ad0e00000e00c00a0000ac9a0d0e0a0a9000090a0000ac0da00c900e00009000a00000c00000a0000aca0a0cb00e90eadaca0ad0e9e0ad0f00e0da0ca900000000000000000000000000000000000000000000000000000a0da909e09eb0fe9ac0a90e0a009000c00c9000ac00a0bc90c0e00e0d0e9c09a00c0b00f00bc00ca000a000a0000000a0000900dac0e90e9000b09caca00bc0a00e90a0dace000000000000000000000a0000000000000a000000000000000000000e0e9e00c009e0bd0e090c000a0a000a0e0900f09c00e0a90f090a000a00000b00e00000a0a0009c0009000ca000000000e0a09a0ca0cadacaca090dac9e0cb0cad0a90fa000000000000000000000000000000000000000000000000000000a00b0e9e9ada09e0a09aca90ac9c00b00000e000e0ac909c0000e000a90ac9e00f00bcac0000b0ca00a0c00a00000000a000d0e00f09e90ad00ada0e00a00f0cb00ac0e0d000000000000a0000a000000000000000a00000000000000000000000d0090a0ca0de0f0f0c90cad0a0bc0cbcb000f00090aca0a0a000d00c090a00c0000009ac00c0a000000a00000ca0000ca0a09ad0ac0ac0a0f000e90f0da00a0cbc9a00b000000000000000000000000000000000000000000000000000000000a0a0e9cb0da090e0f0ada90ac9cada000e0f00bc0acb0d0d0c9a0a0a00ac09a0ac0b0e00a90000000000000000000000090cac0ac0bc9a9c0a9e90e00a00e9ca00ac9ee0000a000000000000000a00000000000000000000000000000000000000c900ac0a9cac900bca0cbc9eb009e9e900ac0ad0000a0a9ac00d0dad09ac009a0c00900ca000c0a000000a00000000acb09ac0b0cac0e0f0c0e00ac9e90a0dac9a00f00000000a000000000000000000000000000000000000000000000000000a009ad0a09a0e009c0bca09cf0e000e0d0000acbc0c0c09ada0a000a000a0c0b0ac0000000000000a000000000a0000cac0bc0a09a0900a900f09a00e0da00ac0f0d000000000000000000000000000000000a00000000000000000000000a000c0ac0adac0f09e0a9e0daca009ada9a0ada0090a9a9a0c000c000ac0f00da0c000a000000a00000000000a00000000a90ac0f0dac0e0e9e0e0cac0f00a0cbc9a00b00000000000000000a00000000000000000000000000000000000000000000000bc009a00e009e90a0b0adac000cbc00daca0c00c0a0a00b0e90000a00000900ca0000000000000000000000a9e0cad0b00a00f0b000a90a90b00f0cb00ac0ee00000000000000000000a00000000000000a000000000000000000000000a00000b0e00cb0bca0e09c0d0009ada00bca000c900a0000d0000000a0000000aca0000a0000000a000a0000a000000b000ac0e0da00cacbc0e0e0cac0a0cac0a90f000000000000a0000000000000000000000000000000000000000000000000a000090e9ac00bc09e0a0ae90c00090090f00a0e0da09000ac00c000000ca0000000000000a0000000000000000000e9c0b09a0cb0ad00a0900b00bc9a09ad0e0d00000000000000000000000000000000000000000000000000000000000000000c0ae9c00ac00a000d0d00a0a00e0e0e00f0000000e000000a0000e0000000000000000000000000000000000e0e9a0ac0e0da0c0a0e9cacac0e00ac0e00a00b000000000000000000000000000000000a000000000000000000000000000000a00d00a00900b0d0b0a000c90c000900000000a00000a000000000000000000a000000000000c0000000000a00900cad0a09a0c0b0d00a0b00b00bc0b00ad0fe0000000a00000000a0000000000000000000000000000000000000000000000000a0f009aca0c0ac0c000a0000b0000ada000000ca00000000000000000a00000000a000000a00a000a0000000aca90ac9e0ca9ac0a0e9c0f0cac0a0cad0a00f000a0000000000000000a0000000000000000000000000000000000000000000000000e000000000a00a0000a0000e0000ca00000000000a000a0000000000000000000000000000000000000c09cac9a00b0ca09e090a000a09ac9a00ac9e0d000000000000000000000000000000000000000000000000000000000000000000000a000000a000000000000c000000a0000000000000000000000a000000000000000a0000000000000a000a00a0a0c9e0cad0e0cac0f0e9cac0ac9e00a00a00000000000000000000000000000000000a000000000000000000000000000000000000000000000000000a00a00000c0000000a00000000000000000000000000000000000000000000000090e9c9c0a00b00a00b09a000a00a9c0a09ac9ef00000000000000000000000000000000a000000000000000000000000000000000000000a0000000000000000000a00a00000a00000a000000000000000000a000a00000000a0000000000000e00a0a9e9e0cac0f0cac0cac9e9ca0bcac0a00f000000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000000000000000a0000000a00000000000000000000a000000000f0c0a000b09a00a90a909a000a0c009ac9e0d000000000000000a0000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000a00000000000000000a000a9acacac0e0dac0e0e0e0e0e9e9aca0a000a00000000000000000a0000000000000000a000000000000000000000000000000000000000000000000a000000000000000000000000000000000000a0000000000000000000000000000000009e0c09090a090a09a090009090000000d0c9ef0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000a000000000000000000a0000e009acacad0e0e0e0cacadacacacbcada0a0a0f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000a00000000000000000000000000000000000000000000a000a000000000000e0090a00a90090a090000a00000a00cbc0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000a0000a000a00000000a000000000000000000000000009a00e0e9cac0e0e0dacacad0dadac0da000a0aa000000000000000000a00000000000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000a0000000000000000000ac0da9000a09a0900a000b000a00090a00ca9c0f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0cadac9e0cacad0cbc0cac0e0e0e0e0bca0af000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090a000a000b000a000a090b090900090000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000acadacbcadacadacbcadacacacacadacadaca0f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010500000000000020ad05fe, N'Margaret holds a BA in English literature from Concordia College (1958) and an MA from the American Institute of Culinary Arts (1966).  She was assigned to the London office temporarily from July through November 1992.', 2, N'http://accweb/emmployees/peacock.bmp', 'peacock@northwind.com', '234345356' ), 
( N'Buchanan', N'Steven', N'Sales Manager', N'Mr.', N'1955-03-04T00:00:00', N'1993-10-17T00:00:00', N'14 Garrett Hill', N'London', NULL, N'SW1 8JR', N'UK', N'(71) 555-4848', N'3453', 0x151c2f00020000000d000e0014002100ffffffff4269746d617020496d616765005061696e742e506963747572650001050000020000000700000050427275736800000000000000000020540000424d20540000000000007600000028000000c0000000df0000000100040000000000a0530000ce0e0000d80e0000000000000000000000000000000080000080000000808000800000008000800080800000c0c0c000808080000000ff0000ff000000ffff00ff000000ff00ff00ffff0000ffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00000000000000a0000000000000000000000e900000000c9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d000c000000000000000000000000000000000e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000a90000000000000000000000ca0000000e900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0000000c00000000c00000000000000090000000000000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0000000000a000000000000000000000ca00000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000909000000000000000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090000000000000000ca0000c000000000000000000c000000e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000c90000000000000000ca9000000e90900000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000000000000000ac0000000000009000000a0000e0e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000900ca0000000000000000b00e900cb0900000000c00000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c000000e000000000000000000ca00f0000da00000000000000000caca90000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009ca0000000000000000c0000000a90ca9c9090000009000c0c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c0000c0b0000000000ca000e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000ca09009000000000000e9000000000000000000000000000000000000000000000000000009a0000000000000000000000000000000000000000000000000000000000000000000000000000000000c0000c90000000000000000000000000c000da09000000000000c9ce0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c000000000000c0ca00000000cb0d000000000000000ea9000000000000000000000000000000000000000000000000000a0b000000000000000000000000000000000000000000000000000000000000000000000000000b00000000000a000000000c0000c0000c0d00c0f09cb0b09000000000000de0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d0000000000000ca9e9f0b0f0b9cbcb0d0000000000000000cf0000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000c00000000000000000000000cb9c0d0a9c9adcb9ad0b090000000000000efa9000000000000000000000000000000000000000000000000000090000000000000000000000000000000000000000000000000000000000000000000000000c0a90000000000a00000000e0de90cb9ad9cb0db0f0dbc900000000000000000c000000000000000000000000000000000000000000000000000e00000000000000000000000000000000000000000000000000000000000000000000090000b0000000000000c0000000c9ca90f9ad0da9ad9ad90f00bcb09000000000000c00000000000000000000000000000000000000000000000000000a9a0000000000b000a00000000000000000000000000000000000000000000000000000000000000000000000009000e0f0bdcb0f9a9a9c90bc9ad0f9c909000000000000000e000000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000000000000000c0c90dad0b0d0c9c9cbcbc9a9cb9cb0e900000000000000e0900000000000000000000000000000000000000000000000000b00b00000000a000900a00000000000000000000000000000000000000000000000000e00000000000000000000a0b0e9a9ad0f0b9a9a90909adf99cbc99ca900000000000c0c0000000000000000000000000000000000000000000000000b00a0000000000000a0000b0000000000000000000000000000000000000000000000a000900000000c0000000000c0cb0d0d9a99c0d0d9e9e9c900fcbdbe99c09000000000000a0000000000000000000000000000000000000000000000090c00900000000000090000c000000a0000000000000000000000000000000000000000c0900000000000000c0000c09090da9ac9ca9b0b009090b0f90bc0d9e9b00000000000000d0000000000000000000000000000000000000000009a900a0090a0000000000a0a00000a000000000000000000000000000000000000000000000000e0e000000000000000c000adada90db9a9d0c90f9e0f0d90f0dbfadac9000000000000ca000000000000000000000000000000000000000900000000da0000000a0a0b0090000000000a0000e90000000000000000000000000000000000acb000900000000000c0000ad090090da9c0d00b9e900990b0e90dbc0dbdbc90000000000dad000000000000000000000000000000000000c0a000000cb0090000c0f090000a000000a900009a000a900000000000000000000000000000000c90000000000000000000ca9000adada9cb9a9bc0090b00e90d9ebc9f9edadb0900000000caca0000000000000000000000000000000090a0b0000b0da000a000ecba00a0a009000000000a0000000c0000000000000000000000000000000000000000a0000000000000000090d09090b0c9009a90c0d090f0a9c9acb9adbcf000000000000d00000000000000000000000000a0b0cb0c000090000000090d00ff0c9e9090a00000000000000000cb00000900000000000000000000000000cb000000c900000000000090cbcb0bcbc9c9b00f0d00b909ad009c9bc9fcdbe9b0900000000eda00000000000000000000000adac90090009000acb000090e00a00ebea0aca9000000a00a009a00000e90000eb000000000000000000000000000000000000000000900e0090009c909a9a00c909a9d00ad009f0bc0ada9bc9fcb000000000000000000000000000000000efdfbdada00a009a9000009a009a90000c9ef9aca0000a90090000000000acb0000f000000000000000000000000ca0000000000000e000e9000a9f0b0f00d09da9ac900a9d0a9e00d0bd9ade9fe9fc9000000000c0000000000000000009effffebcb0090090a0009009a000000c0000aef0e090000a000a000a0000000cb00000cb0000000000000000000000009000000000000009e0000909c09c909a09ca9c900f90ca9c099f0f00ed09e0dbcbb00000000ca000000000000000cefefffffbdf0da0000090c0a0000090e09a00000debc9a00b0000a90a000000000fe90000a90000000000000000000000000000000000900000090f0bcb0b0b09ad9a09090b900a99090f0009ad9a9e9f9ede90000000ca90000000000000cfffffffefdefa0b090e9000b0090a9000900090000a0eb00a009a9000009000000000ff00000e0000000000000000000000ca000000000a09a9e00000d0909c90bc900c9ada9cad09000f90e9f0da0dad0fadbde90000000c000000000000ceffffffffffbf9fd00a900a0000000c00a0009e00000000000dae000a0a9a000000000ecbc90000b00000000000000000000090900000000c0c0000f09b0b0da09c0b09a900900900bc9f0009000b0da9dad0f0e9f0000000000000000000cffffffffffffffef0bc9000090900f09000900a09000900000a0e09aca090000000000000ffb00000cb0000000000000000000e0e0000000009a0000909e909c909a900d090f90e9a09090090bc990c9a9cbcbcdbfda90000000e000000cfeffffffffffffeffff9fa9a09a9c0a0000a090009c0a0000a09a00fa9ac90b0a00000000000efe9a0000a00a0000000000000000c0900000000000090ada9e90da9a9c90f90ac900090c909a09ad000e09e9cbcbcb0edadb000000c0000cfffffffefffffffffffedfac0d09000000900900a0ca000d000000000000cffeac00900000000000fff9000009000a00000000000000ada9000000000e000909099a909090a90a99b00b009000c09c009a90900f0f09edf9edfc000000000effffffffffffffffefffffbfdbb0a00000b000a00900090b0a0a0000a00000acadb0a0a0000900000c0ffeb0000a0000000000000000000c0e000000000900da9cbc9c9ac9a90c90c0090090a90b09a90bc0090f0090f09a0f9a9b000000e0cffffffffffffefffffffffffebc9d00da90000900a009000009000a0090000000f0e09000000a000000feff900b00000000000000000000ca9000000000000b909b09a90990c90b09a90f090c900000000009ac009e0f0fcfdadfcf900000d0fffffffffffffffffffffefdf9ffa0b0000090f009c9000a0d0e000900a00000a000a9a000000000000ceffe9a00000a900000000000000cb00000000000acbd0f0c9099a90a900900900000a900090900900000ada090d0b9a9e9e900000caefffffffffffefffffffffffebef00d09a09a000000000a0900a900a00009000900a00000000090000000ffdb00000000a0000000000000000f0000000000990b99b90bc0dac90b0c0bc909090009000000090909000d0e9edede9e9f000000cffffffffffffffffffffffffffdbf9a000000900090a00900090000000a0a00000090000c0000e0900000e0b000a09a0d0b0000000000000ac0f00000000cadbcbc0bc99a0990009a90909a009000090090000000000a90b00b0fcbcfb0000cfffffffffffffffffffffffffffadad0b0909ca09a09090000a09e0090a0900000a0a00000a90000a00000b000b0000000a00000000000000de900000000c9b90999909a090a09090900a0009000900000000000009000c0c9ede9f0f090000efffffffffffffffffffffffefbfffb0b00ca0009000000a0da9c0090a00000a9a00000000a9000b000000000000000000000000000000000ce9a0000000e9bd0f9a0e9ad90d090bc0009090900900000000000000000909a9ad09ae9e9e900cfffffffffffffffeffffffffffedb9cbc90090900009a009000000b000090a0c00000b000000a000d09a00a00a0000eb00a0eb00000000000cbc09c000099f09b9c99909009a900090b000000000000000000000000000000c0a0fd9e9e9000effffffffffffffffffffffffffffefa900b000a90b0009009000b0c00a0a009a9a90000a00000000a00000900000caf0b00cfff9000000000acbe000000e99f9cb9e9a909a900f09a0090900090000090000000000000000000da0ad0f9e90cefffffffffffffffffffffffffffbfdbcb000900000c900e00a9000b0090000a00000a0090009a0e909a0b00a090ebe90000ffffb00000000c0f0900000f9bf9b99090d0b0d0990900900000000009000000000000000000900900d0ad0eda0ffffffffffffffffffffffffffffffdadb009a00c9a90a0909000c09000a090a00000009a0000e0f9aca00000000a0090000effffff00000000fe9e0009db9e9dadada9a9c90b0000090090090900000000000000000000000000c00bc9e9b0defffffffffffffffeffffffffffefbebf0cb0090b000009a000000bc00000a09090a00a0c0a000f0ecbdada0a9000b000a0cffffffffb00000e0f00900cafdbdb99909c909a90090b0000000000000000000000000000000000009ac00e9ecfeffffffffffffffffffffffffffffffbc9b0c0000000090000090b000b00b000a0a000000a9000000b0ca009000a0000a000ffffffffffff9000c0fa0009f9f9bcbda9a90b090db000909090000009009000000000000000000000009c09a909ffffffffffffffffffffffffffffffdfbe9b909a9009a0b0090a0090000000b000000009000e900a000a9e0ac0a09a09000efffffffffffff000af09000f9fbf9b9a9d090d00b000900000a0909090000000000009090000000000000a9c0daccfffffffffffffffffffffffffffffbfcbc00a000a9000c0b00900ca09000a000a90000a0a00a00c90a9ca900b00000000fffffffffffffffb00c90000fffbd9f09d9a90b0b9090900900909a00000000000090000000000900000e090c0b00fbffffffffffffffffffffffffffffffcbd0b09090d009090c0000a090a0a09009000a00000b0da00ac00adefa09e0b00efffffffffffffffff90ca000cf9f9fb9f0bc9ad09c0090a900900000909000900090009009a90900a90090c00b0cad0cfffffffffffffffffefffffffffffbfba90000a000a00a009a090009009e00a00a90090000a00000b00000edf0000effffffffffffffffffffb0d0009fffbdbdbd9b090b09b009009a090900000090090009c0090000da90009009a9c09000b0cffffffffffffffffffffffffffefdedadbcb090b0909090090090a000a90b00a000a00a0009a9000ca9a90aa0fffffffffffffffffffffffff9a000efbfdbdb09ad9e909009009000900009090b00900da09090d090000909c9c09ca9e9ad0dafffffffffffffffffffffffffffbffbda090c000000a00a000a0009009ca00009a0d0000b0aca000a9c00ac9cbeffffffeffffffffffffffffbc090fffdbbcbdbd0a9090090a90909009090a09009009009a909a9e9099ad0b0a9ca9c00c00adeffffffffffffffffffffffffffffbcbc9a00b090b090909090c900a9a09e09a0000a900c009c0000e0bc9a0acbdffffbffffffffffffffffffbc00fffbfdb909a9909acb0c90a00090a00909e990a9a90c90bc9090b0c9090d9e09cbcb0bc90dffffffffffffffffffffffffffffdb0b009000a000ca000a000a09009e09e00a0a9c0b00a0a0b0009e0a0d0f0aebefbcffffffffffffffffa90b0cffff9bdfbd9e9909009009090bc9090f090ad90d09b9ad0bcbd0db0db0f0b9fe9cbcd0bca0fffffffffffffffefffffffffffbeff09a090909c909009009000000c90e9a90900a9c0b0900000a00f0da000d00cb0efffffffffff9fa90000c0bffdbfdb9cb090e90090a9090000909a90f990ada9e9c99f9bd0b0c9b0d0fde9debda9ac90defffffffffffffffffffffffffafdb0da90a0000a000a9000a090a9090a9a000a00d0a90c0a09a000e0ea9cbfabcb0b09e9cad0a900a00000000bcffbfdbbdb99e990b9090900f909a0f0db09cbd99c90bda90d0bd09b0dbf9cbdebdecbc9ada0ffffffffffffffffffffffffffdbadb0c0909a909a9000090000000a9c0c9a00a0a09e9a90a0090900d0a0c0deb0c00a00b0a900000090009000cfffdbfda9e990a900a9000900f0990b9cbcb9ada9bd09dbdbd9adbcb0d0fbcffdadbcbc90dacfffffffffffffffffffffffffbfda009a00c000000d09a009a9090ca90ac909090e00c0e9000a0a00afcb0e0f9a0ffcb00000a9a90000cfa900cffbfbdbdb90e9090d0090b09009e0d0a99bc99ad90bda9090bc90d9d9ad0d0f0fdadf0bcb09acfffffffffffefffffffffffffafdb00909a90b0900a0090000e00090a90a0a00090b0b00b0a0000ad09e09a00cffffffbcb0000ca9acb900000ffffdfbdbcb99c0b090a9c90b9a99a9dbc9b9e9b0f9b9dbdbdbdb9a9e99f9f9ffadf0fdadad09effffffffffffffffffffffedf9ada90a000000a090900a0909009e0d0a09000a0e09c0f0c909a000afe9ac90ffffffffffffffb9d0da000000ffbdbbdb09900a909090900b0c9da9db09f9c909d90d9a9adbc9bc9f99e9e9edadf0ff0bc909e9fffffffffffffffffffffffbfad0900090090909000a0d00a00b090a0d0a0a9009ca9a00b0e009a9c0be90a0cbefffffffffffff0bef90000cfffffdb9dbcb09090a090a9c99b0db09f090b9f9adb9f9d909b0d9f9ef9f9f9f9e9fe9edb0f09acfffffffffffffffffffffff9f0b0ad0a9a0a0000b09009090900e900ad0000a0a0d090c0b0f00ca0c0fefda009adafffffffada0cfff90000fbf9fbda909090da99c0990b0f0b09f0bdbd090f990f9a9f90db0b0d9ebd0fcbcbd0df9edb9e0d9affffffffffffffffffffbfe9f0d00900909c9a000000a00e00090e900a9e00c0b0a0ca9c00bcbcbffffffffbc00000cb0bc9a9cffff00000fffffdbdbcb0f009009b0c90909dbc990909bdb9adb90d909f00d0da9990f99f9daff0f90fc9f0acdffffffffeffffffffffffbf0b0b00090000a09c9a9090909a9e090a0d009a0b0c90a9ca9fcbcbffeffffffffffffebcfe9e9ebffda9000cffbdb9a9090900b90b000b0f0bcb0b9e9a9f0b09d99c9a90900900b0d9edbde9fcbd0fd0f09b00d9effffffffffffffffffff0f0bc900a9a0a90900a0000ac0a09090ad09a9a0d0c9a0bca0da09efdeffffffffffffffffffffffbcffbda0000fffbfd90f0b0090c9090909099909d099d09d9db0b0b900f009a90d0b09bc9bcbbcbf9af0fadada09effffffffffffffffffffff90a090009c0a09090909090d00ca900ac00da0b0c9c09cb0dac9afffffffffffffffffffffbdff9cfff99000ffdfbbc909090090a9cb0da9e9ada9bcb0b0b909d9d0d9009000c9a9c9e9bcbddbd0fcdbd09090da9cffffffffffffffffffffbde9da09c0090900a000a000a0b0a90e909a900d09a0b0f00fadafcfeffffffffffffffffffffff9ebfff0000cfbfbdb9a90f09a090900909090d90d099d9d9cb9a909a0900090900cb090dbdaf0ff9fada9e9e9bcf09efffffffffffffffff9eb9a009a0b0a00a9090909a090009c090a0c0e9a0e0d0e00f0d0f0ffffffffffffffffffffffffebdfff0b0000ffdfb9c0da9090db09a90b909a9a9a9e9a9a9b9c99a9090909000009090dadad9ff9f0db9e9c9ac90bcffffffffffffffffffff9e909009000909000a00c0900f00bca0d0b090c909a090f00fadefffffffffffffffffffffffbdf9acb90000cfff9f09b09090b000090d0a00d09c9999d99c09bd09c90000c9090900f0bc9dffd9e9ff9e90b0d9e9cbcffffffffffffffffbf0b0f00b000900a0da909a900e90900900a9c0a0b0e0dacb0f00f0fefffffffffffffffffffffdffefbdef90000ffbf9f09bcb0d099bc0b090d0a90b0e0b0db99c90b090b9090a9090f90d0fa90fafdf9ad9e9cb0a9e9cbefffffffffffffffffff90b009e0a90d00000000b000a09e0ad00a9c9c090a09c00f09effffffffffffffffffffffffadbd0b090000efffda9bc9999a9a00990909090909999d9b090b9f9db900d099cbda90f9f9dff9fdbdedb090b0d9e9ebd0fffffffffffffffffbdaf00900900a00b09a090009ad0000909e90a09acbc9cb0f0feffffffffffffffffffffffffff9e9e9c00000dfb9b99c90f0ad90d09a09a09a9e9e90f0b0d9bc909a9cbdb9bcb90dbdf9e9fbcfdbcbb90bcbcb0e9cbd0fffffffffffffffffbcf900bca90a900900009a009e000e90ca000c9ac900b0a0f00f9effffffffffffffffffffffffffbda09a0000efff9ca9a90990090900d009c90909a999d9bc9bdbd9f9909c99c9f9cb0dbdedbf0ff9dad09f0c99bcadadeffffffffffffffffba9e9090090090a90b0009a009a990b09c9a0c90e9c0d090f00edffffffffffffffffffffffffffcbdb009000dfbdbbd99f9e9b090b90b09a90b0909ca9b09bd099a99e9db9da9f0f9dbedbdfdff9fe990f09f9eadbcbcb9fffffffffffffffffda9a0090a9ca900c09a009000c00e000a009a0a90a9a0f00f0fbeffffffffffffffffffffffffbff0f090000eff90da9e9099c90b0c9090909d0bc9b9d0dbcbdbd9db99a9cb9d090dad9fcfade9f99da90dada9dadbdbcfefffffffffffffff0f9c90b0a9009009a9009c0a9a900909ad0f00c90e9c0f00f0fdefffffffffffffffffffffffffffff900000cff9adbd990bda9b0d09b09e90b0090b0909a99909bcb900909000090909cadf9f9f0bca9da9bdbdadacbcb0fffffffffffffff9fb0b0bc0900b00b000090a09c00b0ac000000b0e900b00e90f0effffffffffffffffffffffffffbdbde900000ffbda9adad9ad09b0b00909ad09b0909cb99dadbc9909090000990000000909c000d0990090da9cbc9fdbcf09efffffffffffffedad00900f00b0cb090a09000bc0d09ada9ac090e9c0f09e00f9efffffffffffffffffffffffffffebff90000ffbdf9db9ad9bd0d09bcb090b0d000db00f099009000000909c0ad0bc909c0a909000009a0f9fa99f0f0f9f0f9effffffffffffbf9a9a0b009009000a90009a90b00a00000c9ac090a900e99f0effffffffffffffffffffffffffff99e9a090cfbcb9fb0d9bc9a9b9c990da99da9b900990900090090d09c9c999909009a99c9e9a900000d009d0f0f0f9e9f0fdfffffffffffbf9e9c0900b009a9090c0b000c00009c90f09a00b0e9c0f09e0effffffffffffffffffffffffffff9ef0909000f9dbda9dbbc9b9d0a9a09a9c9a900009000000909b0b0909a9b0f0f9f9fd9e9bdad0b090db0bf0f0f9f9edbcfffffffffffffffcb090b0a900b000a09a90cb0b09e0a0a00000d0c900a90bc0f9effffffffffffffffffffffffffffb0be90b900aff9f9bc99bd0b9d09bc99a9909909000909bcb09d9bdbd9d0909909e9af9fcbdb0d0dad09c9b9dadadfadbcfdfffffffffffbfbda90d00b0ca90d000090000a09d09c9a9e0a9a0f0c0e0b0e9efffffffffffffffffffffffffffffd99fd099c9bcbdadbdadbd0b99e99e99e90000000009c990f0bc909a9a9e90e909d9cf9f0fdb0a90bf09edaf9fdadf0f9ffffffffffffffadada0a90c9090a09a90a9090da00a000c00900c900b09c0f0effffffffffffffffffffffffffffffbf9b9b909fdbdbdb0bf9b0bc0b90b90b9090d0a909e0b0f99999b9c90d090900bcbcbdadfcb0d9ded09e9bd9e9edbedbcbdffffffffffffdbb09c90a9a9a909a00a90ac009009c9a90b0ca9a0f0ce9e9adffffffffffffffffffffffffffffffbdbdbd09cfbdbdadbd9fcbd9bd0f90f9090a909c00990d09ad0ad0b09000009d09cbdadbcb9e9acb9b099edaf9f9edbcbdbfffffffffffbfbc9a9a0900000a0900d0009a9ac00a0ca0c0900d009a9a0de9efffffffffffffffffffffffffffffdbdb99b0bdb9ebdbdbe9b09a9a99e909cb090909a9009a9090d909090090900adadad9ecbde9d9bd0c9ef9bd0dafdbede9ffdffffffffffcbad009b0a9e90d009a009a00009f090909a0ada0bc0d0da0adfeffffffffffffffffffffffffffbfb9f9f999fffbdb9e9f9f9f9d0da99b9b9090da90909ad0bda909e99a90000909090dadbda9da0fcb90990f0fbfd0bcbf9e9ffffffffffffbdbab00c9c090a0bc090a0909ca000e0ac00d000d09a0a0d0f0effffffffffffffffffffffffffff9db9f9f9cfbdfbda9f0f9f0b0b99f0d09090009c909e9090990b0900d0909000c9e9ad0dadf0d9090090f99f9c9efdfd0fdff9ffffffffffff0d09b0a9a0b0900b009c0a0a900a90909a00e9a0e0d0f0f0fbdffffffffffffffffffffffffffbdb9f9fb9fbdfbdbdf9f9fbd9f9cb09b9f9a0900b0a9090b0dad0990b0090090db090dcbcbd0b9ca90bcb9cfadbfbdadaff0f9feffffffffb0b9a9e009009c00a900b00a9c9009c00ca0d0900d09a0f00f0deffffffffffffffffffffffffff9dbdbdb9dbdffbdbcb9bdaf9a90b99f0d0909909009d0909c9090900d0900c90000d0f0bdad0bca990c90c9b9dbcd0fdbdadfb0dfffffffffffcbd09cb0bca9a90a9c0090000f0a90b090a0e9a0e0d00f0be0feffffffffffffffffffffffffba9f9fbdb9bdfbff9f9f0f9df9f9cb09b9b0900f0900009e09a90b0db0909a909090a90dcbdadd9da9909b9c9e9fbfdbeffdbcff0dfffffffffbf0ba0900090090d0a900a90b000000c0ac9090c909acb0c0dadbffffffffffffffffffffffff9d990d9bdbdfffdbf9f0f9fb9f9b99f90d0db99090090b0990d09090090909090909d0f0bd0db0b09ca90d0b9dbcdfbcf9cbef909fffffffffbfdbc90a9e9a0b0a0900a900c00b00f0a90900e0b00e090e9fadeffffffffffffffffffffffff9b0b0fbbf99bfffbf9e9f9fb0f9ad9e9f99b90ca9009009c90b09f9099090d090bd0f0f99c0ff0f9d099c90bcdadfbedf9fbfd9fbdefffffffffcba09ad0900d0c09a09000a90bc900900acb0900f09cad0a0dadeffffffffffffffffffffffff9909dbd9bffffff9f9f9fbdf9f9bdb99ad0b9990990b009a9c900090009a9b9d0b99d9edb9099090b009a9d9bdbfdf9ffcf0fadf9dfffffffffbd9f00b0a9b0b0b09ca9090000009a09c900cad009e09ad0f0faffffffffffffffffffffffffb90909fbd90dfffff9f9f0dbff9f0bdad9b9c9a9d009090009099909099c90da9d9e9adbfdad0f9e90900da9e9fd9fff0ff9fdb0fbffffffffbfbeb0b009c000090ca900e090f0b00c90a0cb090ada09e0adad0defffffffffffffffffffffff90dbdb9090dbfff9ff0f9fbdb9fbdb9f9bd9b9d9a9b0909090b000b0dadb9f9db0f9ffdfdfdfb909090f909d9f0fff9fdf9edadff9cffffffffff9bc9cb0b0f0b0b0909090a000000b0e90b00ac9009e90da9ebefffffffffffffffffffffffb9db909090b0ffffff9fdbfdbdff9f9f9bdb0d9a999c90c909090db9db9bdbdbb9dbdbdbffffbd0da90990df0bdfffdfffbedbf9f9dbfffffffff9bca9a900909c0000a0a000909ad0009c009c90e0f00ada0dbcffffffffffffffffffffffff90999909090dfffffbf9bdfbff99f9f9bd0dbbd9f0909990b000909dbd9f9db9dfbdbdffdfffdfb990dacbb9fdbdfffdfdfdbde9efbdffffffffbfeb9000e9a0a0b0f09090b0ca0009e00a9a0a090009e90dae0f0fffffffffffffffffffffffb9cbcb090909fffffdfffbdf9ffbdf9f9bb9d9b09dbda9a909d909a99bd9fbdb99dbdbdfffdfff90da999d0dadffdfffbffbdbdb9fd0ffffffffe9bcbdb9009c900900ac000909cb000909c9c9ca0f0e09ead0f0ffffffffffffffffffffffff99b99990909ffffffbf9fdbff9fdbfdb9ddbbd9f9a999d09d0a09c9dbd0bd9f9f9bdbdbdffffdbda99cbcbdbdbfdfffffdedfef0dfb9ffffffffbff9a00cb9a9a9e0a9090b00a000009ac0a0a0b0d0009e090f0ffefffffffffffffffffffffb9c9db90090f9ffffffdffbdf9f9bf9bdf9b9d9b9d9bc9a99a999b09a9b9dbf9f9bdadfdffdbdbd090db9f9f9fdfffffdffbfdb9dbf9cffffffffff0bc90b00000090909a00009090bac0b09c90c0a90f00f0f0f0fffffffffffffffffffffff999fb909900dbdfffffbdbdbffbff9fdb9f9f9bd9ad9b99c9090d099d0db9c9f9f99db9fffffedbdbf0fdbdbcffdfdfffdfdbfdebdfb9dffffffff9f09ad0ada9e9a0a0c009e000e00909c0a00b009e00f00f0f0fefffffffffffffffffffffbf909dbd0990fbfffffffffff9f9fdb9fdb9f9f9bd9bd9e9b9db9a9cb9b9cb9f9f9f9bdfdfdfdbdad9db9f0fdbdfbffdfbfffdaf9e9ffbcffffffbffaf09a90090009c90a90090b00900a00909ac0f090f09eca9e9fffffffffffffffffffffff999fb909009cbdfffffffff9ff9fbdf9bdf9f9bd9bd9a99c9a9d99b9c9db9dbdb9dbdb9fffbfffdbebdedbdbdbdfdfffdfdfffdf9ff999ffffffff0f9cb00f9a9a90a0090a000009a00d0bcac00900ca00e0b9e9efeffffffffffffffffffffb9adbd9b9090fffffffff9f9ff9ff9f9bdb9b9bd9f90b9db9b9da9e9dbdb9fbdb9fb99dfdfdfdfdbf9df9bdbdfdffffbdfffbd9f0fffb0fdffffffbfb0b0e9000c90a90b0009009a0000a00090b0acb0dad0d0e0f0ffffffffffffffffffffff9d99fbd9a9090fffffffffffdbdb9f9bd9bddbdbb0dbdb9d0da99990b9bd9c99fd9dbfbdffffffffdff9fcbde9fbdbdffdfdffebfdffd99fffffffff0f0900b0b0a9c0000000a009c9090da000c9090a09a9adad0fcfffffffffffffffffffffb90f9fb9d09009bffffffffbfffdb9fdbdb9bd9d9b999cb9b9dbcbd9d9cbb9fb9bf9d9f9fdbdfff9fdadbf9f9f0dfff9fffbdbd9efffbdadfffffff9f0f0b9c00900b0f00b0900c00a00a00d0b00cac9cac0da9adaffffffffffffffffffffff9999dbdb9b909cffffffffffdb9bdf9be9dbdb9b9dbdb99d09b0990b0b9d9f9dbd9bbd9fdffff9fffbdbd9f9bdbf9f9ff9ffefffdffff99fffffff0fba90c0b0f0a900009000090a9000d090ac0b0090a90fa9edadeffffffffffffffffffff99e9fbfbd9909a9fffffffffdbffdb9bd99b999f0db099bcb9f99f9f9d9f9bd9bdbf9d9f9fffdffddadbdfad0f0f9fdffdffdfdadafff99edffffffff09cb0b09009c90b000000a000000a0e9090cb0ad0cb00d0adefffffffffffffffffffffb9999dbdbf9f99c9fffffffffff9bdbdbdbdbdb9b99dad99d90f09090b99f0bbdbd9f9bdffdfbdbfbdbf09dbd9f9cbe9fffffbffff9fff09fffffffbdfa90900cb0a0a0000a09000909090900ca900d0a9acbcaf0b0ffffffffffffffffffffff99e99fbdbf9bf9fffffffffbdff9f9bdb99dad9db999a9b0b99f9bdbdad9d9da9f9bd9bdffdffdedbd9f0b0a90fbdff9fdfdfdbdfff9f909fffffffadab0e9a00d09090900000900ca00c0b0b00a9a9c0c9cbc0fcfeffffffffffffffffffffb9099f9db9dbd9b9dfffffffffbfdb9db9f0b99b09cb99d09d0b09c99099b9bd9f9f99fdfffff9f9bda909c9dad9cfbdffbffffff0fcf9f90ffffffbfbd0c9090b0a0e0a00900a00a0000b00c09c90c0a0b0b0db0fafffffffffffffffffffff9d90f9fbfdbb9f0fbfffffffdbfdbbdb0d9bd9f9d9b9cb0b9a9c909b0f9bcbd9b99f9f9bff9f0fa9d00d0b09a90adbcf0dfdbcf9009fb090feffffffe90b9a0e0090909c00000000909000b090a0e9ad0d0e9ea0f0fdffffffffffffffffffffbb99099f9b9df9f09000fffffffbfdbd9bd0b090b0da9090c9090b0c99c999b9f9f9b9dfdffbd990099ad09c9e9dadf9fbffffffb0edff909ffffff9f9e00090b0ac000090090090000090c0ad09000a9a90c9edadaefffffffffffffffffffff909ad9bdb9b9b9f09000fffbdfdbf9bd0b99db9090909c909a09c9000b09e909f9fdb9fffdfbcbda09009a9090bdadede9fdf9fc90ffff90dffffbfeb9e9e09c909a9a00a0000000e000f09000a0d0d0c0fa090f0dfffffffffffffffffffffff99d9adbdbdfbd90009dfffffbbf9fb9b9c9a0db0909a909009090b0909c99f99f9bdbdfff9990090009090bcbdadbdbdf0ffffb0e9ffffffffffff9bc9090a000a00090000000a90900000acbc9a0a09a90dae9ebefffffffffffffffffffffb90909090f9b99a0bcbefffffdfdbd9c9cb999909ad090a9090000090090b09bf9bdbdff9b0f009090909e9c9cadbcbedadfbcf0d90bffffffffffbfca9a0a90bc90d0000900090000090b09000090dac9ecbc9acffffffffffffffffffffffff99090bdb9f9f00d000dffffffbb9bb9b90bc9a909a90990d09090909a090f9c9bdbdbdffd90090000000009a9d0fbc9adafdffb0efdbdffffffffda9b0c900c0a000a0900000000a00ac0ca90b0e009a09a0f0f9a9effffffffffffffffffffffb9bddbdb990900f0f0ff9fbfdbd9c90099b0dbd09da0d0900b0000090090b9f9f9f9ffbfb9adb90d0bd9bc90a90dbd90debedf9efffffffffffbff0f0b0da9090b090a0009000009009a90c0c090bc0dac9ad0edefffffffffffffffffffffffffdbb9b9f00009000fffffffbdba9b9000c9b09b0099a0b0d090909c900909bdbdbdfdf90d9000909000000f0de9ca0cbdfdfb0cffffffffffffebf0900a00ac000c0090000a0d0000000b0b09ac009ac9ad0af0ffffffffffffffffffffffffffb9dbd900000a00f9ffff9fdb9d9d09009b0d900900090909090009a99e9fdb9f9fffbc9a09090a00000000da9a090bcfbefc0fffffffffffff9f090e90d090b09a90000009000a09a9c000a09adac90bc0f90f0fffffffffffffffffffffffffffb90009000c90cfffffffbd0b0b90900090a9000000ca90000900900909b9fbdbdf9b0db000009000000cad09000cbcdffb9efffffffffffffada900a0a000c000c0a9000000900c0b0d09c0009adacb00e09e9effffffffffffffffffffffffff090000090000ffffffffbd9f0bd090000900000000deb900090090bd0fd9dbdfff9b00900900000000acb00c09cfbe9ff0cffffffffffffbdbca9090da90b00a9000000000000b000a0e0bcbc00090f090e9effffffffffffffffffffffffff90000000000f0ffff9f9fb9a99c9b0900000000000da9000900090ac9b9bbf9fbdf9c900090000000000900090cbd0def00ffffffffffffbdeb090e00000a009000900900b000000ad09090009acb0e090e90fadffffffffffffffffffffffffb000900000000ffffffff9f9d0bb0d000900000000000009009000999adfd9ffdfb09a0900009000000000090e9fcbf0f90cfffffffffffffb09ca90b09c90ca00a00000000e09c9000a00e9ac90c909e09ad0ffefffffffffffffffffffffff90000000009c9effffbdff90b90d9b0900900000000009000000909e9f9bbf9fbfdbd90090000000900009acbdf0f0cfda9efffffffffffbcbda9000c00a009000900a000009000a90d0900090a90ac09ac0ad0fffffffffffffffffffffffff900000000000a9ffffdfbfbd0f0bcbdbd000090000090000b009009090f9d9f9f9f9a9d0a990090000d0c099efbf9f0ef90cfffffffffffffdada9cb0b0900a0d0009000090000b0ca0aca90e0d0bc9ac090dadadfffffffffffffffffffffffb000900900000cffffbfdffb909090909b99da0909a0c9a9009a09a0bd9fbfdbff9e90a90ca9d00909a9bf0fdbc9e0df9a0cffffffffffffbe900000000ca9000a0000090a0000c0090909c009a0000009aca0ffffffffffffffffffffffffff9000000000900ffffbdffbd9cb0cb0f9e9cb099b0d09b0900900909d09ad9dbdf9b990909090a09adadad0da9e9e0debe900fffffffffffbe90e9a90d0a90c00090000000c0b090b00ac00a9a00f09ada0909fadffffffffffffffffffffffff90000000000000fffffffffb900909009a90bcbcb0b0090900900900f9fbaf9b9f0f0f000009090909090b0d00009adf900cefffffffffffbdb00ca0a900000b00009000000000009090bc90d000ac0090e00cfaffffffffffffffffffffffffb000000000ca90cffffbfffff9b00a9009009090909090009009009a090d99f9e9f99099a90000000000000090dac9eef000fffffffffffdfadb009000cb0b0000a00000090000b0ca00000a0ad090b00c90fadfffffffffffffffffffffffff90000090009000ffffffdff9f9c90900900900000000000000000bc9dbda9e9e9fdbdb0d0090000000000000a0009edf9000efffffffffffada0da0c0b000000d0900090a000000009c90b09c900ac0ca9adadbfffffffffffffffffffffffffb000000000000e9ffffffffffb90d0000000000000000000909c9090b099f9bdbdb0bc9a99c0900000000c90c9adedfb0000fffffffffffbfda9090a90090c90a000000000a909cb00a00c0a00ad09a900cbefefffffffffffffffffffffffff900000000000900fffffbffff9fb09909a90090900000090c0b0bcbd9fad0fdbdadbd9f9f0b909c90900900f0fcfffff9000efffffffffff9a9ca0d000e0a0a00000000090000000909cb09cb00a0c0a9e9c9fffffffffffffffffffffffffff9000000000000900ffffffffff9f9ad9c90900a009090009bc9f990bc9db9bcbf9bcbf9e9f0f9ebe9cbcadadffffffffa900dfffffffffffeda900a09090090090b0900000000090e00a00000c9c9a9c00eafeffffffffffffffffffffffffff900000000009ac0bdfffffffffbdbdb0b0f0bd909cb09f9e9fbcbdbdbfbcfdbfdfdbdbf9bf9ff9f9fbdbdffffffffff90000efffffffffffbf9cb090ca00c00a00000000000900a0909009e90b0a00c0bcbdfffffffffffffffffffffffffffb00000000000c090d0ffffbffffdbdfbdbd9bc90f9bcbdbdbdb9f9bdadbdbdbf9b9bdbdfdfdff9fffdfffffdfffffffde900cfffffffffffbc9a0000a9000b00d0000000009a000900a0da00e00d0f0b0cbcebfffffffffffffffffffffffffff900000000009a90a9fffffffffbfbbdbdbf9bf9bcb9bf9e9f9f9edbdbdbf9f9ffdffbfbfbf9fff9fffffdffffffffbfb0000fffffffffffffad0f0d000b009a00c9000900000000c9c0090909a000009acbdeffffffffffffffffffffffffffb000000000000c09ca9bffdbffffdf9f9bdbddbfdbdfdadbdbcb9bdbf9fdbf9f9fb9fdfdbdffdbdf9fffffffffffffdffb000effffffffffbdab000a90c00c00090a09000000000b000b0c0a00c9a9e9e09eaffffffffffffffffffffffffffff9000000000909a090fdffffffffbfbdbf9fbbdbbdb9bdb9bdbdbdbdf9fbdffff9ff9f9fffbdbffbfffdffffffffffff9c90cfffffffffffff9cb0900a90b0090a000000000090000b000a90da9ac00009e9dfefffffffffffffffffffffffffb000000000000ac90fcbf9ffdff9f9dbf9f9fdb9db9fdb9fdbdbdf9f9fbdfbdbdbf9fbff9fdff9fdfdfffffffffffdfbcb000ffffffffffbebcb00cac900000e0009000000b00009009c90c000c909e9e00eadfffffffffffffffffffffffffff90090000000009e09adfffbffff9fbf9f9f9bdbf9f9bdf9b9adb9fbdf9fbdbdbdbf9f9ffbf9fffbfbffffffffffffedbd00cfffffffffffdb9cb00900a0cb09090000090000000ac00a00b0b000e0009e9daefffffffffffffffffffffffffff900000000000d09c09adbdfffffbd9f9f9bfdbd9f9f9bdf9fdbdbdbf9f9f9fbdbd9f9fdbdffdbfdfdfffffffffffffffad000fffffffffffeb0c9a0009000000a00a900000000009a909000c0b090f0000e9daffffffffffffffffffffffffff000000000900000b0f9fffbdbf9fbb9f9f9bbdbf9b9fdb9db9f9f9f9fbcbf9fbdbfbdbbdfbdbf9fbffffffffffffdfffb000effffffffffbf9cb0c90bc0b00ac09000000000900900000e90a9c0e000adadaefffffffffffffffffffffffffff90000000000b00f0d9e9fbdffffb9ddbf9fdf9bdbdf9b9fb9f9f9f9ff9dbdf9f9f9dbfdfbdbfdfffdffffffffffffffd0900fffffffffffdbcb009a00000c90900000000090000ca0cb000d00a909ad00dadbfffffffffffffffffffffffffff90000000000c0090adbf9ffbf9f9fbbd9f9b9fdb9b9f9f99f9f9bdbf9fbf9bf9f9fbd9fbdbf9fbdbffdffffffffffffff000cfffffffffbf0f09a0c90b09a00a000009000a000a90900090a9c00ac0a9e0aedeffffffffffffffffffffffffffb900e00000009e0bcbc9f9fdffbf9dbbdbfdb9bdfdbdb9ff9f9fdbddbd9ff9dbdbdbfbdbfdfbdffdbfffffffffffffff0f000ebffffffffff0bc90a00c0009000b000000000000000090a000a9c909c009c9efffffffffffffffffffffffffff900090000009009c9fbffbfbf9f9fbd9f9b9ff9b9bdbdbf9f9f9bdbbdbf9ffbdbdbdbdbdbbfdbbdbfdffffffffffffff9000adefffffffff9bca0090e09ac0c9000900009009000b00e0c90d00a0e0a0f0faffffffffffffffffffffffffffffb0000000900e09e9ebdf9fdfdfbf9dbb9bdf99bdbdb9b9df9f9bdbbd9f9f9b9f9f9f9bdbdfdbfdff9ffffffffffffffe0000dfffffffffbcbc909e00900090a0000000000000000c909000a0b0d090d0009defffffffffffffffffffffffffffb000c0000009e90bdfbffbfbfbd9fb9dfdb9ff9fdb9f9f9b9bdbf9fbf9fbfdfbdbf9fdbdb9bdbf9ffffffffffffffff99000ef9efffffffbf0b000b00b00a090e900000000000b00a000b000c0a0e0adaca0fefffffffffffffffffffffffffffb000d0000000f0dadf9fdfdffbf9fb9b9fb9f9b9f9fb9f9f9f99fbdbdbdbf9fbdbf9fbdff9fdbf9fdffffffffffffff00000efdfffffff9f0da90c00c09000000a90009009000090c0900d09090909009f0fffffffffffffffffffffffffffff9000a00000cb0f0fbffbfbfbdf9f9fbdf9f9bdbfdb99f9f9f9fbdbf9f9dbdbdbfd9fbdbf9f9ffdffffffffffffffff0b000cfbeffffffbefb00ca90b00ac9a900000000000a000009a000a0a0e00e0e9e0efffffffffffffffffffffffffffff9000090000000dbfdf9fdfdffbf9f9db9bdbdbf99bdfb9b9f9bdbd9fbdbfbdfbdbff9ff9ffff9f9ffffffffffffffb9000dbf9effffffff90cb090000090000000000000000090b0000f090d090909000fdeffffffffffffffffffffffffffffb0000000000d0bcfbffbfbffbd9f9fbdbdbfbd9fbdb9df9f9bdbdbbdbff9df9fbdbdf9bf9f9ffffdfffffffffffffc00000ef0dfffffbf0fb00a00ad0a00a00a9009000000900c000d0000a00a0e0e9e0afffffffffffffffffffffffffffffff9000000090a9cbdf9ffdfbdfbf9f9fbdbd9fbf9f9fbb9f9fdbdbdf9d9bfb9f9fbdbffdffffdbdbfffffffffffffdb900000cbeffffffff0f9d090000d0900d00000000900000009a000b0d0d0d09000dceffffffffffffffffffffffffffffff009c0000000000ffffbffffbdbf9f9dbdbf9f9f9f9f9f9f9bdbd9bfbfdbdfbfdbfdbdbf9f9ffffdffffffffffffb000000ff0ffffffff9f0a00ca90a00ac90000000000000009a00090c000a00a00e9ebffffffffffffffffffffffffffffffb900000000009edbdbfdfffbdbf9f9fbfbf9bdb9f9f9f9bdbf9e9ff9f9bdbdbdbfdbffdbfdbf9fdffffffffffffd000000fe9fcffffff9ef0da900c090090a00b0000000090000009c0b00a90b09e900edeffffffffffffffffffffffffffffff00a0000000009a9fdbfdbdfff9f9fbd9f9fdbdbdb9f9bdbf9f9fa9f9ff9fbdfbdbfdbfdfbdffbfffffffffffffb00000c0febffffffffb9b00a09a00ac0009000900000000000d00a0009c0c0c000f09afffffffffffffffffffffffffffffffb9090000000000cbadbffbdbdfbf9fbf9fb9fbdbf9bdfbd9f9f9dbdb9ff9fbdfbdbbdbf9fbdffdffffffffffff0900000f0dfefffffffedad09c090009a00000000000000000b009000000b09a0bc00edfeffffffffffffffffffffffffffffff00c000000000909dbdbdfbfbdf9f9f9f9ffbdbdbfdb9fbf9dbfbdbdf9ff9dbbdffdff9ffdfbdbfffffffffff900000000befffffffffb9e9a00a0cb0009ca90000900900000000009ada000a09c00bcbeffffffffffffffffffffffffffffffb00000000000000da9f0fbdbdb9fbf9fbfdb9f9f9db9f9f9fbf99f9fbfb9fbfdfb9fb9ff9fbdfffdfffffffbd00000000fedbfffffffbde900090900000000c0000000009000009e0000909c9c00b0cbcffffffffffffffffffffffffffffffffd9000000000009ada9dbdbdbffbdbf9f9bff9fbfb9f9f9bdbdbf9f9f9df9f9fbdfbdff9ffdbf9ffffffffcf00000000d0fffffffffffa9ac9ac0a009e9a900a900000000000900900000e0a09a00cbcbefffffffffffffffffffffffffffffffb00900b000000009c9adb9e99e9fdbf9fdb9f9f9fdbf9fdbdbdbdbdbfbdfbf9fbdfbf9f9bfdff9fdadffffb90000000acfbeffffffbfdf9a00900d000000a900000000000000a000b0009000c0d0b0acfffffffffffffffffffffffffffffffffb00e000000000000bc90f9ff9dbbd9fbbdfbf9f9b9fb9bdb9f9fbf9dbfbd9f9fbdf9fbfdbf9fffffff0f9000000000cfbcfffffffffbac9c9a00a0a900c00000000090090009000c0bc00d0b00a0cdffffffffffffffffffffffffffffffffff90000c900000090900bc90b99fbdfbf9db9f9bdbdf9dbdbdf9fbd9fbf9dbfbfbdb9f9fdbf9ffe9f9f0f9090000000adadefffffffbf0db0a0c09090c00b000090000000000000a90000b0a00a9c9eafefffffffffffffffffffffffffffffffff0090000000000000909ad9cb9cb9d9fbdbdbdbdb9fbdbdb9bfdbfbddbf9fdbdbfebfdbd9e9f9f0f090000000000c9ef9fffffffffffac90090ac000b0009a00000000000000900a900090d0c0a09cfffffffffffffffffffffffffffffffffff90c000000000000000090a9cb9fbad9fbdadbadbf0f9f9ff99bc9fbbdbf9adf9bd9dbebf9e9f0f0f090000000000cbeefffffffff9f9bcb0a090a900c0a000000000090009ac000c00c00a090d0ebeffffffffffffffffffffffffffffffffffb0009009000000000900090b0d09db099b9bd9bd9f9f9f99ffdbf9cfbd9fdbbfdbfb9d90f09cb090000000000000fc9fffffffffffbe900c900000a90900090000000000000009000b0a090ca00fcffffffffffffffffffffffffffffffffffff9000ca0000000000009009090bdb0bcbc9d0bd0bdb9f0bfb09b90b990b09ad09ad0da0f09ca0000000000000ccefbfefffffffff9e90e900ca0d0000a000000009000000009000b0009c0a90da9effffffffffffffffffffffffffffffffffffb0000c0000000000000000000000909090ad00bda9e9f009dbc0f9cbc9cbdb0f00b0900000909000000000000bfbcffffffffffffbe90a0b0900bc090c9a0000000000000000a0000c009c0a0c0feffffffffffffffffffffffffffffffffffff9000900900000000000000900900900a909a90090909f0b00b90b009a000900900009009000000000000000cefdefffffffffffedbe9c00000000a000000900000090009a009c009a0a0090cbeffffffffffbffffffffffffffffffffffffffff90000000000000000900000900000900009090000000900900000900900000009000000000000000000000fb0ffffffffffffbfbc9a090acb009000a000000000000000000009ac090da0e9edffffffffffffffffffffffffffffffffffffffb000c00000000000000009000009090009000000900090090009090090090090000000000000000000009cebcffffffffffffffde9a90ac9000a0c090900000000000000009a000000000900feffffffffffbfbfffffffffffffffffffffffffff009a00000000000000000000000009009009000090000000000000000000000000000000000000000e0ffffefffffffffffffbbf0c9000009009a00000000000000000900000900f0acada9fffffffffffffffffffffffffffffffffffffffff9a0c0000000000000000009009000000000000000000000000000000000000000000000000000000c0f09cffffffffffffffffd0b0a09a0ac0a000a090090000090000a00c9a009009000ceffffffffffffffffffffffffffffffffffffffffff900900000000000000000000009000000000000000000000000000000000000000000000000000000cefefffffffffffffff9ebc9c0c09009000d0000000000000000009000c0a00c0bcbffffffffffffffffffffffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000acfffffffffffffffffffffebd0a9000000009a0000000000000000090a000090c0b000cffffffffffffffffffffffffffffffffffffffffffffbc00000000000000000000000000000000000000000000000000000000000000000000000000cfffffffffffffffffffffbdba90a9a00b0ac0000a90000000900000000009a009000cb0fffffffffffffffffffffffffffffffffffffffffffffbdac9000000000000000000000000000000000000000000000000000000000000000000000cffffffffffffffffffffffffdad0c009c00900009000000000000000009000000ac90b0cffffffffffffffffffffffffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000cffffffffffffffffffffffffbaf0b009a00000b0000000000000000090000000c900a0c0feffffffffffffffffffffffffffffffffffffffffffffff9000000000000000000000000000000000000000000000000000000000000000000000fffffffffffffffffffffffffbcd9000000090e000c00900000000000000000e09a00900bcbfffffffffffffffffffffffffffffffffffffffffffffffe9a000000000000000000000000000000000000000000000000000000000000000000effffffffffffffffffffffffffbae9a9e000a009009a0000000000900000b0090000a0c000cfffffffffffffffffffffffffffffffffffffffffffffffbcd00000000000000000000000000000000000000000000000000000000000000000cffffffffffffffffffffffffffffdb0c0090c09000a0000a000009000000000000009c0a90e9efffffffffffffffffffffffffffffffffffffffffffffffba0b00000000000000000000000000000000000000000000000000000000000000fffffffffffffffffffffffffffff9ad0b00a0900e000090090000000000009000009000900c9effffffffffffffffffffffffffffffffffffffffffffffff0d9c000000000000000000000000000000000000000000000000000000000000cfffffffffffffffffffffffffffffbeda900000000090000000000000000000000900a000a90a0bfffffffffffffffffffffffffffffffffffffffffffffffff0a9e090000000000000000000000000000000000000000000000000000000effffffffffffffffffffffffffffffbdb9ca09c900b000ad0a00000000009000000a0000c9000c9c0ffffffffffffffffffffffffffffffffffffffffffffffffbf0090c00000000000000000000000000000000000000000000000000000efffffffffffffffffffffffffffffffffefb90ca00ac0000000000900000000000090000900a0c0a00feffffffffffffffffffffffffffffffffffffffffffffffff9e90a9a09000000000000000000000000000000000000000000000000cffffffffffffffffffffeffffffffffffffbdada9000000090000900000000000000000000009009000fcfffffffffffffffffffffffffffffffffffffffffffffffffa9cad00d00a90000000000000000000000000000000000000000000cfffffffffffffffffffffffbeffffffffffbfdad000090090ac0900000000000000000000090a0000a09e0bffffffffffffffffffffffffffffffffffffffffffffffffbda9009a0a900d0e000000000000c00000000000000000000000000ffffffffffffffffffffffffffffffffffffffbfb0b9000e0000000a0000000000000000009000000d00000d0ffffffffffffffffffffffffffffffffffffffffffffffffbf9e9e0d0c0f0a9009c90000c90ca000c0000000000000000c00deffffffffffffffffffffffffffffffffffffffff0fc0e9a00000900000900000000090000900000900a00c0a0efffffffffffffffffffffffffffffffffffffffffffffffffda900b0b9a0d0e0f0a0cbcbada90c90000cbc9000000000cbfdafffffffffffffffffffffffffffbffffffffffffffb9b0000900000900000000000000000000000000000909c9ffffffffffffffffffffffffffffffffffffffffffffffffffa9cad0c0c0f0b090b0dbe9fda9bcbeffffffffffffffffffffbfffffffffffffffffffffffffffcffffffffffbffb0dac09000a000a0000000000000000000000090009000a00e0ffffffffffffffffffffffffffffffffffffffffffffffffbda09a9a9a900c9e0c9a0dab0bc0f9fffffffffffffffffffffeffffffffffffffffffffffffffbfffffffffffffbffb09000000900000900000000000000000090000000000009e9ffffffffffffffffffffffffffffffffffffffffffffffff9dbc00c0dada9a9a90da0debdb9a9cfffffffffffffffffffffffffffffffffffffffffffffffffbeffffffffffdbde9e9a090000090000000000000000000000000000090000c0fffffffffffffffffffffffffffffffffffffffffffffffffba09ada9a009c0c90e09eb9e9e9defffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffffbfeb9a900000000000000000000000000000000000000000090bfffffffffffffffffffffffffffffffffffffffffffffffffbc09e0090c0f0a0b0e90f0dedbf9ebffffffffffffffffffffffdffffffffffffffffffffffffff0ffbfffffbffefb9e900000000000000000000000000000000000090000000c0cbffffffffffffffffffffffffffffffffffffffffffffffff9f0090e9a909c9c900f0ffbffffffffffffffffffffffffffffbefffffffffffffffffffffffffffffffbfff9fbdbc9e09000090000900000000000000000000000000000000a9acbfffffffffffffffffffffffffffffffffffffffffffffffa9e0e900daca9a0ada9e0ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbcfffff9ffffbfb09a009000000000000000000000000000000000000090000dffffffffffffffffffffffffffffffffffffffffffffffffbd09090e9a909c9c900cffffffffffffffffffffffffffffffbff9fffffffffffffffffffffffffbffffbdffebf9e9e9e9000000000000000000000000000000000000000000000fafffffffffffffffffffffffffffffffffffffffffffffffdada0e090c00e0a0adaf0fffffffffffffffffffffffffffffff0feffbefffffffffffffffffffbfcfbfffbfbdffbf9a900009900000000000000000000000000000000000000dadffffffffffffffffffffffffffffffffffffffffffffffffb90909acb0b0909c909cffffffffffffffffffffffffffffff9e90dadfbfffffffffffffffffffdfbcf0fbedfbe9e9ad00000000000000000000000000000000000000000000000adfbffffffffffffffffffffffffffffffffffffffffffffffe9e0c900c0daca9e0a9effffffffffffffffffffffffffffffbeb0dadf0fbffffffffffffffffebfbfffdbbedbf9f9a9090000000000000000000000000000000000000000000adafffffffffffffffffffffffffffffffffffffffffffffffb0b09a0ada9a090009c0ffffffffffffffffffffffffffffffffd9ca9a0f0debeffffffffffffbfdfcbfbffdbbdbe9ad0a00000000000000000000000000000000000000000000d0ffffffffffffffffffffffffffffffffffffffffffffffffbd00e90d0000d0e0bcaf0fffffffffffffffffffffffffffffbda0a90cbcbebdfffffffffffffffbebfdfadbfcbe9bda0900000000000000000000000000000000000000000000adadbffffffbfffffffffffffffffffffffffffffffffffffda9e900a0a9e9a90d090dffffffffffffffffffffffffffffffff9f9cb009009e9adbfffffffff9edbdaf9fadbbf9e90900000000000000000000000000000000000000000000000bcbdbdebffffbffffffffffffffffffffffffffffffffffbff09a9c09c000ca0aca0acdafffffffffffffffffffffffffffffa9e90da0bc9acbedbebfbffdffbf0f9afdbfcbcb9e9a90900000000000000000000000000000000000000000090c0bcbfbdbf9fffbffdffffffffffffffffffffffbfffffbdb0f0c0a9a0bcb09c909c9abfffffffffffffffffffffffffffef9fda9e09c000c909adbdefebfbcf0f0fd9ad0bdb9e9ad000000000000000000000000000000000000000000000009adaf0dad0bcb0f9ebf9fbedfbfffffbffbffffffffbfbfebc90b09c0d000c0a00e9acdedbfffbfafebfffefffbfffffbfdbeda9e99a90b09adadade9fbdfcb0b90f0af0bf0bcb090a0000000000000000000000000000000000000000000000000909a09ada9e9e9e0fadbdadad0f0f0f0f9cbc9e9cbc9090a00e0b0a0f0b0da90009a9ac9e9cbd99e9adb0f0f0f0b0f0bcb0f09a0c000c000000a9a0dab09c0e90bd9ad0fcbc9e90900000000000000000000000000000000000000000000000000090000000000900000a009a09a09ad0a09a00b00bcb0c9c90c09c90c0900cbca0d09a09a00acb0f0acb0f0f0f0f0f0bcb0f0d0b0d0b0d0bc90c9e9c0f0b090e0ad0b0b09b090000000000000000000000000000000000000000000000000000000009009000900900900900000900000900900000000b0a0a9a0a0a9a0ada0090a0009009000000090000000000000000000a000a000a000a09a00a900000a9090bcbcbc0f0a9000000000000000000000000000000000000000000000000000000000000000000000000009000000900000000900bc009c90c90c90c090009c0090000000900090009009009009009009009009009009009000009009009000e0c09a90b0090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009e0acb0e9aca9e0e9e0a90000000000000000000000000000000000000000000000000009000000000090b0bc9e9cb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090009009000900090000000000000000000000000000000000000000000000000000000000000000000090b09a9090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbdfadfbcfbdebdfadfbcfbdfbedbf00000000000000000000010500000000000076ad05fe, N'Steven Buchanan graduated from St. Andrews University, Scotland, with a BSC degree in 1976.  Upon joining the company as a sales representative in 1992, he spent 6 months in an orientation program at the Seattle office and then returned to his permanent post in London.  He was promoted to sales manager in March 1993.  Mr. Buchanan has completed the courses "Successful Telemarketing" and "International Sales Management."  He is fluent in French.', 2, N'http://accweb/emmployees/buchanan.bmp', 'Buchanan@northwind.com', '234345439' ), 
( N'Suyama', N'Michael', N'Sales Representative', N'Mr.', N'1963-07-02T00:00:00', N'1993-10-17T00:00:00', N'Coventry House
Miner Rd.', N'London', NULL, N'EC2 7JR', N'UK', N'(71) 555-7773', N'428', 0x151c2f00020000000d000e0014002100ffffffff4269746d617020496d616765005061696e742e506963747572650001050000020000000700000050427275736800000000000000000020540000424d16540000000000007600000028000000c0000000df0000000100040000000000a0530000ce0e0000d80e0000000000000000000000000000000080000080000000808000800000008000800080800000c0c0c000808080000000ff0000ff000000ffff00ff000000ff00ff00ffff0000ffffff00ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffcf9a9fbcbffd0000000000000c0bcf9bdf0ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0fcf0efde9a00000000000000bcb0fca0fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0a9a9f9ebfc0000000000000ad0bcf0bdffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0dacbe9f0a000000000000090bcb0bcbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffb0f0da0fd000000000000000adade90fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc909a9f0a000000000000000000b0ebffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00a0c0000000000000000000bcbc9fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0da9e9000000000000000000009bffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000000000000000b00fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff900b0000000000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0000000000000000000000009fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000000000000000bffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00000000000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000000000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe00000000000000000000bfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00000000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000000000000000009ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00bffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc00000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0009ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000000000000000bfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000009ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000befffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000bfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000009affffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000a0009ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000000000000a0bffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000bf9ed0bffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000000000000900a0a9fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff090ffbfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000b0e909000bffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000009a0a00000bffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff90090f0dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000000000000a0bc0900b0000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdbc009090000bffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000090a9a0a00000009fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe909a0da9b0900dbfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000000000000009a090000009000fffffffffffffffffffffffffffffffffffffffffffffffffffffffff090b09909009a90bcfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0a0000000000000be9a000000009a9dfffffffffffffffffffffffffffffffffffffffffffffffffffffd09a09090a9090909009ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0f0090000000000a009e9e000000000aa90ffffffffffffffffffffffffffffffffffffffffffffffffff00909d09a9909a090090009ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffda0f0a000b000000090a09a9a9000000009af0bfffffffffffffffffffffffffffffffffffffffffffffff09a9a09a900090900b00b0009ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe000f009a0000000000000acb0a00a00009ad0a00ffffffffffffffffffffffffffffffffffffffffffffc0b0d09900909a00009009090900bffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000900f00a000000000000090b0e9e900009a0ba90b0acfffffffffffffffffffffffffffffffffffffffe9090909b0090b00900b0090900a000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc0a9a0a0f0000000000000000a009a9a0a000009f0bc090900fffffffffffffffffffffffffffffffffffff90b090b000b0009009009000a09909009ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffcb0b000000f09a000000000000000000090cb000a0adaba0a00009ffffffffffffffffffffffffffffffffffa0909a90990090000000009a09000909009bffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0b0a0fa9a90f0a0900000000a90000a00a00b0000090a0c9ada9a000bfffffffffffffffffffffffffffffff0909f0909a0090a909a090000900b000a9000fbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0a090f0b00e00af090e0000000000a00000000b0000000a909a0000000a9c9ffffffffffffffffffffffffffff0909a090b0d0b0090900900b0900900b9900b09fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0a90bcaa9e9a09a0f00b0b0a900000000090000000a00000000a0b0b000bcbaa90fffffffffffffffffffffffff009f099a909a90bc00a09a90c9a9ac90000090900bfffffffffffffffffffffffffffffffffffffffffffffffffffffffffa090ac0b0da0ada000f0a0daf9ebcb00000000000000900000000090e09a0090da00009fffffffffffffffffffff09b09b099e909ac09a900000b000909a9c90b09cb090fffffffffffffffffffffffffffffffffffffffffffffffffffffe90da009a00a00f0a9af0f000a90f0b00000000a00000000a0000000b0a9a0000aba900900fbffffffffffffffffff09b09b09ad09e09000000b00900b0a9a90b0909a909090ffffffffffffffffffffffffffffffffffffffffffffffffff0a9a0a000a0dadab0adac0af0009afaf0a00000000000000a09000009a00f00a00b0d00a00a9b0ffffffffffffffffff0b0db0da9b0b0900b009000900900d09ca9a900090b0da9fffffffffffffffffffffffffffffffffffffffffffffff00a90cb090090a00000f0a0b0f00000090f0a00000000a00009a00000000bb0b00900a0bc00000f0b00bfffffffffffff0999a99a9dad00a90090a090a00a09a0b090da9b9a90b90909fffffffffffffffffffffffffffffffffffffffffff009a9ebbf00000adabada00b00af00a09a00009a0000a900900000b00000a00dacb00009a0b0a09a0f0b0000ffffffffffe9be99af9a909a90090a09000900900900b0b09e099090b0b90bffffffffffffffffffffffffffffffffffffffff00a000b0f0ffa00a000c0a9a0cad0f0900000b00000000000000000bca9a009afa900000000ba90900ba000000bfffffffff9bc90bd9ada9a900b009000b000900900909c9a9bca9f09909b09ffffffffffffffffffffffffffffffffffffe00a9000a9fbfff0009ca9abc0cba9a0f0a0000000b0090a000a00a00b0a90090a9090a00a000b9e9a00e900000b0f0fffffffa9f9bbf0b09090da900900090009a09a9ada90b090b9b099a9f09bdfffffffffffffffffffffffffffffffffc00000000adfffff00000a90e00ab0000af00000000000a00090009000000bca0a00a0a000900fada9e0a090a9000090bfffffffdb0bc90bcb9e9a909b90b0b0909009009090b00b0f09e9ad909b0909ffffffffffffffffffffffffffffff000a90000009affffff00000a000b00a9eb0f0000000000000000a00000000b0b9000b09000a0a90bada909a0bca00000b0bffffffbf9fbad9b0b909a9c0b0909a09a9cb9a90b09b0d90b09b9a9b09b9b90fffffffffffffffffffffffffd0000a000000a0009bfffff000a9ca9a0f0e00caf00b0000000000000000a000000bca00900a000909ebdba9a0009a09000a000ffffff9f9a90db0f09a9f9ab99a9b0d9a90b09d0b09ad9a0bc9adadbc9ad09a9bdfffffffffffffffffffff000a0090000a090000affffff00090a90ca009aba9f0000000a000000a0000000000bda9000ab0b00a0a90a0000000a09a00000b0bfffffbcbf9fb0b09f9a9ad99e9f090b0db09a0b0fa99a9b90b9099a9b99be999afffffffffffffffffff0000090000900000000bdfffff0000ac0a0a90a0e0c0f00a9a0000900000009a0900000a00a0b000000000a9000000a90f0000000009ffff9fb90b09f99b09db9beb99adbb09b09bdb9999da90da99eb0f9f0b099b0f90fffffffffffffffff0000a000a000a00000000bfffffe0000b0cb00e9a90baf09009a090a00a09a000a0a000b0b0000bfa9a0b090009a00000a0bca090a000ffffe9ebd0b09ad0ba9ad99eb9b90db09f09a9afa9a9b9a9e090b0b9f0f099b9b9bfffffffffffffffe0009000000a0090a00a000bfffffa0000b00f0000a000f000a0a9ae90b00009a0900000000000b0a9a9a00a0a000009009fa900000009ffff9b99abdb09a99db9a9a99e9ab0bda9bbdbd99bbd0b909b9f090a9b9b9e9ada99ffffffffffffff000a000a00900000000090ffffff9009a00a00ab0e09e0f0a09090a90a009a000000009000000b0f9b0f00f0900000000faa90a9a09000fffcb0fad900f99b0a909099a99d9990b9d0bb0bbc90bda9b090b9f9bdada90b9b9ebffffffffffff0a900000900000a00000000bfffffe0000cad0bc0090a00f0000a0ad0b0b0a0fa00a0000a00a000b0beb0bb0ca000000a9ad9a00000a000bffbdb990b9b0a9c9909a9b0d0b0ada9da9bc9bc9b0b00900f0bc9a90b9b9b9dbdbbdbfffffffffff000a09a0000a0000090a00adfffff9000a90a0a0fa0a0a0f09a09a9ab0a09a90b0900a000b009000b0b0bcbb0000000000baf0f0b0000a00f0b0fb0bc0999a9a9e090d0b099099a99a9b90b09f9b9b99099b09f90f0bcb09ad9b9bffffffffffc0000000a00000000a00009abfffff00000b009000f0c90f0a0000000f0badabcbaf000f9ada00a009a9ab0fa00000a00bdf090000b0900b9f9f90f9b9a9e9b0999a909090a9009099090b99a909e9a9b0b0b09af09f9f9b9bbcbdbffffffff00a90a00900090000000090adfffffe0000e0a0e0b00a0a0fa9cb00b0b09a90bcb9e909b9ada9a090bab0f0f090000090beba00a09a00a0b0f9a9ab9090da9909b0a90b009090099a9e99b09e9a9b90db09db9db999bb0b0bcbdb9b0fffffffc9a00e90a000a00a0b000a000bfffff0000b00c09a0ca900af9ab0b00b0badaf0b0f0faacafb0a90a0090b0b9a090a000adbc9a09a009a9bdb0f9f9cb0a9a9b0bd09990909a009a00909b0db99b9c9a9b09a900b0f0bc9dbd9b9b9fbdbffffff0a9a90a0000000000000900a9fffffff0000a0b0a00a00e90f09adada0c90b0bb00a9090b9adbdabcb0ab0b0a9e0009a00a9a00000b0000ebdb9a9b9990909090b9ada909090009090909b09a90b9b0909a9b99b99b0b0b0be9e9f0bb9bfffffac0ca09e9a000000000a000000ffffda0000d00acb09a00a0f00a9a009a0adbc00000a0000f0a000b0a90b0ada9abda0090009000000a0f9fbcbdb0be9bcb0f9b9099090a00090000a90909bd9bda9db0f90da90fa9f9bdb99bb9bbdf0fffff00b0b0f000000000b000000000bffffff000a0a0090e009a00f009009a0009a00b0a9000a0b0a90bb09b0a0090b0bda0d0a00a0a00b0090b0b0b9a9f99009099ad0b9a9a909090009090b09b09a9a99a099a9a9db999b0b09ebc9dbdbb9bfffe0f0a0a0a00009000000000000bffffff0009009cb0a000a09ef000a00000000b00000a09000000a0cba00900a00bfadba00009e9b00a0a9fbdbdbdb0b0b9a9a999b9c9090909a909a0090b0db99b9b099a90999a90be9dbdb99bab0b9fadfff000ad0d090a000a0000b0009a00ffffffa000e0a00e00b0c0a0f0000000900b00a0b0f9a00000000b00dba0b000009be9f0b0b09ebf0900b9cb9a9a9bd90909dab0dbb9bdb9f9db99d9b090b09e9cbdb0f0bda9a9b999ba9a9e9d9f9fb99bffdb0b0a0a000000000000000a00009ffffdf0000b0a90b0ca9a9af0000000000000090fbada00a00000bba09a00000a0f9a0a000bfbdfa00bdbb9f9f9f0b0f0b0b9db909adb9e9b09f0b999b99b99b99a9b990909d90f0b09bdb9a9a9a9bebfffe00cbcb00a0900000a0000000009afffffa00000c0aaca0000c0f0009a00a0000090bbadb0b000009ad009a0000b0db0000900bffffada9f0f0da9b9a99909c990b9adbdb9f9bdbf9b9e9f9cb90b09a9909a9a99a9b9bd9f9a909bdbdbdb9fff00ab0a0000000a00900a0000000afffffe0000b0a9e90090a0baf000000000b000a0adbefbc0900a00bafa900000a00a00000bdbfffda9a9b9bb9bcbdaba909a9f0b9b99bdb9f9f9f9f9b0b9c9bdb9da9f09090b9ada9a9a99bdb09a9a9fbff09ad0e90f0bca900000009a000009bfffffd0000d0a00a0ac9ac0f000000900000000b0bb9aba0000000900a0b0009a09000000adbffffdbda9cbdb9b99d00b09099c90f9f0f9b999bdbdbdbb9b0b0bb9a9b0b0f099b9f9b9f0b09f09f9b9bffac0a9ae00a0bcaca0a0b00000a00adfffffa0000a9cb09a00a0b0f0000000000000900b0daf09a0090b0a0900000b0000000000bffffbfa9b9b9b0bdabb0b909a0b0b9f9b09990090099bdb9d9f99f909d909c909b0b9b9e90bd9b09b09e9ff090b0e909adbca9090000cb0a09000bfffffd00a00aa00e09a0000f000a900a0000000b0bab9fa000000000a000000000000000bdffffef9f0f0f0bda9d090000090909090990bc9a090009bdbb09b0b9b0a9a9a9b0f9e90b9b90b09b0db9be0aca0e9a0e0a0a90a00000a0000000beffffa00009e90cb00e00fabf0000000009000a90a90fb0fb000000900000b000000a00000bffffbda9b9b9b9b99a9a900900000090c0a90b990f0b9090d9f9d90d0990909a9b9b9fb99c9b9bc9b0bcb90009a9e0b09ad0a0ca09a0900b00a09ffffff0000a00ba00b09a000f000000000a00000b0a90fbf0fa000a0000000a9a0000900000dbffdbda9e9adb0fb90da9a000000009b90f90e9a9bcb909099a9a9b0a90b099cb9a99beb9a9c9b0999bcb0b00ca9e0ac0a9c9000000a00000000bffffff0009a0ca9e0ae0be0f0090a0900000090a9a0bbcbf00900000000b0000090000000bfffffb9bdb9db0b909a909090000000000b00b909099be90b00909009000090a99f9bad99f9b9b09f0b0b9a0cb0bcb0d0b00a0a0000000000000adfffff0000acb09a0b09a00bf000000009000a0a9090bcbf0b00000000b000900000000009fffff09e9a9ab0bd0b0909000090b09a909099000090bc90b09000009009090b99b09f99bba90b0db090b9c09a0bcbe9aa0da0909a000000000009fffffe0000090eacb0ca0da0f000000a00009009a0a90b0b00a0a090000090a000a000000a9fffffb9bdbd990b9da9a9a9a9090bc90909009099a90b009000000000000a909adbb0bb0d99f9b099b9c9b0a9adadaf9cbada0e09a0000a00000affffff000b0ab09ac0a90a0af000009000a0009a9b0a000da900900a0000a0000000000009ebfff9e9a90b0f90b0909c9090b099b9a9a990b909009090a909090000000909a990f90fba9a909b0bcb9a9b0cbafbcafbcbada9ac009009000009bffffff0000c0a09a90a0090f000b0000900a000a09a9a9a9acb0ad00b0f0900090000a0009fffdb9bdbb9b90b9b09a9a90b09f0b9d990bc90f09909099900b00a0009009e90b99bb999bdbbd09b99a9c9a90dadbdacbfcb0fa9a00a00000000ffffff00000b0ca000e0bca0f00000a90a0090a9b9e9c9e09090c90bc0900a00000090000bfffba9f0b0d090bd090b0999a90b09e9bb0b9b9b99b09a9f9a9b909000b00b090f9abc99af0b090b9f9ad9badaebfebebf9eb0f0c0000000a00b0fbffff00009a00b0f0a900a00f0a0090a009a009a0a90a90b0f0a9a009a0bc090a0a00090a9bfffdb9bd9b9f90b0bc9b0f09e90b99ad9f9e9f9fbdbbdb0b9d009009009090b90b99b0f99b99bbdb0b9b099adbcbfdbcfedfe9ab000a9a090000bffffff00000f00a000a0b09af009a00900000a0909a90a900090090b0900b00090900a0900afffbda9b09a9a99b9b0990b09bd0a99a9b99b0b9a9db9bdba9b0a900900b090b99e99b0b09ad09a9bdb0b0f9abfcbefbfbfadad0f000000a00000fffffff000a0bc0ada000e00f0000000a909a90aba0009009a0000000a0b00a0000a090a0bdfff9a9f0fb999f0909b9a99b090bd0bdb0da9d00dba9e909d0099cb0a9a9da90da9ba99f9bdbbd9bcb0f9b09fdebffbcfdedadaa0000000000a09bfffff000a000a90a09eb00af00009a090a090a9009a000a000009a0b09009090a0090a909fbf0b9f9b90dab09b9a9e9cbc9ab90b0909a90a99b0d99b9b0b9b0b099909a909a990d9a9a9a990b0b9b9bc9bfebff0ffbebaf0f09a00a0000900ffffff000090fa90a90a000b0f00b00cb0b0b0ada0b0900900900a099c000000a0090a0000beffbdb0b0b9b999bc999b9b9bbd0f90b0b90909a009b0b0bcb90c9090f0b909b99a9b0b9b9f9a9bdb9bda99b0bffffffeffdf0b0e000009a00000bffffff0000a000e00e0b0e00fb000b0bcf9adb0b00a0a009a00900a9b0b00b009000090009bdf9a9f9f9f0bda9b0f090bc99b9a9f99cb0b0090b09b0d090b9b0b0b0b0f90da99a990f090bda9a9f0bdabcb0dbefff9faf0f0b9a09000000a000bfffffa0009a0b0b0900b0b0f09a909fbbcb00b09b09090a90b00900000000000a000a000a9fabdb9a9a9b9a9f9b9b9f9bbebdb9a9a909c0b0c90f09b0b9cb0bdbd99f9a9a9bc99a99bbb90b99b9b9b99b9bafdbebfedbe9acac00a00000000bdfffff000a0ad0a0a0ac000af9f09ebe9da90b00a000b0a90b00b0a90b00b00b0009000a99fb9db0bdbdb0db990b09a90bd99abc90d00b09090b090b0bd0b9f99a9ba909b99099e99a9c90b9dabcbcbcb0dadfbedfe9be0bcb09a00000a9000ffffff00000d00ac09a9aada9fa9a0b9bfa90b0f09a90009ad090009000000000000a09000fbcbb9f9b0b9bbdafb99f99b0bfbd9b9a9a900b00900b0d909f9f9ebda9db9b0da9b09ad99b9f90b99b9b9b99b0b0ffbcbfe9f0ada0000900000b0bffffff0000a0b0b0e0090a00fbe9b0f9ada00b0b00a09009a9a9000b09a90b00b0000a00b9fbda9adb9f0db999bfa9a9c990bbd0900909009a90909a9b0bb0b9b9fa90b09a909b99a9a9a9bb0f0bdba9f0bd0f0ffbcbdada9ada00a0a00a0000ffffffb0009ac00b0a0e09a0f0900f0bcb09e0000b00a00909009a900000a000009090090bf9b9f9b9f9bb9fbad99b99b9a9900b0090a090900a09a90db9dbdbdb99bbd9b99bd0b09bd9b90db9b9b0f9a9b0bafbcfbfafa9e9a090000900000bfffffe000a00b0a009a90ac0f0b0b0b0909a090b000000b0da090090b0b0909a9a0a0a00bf9b9fb9be9bf9fad9babd0b009d0b900000900a009090090b9fab9aba9bc90b09a90bdb9a9ad0bb0b9e9f99f9e9adbcfaf0f09e9ad0a00000a09a0bfffff900000f0ad00e00a0baf00000000a090a00b009000b09a0b0a900000a000000909adbbcbb0f99bf0bb9bf9d9bd99b9a9909000009909000090090099dbd9d099bb9bd99b99ad9b99bd9bdb9b9ab0b9b9affbdaf9eb0e9a000a9a00000bdfffffe0009a00a0ab00ad000f0090009000a0900000a0009ad9909da909a09a9a0b00a09bdb9f9fbfbdbdbdbdbbb0b9a90990bdb09000a0909a900000900b09b0b9a909d0b0bda99b0dba9a9a9bcb9dbda9e9dafcbdaf0f9adada900009a000abfffff900a0f09000a90a0b0f00a090a09090a000000090a90a0b0a90a0090000900b00befbf9b9b9fbfbfbfb0f9f9a9f9a0b9a99a9f999a990000a99bdb09a09099b9b0b9b9a9be9bb9db9f9b0b9ab9b9f9b0b9bfaf0f0ada9a00a00a0000adfffffe000000a0eb0da09ac0f0900000000000000a09a0a90b09009a009a0a09a00b009f9b09bfbcfbdb9f9f9f9b9bdb90999f9fa9b90bc90b09a990b09099099b0f9e9b9f9f9fb99bd0bb0b9e9bdbda9f0b0bd0f0bda9adabca0b09a90a9a9bfffff9000bca9a900a00a00af0009009000a09009000909a09a00b009a0909a09b009a9bbdbf09fb9fbffbfbfbf9eb90b9b0bfb99d0b9b9b99f99bdbd9b90a9bc9b99b0f9b90b9dbe9bf9dbdb9b9a9b9b9b9f9bb9bcbada9e9ad00a00000000ffffffe000090e00ea90f00b0f00a00000b09000a00b0a9ada09a00b009a00a9a00b000b0db9bfb9fbbdb9f9f9f9f9fb9f0d909ffab9bc9b0fa9b0b0bbf0bd909b09a9b9b9ebdbab9bf9bb99a9bdb9f0f9e9a9bdbf9bc9acb0f9abc9a00a00000ffffff0000a90b090e00bc0af0900900a0000a09000090b09a09a90b0a09b009a90b0bdb9af9b9fbdfbffbfbfbfbb9fb9b9a9fb9f9fdbbdb99f9f9fbdbf9a9909bdbdbdbf9bb9f9fb9e9fabdbcb9fb9b0b9f9fadbbdbe9a0f0ad00a09009a09bfffffb000a00a0ea090a0a90f00090a9090a9090a90b0b09a09ad0b0b09a00ba9a0009b0bf9b9fbdb9bf9f9f9f9bdf09f0b99bdf9ffbbdbfbfbfbfbdfb9909a9b9b9b0bb9fbdf9fb9f9bbd9bb9b0b09f9bda9b9b9f9a9adb0ada0a000a0000affffffc0009cbcb009aacb00af0b0a9909a900000000090a09a09ab0b09a09b0d00b0bf9f9bdaf9fbbfdbfbfbfbffbbfbbdbcb9bbfbbdfbf9f9f9f9fb9ff0b99bdbcbf9f9f9fbbbdbfbdbdbbc9f9f9fb0b0b9f9f9f9fbda0e9fa90090000a090ffffffb000a0a00b0e09a0ad0f9099ebb09a9b9a90090a9da09a090b0b09a00a0b00909b9fbbdbb9f9bf9fbdbdb9bfdbdbb9b9e9ffdfbf9fbffbffb9fb9090bda9bbdbbbfbfbdfbf9fbfbbdbb9ab9b9b9f9a9b90b9a9b0f9a09ead0a0a0900a09ffffff00009a9e0b0a09e0aaf0b9a9b0bf9000000a0a90a90a90a9cb0b09a90909a0bf0f9f9bdbebfb9fbdbfbfff9bfbdbf9f9b9bfbdbff9fbfbdff9db9b99b9f9fbdbdbdbdbbf9fbdbdfadbf9dbe9f9b9dbcbbbdbdbf0adaf09a00090a0900bfffffc000a0ca0bcada00b00f90b9b9bb0ba9b0909090a9b090a9ab09a9a900a0a09f99bb9ffbf99f9fbdbbdbdb9ffd9fadbbfbfdffbfdbffdfdbb9ab9e9dabfbfbdbfbfbffbdfbf9fbfb9b9b9bb9b0bcbab9bd09b9b9e90b0da0090a00000bffffffa0009cb0f0a9a9eb0cbfa9afbbcbb09000a000a0900a0909099a9a90b09090a9b9f0f9bdbbfbf9bf9fbfbff9bbfb9bbdbdbb9fdbffbfbfbf9fbdb9bbdf9b9fbf9f9fbdbf9ffbf9bdbdbdbe9f9f9b990f9bbbdaf9bcadaa900a00090a09ffffffd000a0a00bcaca0cba0f9090b9b90b0b0900b090a9090a0b0aa9a9a90b0b090bda9fbfbfdbf9fbdbf9a9b9bfdb9ff9fbcbdfbfbffbdffbf9fbdbfbdbb9ffbf9fbff9fbfbfb9fbfbbdba9b9b9a9b0bf9b09da99bcbb0bd0e900000a0000afffffe00009cbca9a90b009af0a9a90b0b0000a09000090b0a900b999a9e9b0b00a9f09fb9f9bbf9bbdbb0f9f9e9bb9fb9ff9bfbbdbfdbffbdbdbf9bf9fbdbfb9f9bf9fbfbdbdbdfbdbdfbdbf9f9f9f9f90bdb0b9fbdb9cacaf00000b00000b9fffffb0000a0a09e0ac0af00f09000a00000000000000a000900b90aa9b0ba9b0b9b9b9b9fbf9f9bfdbb9db9b099b0fb9fb9bf9bdbfbffbffffbf9bfdbbdbfbdbfbf9fbbdbfffbf9bf9bb9bf9b0bb9b9a9bdb099fb0b99ab9b00a0000000900ffffff0009ad00da0090a900ffa0900090000000900009009a00b00b99a9bb9eb9a0f90fbfbdbbfbdbbbdab9a9b9ad9a9ebdaf9fbfbdfbfdbf9bdbbdbbdfb0bdbdb9ffbdfbdb9bdbbdbbfdbf9bfbd9bcb9a9b9f0b9bd90f90e0f0090000000a9ffffffc00000b0a09e0b0e0a0f9a0a90000000900090a09b09a90b00a90b0ba90b9b0b909fbbfdbfbfcbbdb9f0db9a9999b9f9b9d0fbbdbfffffbdbfdbb9fbdbbbfb9fbbdbfffbbdfbdbbbdbf99bbe9b9f9e9a9f9fbbb90bdb0a00a000000000bfffffba000ac09a00ac09a90fa9900000b00a000a0090a00b00b0b09ab9bb9ba00bdb9bfbdf9bf9f9bf9b9a99b0990f0b0b9bdbbb9f9ffbf9b9fbf9bf9fb9b9f9bda9f9b9b9bdfbbdbdf9bf9ebd9bbda99b9fb9a99c99b9a0f0f000000b0009ffffffc000a9a9e09a90b00caf90a00b0b009000090b0b09b00b0009abdbe9a099b099cbf9fbbf9fbbd9f0f99b099a9090d9be9a99fbffbdfbffbf9af9eb9f9f0bcb9b9adbdafb9bdbbb9bf9bb9bfbd9b9be9b909009be9a9f0b00000b000a9affffff00090c0a09ac0a0e0b0fa09a00009a000b0a00b09a00b0a9a009a9badba00b09b9bfbfdbe9bdbbb9b0b09e909a90b099f9fb9f9bfbf9b9f9fb9b9f9ba9b9b9bcb9a9b9bdbfbdbdbf9bf9fb99ab9e99f9fb09b099f9a0f00a9a000a90a9ffffffa000a9e90e09ad0b000f9a0900b009a00000b00b0bba09000b0a9a9b00b0bd909f9f9bf9bfbbdadbdbdb90b0909090b0b90bdbff9fbffb9b9dbf9bd9b0d909b9bdb9f9fb9bdbfbdbfdbb9fbf9f9bb0bb09f099a99f9b0f0000b0b0eb0a9ffffdf0000a0a90aa0a00be0f0900a90b0009009000b0b0090a0b0009ada0b0090b09abfbff9f9909a9b0b0000909a90b09090b99bb9bfbdb9fadbb0b9a9ad9b0bd090b9ab9bdbfbbdbbf9bf9f9b9b9bdbdbc9b090009a90f0b0b0000adb0dbffffffa00009e9e0d09cbc00bf00a090a90b00a0000b0009a0a90000b0a9a90a9ab0909f9bf9ab9a090909009a900000000b09b9fad9ff9ffbf99bb9db0db90b0900b9f09bdafbdbfdbbfdbf9bbe9bfbcb0b99b090a999f9b0b0e00a0a9a0fafffffff000b0eb0b0a0ab0a0b0f9009a99e009090a00009a09000000000900a9000d9009bfdbfbdb9f000000000a00000090000d099ba9bfb9f9bf9dab0b9009090b9909bdb9b9bbdbbfdbbbdbf9bf909b9b0f00b00900b9bcbca9000900dbe90ffffffc00009ebcb0bc0a9ac0fa9000a909a00000000a09a00000000000b00a9a9ab09a0bf9bdb090b00000009000000000009a9a99f9f9ffbf9ba99d90b9a900000a909b0bdbcbbdbbbdfbbf9f9bfbfb9f9b9009009009b9a9e0a9000a00bebbfffffb000ad9eb0e0b0ca0b0f000a9ca9a09a900090000000000000000000000090909db9fff0fb9090000000000000000000990da9bbfb9b9bc9b0b0000009a90909a90f9bb9bdbfdfbbdbdbbfdb9b0f09f090009099f9a9e9a00a0000b000ffffffc0009ae0be9a0a90f0af00090a90090000000000000000000000000b000000000bbffb9b9909a900000000000000000b009b9bbdb9f0f09b0b9000090000000000b9b0dbfbf9bbbdbfbbf9b9f9f9bb000009090b09f0bc00000000009bfffffb000a0e9bc000f00a000f09a0000000a000000000000000000000a90000b0000009eb9f0fadb90b0909a00000000000909b090d9adb9b9b09d0090000b0000000900009a9909bf9fb9f9f9be9bb0b0db90090b0999a9e0b0b00000000a0ffffff00009a0a0a9a0ac9adaf0000a90a9009a00000000000000000000000b0000000099dbfb9bb0f90b0b090d99a90900900009a9a9b9ad09db0b90a000000000000000000000b090b9ebbfbf9bf9bdb9b09b9a90b0f990bdac000009a0009bffffff0000d0cb000900a000f0090000000000090000000000000000000a00000000000fb9bdbd0b9a999090b000900a09a090909990d099b0b09009090000000000000000009a99b9fb9f9bdbbdbbcb9a9fbc99f999b09b0a90a0000000000ffffff000a0a0a00e0a0a00a0f000090a00a00000000000000000000000090000000000bb9e9fa9bf09da09a909a90090900909a9ad0b9b9a0909009090090000000000000090099adbb9bfbdbbdbbdb9adb099b090fb099e0bcb0000000000bfffffe000900b00b00ca9cb09f000a000090000000000000000000000000000000000000dbbf99f09b0b9b0da90900b00009000909a9900099b09a9a9a9009090909a9a9a9909b0b90bcbdb9bdbbf9a9e90b9a90b9b9090b9e9ac90a0000000bfffffda000e00ac00b000a0a0f0a90009000090000000000000000000000000000000009ad9fa90b0db0d0b090b099090b00b0909090b9bda9090909090b00a9a9a9d09090cb09d0b9b9bbffbbcb9bdb9b90bdb090fb0090b0e9a00000000000bfffffd0000bc0b0a0b0b0c9af00000a00000000000000000000000000000000000000009bb090009a9b0b90b090a000909009a9b09b090909a90090009090909c90b9a9a9b09a9b9e9bc9b9adbdbf9ad0ad0909ad900999e9a9cb0000a0000bdfffffa00b00a90ad0e00a9a0f00009000a0000000000000000000000000000000000000be9f0000000000000000090b009a900909bc90b9b9c9a90a90b00909a9a900909909b9b0b9bdbbfbdbbbb09b0b990b9099b0909a9a9ea000b000a90ffffff000000f0acb0a09ada0ff090a0000900000000000000000000000000a000000000099b9f00000000000000000009a090b9cb09b9f909a909009090090b0909a9b0f0b9ad0bd9f0bf9bdb9dbdbe9900a90a9b00000b9ada09a000009000bffffff0000a09a9a0b0a0a0b0f00000090000a09000000000000000000000900000000000f9b0b000000000000000000090b90b99b09a9bd09b0b090a090a909a909a99990b9b99ab9f9be9bfba9b99a9a9009009900099e90fbc09a00a00b00bffffff0009acb0f9cbcb0f0bf000900a00009000000000000000000000000000000000009adbd00000000000000000000bd0b90bcb9b90b9b090d0b0900900909e990b0bf9e9ad99a9bf9fb9bdbda00000000000a099da00a00b0000900000bfffffe0009e0b0e0a0a00e0acf000009009000000000000000000000000900000000000009b9a9a000000000000000009090b9eb9b9d09f9bcb09a90900b00b0a909cb9f0909a909adbd9bbdadb9a90000000000009b0b00bcbf0a00000b00bdfffffb00000b0f9a9e90b0b0bf090a000000000000000000009000000000a00000000000000f9f9c000000000000900a0f9b0b99f9ab9a9a999f90b00b00900090b0b0b0b0b090b09b9abf9b9b9b900000000000000090000b00d009a000000bffffff000a9e00aca00ac0ac0f0a090a90a9a90a900000009000000000000000000000000009a9ab90900000000a009909ad9eb9ad9bdb9db0b0b90900000000000090090000000009f9f9e9bcbcb00000000000000000090afa0b0000000000fffffcb00009e9a90ad0a90b0f009000000000000000900000000000000000000000000000099f99ada9a9f0f0b99b0f9b9bb99f9bbda9b9a9f99e9a9000000000000000000000009a9b9bb9f9b90000000000000000009a0d09e000000b000bffffff0000a0a00a0ca00e00af00a0090090009000000000000000000000000000000000009a9a9e9b9f9f0b99bdafdb9ada9dba9bc9b9e9bdb0b909000000000000000000000009fbdbcbdbb090000000000000000000ac9abe0000000000bcfffffa0000090cbc0b09a00bcf0900000a009a090090a00000a900a009009000000000000009f9b9bda9e9bdaf9bf9a9fb9dbad9f9bbdb9f9b9f0b9f0990000000000000000909a9a9b9b9b0d9a000000000000000000009ad00b0000000000bffffff000b0e9a0a00a0cb00af00090a900a000a00000900000000090000a0000000000000009ada9bdbbf9bdbe9bf9f9fbbdbb9bf9badb9f0b9bda9ba9a900900900000000009dbdbcbf9f9a9000000000000000000000a0abc0b0000000000fffffdb00000a009ac0a00e90f00a000000909a900a00000900000900a00000000000000000a99b9b0b9dabfb9fbf9bfb0f9f9f0f9bdfbbcbbdbdb9f0db9f0b00000090000b9fab9b9b99a9a900000000000000000000009e9cb000000a0000bfffffe0000f00da009a00a00af0000a90a00a0000009000a0090b000090090000000000000090bc9e9f0bbdb9f9bdafb9f9fa9bf9bcbb9dbbdb0b9fb9bbcb9d09ada90009b9eb99e9f9be99000000000000000000000009a00b0e0000000009ffffffb000a000a0c0a0da90e0f090900909000909000a090000009a00000a00000000000000090b9909bd9bdabf9bf9dbfb9fbf9fbb9fbbf9bf9fb09fadbdabbf9b90fbdb0f99fb9b9e990000000000000000000000000ada9e09a000000000bfffffc00090e90a9a0a00a09af00a00a0000bca0a000000090a00009a0900000000000000009a90b0b09a90b9daf9bbbdbdb9b9f0f9b9cb9e9bbdbbf9bb9bdbd9fbfb9b0f9bfb0bdab9b0b000000000000000000000000000a9ac00000000000ffffffb000a00e00c90ac0a00f0009000a000090909000a000900000000000000000000000000000090b09f9fb9bf9f0b9abdbdbb9bdbb9f9bdba9f9bd9fbf9afbcbdaf9bbdb0f9b9f9e900000000000000000000000000bad0f0b000000000bfffffe000009a09a0a090b0caf090000900b0b0a00a0b0900a00a90000000000000000000000000000009b0b09bdb0b9fb9db0bb99e9adbbbdbb9f9bdbfa99bfbdbdbf9fbda9f9bcb9a900000000000000000000000000f0c0b0a00000000a9ffffff9000bca00a0000ca00b0f0a0a0a000000909000000b090000a0000a0000000000000000000000000099bf9adbdb9c9a9b09cb99b99c9a9db9fba9bdbfb9dbbbb9ba9bf9b9b99f90900000000000000000000000000b0b0e9000a000000bfffffe0000900bcaca9a0e00af00909009a9ada000900000000900000000000000000000000000000000000090b9b9a9a99909f9b0b09a9b99badb0dbf9b9bfbbdbd9f9db9bdbcbb0b9a00000000000000000000000000a0f0b0ac0000000000ffffff900a0ac000900090bc0f00000a90000009a0a09a9a9a0a0090009000000000000000000000000000009fbcb09090a0b090099f99b0bc99b9bb9b9fbc9dab9ab9bbbcbb9b9dbda90000000000000000000000000b0f00ad0b000000000ffffffe000009a0b0a0e0a000af00b0a90000b0b009090000c0909a00a00000000000000000000009a0000009a909000000090909bda90b0d9b9badbdb0fb9bbbb9fbdaf9dbbdadba9a9000000000000000000000000000f00bdaa000000000b9fffff9000bca00ca009ac00a9f0009000a900009a000a00a9a0a0000000000000000000000000000090900009b000000000000b09099bd9ab9ad9b0bdbbcbf9f9fb9bb9abf9b9b9db9000000000000000000000000000b0b00a9c0000000000ffffffe0000000b00da00b0bcaf900a9e000a9ac090b09090090da900000a00000000000000000000000a90000000000000009009a9a90b99bdbb9fb9bdb9b9f9b9f9f9f9b9e9f9ab0f9b0000000000000000000000000ca0f0ca9a000000000affffff000a9ac0a000a000000f0090009000009a0000a000a0a000a0900900000000000000000000009009a900000009000000090990b0bcb09cb99e9b9fbdabda9a9b9bdb9b0bd990000000000000000000000000000b0f09a9e00000000009fffffb0000c09a09a0d0e0a9af0a00b00a9009a00b0b09a90909a09000000000000000000000000090a090000000000000000900b9cb999909bb90b9b0f90b9dbb9fbf0fb9bdb9a9a900000000000000000000000000bcb0aa9e09a0000000bffffffc00b0b0a0e00a0a090e0f0090000009a0000000000000a09c0a0000b000000000000000000000090b000000000000000a009a990f0b9f909bdbdb9bbdbbbdb9b9bb0f9ad0909a000000000000000000000000000bcb0da9ac90000a000ffffffa00000c009e00090a000f90a00a90a00b0bc9a9e909a900a90009a0000000000000000000000000900000000a0009a00900090a99b0b0bdb0b0bdadbbdb0bfbcbdb9bb9a9a0090000000000000000000000000000bca09e9a00b0009a9bffffff000a0b0a00bcaa0cb0af00909000090c000000000a00e900a9000000000000000000000000000900090909a9000090000090b99a9d9b9a9f9b9b9b9cb9f999b9b9f9cb9090000000000000000000000000000000e9bca9e9eb0e9ac00fffffff0009cac9af0a9cb0ac9f0a00a0b09a00b00b0b0b009090a0900009a00000000000000000000090a00a0000000000000000a90da9a9a9e9b9bcb9fbdbbf9bbeb9e9b0b90b0000000000000000000000000000000b9aca9e9a9ca90f0bfffffff00000a9bef0afcbe9e9af09ac00c000b00900000090a0a090000b000000000000000000000000009009000009090000000909b099db99bd9e9bdba9bf99ad9bdb9e9b9ad909000000000000000000000000000000e9a9e9e9ebdaf0bcbfffffff00adaecb0fdabe9e9aff000b09a09009a0b09e90009090a90a00000b00000000000000000000000090b090b09e900900000099a9a9e90bb9b9ad9f0bf9fbf9bf9be9d9a9a000000000000000000000000000000b0f00a9adacbcbca9cbffffda000099effafdadafedaf09000009a0909000a00a9000000009000b0000000000000000000000000000000090b09a00000009a090909b990bcb9bb9bdbb9b9ad9b99b0b9090000000000000000000000000000000f0bcbcbe9fada9faffffffff0000ae9f0f9efbf0bfff0a0a9a9009a0e0a900900a00a9ca0009000c000000000000000000000000090009a000900000000009a09a9adaf99bdbcbdbe9f0bf9badb090000000000000000000000000000000000bcbcb0af9fadaffe9fffffff000b0f9faffaf0fcbfe0f909c000b0009090c0a0a00090a09c00a00b00000000000000000000000000000009090a90000000000900909999adb0b99bf9b9f99a990090a9000000000000000000000000000000000b0a0bdaf0fbf9e9f0ffffffe0000ebcf0fdffbfedbff0b0b0f009a00b00b00c09000000a090000000000000000000000000000000000000009000000000000000000a099a9db0b0bda9abd9e9b0a900000000000000000000000000000000000cbdacb9ebcf0fbebfffffffb000b0fbffbebcf0fadff0000000b009000000b000a0009000a00900b000000000000000000000000000000000000000000000000000090a090b0f9f9b9d990b90909000000000000000000000000000000000000ba09a0cbcbafbcf0fbfffffc0000bcfebcfffbffffaf00b00b00000000b0000b00900a0090000a0000000000000000000000000000000000000000000000000000000009a0909a900b09a900a000000000000000000000000000000000000009e09e0fbe9ade9e9adffffff000a9ebf9ffbcbef0f0ff00090000090a9000b0000000000a0000000000000000000000000000000000000000000000000000000000000000090b090b90b09a909000000000000000000000000000000000000000bca0b009e9a9ebcbaffffffa000cbcfaf0fffdbfffff900000090a00000000000000909000000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0b00cbe0acbe9e00dbfffffd009a0bcdaf0fafcbe9ef0cb0b09ac900009090bc900a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f0cba09adadebcb0affffffa0000bebae9ebdebe9ebfab9edab09a9b0b0faf0b0bf90b09a9f0adaf000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f09a00daf0bfada00fffffff0000f0cbc9e9febf0fadfdfffbdffbfcb09fbdbfdff0ffcb0dadf9ff9f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0a09abdafe9fa0a0bffffff00000abcaebef9e0f0fafbfffffbdfbfffadffffbfffbdbfbfbffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000adada0c0adbfede90d0fffffff00a9ca90bcbef9eaf0ffffffffffffffbdbfffffffffffdbcffffffffe000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0b00f0bfafcbfa0eabffffff00000a9eadafdaadadafffdfffffebfdbdaffffffffffffaffbffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bcac0b00bcffffe9fadfffffff0009cbca9e9faeda0faffbebffbdbdfaf09fbfffdfff9f9f9bdffffbfbf000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b9bc0a9ebdebe9eadadffffff000a0a0f0bede9a9fadff9bc9f0f0b9f0b00dadaf0fbe9e9a9a9fadfcfda00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e0a090e9ebfcbe9ebebfffffff0009ca0fcbebe0e0faff00b00a90000900b09a90b0090b0d00b09a9a9a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f0f0bacb0bcbadae9e9fffffff0000a0bcabfcf0f0fadff00000000a9000000000000000000a9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0b0bc090adabcebda9effffffca0090bcafdebabcbadfaf0900090000a000900900009a0090909a0900a090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f0e09a0bdace9a0acabfffffff000acafdbebdedacfafff000b00090000900a00a09a0090a00a00000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f00b0bc9e0a9b0e9e9ad0bfffffff00090aafdebaffafdaff0a0000a000900a009000000000000909000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009a9acbcaa0bcacb0e0acafeffffff0000a0fdafbcf0adbefff090909009000009000000000000900a00a0000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009e0e0b0a90d0b0f0f0bcbf9ffffffb000adbfadfcfbeffe9e0f0000a00000a0000000900900b000a0909090090900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a09ad0f00a0acb0a9acb0ebfffffff00000e0feafacbdaffbff09a900b0b00900000a0000a00000900a000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fa09a00bc0b09adacbacbca9ffffffe009a9f9fdbfbefdadebf0000090000000a900000a00000000090909000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b09e00f00a900aca9ac0b09effffffe90000eaefae0e9ebfebcf000b000000000000900000000900b0a00a009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f0ca09a0a9000e9a9e00b00e9bfffff9000acb9f9adb9fafcb9ef00000b0090a00000000900900a000090909a0009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ab09a0c90aca900ca0b0ca00adffffff0009a0e0acacaca9aca0f0090009a00000090a000000a00000000a9090900a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0dae0cb0a09000a9090ca009a9afffffef0009a9e9a9a9ada9adaf00a0900000090a00090a0000000900b090000a00000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009a90b00090a00a00aca090a000fffffff000a0ca0acacaca0e0a0f0009a0009000000000000a009000a0000a0b090a900a0bc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0eaca0a00e000900b00000ac00adbffff90000cb09e90a9a9e9e0ff0900009a00a00900900909000a00090909000090000009ff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009ad00a90000000c00b0000a09ffffffe000b0aca0adacaca0b00f00b09a000900000a00a000000000000a0090b0000b09a0bff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0f00a0d00a9a00a0a0000a0090a0ffffff9a0090bcb0a9a0bca0faf000000909009a00009000a09000900090a0000b0000009ffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000e9090af00a00000009009000090000fffffff000caca0ac0e0f0a9e00f9009a90a0a00009000009000c000a900009a9000900a9adffff0000000000000000000000000000000000000000000000000000000000000000000000000000000009a00a0af00b00bc0a000000a0000a0a9fbffff0000a0b09e9a09a0bca0ffadbe9ad909f9b0f9adb0e9ab0bbc9ada9ad0f9b0cbc90fbfffffa00000000000000000000000000000000000000000000000000000000000000000000000000a000a009adad0bacb00a9090a0a0000a00000fffffff000900ea00b0e9e0ada0fb0f9ffafbcbcfdafdadb9fdff0fbe9fff9abf0f9a9bfadffffffdb00000000000000000000000000000000000000000000000000000000000000000000a0000000adaca00bafc9a0e90a0e0090a9a0d0a90a9ffffff90a0e90da0cb0a9e9adaffffff9fdafbfbffdbfbeffbfdffdfff9fedf0fbe9fe9fbffffff0e0b000000000a000000000000000000000000000000000000000000000000000000a00000009e9a0b0facb0be9e9ae9a09a0e90cb0a9ca9ffffffe00009a0a0b00e9e0bcadffffffffbfdffffffffdffffffbfffffffbfbffdfbdbffffffff0fbde0000000000000000000000000000000000000000000000000000000000a9000000000a0be0a9cbcbcb0fe9e9af90f0ada90ebacbca9effffffb0000acb0f0ea9a0bca9af9fbfffffbffffdbfffbf9fffffffbffffdfffbf9efffdbffffff00a9fac00000000000000000000000000000000000000000000000000000a9ca0a0090a9c9e90f0fafada9eb9eb0f0ae9f0a9efbcfbebfebffffffc000b0bca0a90e9e0a9e0fffdfbffdffdbfffffffffffffffffffffbf9ffff9fbbeffffffffbcacba000000000000000000000000000000000000000000000000000000aa900bca09aa0aeb0bcbcfafe9ef0fe0f9a0a9e90afbcf9e9f0fffffffb000ca9e9ea9a0bc0a9affbfffffbfbffffffffdfbfffffffffffbffffffbfbcf9bffffff0cb0bcf00000000000000000000000000000000000000000000000000000f0dacbca9eac9e900f0fbfada9e9afa9b0e9e9e0af9efbeffaffffffffe0000b0cba9cbcbcbadacfbffffffffffffbffffbffffffffbffffffdfbfffdbfbfffffff0fb0acb0ac00000000000000000000000000000000000000000000000000fa0a0b0a9e909ab0efbebce9e9ebeda9cacb0b0a9f9edbcbdafcbffffff9009e0fbedebeae9ada0bffdbfffff9fbfffffffffffffffffffffffbfffffbcbdbdffffff00f0b0f0ba000000000000000000000000000000000000000000000000b0bcbe0f9e0bead0fb0f0fbbfbebdfadaa9a0e09ca0abafbfadbbfbfffffe0000b0e9a9e9bdae9af0ffff9ffffffdffffffffffffffffffffffffffffffbfbfbfffffbf00f0f0e9cb0000000000000000000000000000000000000000000000bcbcb09e0a9e09abe0ebcbede9e9ea0fadac9a9a0b0f0cbcbcbedeffffffff00a0cb0faf0ecbdbedafffbfffbffbfbfffffffbffffffffffffffffbdfbfbdbcffffffffcbf0f0fbebcb0c000000000000000000000000000000000000000000bcbe0ebe9e9e9be9e9fbcaf9afebe9ffada9a00000000badbebe9ab0ffffffb0000b0f0f0fbbeacbadaffffffffbdffffdfbfffffffffffffffbfbffffdfdabfbfffffff0b0fbebcf0f0fa900000000000000000000000000000000000000acbcbca9bc9a9eb0e0f0facbfdaff9f0fae9ebcbc0b0ca9a9cbe0f0fadfffffffc000b0e0b0e9aca9fadadfff9fbdfffbfbfbffdfffffffffdbfffffdfffbfbffdbdfffff9e9ef0fdfbfbff9edad0000000000000000000000000000000000a90b0a9adacbedabcbdbebcbf0fafdafafbdbfada0b00a900eafadbcbadabffffffb00009abca9acb9ea9eb0ffffffffbffdffffbfbfffffffffffffffffbfffffbfbfbffffffa90fafbcfcbefbebefbe90000a000000000000000000a9009ac0af0f0eda9a9a9edaeadafbcaf0faffcbcae9edada0f00ab09adfafbcb0f0fffffff00a0c0a9e0b00e9cb0faffffbfbfdf9fbffffffffbffffbffffdbfbffdffbfdff9ffffffedaf9f9ebfbfdadbdf0e9ebe9e9000a000a009a00090ac0aa00b0d0a0b0a9efcaf0bdbdadadbf9ebda9fefbdebafada0af0cbe9ebdacbea9fbfffffe009cbada9acaf0ab0e00ffffdffffaffff9ff9ffffffffffffbffdffffbdffbf0fffffff9badafeffcfcbffefafbfdadaf0e9e09009cac09a0a090a9c9ac00a09e0f0e9abdafaeafadaf0ebdaffe9bcaf0fc9adaf09be9ebcbeb9e9feffffff9000a0cbcad0b00f0e90bfffbff9fbfbf9ffbffffffffbdfffffffbfffffffffffbbfffffe0daf9f0fbfbedadbdf0befbcbdbe9fada0a99a09000a900a009a09e00b0b9adfebcdbdadadaf9fadbcbfebdaf0bacb09eae0bcbfe9febebfffffffe0000fbcb0aacaf0ebca0ffffffffdfdffbfffbffffffffbffffffffbffffbfdbfdffffffbf09ebff0fdebffafaffcbedbebcbe9ebcbcae9eacbc0e0b09a00000b00e0e0b00baa0f0faf0af0fafbe9e0f9ebcb0feadb0f0bcbfeadfbcbffffffb00b00ebcf09adaf90bcaffffffbfbfbffdf9ffffffffffffffffdbffffffffbffbfffffdf0bfbcfafbebdadfdf0fbf9ef9ebdbada9a9f9e9f9a9b0bc0a000a0000f0b0bcaf0dadaa9e9f9eaf9ef9ebdae9e9af0bda0da9ebe9bdbedffffffffc000cb0eb0fadadaebca9fffffffdffffbfbfffffffffffffffbffffffffffdff9fbfffffa0f0cfbdfedfefbebebfadaf9ebcbedadacf0ebf0edae0f0bc0b090a9a000a00900a90a9cb0ae0bdaf0fadaadb0ef0bcaada0e9adfefebfafffffffb00a9adb0fadafadbca9efffffffbf9ffdfffffffffffffffffffbfdfffffbffbedffffff0f0fb0fadbe9fbcfdbcfdadfadbfcbbcbdbaf9fcfb0f9f0f0bc00a00c90a9c9a0a90a9c0a0e90f0e9facb0e9aef9afcbc9a9a9efebfbfcff0ffffffc000aca0f0fadadae9af0fffffffffffbfbdbfffffffffbffffffffbfffffffbdbfbffffff0b0fbedadbe9fbebebebfadbedabce9ead9ebabcfbcb0f0f0b090b0acbca0a9c0ac0a0b090a00b0adb0e90f9acf0b0bac0acb0b9edebfaffffffffb0090bcbebcbebe9ebcaffffffffffbffffbffbffffffffffffffdfffffffdffffdffffff9e9edadbfebdacdbcbdbcbdadabde9be9baf0fdebf0fadaf0bcacac9a9a90bca0b0b09000e090bc09a0f0a0acba9e0e0cb0da0ffefbfdef0fbfffffe000a0bcbcbe9e9e9cbdafffffffbdfdbf9fdbffffffffffffffbfbffbffffbfbfbfffff9eb0fbfffebcbebbaf9eaf9ebebdebbedacf0f9ebf0fadaf0bcb09a9adadafc9adac0f0e0b09a00abe0f0a0da9ad0a9a0b0a0bde0fbedaf9ffffffff00a0c9ebcbe9e9ebeabebffffffffbfbdebfbdffffffbffffffffffffffbfffffdffffffe90fedfebdfbe9fcf0e9f0eb0fdabde9adb0fbe9f0f0f0bcbcbca0dacadaf0beda9ab0a9aca00e90090a9ca00e00f00d0009e0abf9cbeb0fafffffff9009ab0fadafae9e9fcfcffffffffdbfbfdbfbfdbfffdffffffffbf9fffffff9fbfbffffffa9fbfdfffdffaf9fbe9f0da0adabcfaadb0cbebfaf0f0bcb0bcb09b0f09e9abcbc9e9e90bcb0a9e0f0a90a90b00a0a0f0a09c0aaf00facb0ffffffe0000cbcbe9cb0f0ebabfffffffffbe9fbff9fbffffbffbfffffffdffbdffbfffe9ffffff0dadefbefafbdffeffdefbadbdad0b0d9acbbdbcbdbcbe9bf0f00f0e9afa9edabcbada9ebcb0e9e9ab0f0a90a00b09000009a0bc90ad00b0ffffffff000a9ebcbebcfafbcfcafffffbdbfdbfdf9ebdffbdfffffffbf9fbfbffbfffff9ffffffe9a9fbffffffefefbdebf0fcb0ea9ebcbae9bcbebcbebcbce0f00b0a9adade9a9cbcf0be9ca9e9a9af0f0bc0bc9e00a0a000000000a000b0cbffffff000bcab0f0adabcbcfab9ffffffffbfffbfbdbfbffffbfffffffffffdffffffdbfbfffff9e0fefcffdffffffffffffbfff9ffadac09acb0bdada9e9bbda9ac9ebcbcb0f0fada9ad0ba9e9adad0fad0bca0a9ad0d00b0a0900090a000a9ffffff00009c9e9adafcbeb0fcafffffffdf9ffdfffbdfdbfffffffffffdbfbfffffffffdbfffff9a9bfbfafadff9efbdefdebcbf0fdbfbf0f9edaf9ada9ecbe9e9a09a9ebcb0f0f0f0faf0f0bcb0faf0faf0bcbda0a0a900c0000a00090090afffffff000a0a0aca9abcbcb0bcffffffbfbffbfbdbdbfbfffffffffffbffffffffffbf9ffffffcbc0f0ffffffaffffefbffffffeffafcbcb0a9a9e0f0bcbbcbcbc0f0f0f0bcbe9af0bcb0f0bcb0f0bcbdadacbca9e9e9eb0b0b0a90a00a0009ffffffa00a9cb0da9cbcbcbcbcbffffffffffffffffbffffffffffffffffffffffffffffbfffffb00bfffffffffffffffffffffffffffffffffffffbf0f0bcbcb00b0b0f0bcbcb0f0bcb0f0bcb0f0bcbfada9a9a9e9a9a00000000000000000bffffff00000a00a00a00a0a0a0a000000000000000000000105000000000000d4ad05fe, N'Michael is a graduate of Sussex University (MA, economics, 1983) and the University of California at Los Angeles (MBA, marketing, 1986).  He has also taken the courses "Multi-Cultural Selling" and "Time Management for the Sales Professional."  He is fluent in Japanese and can read and write French, Portuguese, and Spanish.', 5, N'http://accweb/emmployees/davolio.bmp', 'suyama@northwind.com', '343474356' ),  
( N'King', N'Robert', N'Sales Representative', N'Mr.', N'1960-05-29T00:00:00', N'1994-01-02T00:00:00', N'Edgeham Hollow
Winchester Way', N'London', NULL, N'RG1 9SP', N'UK', N'(71) 555-5598', N'465', 0x151c2f00020000000d000e0014002100ffffffff4269746d617020496d616765005061696e742e506963747572650001050000020000000700000050427275736800000000000000000020540000424d16540000000000007600000028000000c0000000df0000000100040000000000a0530000ce0e0000d80e0000000000000000000000000000000080000080000000808000800000008000800080800000c0c0c000808080000000ff0000ff000000ffff00ff000000ff00ff00ffff0000ffffff00fedecdacfefceade0ececbce0cefefecffefcfeeedefefefcdebceffefcfedefcfefecfdeffc000c0a0c0ce0edfe0fce9fdfcbf9f9fcfcefcf0fc000000efce0ce0ce0fcbe0f0edecacbcaecacef0fce0fccace9e0feede0e0e0eedacec0cedefcacaece0caedeecfcacfcedefe0edefecfcfedffefffcfeeeceefce0efedfedeffedfefefe900000c9e9cadefe0fcbdfcbdbd0fcf9f9ffdeffcaf0000c0cadcac0e9ecaccfcecacadecedefcf0eecacecaede0ececedacfcfcedeacf0fef0eefacedcadefed0ecbcadeeefaeedefeefcfeefefeefefefedacbcf0efede0fefefecfeefefff00c0ce0ec0edefacfcbdbcbdfe9fdb9e9e90effcac0ca00c0efcaccecec0ecace0fcedecbcac0e0ed0cedebcde0fcf0e9eefee0e9e0de0ecacefdfcccafceecfeefcecece9ecfcfefce9eefededefdefffededeceefedfefefeffcffefdefdeff00000de9ecefede9edadfdaf9f09edf99cf9efffcac0900cc0ec0e9cace9cf0ec0f0e0ecfcfecfceebcacceacecacececfcbcfceceecfcededeefebcecbc0fcfcaf0f0ecedeefcfefefedefefefeffeeffeacefcfceeffcfefcfeefeeffeffefb0c0e0f00debce9e9fdadbdcf0f99adeb90d0feffdeca000acdac0ecdace0ec9ececfcfe0ecbecadcecebcce9ececadeacecfacbec9ee0fceadef0cefecefeebefcecedacaedeafcedecfedacfefeedfedfce9ee0edfeefedefefdedfeffefff00000c0cfefcdad9e9edbcfbdf9cbd99c9f0fcfdefbcc000ccacfc0eaccaccaccacac0e0fceccbceadacce9ece9e9ecedefedefccbecdeebedeffcac0cefefdecccac0eecedecfcffeffefeffedefffefeaedeecfefeeffffebedeefeffcfefcf000caeedebcbc9e9cbdadbde9a9c9ce9e09d0fefcfe9a00cacf00e0ccadcadeadedeedece0feecfcecfe0ece0ececf0ecadeecfeecfaededefeffcbcac0ceefebedef0cbcaefefeef0ededecfefefefdedcaedacfeffdefefcfefffeeffedeffbc00cdfafcbdad9cbd0fdcbfdf90a99c9fcbcbcefcfed000caceccedace0e0ccacac0edafcac9e0e9e0decacfcacacedefee9e0f9eecfeefeedfffefcbc0c0ceceacefececcecefdefeefefefefdefefeefcceceffcfefedeedeecffdefffefefbc0eedcbc9c9e9d0fdaf9cbdad9c0bd090d0d90ee9efe900cbcbc0ec0cece0ececfe0ececfecefceceacede0ecfce0ece9eedeeedef0fcfffaffedfefefbcad0cce0edf0facffeefcfcfcededefeffef0eef0efdefefedeffefffefefefedeffc00cb0bc9e9e9e9f09d9eddadbc90c0fcf0f0e0dcedef000ccec0e0ce0c9cecbcaccfcbcbc0f0cacadce9cacc9e0fcfadecfecfcebceefeb00fefeedfcfcedeeca9cceeeccfecedefefaefefefeffedfedaceffefffeffefcefcefefefcfeffeffce0fc9e9e9cdbc9e9e9fadf09a90b9090d099cafeeda900ef0e0ce0cace0decfcbeececeeceecdece0cecfaeece0eceefacbcefcedffb000ffcffeefeefee9fcef0c0cfe0effefedede0fefeffefe0ecedefefefedfedeffeffefcffefffcfeff0d09e9d0f9acbd0f9e9de9f99c9c0dad0bc09c0cfef00cecfce0c0ecaceacaceed0edac0f0dae0e9eacacc0cbcecfededeefacffef0c0e0fefecffcfdedeeefceebce0edeedeefefefecfcfeffffecbcefefffefefefecffefcffedeefefefcaf0f0dadbcf9dadbc9f0f9e9e0909a0dad09e00e0cfeb00cfad0e0c0cc0dedef0eefcacecceccececccfcaceccacbcf0eedecfceffeb000effedfecbeebefdecbedee9c0ecfefdefededeefefedecfecefcfefcfcfedeffedfeffefffffcfedad0d0f0dad90f0d0dbc0f09f09da00d0090f0909cefed000fedec0cacacecaceced0cacdacacac0f0e0e0ecacacfceeefe9e0feffbc90e0f0fefeeffeededaeefedeedefe0ce0feedefeefcfeffeffacefffefeffefefefefeeffefefefefbcadad0f0de9dadf9e9f0dbd9fc9f09c909f0d0900ceff0cacfef0e0e0c0ce9ecf0f0ecaceacedacce0ece0ec0cce0e0fcbcfcefeffaca0e0e00fcfcfcedfefededece9efedef0eceffefcadefefeffecf0fefefdefefcfefcfefffedefcfedecfc0d0f0dbc9e9e0d9f0dbc9e99f0f0bc0000b0c9000ceffcfe9ef0c0c0e0cedacecf0edacccacce0ec00cc9edebcfcfefce0efde9e9000000a0ffefafeedecfefafefedefacfe9e0cefefdecededeffecefdefefefcfefcefedefeffefeffefca9cbc9f0f9f9f9f0f0f0dbc9e0d90d09b0d0c90a900fceffefeccfe0e0ce0ecfcacac0eca0fcac0c0ecebeecacce0eccacffdefffa0a00a0000fefcfcf0ef0ecededeefecffecfefcacfeeebefeffef0fefefdfedefedeffefffefdefcfcefcb0c9cf0df9ef0fcbdbd9f0d0f9f9e9a9c0d009a90c000edefcfcbe0c0ccacef0e0decce0ccec0c0efe0c0cc0bc0e0ccbeffefefea00000000000fffeeefefcefe9eefedecbcecfede9c0effdedeffefcefcfefeefefcfeffedfeeffeefefefcf0f9eb9debcf9df9f0f0f0f0f9c9e9c9ca90a900c0900cebcfebeede0ca0ce9ce0ee0e00ccac0e0ec0c0e0e0eceecffefedefcff0900000000000fcfffdedeefceede0feffeefefefefffcceeefefeffefefcfeffedefefcfefefdfeffcfede0909c9debddb0fade9fdbdbd99e9e9f0f99c900d0900000ceefdedecac0ce0ceacc0cc0eca0c0ece0cacecedededafe0fcfefef00a00a000000000facfefefe9ef9ecefceedededacfceefaf0deedefedeffeedfcfeffcfefefedefefcfedefbcbcadaddebcdfddbde9e9e9edad0d09d0f0b0d00a0090000dcefecbedac0cfc0cace0ec0eceec0c0cacbcbce0e0ededefecfcfeb00a000000000a0fcf0ffefcfecefe9cedaefefeffeffdefcecadeffefefcffeefffefeffedfeffefefeffe009c99fdbe9dbf0fadf9fdf9f9bdf9adadb0d0da90d090000ceafcadecec0cacacc0c0e00e0c0c0eadedeccecadeceefefcffeba0a0a0000000000c0fe900efffecffedefaededededecfeeffef0ceefeffcfefefffeedefcefeeffefdefcfe09fcbcfcbd9ffedffdfbedf9ef9ed09cbc90d0f09c000000000edcefe9e90eedac0ac0ecdecc0e9efccacadacbcecfadedefeae0000000a000000000af0f0000feffecfaecfceefeefeffcffeffeff0ccfeffedefcfedfefeffcfffcffefef0c9c09cbdbdefe9fbdfbdfdbedbcfdbde9d9adbd0f09090c00000cebcfcecec0c0c0ccecf0e0cadce0cbedecececedaedebedafc9a0a0a0000a00b00a90be0a000cfefffcfefcfdecf0efeffedefcfedeaccffefefffefefedefefefefefedeef9a9cbdededbdffdfedfe9fdbfdbdadb9e9cdadad0f0ca90900000ce0ef0f0fcacaca0ca0c0e0ee0feccae0f0e9e0ecfeceefcaa0c9000a0000000a00a0f09000000dfefefcafeafeefedefefefefefefd0efefedefefefceffcfefefefcfefd00d0fcbdbfbdfbcffbffffffdebdf9fcf9fa9d0dad0990000000000cfe0fcecac0c0ccaccacecd0ec0fedcfcedecfcbc0ffcea9c0a0a00000000a009a0af0a000000feffedeffcfcf0fcfefdeffcfcfeffefffcfefefcfeffeefefcffcfefa90e9cbcbdefdeffffffdfbdfbcfbde9e9f9f0ddadbd09f0009000000ce0cfcead0cacacaccade9e0edace0ceace0e0e0ecfeca9000bc0000000000000a090ff0c0090009efffecefefefeefefefcfefedfeeffeefffedfedefedfeffedefefcfc09e9fdff9ffdfedfffffffdfbfdbdbdf0f0db09e9cbc0ad0c090000acfee0fce0c0ccccade0cece0ecbcfaccbccfcecfef0b0a0a00a900000000000000a0feb09a00a0000afffecfcfcffedefefefefefdeffdefeffeefefcfefdeffefedef0bc90f0f0ffdfbffffffffffffdfadfcbdf9fbcfd9e9dbd9090000000c0c9ef0e9e0caf0fcace0f0edace0ce9ecae0cfe9eaca0900ac0a000000000000a000feda000090000ecfedefaefecfeedefedfefeefefefefdefdefffefeffefedefe09c9efcfdffebffdfffdffdffbcbfdbdbdadad0b9ac9ad00f0e90000000e0ececfcc0eccacacdaccec0ce0ec0ecadcefe9e90000a0900a00b0a0a00a0a00000f9a000900000000efffededeffeffedefedeffffcfffefefefefefeffedefef090d0f9dbffffdfdefffffffffdfffdbdedadbd9fc0d9fdadf9090090000cc0e0fcacacfcacedcac0e00ce0cc0ecadeebcb0a0a9000000a09a000000000000000be90900a00000000eeffefefeffcefef0eefcfeffedefeffeffefdefefefcfe9cbcbcfefdf0ffffffffffffbffbf9feb9bdbc9e99f9e90f09ad0d000000cacfcadefcac0de0cacec0ece0ef0e9ececfda000000ad00e000a0a0a000a0e0f0b00f0a00a090000000000cfedfefcfffcfefdefeffeffefffcffeffeffefffefeda0d0f9fdfaffffffffdfffffdffdff9fdedadbf9e90f9ed9fc90b0b000000c0cfcac0fcacacfec00ec0e0d0cececffbe0f0a000e0af009a000000a00000a00000f90009000000000000acfeedefefefedeefcffedfeffeeffeffefeffcfefed00dadcfcbfdffdfffffffffdffffffdef9f9f9c9e9e9d09ad0bde9c09000000ee0edefcadece0c0ec0ac0ecec0feb00c0fa0000adfc9ebe0a0b0a000000000a0a000090000000000000000efffeffedfefef0fefffeffefffeffedfffefefde90dadbfffffffffffdfffffffffff9fbf9f9e9e9e999da9ed9bc09909000000ec0cfcacade0c0c0ec0eccf0e0efe90000a00000ac0a0a00009a0a000a0000000009f000000000000000000000efffefeeffedeefefefeffedefeffeefefedee00e9dedebdffffffffffffffffffdffdfdf0f9f9f9ecf09c9bcdbdbcbc900000c0fe0ecfce0ce0e0cac0dacecfe900000000000000a000e0f0a0000a0000000000a0ab000000000000000000000acfffffcefedecfffffeffefffefffedffedf9c9e9fbdfffdfffdffffffffffbffbefbffdbdad09990f0bc0b0dad909a900000c0ecbcafcac0cce0ceececffcb0000000000000000000000a0ba0000ac000000000d00000000000000000000000acfefeffffefefefefffeffefdefefefefe00dadfcffffffffffffffffffffffdfdffcbfef9ff9edb9cd9f0f90bcbc9000000ec9cecfc0c0e0e0ed0cefb00000000a0a000000000000a0e90000a0ac0a00000000a0000000000000000000000000effffefedefffefffeffeffefffffeda90dadefffffffffffffffffffffdffffbfdbfdf9f99e900da9a0d90fd9c9000000cc0eedacacac0f0ccaefb000000000c0000000000000000000a00a0009a0000a00a09a000000000000000000000000000efffffefefffeffeffeffefefefe90dadfdbfdffdffffffffffffffffff9fdfff9f9edef9f9f09c9dacf9a0bcb900000adc0ecf0ccacccafcf0000000000a0a000a000000000a00a00a090aca0000000000e9000000000000c0b0a00000000000effefffffefffefefdeffeffdef00d0fafdfffffffffffffffffffffffffff9ffff9f9f0f09f0bc99b0d9c99c09000c0e0dadecaccacecfa90000000000c090a0000000000000000900ac90cbca000a900be000000000e009a0000000000000000effefefffefffffeffefefef00dafdfffffffffffffffffffffffffffffbff09ff9f9f99e99c9e9c9adbca99000000c0ecebc0cacfaf00000000000000ac000000a00000000a0a00000a000090a90000f09000a0a0e9cb00000000000000000c9efffffeffffefeffefffef09e9edffffffffffffffffffffffffffff9fdf9fff0f0fc9e99e9a9c9ad909d9e00000e0ec0fc0deedad0000000000000a000a0e0000000000000000a00000a00a0000000fca00000000a00a0000000000000000a0000efffefeffffeffefedf000dffffffffffffffffffffffffffffffffbff9f9fbdb9f9f090d0bc9bcbda099000c0c0ceacee9e90000000000000000a0ac000a000000000000a00a0a0000000000000af0000000a00a000000000000000000000000cffffffefefeffffea9cbcffffffffffffffffffffffffffffffffdaff9e9dada909f9e9c9bc9909dbcb0000c0cbcde9e9000000000000000000000a0a000000a000a000000000a0e0000900000fe9a000000000000000000a00000000c0a0000fefefefffffefeff900dffffffffffffffdfffffffffffffffffbff9fe9fb99f9f09090b0c9acbcb0909000acacea0a0000000000000000000a0aa00000a0a000a0000000a00ac090a00000000fa00000a0a0a00000000a000a0000a0a0c0000cfffffffefeffffc0cfeffffffffffffffffffffffffffffff9fdf9f99f9c9e0d09adad0d9ad9d90dad0000c0ccad0000000000000000000000000000a000000000000000000000a0900000000ff00000000000a0a0000000000000000a000a00cffefefffffefcb9adfffffffffffffffffffffffffffffbffbfbdb0f90bc990bc9090b00900bcbd9b000c0e0fca000a000000a0000000000a0a0a00000a0a0a00a000000000a00a00a000000feb0000000000000000000a00000000c0a0c0000cffffefefffef00cffffffffffffdffffffffffffffffdffdfdaf9f9e9dbcbc9bcbc9dbc9bc090ad09000c0ce0e000009a00000a0a000000000000000000000000000a000000000000000000fbc00000000000a0000000000a00000a00ca0009efeffffffeffe90ffffffffffffffffffffffffffffffffbfbf99edadbe99db9c9dbdad9a090c9d0f000c00e0da9a00fac9a0000000a000000a00a000a000a0a00000000000000000000a000feb0000000000000000a000000000000c0b00e00cfffffefeffe90ffffffffffffffffffffffffffffbfffbdbc9efdbdf9dbdade9fbc9f9fc99e900a990c0accfa000cfac9ac90a00a00000000000000000000000a00000000000000000a0c0af000000000000000a000000a00000000ac0e00a00effeffffefce9cffffffffffffffffdffffffffffdbdbdf9ff9fadf0ff0f9b9f0dfe9e99f090bc9c0000cac0ca00a0cbe90a0ca000000000000a00000000000000a00000000000000000a00ffb000000000000000000a00000000000a00e0ca09cfffefffff90fffffffffffffffffbffffffff9ffff0bcf0ffdfbff9fffcfdbfbdbdff9f9e9090b090c0ceb00a00a000a009acb0a0a0000000000a0000000000000a00a0000a00000000a0b00000000000000000a000c0a000000000ca9ca9ca0effffefeb0efffffffffffffffdfffffdfbdfff90ffdbfffdbfdfdff9fbfbcdffffbcf9f9dbc90d0c00f9000000000009a000000000000a00000000000000000000000000000a00000a00f0000000000000000000a0a0000000a000a0ea0cadadffeffffc9cfffffffffffffffffffdfffffaf0fffdbffdbffffbfbdffdfdfbe9fdff9ebda90bcb0b0ec0000000000000000a000b000a00000000000000000000000a00a00a0000a00000ad000000a00000000000000a000000c0a00c00da0000cffffefb0ffffffffffffffffffffffbff9fdfbdbffdffffdffdfffffffbfdffbf9ffddb9f9d09c9ccb00000a0000e0acb000a000e9000a0000000a000000a000a00e90a000000000000fada00a000a00000000000000a0a0000da00acacb0000cfefffe9cffffffffffffffffbfffffdbffbdfffffffffffffffdfffffdfbdfdff9fbfde9a9f09a9a9000000000a0e9acb0000a00a000000000a0000a00000000000e00000a000a0000ffa00000000000000000000a9c0000a0a00a000000a000ffffed0efffffffffffffffffdfbfbffdbdffdffffffffffffffffdfbffffbff9e9f0f9fdb0dad0d000a00000a0cbce90a00a00a00a00a00a00000000000ca000ca00a0a0000000000fa00000a0000000000000a0c00ac0a00000000a0a00000effefb0dfffffffffffffffffffdfdffffffbfffffffffffffffffbfdffdfdf9fffdbdbf9adb99cb00000a00000aca9a00000000000ca00a00000a00000a00000a000000000a000000ff90a00000000000000000a0a00a00c000000000000009cffffc00fffffffffffffffffffffff9fffffffffffffffffffffffffdfbfbffdbdbdbc9fdb0da90d00a000000000ac0a00a00a000a00f0000a000000a00000a0000a0000000000000fca000000000000a000000000a00a0a0a000000000a000a0deffbcfffffffffffffffffbdbfbfffffffffffffffffffffffffffbffdfdbfdbcf9ff0f9f0db09a9000000a0000a000000000a00e00a0a000a00a000a00c0000000000000000000ab0000a000000000000a00000000000c000000000000a000effed0ffffffffffffffffdfffdfffffffffffffffffffffffffdfffdfffbfdbff9f99f9f99bc9f000a0a0a00a0000a00000ac00a00a0000e000a000000a000a0000000000000000f00a00000000a0e0a00000000000a0a0a0000000cb00000cdeff0efffffffffffffffffffffffffffffffffffffffffffffffffffbf9fdbe9dbdadbcbcbcb909da000000e000a0000a0aca9a0a000a0a0a0a000a00000a0000000000000000000e0ca0000000c0ac9a000000000000000000a90a0c0f009a0fefe9effffffffffffffffffffffffffffffffffffffffffffffbf9fdff9f9dbf0f9f9bdb99dada09000a0a00a0000000000ea000a0000000000a00000a0000000a00000a000000b9a0cb00000a0e9a000a0a00000000a000a000090b000a00acfffcfffffffffffffffffffffffffffffffffffffffffffffffdffbf9f9fbd9f9fbcfdadaf099dad0a00000acb0a0a00a0000a0000a0a0a00a000000000a00a000000000000000e000ac0a000000a000a0000000000a0000000000a00a0000cbcfebcffffffffffffffffffbffffffffffffffffffffffffdfffbdf9f9f0daf9f9cb9bdbd9bda990b0000a000000000000a0a0a0a0000000a000a00000000000000e0a00000000b00ac0b00000a000a000000000000000a00900a000000000acaffcffffffffffffffffffffffffffffffffffffffffffffbf9fdf9e9f99f999c9b9fcbf9ada9c9e900a000a0a0a00a00000000000a0a0a00000000a000000000000a000000000e0000ac0b0a000a00c0e0a000000000000000000000000a00adcffffffffffffffffffffffffffffffffffffffffffffffdff9fbdbd9e99f0f9fdcb9d0bdbd9b09d09c00000000a0000a00a0a0a000000a00000a00a000000000a000a00000009a0000ac000000000a900000000000a0000000000a00000000a0efefffffffffffffffffffffffffffffffffffffffffffffff9f9fbd9f09d0b0b9debddadad0f0b0a0b0a000000a0a000000000a00a000000000000000000a0000a000000000e0000000a000000a00caca0000000c00000a000000000000000000ffffffffffffffffffffffffffffffffffffffffffffbfdbf9f999f9db99d9d0b9dabdbdb999c9d000000a000000000000a0000000000000a0a000000000000000a000000090000a0000a0000000a009000000e0b00000ca00000a0000000a0efffffffffffffffffffffffffffffffffffffffffffffdbd9d90df0b909da90bd0f9d9e9f09e9f0a00000000a0a0000000000000000000000c0a0000000000a0a000000000e0a0000a000000a0ac0f0ecb0a0000eb000a0c00a0000000000009cffffffffffffffffffffffffffffffffffffffffffdfbdbf9fdb9d9f9f999d09f09eb9f9f090099000000000000000000000000000000000a90000000a0000000a00a0000b0000a00a000a00a0a000ace9000a0c0e9c09a0c0a0a0a90a00000afffffffffffffffffffffffffffffffffffffffffbfdffdff9fdbdf9d9fcb99c9f99dadb9f9f90f0a0a00a00000a00a000000000000000000e0a000000000000000000000ca00000000a00000000eada9e00000a000a0ac0b0c00c00000000acffffffffffffffffffffffffffffffffffffffffdffffdbd9f9fdb9f0b999cb909cb9dbcf9090f090000000a0a000000000a0000000000a0000000a0000a00a0a0a000000b0000000000000a0a0a000e00a000000a00d00ac00b0a0a000a9e0dfffffffffffffffffffffffffffffdffffffffffffdb9bdbf9f9b0d99d090990bdb9ebdf90f9f090a0a00a00000a0a000000000000000000e0ada0000a0000000000a0000e0000000000000000a0a0a0a00a0000000a0ad00e0c00900a0000aefffffffffffffffffffffffffffffbffffffffbfdbfdfd9d9fffdfbe9b90db0d09c99cb9ff9099e90000000a0a00000a00000a00000000000000000000000000e0a0000009a0000a0000000000000a000a0000000000000a09a0f00a000a009cffffffffffffffffffffffffffffffffbfffffdffdb99fffffffbdffdefb0d90909e9bdadbf9e99e90a0a000000a0a0000000000000000a00aca0000000a000a00d0a00a0e9000a00000a00000a0a00a000a0a00000000a0dac000e00e900a0affffffffffffffffffffffffffff9f9fdffdfffbdbdfffffffffffffbdf9fb0009090dbdbf9e9f090000000a00a00000000000a00000000000000a00a00000a0ca0a00000b0000000000c90a000000a0a0a000000000a000a00b0e90e00cad0fffffffffffffffffffffffffffffffffffffbd9defffffffffff9fff9eb9e9900009dbc9f9f990dada0000000a000a00000a00000000a00aca0a000000000000a0e00ca00e00a0000a0a0a000000a000000a0a0a0000000b0b0000cb09eb0acbffffffffffffffffffffffffffbf9f9fbdf9dafbfffbfffbdfffbdb9b9c99cb00000099e9e9f0f90900000a0000a000000000000000000000c0000000a0a00000cada90a0db00000000cada0a0000a0a0a00000000a000a0a0a000acac9cb0acffffffffffffffffffffffffffffbefdffbf9dfdbfffdbffbfb990d0d0900909000000b9f9fdb0f9f0a0a000a000a0000a00a00aca000000a0cac0a0000000000acaca000eaca00000000000000a0900000a0a0a0a090a00000000000a0a000fffffffffffffffffffffffffffffdb9ff9009efbdff9bd90d9cbd9b9b909f0909090090d0f9b9d090900000000a000a0000000000000a0a000a00b0000000000a000ac9a0f00000a0000a0a000000a00a0a000a00000a00000000a00b09000f0fffffffffffffffffffffffffff9bdf909090f99ff9f9dbdbdbdb9c9d0bd090d09a99000b90fda9ada90a00a0000a000000a000a0a0a0c00000cac09a00a0000000a00a00ebe0e09a0a0000a000000000000a0000a0a0000a000000000a0000fffffffffffffffffffffffffffbfdb0f900009f9f9f9fbdbdbdbdfbf9fdb9db9bd9d0d99cbd9bd9c9ca000000a000a000a000a00c0000a0000a000e0ca000a0ca00000000fcb00e009000000000a00a00e009e9a0000a9a090a0000b000b00acfffffffffffffffffffffffffffb9db99bd9dbdf9fdf9ffffff9f9dbf99e9e9c9ada9a0909ad9b0b9900a0000000000000000000a0a000a0a000a00eada0c0a00f0000000fbceb0f0a0a00000a000900f0be00a00a0b0000a000b0000900000ffffffffffffffffffffffffffff9db9cbdbfffffffffffffdbdf0fbd0fbdb9fb9db9d9990f99e9d9e9b0000a000000000000000a0000a000000000a0ca0f0ac0e00a00000fcb00c0a9c9000009000a0f0ac00b000900e0a000b000a00a00a0feffffffffffffffffffffffffffb9a9cbdfffffffffffff9fbffbdbc9f9c99e9dcb0dbcbcb90f9f9a9c000a00000000000000000000a0000000000000a9e0e09a0a0000000ab0da9ad0aca00a00a90000e90b0000a0a09e900000a00900b0900ffffffffffffffffffffffffffff9d9bdffffffffffffffffdf9dbd9b099e99a9b9da9909c990f0d9cb900000a0000000a0000000000a0a00a000000000000a0c90a000000dea0000a90b00000000a0000a000a00000e00eb0a000f0a000acbcefffffffffffffffffffffffffbdb0bd0bdfffffffffffffbfbfbdad99a0909d09cbdadb9bcbd9b0b90da000000a090000000000a0000000000a0a00a00a09ca0e090a0000a90000000acada00a0ac0b00000000000a0ad00009ae0e90a00000fffffffffffffffffffffffffffff990ffffffffffffffffdfdbdbdb9c990f009e990990d0990fdbd0f0900000000a00cada000000000000000c000000000a00f0a0000000f000a000a909a00000daf0000000000a09c0a00a0ac9ebca00a0afeffffffffffffffffffffffffbdf990ff9ffffffffffffbdbfbdbdbd0b909009909e9f0f9b90f9090f99000a00a0a00e9a00000ac0000a0a00a00a000000ac0e00000000009a00900900a0000000ac0a09a0000000a0b00a00000e0ea900000cfffffffffffffffffffffffffffbff990f9fffdfffdfbdfbd9dbdbfbd9e9099e090909909cbd9f9f990f090000000000ac9a0a000ada0900000a0009000000b0a00a0000e0e9a00b000090a900000ac9a000a00000000e009a00a0edeeb000a0fffffffffffffffffffffffffffdbdf999f9ffbffbfffbd9b9bdffdbf9db9c990da99e9f990f90f0f9d0b0f0a00a0a000aa0000a0000aca0a00caca00900a00000000b0e9eb000000b00000ca000090a00a000a0a0a0a90e00000ca0e9e9a000fffffffffffffffffffffffffffffbf9f09fbdfdfff9fdbffdffbdff9fbda9ad9bd9c9909e99edbd9e9bdd0000a0000a0000a0a00a0a0090000a09000a0000000a000c0caca09a0f00000ada90000a00cf0e9a00000900e9a0a00a0e9eca0e9ffffffffffffffffffffffffffffbdfdf9f90dffbfdbffffffffffff9fbdbd9d9bcb09a09e99f9b9db9f0d9a9a00000000a0a0000a00000e0a0a0ca0a900c0eabc90a0a0acff0000090a000a000000000a0f0e00a0a0a0b0ac9090000a0bcb0cafffffffffffffffffffffffffffffbfbf9f9a9fdbfdffffffffffffffdff9e9ad9bf99db9df0fdfade9dabd0000000a0a00000a00000009000c0bc9c000b09c0a00000edae9a000acb0f0c90a900000bceff0f000000a009a0a0a000000adb9dbffffffffffffffffffffffffffffdff9f9f99afdbfffffffffffffffbdfbdbdbcd9e90db9f9b9d9bdb9dcbdb000a0000a000000a0000a000a000a0acb00a0bc9a00000acfe9000dacf09a0ac0090a9caf0fa00a00b00a0a000000a000fdbdffdfffffffffffffffffffffffffffffffff9f9f9dbdfffffffffffffffffbdbdadbbf99fbcf9fdebfdbde9bda00a0000a0000a0a000a00000a09a00c090e90000a0000a0cb0b00a0acb00a000900ac9cad0f09cb0ca00a90000a0b090ffffffffffffffffffffffffffffffffffffffff9ffbdbdbfbdffffffffffffffbfdf9f9dbd90f0d9bcb9bddb0f9bdf0b00000a000a090000000a0a900000a0bee90f0009000000a0eca0d0000a000000a900a0b0a0e0e0eb0e900a000000cadffffffffffffffffffffffffffffffffffffffffffdff9fbdffffffffffffffffdfbdbc9e9e9f9fbfdbdfdbbdf9fda9f00000000a000e9e9a00000000a00000c0ffe9a000000000000bda0a0a000a00a0000900009e9adade9a0ac90a09a00fffffffffffffffffffffffffffffffffffffffffffffbffdfbdff9ffffffffffffffff9f9b99e9f9f9fdb9fde9ff0fdada90000000a000000000a00a00900000ac0ebe9a00000000000ca0000000a000d0b0a0a90000000a0a0000b0ad0000fffffffffffffffffffffffffffffffffffffffffffffffffbfdfbffffffffffffffff9fbdbc9f9f0f9e9bdf0f9fdbf9bdb0000000a000a0a0a0a000000a00a00009a9c9000900000a00ab000a00ac090a0b0c9c900a0a0a000000cacad0a0cffffffffffdbffffffffffffffffffffffffffffffffffffdfffffdffffffffffffffbdfbdad9f0f9bdbdbdf9f9f9bc9fc9ad0a0000000a00000000000000000000a0000a090a000a000ace9000000a0a090009a0e000900000a00a0f0faf0f0ffffffffffffffffffffffffffffffffffffffffffffffffffdffbfffffffffffffffffbdbdb09f9fdbdbdf0f9f9fdbf99f9ad0a0a00a00a00000900a00900900a9000b09a000a00000000fab0a0a0e0ca0b0a0090a000e90a000000eefcb00ffffffffffffffffffffffffffffffffffffffffffffffffffffbffffffffffffffffff9ff9bdf9f0bdadfb9f9f9ebd9cfa909a9090a00a000a00a0a000a00a0a00e9e9cac9a0000000a0a0bd0000009eb000090b0090a000a0000a0acbcb0cbffffffffffbfffffffffffffffffffffffffffffffffffdffbfffdfffffffffffffffffff9fda9e9f9fdb9cf9f9f9dbfb99f909e0e000a00a000000c0b09009009e000a09a000a0000a0000f0a9a0a0e0009000000a0a00a0000a000cbeb0e9eff9fffffb9dffffffffffffffffffffffffffffffffffffffdffffffffffffffffffffff9f0b9f9f9f9b9fb9bd0f9fad9cf09cb0b000a00a0a0000a0b00acbc0a0000a00a000000a00000a0a90000000a90090000000000000a0000a000000adffffffff9fbffffffffffffffffffffffffffffffffffffbfff9ffffdbffffffffffff9ff9f9d09e9e9c90d9cb9e9d9e9b9da90000a00e00000a9090000909a90a0a000000a00000000a00afe9a9a0a000a00009000000000000a000a0a0000fffff9ffbd9dffffffffffffffffffffffffffffffffbf9ffdbff9ffbffdfffffffffffff9f9a9f99f9b9f90b9099a999e9e99f9a000a00ada090a0a0b0a0e0e000000000000000000000a00b909000000a0da9a000000000000000000000a09fffb9fdfdbffffffffffffffffffffffffffffffffffffff9ff9fff9ffffffffffffffffffbc9d0f990909090d9bc9dadbd9bc90000009e0a0a0ad000c0900909a000000000000000a00000af0a00000a00dac0d0000000000000a0a000a000cff9d9fbfbf9ffffffffffffffffffffffffffffffffbdfb9f9bdbf9ffffbfffffffffffbdbd9b0b90c90d0bc90bc99ad9d0bc9a9a0ca0e000000dab0a9acadaca00a0000000000000000a0a0a909a00000a0a9a0b000a000000000000a00000fff9bddffdfffffff9ffffffffffffffffffffffffffffbdbcbdbc9f9f9fdffffffffffffbdb0d9d0b909bd99bd99ad90b0bdb0d00b0ca00a000a00cbcadada9000000000000a0000a0000000da0000000000000000a0000a000000000000a00cfff9af9ffffffbfff0fffffffffffffffffffffffbdb9dbdb909b90f9fbffbdbffffffffdbdb009009f099e9cbd09a99c909db0f00a0cb000a00a0000cacaca0a00000000000000000a000a0a90090000000a00a00000a000000a0a0000a000fffb9d9f9bdfffbdb09dffffffffffffffffffffffffffbf9f9f9c9b909c9fdfffffffffbff9099a99099f099b90bd9cb09f090d0f0cfaca0000000a0a0a0a00000a0000000a0000000000000f00a000000000000000a00000000000ca9a00cffff9d9b9dffbdb9e90feffffffffffffffffffbfff9ff9f9fdb9f9bd0999b9fbfdffffffdf909f0c9ed9f0f9e9cbd90b0db09e90b0a0a000a00000000000000a0000000000a0000000000000a0f090a0000000a0a0a000a000000a0a000c9cbffffbb9cb9f9ffdf9b09fffffffffffffffffffff9ffbfffffbff9f99b9f09cbdbffffffffbf90099990e990909900090900d09e9c00000a000000a00a00a00000a0a0000a00000a0a0a00a000b0a000000000000000a0000000a0000a0a0a0cf9fffdb990f09fbf0900dffffffffffffffffffffffffffffdf9e9cbc9099dbdbdfffffff9f9f9000a990000000090000090b00909a0a00000a00000000000a000000a0000000a0000000000a0e900000000a0a0a0a000a00a0000a00000000fbfffff9f9999f9f9909cfffffffffffffffffff9fffffdfffff9f9f9b9f9a99e9f9ffffffffa90090d00000000000000c90909f9000000000000a0a00000000000000000000a00000a0a0a0000b000a000000000000a0a00a0000000a00a0dfbddffffff990fff9ca90adfffffffffffffffbf9ffff9ffbdb9909090d0909cb9f9ffffffff9d9090000000900000c090b00f0d0000000a000a0a000000000a00a0000a00a000000a0000000a00a0000000000000a0a000a000a0a0000000a0edbffffffffb9090b9900dbfffffffffffffbf9ffb999b0090000000009009090d0ffffffff9fb090090900000000909e909090b9b0000000a00000a0a000000e90e0a00000000a000a0a0a00000da0000000000a0000a0e0f00000000000000ffdffffffbf9e990000900dfffffffffffffdff9fdbe9dbd0900000000090b090b99fdffffff9f9e900009e909adbcb9090090d0c090000000a0a000000000000a000ca0000000000000000a0000a00000000000000a000000a0a00000000000e9f9ffffb090900909000d0fffffffffffffbffffbd9fbdbfbd0900b00bc909099cfbffffffff99909090009cbc90900909bcb09b900000000000a0a00000a0a0c0a0a00a0a0000a00a0a0000a0000000000000000000a0a0a0000000000000adf9fdbfb0d09009000009affffffffffffffff9f9ffb9cffdfffb9d0d9090909e9fbdfbfffdb0f0f9a90090009090909cac00909c00000000a00a0000000000c00a0000000000a00000000a0000af00000000000000000000000000000000000fbdfffd99000900000000cdffffffffffffffffffff9f999f99fdfb9a909090f9dbdbfdf9fbfdb90d90090909009acb0999990da0900000000a000a0000a0000a000000a0000000000a0a00a0a00a000000000000000000a00000000000000000fb9dbf099900009000009affffffffffffffffff9ffbf9a9f0b09c990090f99bf9e9fbff9f99ff9adb90009090990dbcbcadb0900900000000a0000a00000a00a0a0a000a0a000a0000000000a0f00000000000000000000000000000000000f9dbf999e009a90000909adffffffffffffffffffff9fffdf9f9f9b09dbcb9ad09f9f9f9ff0ff09f990da90000000909909900900000000000000a000000a0000c000000000000000a0a0a000000000000000000000a00000000000000000000e9bd9c9e99f9900000000cdffffffffffffffffdfffffdbfbf9f9fdbda9990d09f0b0f9ff9ff9ff9f0f990900000000000000900009000000000000a00a000aca0a0a00a000000000000000a00a0a00000000000000000000000000000000000df9e9bdbdf9e9900000009affffffffffffffffbfbdffffdfdfbda909000090f90d9dbc9fff9ff9e9f9f0dad0000000000000000cb0000000000000000000000000000000a0a0a00a00a0a00a0cab00000a0000000000000000000000a0000000e9990dfbf990009000000d9ffffffffffffffffdfadbdfbb090090009090da9e90f0fbf9fdfbdf9fdadb09099a90000000000090990000000000000000a0a0a0a0a000000000000000000000000ca00000000000000000000000000000000000fbdeffbd90090000000000ffffffffffffffffff9dbda9d090090090000009d9ff9fdfdffbfdfbffbdbfdbdad09c900009000c09c0000000000000000a00000000000a0000a0a000a0a00a0a0a0a0000000000000000a00000000000000000000999990909000000000090fcfffffffffffffffffb909009e09c0f0bc9e9fffff9ffffbfdfdbfdfbdbd0bf0f9fdb0d0f9e0909b0a900000000000000000000000b00000a0a0000000000a0000009e00a000000000a000000000000000000000000000090000000000000009ffffffffffffffffffffdf9f99dbbd9fdbdbdf9f9ffdfffdbfbffbfdffffffdbdf0bc9a9009d0f00c90000000000000000000a00a000a000000a0a0a000a000a0a00a90000a0a000a000000000000000a00000000000000000000000000000009ffffffffffffffffffffffffffdffffffffffffffbff9ffffffdffbfdf9f9fdadf9bd99f90b009090900000000000000000000000a000a9a00000000a00a0000000ea0a0000000a0000a0a000000000000009000000000000000000090000000dbffffffffffffffffffffffffffffffffffffffdffffffdfdbffdffbfffffbdb9c9a9e90c9090000000000000000000000000a00000a0000a0a0a0000000a0a000b0000a0000a000a000000000000a000000000000000000000000000000909fffffffffffffffffffffffffffffffffffffffffffffffbfffffffdff9fdbdbd09bd0900b090009000000000000000000000000a0a0000a00000000000a00000a0e00a00a0a000000000000000a0000000000000000000000000000000000000ffffffffffffffffffffffffffffffffffffffffffffdff9ffdffffffffbdb09f09090909000b000900000000000000000000a0009a0a000a0a0a0000000a000009a00000000a0a00a0a00000000b00000000900000000000000000000000009cbdfffffffffffffffffffffffffffffffffffffffffffffffbffbff9fff9db09909a0c90900090000000000000000000000000a00000a00000000a00000000000e000a00a0a00000000000000a00000000000000000000000000000000000909fffffffffffffffffffffffffffffffffffffffffdfbfff9ffdfdffff99b0909e909db9000900900000000000000000000000a00a0a000a0a0a00000a00000000b00000000000a000000a0a0000000000000009000000000000000000000000bcffffffffffffffffffffffffffffffffffffffffffffdfffffbffdfb9f0d9f990da900090c0900900000000000000000000000000000a000000a0000000000000a0000a0a0a000a0a000009a0b000000000000000000000000000000000090d9ffffffffffffffffffffffffffffffffffffffffffffbfffdfffbf9d099b09a909d099009a900000000000000000000000000a00a0a00a00a0000a00000a00a0f000a0000000000000aca000000000000000000000000000000000000090c90ad9fffffffffffffffffffffffffffffffffffffffffffdffbffdffbb900090d09a99e90009009000000000000000000000000000000a00a000a00000a00000000a000000000a0000000090a0a00000000d000900000000000000000000009a9dbeffffffffffffffffffffffffffffffffffffffffdbffbfdffbf9d90db9db90bc9a90090909000000000000000000000000a0a00a000a000a0000a0000000e0f0000a0a0a00000a000a0a0900000009000900000000900000000000900909da9dffffffffffffffffffffffffffffffffffffffbffffdfffbfdf9a0db9cb900d9909090000000000000000000000000000000000000a00a0000a000000a0a90ab00000000000a000a00000a09009000090000009000000000000000009e9e9debfffffffffffffffffffffffffffffffffffffffffffff9fdffb99dbc9bda9990a90000909000000000000000000000000000a00a0a0a0000000000a000000aca0a000000000000000a0a00a00000000000909000000000000000000c0909a99dadfffffffffffffffffffffffffffffffffffffffffffffbdbf00bdbf09900f99090900009000000000000000000000000a000000c000a00a00a0000000a00b0000a0a0a00a00a00000000000000000090000000000000000000900900f0d9efdfffffffffffffffffffffffffffffffffffffffdff9ffffff99d9f09f9cb909ad0909090000000000000000000000000000a0000a0ae9000000ca00a00000a000000000000000000b0a0a00009000000000000000009000000000dad9090fbdbffffffffffffffffffffffffffffffffffffffffbfffbdbf99e9e99f9a990f09090000000000000000000000000000000a00000e0cf000a09e0b00000a00af0000000000000000a000900090000000000000900000000090000000900b0f0dedfffffffffffffffffffffffffffffffffffffffffffdfff9f099bda9c90909009a09090000000000000000000000000090a00a00be0fa0c0e0e09a00000000a00000000000a0a00a00a00a00000000090090000000000000000000b09c90f9fbdfffffffffffffffffffffffffffffffffffffffffbfbdff9b0d0bdb9bda9099090000000000000000000000000000000c0f000000e0da9acbca00a000000f0000a00a00000000a00a00a00900000090000000000000000900000d09a90d0fdfffffffffffffffffffffffffffffffffffffffffffdfffbdf9c9f909c909c9ac909090000000000000000000000000000aca0a0a0f0ea000a0a9a000a0a00a00000000000a00a000a09a09000900000009000900000000000000000c000fbcffffffffffffffffffffffffffffffffffffffffffdbffdbdfb0b9adbdb9b909090000000000000000000000000000000cacbe090c00a9000a0000000a0000a900a000000000000a0000aca00000090009000000000000000000090090909c9f0ffffffffffffffffffffffffffffffffffffffffffffbfffbd90d909090da90900909000000000000000000000000000a9e0fce0b0aca0a00000a0a0000a00ea000a0a0a000a0000000090a90000090c00000000000000000090000000cb0dfffffffffffffffffffffffffffffffffffffffffffffdfdbdfbf9adbcb9909cb09000000000000000000000000000000000a0a9aecb000c00a000000a000000b0000000000000000000a0a000000000090900000000000000000000000900dafdffffffffffffffffffffffffffffffffffffffffbffffbfbdf9f90999ca9099090900000000000000000000000000000a090cee9a00a0a0a000a0a090a090a000a0a0000000000000000000000000000000000000900000000000009000dafdaffffffffffffffffffffffffffffffffffffffffffdbfdfdf0f90dbc909da90000000900000000000000000000000000c0acaa9a0a00ac00000000c0a90a00e000000a000a000000000000a00000000000000900000000009009090000009dfffffffffffffffffffffffffffffffffffffffffdffffffbf9fbdb909a900900900000000000000000000000000000ca0a000000000a00a9a09a00a9e9a00a0b00000000000000000000a0000000000000900000000000000000000009090cadfffffffffffffffffffffffffffffffffffffffffbfbdbdfbfdbdf0f909b00900090000000000000000000000000000ce9a00bca0a00a0c0ca00000a0e9e900ca0000000a0000000a00000000000000090000000000000000009000900000bdafffffffffffffffffffffffffffffffffffffffbffdffffbd9bdb09909c090009000000090000000000000000000009a0ac0a000000a00a0acaca900eda9a0aa000a00e090a0000000a000a00000000000000000000000900000090000090d0fdfffffffffffffffffffffffffffffffffffffffffff9fbdfaf0f9f0b0090090000000000000000000000000000000a0c09a0a0a90a00a0ad0b000acb0a0090b0000000aa000a000000000000000000009000000000000000000000090000adffffffffffffffffffffffffffffffffffffffbdfff9fffdb9d99909d90909009000000000000900000000000000000ca0e000000a00a00000ac9a090e9c9a0aca0000a000e9000000000000a0090000000900000000000000900000000900909edffffffffffffffffffffffffffffffffffffff9ffbdbfffbff9f090b00000000000090090000009000000000000900b0a90a000a90a0a000ac0a000a00090b0000000ac0a000000000a00000a0000090c090909000000000000000000090debffffffffffffffffffffffffffffffffffffffffff9ff9e9f09a99ad09009000090090000000000000000000000900e0c00a00e0ca000000a00b00e0e9a0a000a0000ac0a00a000a00900a000090000000bc90c000909000000000090a90adbdfffffffffffffffffffffffffffffffffbffffbdbdff9f9f9dbd9090909000900000000000000000000000000000ac90a9ac0b00a000a00a09ac0adada0000e000a0000a9a000a900a0a900000000000090900909000000000000000909c90dffffffffffffffffffffffffffffffffffdffdffffbdbf9f9a909cb0900009000000000900900000000000000009c9a0e0000acae09a00009ca00acaca0e9a0b00000a00c00a0c0a00000a0a0000900000000000000000000000000000c0090bc9fffffffffffffffffffffffffffffffffffbf9fbdbdbe9f9f9b090090900000000090000000900000000000000000009a000009e00e09a00cac0e0bcb0000e0a0a00ca0a000a000a0a0000000000000c09000000900000000000090090b0c9fffdbffffffffffffffffffffffffffffffffffffdbcbd99090909009000009090009c0900000000000000000090b0a0a000b0e0e0b000a0ca90b0a9ca00acba00c000a00000000a0000000000000000090ca90000009000000000000000c0b9e9ffffffffffffffffffffffffffbfffffff9fdb0bdb909a9090090900090000000000b009090000000000000000000000a0000b0000fad0b0cac00ca0a0ca09e0ada000a9a0a00000000a00a90000900009000000000000000000000009090c9f9ffdfffffffffffffffffffffffffff9fffbf9f9090909000090000900909000909000da9cb0000000000009c900a0a0c0a0e00b0e0ca00e00ada0000a90aa900a00ac000000a000a0000000909000000090909000000000000000090000090dbdbfffffffffffffffffffffffffdbffbdbd9f9f90b00090900090000000009000090009009009000000000000a00c0a9ac00e0000fadae0ed0ada9a90a00e0a000a00a0a00a00b00000000ca00000000000000090000000000000000000900bcbdf9fbfdffffffffffffffbfbdfbfdadbcfa9909d09900000900000090909000000000000009000000000090b00e0fcacb0f0f0be00e09a0aecaac0caca0b000a00000000000e00000000a099e90090000000000000000000000000d0090a9c9bcbfffffffffffffffffffdfffbfdbf9f999dad9a900090000000909000000000900900900009000000090e90ce0fa0a90e0e0e00ce90e00edadc0ea0900e0000000a00000a000a00000090c09e9000000090c900900000000000000900c90bc9f0d9f9f9fbffffbffbdfbf9f9f9bd9f0bcb09b090090000000000000900000000000000000009000090090a0a9eededea9e0f0e9a0e00ac0acaae90e0a09a0000a000000000a000000000a9ec90f00090000000000000000000000000000090099ad0fbfdf9f0fdb9fb0dbf9e9f9b099990900909009000000000090000000090090900000000900000009c00e0aeba9ca9e0f0e0b0a9cacaccdaec0ac0e0000000000000000000000a000009e900d000900900000000000000090090909c0bd0ad0bd09a9e9f9bcb9cb9099990009000000900000000000000000000000000000000000000000090090b09ac0fcbccef0ca0e00e00ca00acaaac0abc0a9a000000000000a000000a900a0a9e900f909000000900000000000000000000009000909009ad9909009009009000000900900900090090000090000000000000900009000000000900000a9c0e09a0aceaf0aadedaf000ac0eccacc0e0c0aca000000000000000000000009000000909e90d0090009000000000090000000090090900009090009009090090090009000000000000000000000000000000009000090000000000000909c9cbcbca0ecbcf0e9cacac0a0f00e0bac0ae0e0e00f0a00000000000000a00000a0000a090009e9a9a090000000000000000000000000000090000090009000000000009000000000000000000000000000000009000090e9000900000009000b09cacb090acaefeadebebca00e0eccae0c9a0a0e0a0000000000000000000a0b09a0000a09c090d0d9ca909000000000000000000009009000900900900009090090000000000000000000000000000000000000000900909a9ca00900ca90d0dadebca0e9eede9eace00e9ce0e0a0c0ea0c0c000a000000000000000000000000000000000b0da9a009c00090000000000000000000000000000000000900000000000000000000000000000000000000000000090009000009090009090b09a0e00f0d0e0fafefdeb0f00e0adace0ac0ca0a0a0f00000000000000000a0900a00a00a0e90da0d0d9f09ad000900000000000000000000090090009000000000000000090000000000000000000000000009009009cb000090090d090b0d090c09efaeae0eceedaebce00e0acaca0e00a00000000a00000000000000a000a00000009000a00db0f0090c9a900c09000000000000090000000000900090090000000000000000000900000000000009000000000900909090000009ad090b0e9a000edadaf0efaffcebcacade0cacacbc0aca0000f000000000000000000a0000000a0a0a9cb00d0db0f90c0da900090900000000000090000000000000000000000000000000000000900000000000000000090c9a0000000000b090b0d0d0000eedafecaebcfeeffe9e0ca0ecac0ac0ac000a000000000000000000000000000a0000000a00dbcbcd0009b090009a0000000000000000000000000900900000000000000900000000009009000000000900f0090909000000b090e9c9a9a90adadaee0f0ecefeffacac0e0eca0e0e0e0a0a0000a00000000000000a00000a000000a00a0000009cb0f9d0c909c90d9000000900009000000900900000000000000900900000900000000000909000000009009a90000000d09c099a90d00a00acace9eacfafeffeffa9e0e0a0da00000c0000009a0000000000000000000000000000000a9a0e9ad90e9b0f090da0da09000000000900000000000909c0090090c000009c00009000900900000000000d0090d0900090b00009bc0dadad00000e0f0e0e0ecafeffefca0e0e9e0caca0a0a00a00e00000000000000000a00000000000000000090dadb9e0d0dafa9da99000000009000900000000900090900000009c9000b0000090000000000090900a090b000090c0090b9009b090e0a0ca09e0e0e9e0efeffefe9e00e0e00a0000c0000000000000000000000000000000000000000a0a0acad09c9db0f9c9da9d000900009009000000090c00c909a0090909000090009a09c000009090900000909ad0900b00090000cb9f09cf009e90ceacaf0e0fecffefe9e00e0000e00a00a00ac0a0b000000000000000a00000000000000a000000090bcb0f0d9e9b09cbcb00900000f090090000009a90a0d0900000a09c090d090009009000000000000d09000900090090db9c909ca0f0e0e0b0cbc0e0e0feeffffebca0a0e0000c0000000000e000a00000000a000a0a000a0000000000a0b0a0009c90f090c9e90090d000000009c90c0900900009c909e9090d090900000c9000000009000090090b0090009090900b0dbb0bc9cacada9e0e0eacadacadefeffedac0c00a0a00a00a00a000b0a0000000000000000000000000000000000000e0b0f90f0f9090c9cb090900d09a9a90900000900c0b0090f0909e9e9d0b090a90900900090900f090db090f000a09f0f0d0d090acbcace0f0f0cbcacaeefeffeda0a0a000000000a00c00a0a000000a0000a00a00a00a0000000000a0ada0b0900d00f9f9cbcb9a909ac009a0c9c900090090009090c9cf0d0ad0909a0090c90ca000009e9e0909f090009009c9db099b09a9a09e0e0e9e0e0eac0e0edeffeffead0c00ac00e00c000a00c0f0000a000a00000000000000000000000000000a0eb0bd0c9a909d0d09c90900090b0f9b0090c090000909a99ad9090f099d0a9009090f0d0909f9f00b0090009a90bc9e9cb090cac0acbcacbcad0eacbcafeffefbc0a0a000a000a0ac00a0a00a0a0000000a0a0000a0a0b0a00a0a0000a0a0a000c9cb9bcde9e0b0da9cb09c9ad0d0c9d0a990090900f0d0e90f0f090e0090090090090bcbd090990090a9090dbd0b90f9cbcb09acf0eacacacac00e0acafeffefef0c0ca000a0000a00c000f00000a0a0a00000a000000000000000a00000d0f0b0a0d0b99f99c9ad0a90cb0d09a9bcbbd00b0c9e9f09a909e909dad99009000900b9c990b9e9a0d909d0fbdb0a9d0f9e0da0caca0e0cbcadacada0acedeffeff00a0a000e00ca0000a000aa000a000900000a00000a00a00a00000000bca0a0ac00f0bdade9e9ad9a9d090d0b00dcb9c90f0d9e90090d09e9dbda9900ad090f009c0b9ad9c9addbadb0f9c90d9f0bcbcbac9ead0ecbaca0e0a0a0c0caeffeffe9e0c00a000a000ca000a009a00000a000a000000a00a00000000a00a000da9000b00e9adb9fbd9a0d00bcb090d0b0cf9ad99a09f9bc900090a0bde9f990f090db09bcbda0bd99ad90db90b0f0f0f90da0dae0caf0accaca00d0ca0a0cfefffebe0a0e0c0a0000a000a0c00e00000000a000a00a00090000000000000acac0e9a0ca900f0e9c9bc990f909dada09c9b0f9ac9df09c9adb09c99c099a9e990da90dbc99c9d90bcb9adb0da9db9f9f0fa0fe0caf0cac0a000da0a00000a0efefffedac00a000ca0000ac000a09a0000000000000a00a0a0a000000a00a9009a90000000a00090b0cb0e900c0e909ca90c90d99e90f0bd9adbc9a090009c9000b9cbbc9bcb0bcbdb0d9bcb99cb0e9e0f09e00faccaac0bcaca00000a00c0e9effeffada0e00a0a00e00000a000a0000a00a0a0a00000000000000a090a0000a0a0a0a0a0009a0a00b0d99cb909c9e99009ada9e9e909d0ad9c9b0d09e900b0909009c9bcb9df9bcbdbedbdbcb0adacbc9eb0eac0a0d0ac09000aca000a0acefefffacac000ac000000ca0ac0a0e00000000c0000a000a000000000ca0900a0000090000a0a000000000ca90ad0b09a0d0c909c909c90ad9b0b9c90b00dbd09a9cb00b0f90fa9edbda99a9a9a9ada0f0bac0e9c0bc0ae0a0a0e00000ac00cbeffffeff0aca0000e0a0a000000009a0000a0a9a00000a000a0e9000000e0a000000a0a0000000a000a00a90c900d0d0d09a909a9cb09e900c09ca909090009ad9009d00d0fd9f9bcb9db0db0da0f0f0adcbaf0e0e0ac009c00000a00c00a00ceefeffe9e900e0a000c00a0a00a00e00a00c90000a00000000000a00a0b090000a000000a00a0a00a00000ca90c9a9a90bc90f0d0bd0f90f9b9090dad0090dadb0990b9dbf9af0f9bda9ada0fa9f0b0f9abc0cada00cb0e0a0a0a000a0a000acaffffefe0ca00000a0a000c0ca0ce90000a0a00a00000000000b000000c0a00a000a0a00000000000000a0a909a90dc9c00bc990ad0bd0f90c0f0da90ade9099cbfcbc9e9cbd9fdada90f0bdb0fa9eda0ec0eaca0f0a0000000c00e000000e0efffeffeb0aca0aca0000a0a0a0fe0a9000090a0000a000000a00a000a9a000000000000a00a0a90a00000d0ce09c9a9a90900cadd9edad0f9bd0f0de9d09e9ca9c9bdbf9ff9ef0bdb9eb0bcbebcbe9acf0ae09ac0ac0aca0e0a0a000a0ca000ceefffffce00c0000c0ac0c0ece0feea0a0a0000000000000000000000009a0000000000000090e00a00a0a0a9e0ad0e90f090900adbcbfbdadad9f0da9f0f9fdb0f0f09e9bf99fdacb9e9eb0bcbcada0ec90e00bc0b00000000000a00a00a0a0feffefcbda0a0a00a00acae9efeefb000900a00a0000a00000b0a00000a000a00a00a000000ac0bc90a0000f0ad0a090f0dadcff90dbc9cad9f9e9fbdf0bcf0bcf990df9f090f0adbe0ba0fada09e0cb0aac9ac0a0c0a0a00aca0000c0000c0eefffffbeacac0c0a0cacacfefefffc00a0a0000000a000a00a00000a0a0000000000000000ac0be0a00000a00f0a900e0cbcba909e9e90b99a9ebdbc9a9dbdbdf99adb9a909e9adb00b0db090a9e0eb0e9c0a00a000a0000e0000ca0a00a00acfefeffef0900a0acebcfeffeffffebe000000000a0000000000000000090a009000000a0a009ac090a00a00a0000ca009a0b0d0f0909b90dadb9dadbf9cbcbcb9ffdbcbdada9adacebcbacb0ada0b0cb00a90e00da00c0a00000a0000a0ca0caeffffff00e0e0ecbceefefefefeff0b0b0a00a0000a0a0da0a000000000000a0a000000000000b0a000009000a0b009a0000a000a0e00c90900909e9cbf9bdbda09efbcb0fbcb09a9cbc9a0f00f0cb0cb00e00b000a0a00a00a00a000c0000acfefffeffe0e9e9eeffeffffffffefbc000000000a00900a0000a000000a00900000a00090a0a0c000a0bca00b0000a000a0000b09090b0a0009e0b09b09e9e9a9fa9adbcfbcbcbe9efebe9ebffbfbffbe9a90ac0a0c0000c0ac00c0a0a0a00cbcffffffacbceeeffefffefeffefffe0a0a0a00a0000a0bc0b0000000a000ca0000000a0a00c00a0a9c0000cac0cb0000000a0a000a0a0090a9a09c0e00f0b0bcb09bcbefbfbfbf9efadadbffffffffffb9a0a00a000a0a0a000a0a000000ca0eefeffefefeeffffefefeffffeffefb00090000000a0000a000000000000b000a000000000b0a09000a0a0a09a9a0e9a00000090a090000a00000a0b0bcadadabcbacbfbffffffbfbdfefefffffffffffff90ca90ca000c000a0000a0ac0a00e0fffeffffeffefeffffffffeffffffcb0a0a9a00a00000000a0a00a00a0000b009a0000000009a0a0000d0dac0e900009a09a00090a00b00a0a090e0f0b0b0bcb009adfffffffffffafcbfffffffffffffbfa90a000b0a0a0c00e00c00a000e0eeffffffefeffffeffeffefffefefff0a000000b00a0a00a9000000000caca00a000a00a0a0000000a0a0aa0b000e9a0000000a0a09000009090e09a0adaf0fb0b9ebaffffffffffffffeffffffffffffff9a0ac0b0c00000a0a00a0a000e0bcefefffffffffeffffeffefffefffeba009a000a0000000000a000a0000a0b0cada000000900a000b0090c9c90a9a9000a00a090090a0000a0e0a90ac9f0f0bbcbdabdffbffffffbffffaffffffffffffffba9c90a00a00a0a00c0a000c0e0eceffffffefefefffeffffffffebfacbcf0a000a0000a0000a0000a0000a0d0ca900da0000000000a000aca0a0a0000a0a90090a0bca00a0a000090a909a0b0be9bebdafbfffffbffffbfef0f9fbffffffffff9a0a00e00a00c000a00cacaf0fefffeffffffffffefffefefefafccfacaa900a000a0000a0000b00000a000a0900a000b000a0a000000a0900000b00000c0a00000009e090000b0ad0a0a9cad0be9fbff9e9fbfbfbfbffffffafbfbffffffffbe900e90a00e0a0e00e0acbceeffefffffffffffefffeffffefadaba0000f0a0000000a000000000000b000a00a0a90a000a0000000a0a9ca0b0b000a0a00a00a00b0a009a0a0a0cb0a9000a9abdbfffbfbfbfbffffbfbffefecbcbfffffffffb9a0b0a00da000000e9ecfefffefffefffffffefffefffeaf0bcac0c0e0aa0000a0a0000000a0a00a0000000000000009009000a0b00000a000000a00900a90909000900a000900b09000a900fdafbfbfbffffffbfbffffeff0bfbffffffffffbcb0c00ca0090e9ee9eefefefeffefffefffffffbeffecaf00e000a0a00cf00a0000a000a00000000aca0b00a000000a00a0000000a9a0a9a9a0a000aca900a0a0a0a0a90a9a0a000a9a900b9abfffffffbffbfbfbfbfbfffefdaffbffffffffa900a0a90ae0e0e0fefffffffffffeffffffffefefacabc0ea0e0ac0caca0b000a0000a0000009000090000000a00a0000009a000000000000000a90000e00000009000a0000090a0900e9e0e9fbffbfbffbfffffffffffffbebf0ffffffffffbf0b0d0ac90e9effefefeffeffeffffffffffffef0fac0a00c00c0acacacf0a0a0a0a00000a0a0a0a0a0a0a0a0000000a0a0a000a0a0a0a0a0a0b0a0b0b0b0b0b0b0a9a0b0a9a0a90a0f9bb9bffffffffffffbfbfbfbfbffeffcbfbffffffffff0b0e0adaeefefeffffffffffeffefefffffffe9ee0e0e0e0a0e0e0e0ecaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000a9fbffffffffffffffffffffffffffffffebfbffffffffffb9acbcfefffffffffffffffffffffffffffffffee0e0e0e0e0e0e0e0e0a000000000000000000000010500000000000070ad05fe, N'Robert King served in the Peace Corps and traveled extensively before completing his degree in English at the University of Michigan in 1992, the year he joined the company.  After completing a course entitled "Selling in Europe," he was transferred to the London office in March 1993.', 5, N'http://accweb/emmployees/davolio.bmp', 'king@northwind.com', '343454356' ), 
( N'Callahan', N'Laura', N'Inside Sales Coordinator', N'Ms.', N'1958-01-09T00:00:00', N'1994-03-05T00:00:00', N'4726 - 11th Ave. N.E.', N'Seattle', N'WA', N'98105', N'USA', N'(206) 555-1189', N'2344', 0x151c2f00020000000d000e0014002100ffffffff4269746d617020496d616765005061696e742e506963747572650001050000020000000700000050427275736800000000000000000020540000424d16540000000000007600000028000000c0000000df0000000100040000000000a0530000ce0e0000d80e0000000000000000000000000000000080000080000000808000800000008000800080800000c0c0c000808080000000ff0000ff000000ffff00ff000000ff00ff00ffff0000ffffff00f00900000000000009090fb0000900000090000000909bfbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd0009c90c0f9e9be000090009000d09009009000000000000000b0900000000900000ff009cd00000009000090900000dfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0b0d0900909e9fc9000900900fbfa90000000090000909000000d00b0000000000009000009b00000000090900000909bfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd0900b00009e9e09000900f9dffff090009000090000090090b09090000000000009f00000f0000009000009000000bffffffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe9ac90009009090c9000099e00d0fffe900000000090009000f000000000000000009e90090f00000090090900009c9bfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00900000000900900009f00090909ed009090900000090090000090000000000009e0009f0000000000000909e90ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbfbffffffffffff90d00909090909000900bc90900009bda90000000000beffe00000000000000000090f09a0009000090000900090bffffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbfffcbbf00000000000090009fe00000000ffc000900909dfbd0b0000000000000000000099ed00009000090009f00009bfbfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbffc9f000000909000000099e00000090b0090090000bfc00d00000000909a00000000009000000000000900bf009adfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdffbfffffffffff9e9ff90000009090090009bd0b0909c900000090900900b00000000000900000000000009000090000000900009bfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbfffffbfffffffff09f0009000900000000000fbc9000a00909000009f000f0000000090000900000000000000000000900009f009efbfffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdbffefffff0f009000000900000000090dafdbd0900009009fe000900000000009000900000000000000000000009090fc9bfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbffbdfbfffffbfffffff0000000000000000009000090000000000000090000f000000000000000900000000000000000000000090009ffbfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdffffffbffffffffffff090909090090000000000009000900090000000000b0090000000009000a0000000000000000f00009000900bfffffffbfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbffffbffbfdfffdfbffbffff00000000000000009090090000900000009bf00990f00000000090000909000000000000000900f9e0009009fdffffbffffffffffffffffffffffffffffffffffffbffffffffffffffffffffffffffffffffffffffffbfcbdffbdbfffdfffbffc000900900000000000000000900090009cfc9ff0eb09090000000900000000000000000009009009a000009bfbfbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffbfffebffffdfffffd0009009090dbdb00000000000000090fbffadad0f90009a00900009090900000000000000f00090d9000000fdffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbffffbfffbfdff9fffdbfbfffef9eb00000000f0fadfbcbc90000090000bcffcf0f00f0090090900909000000000000000000090000000009009bffbfbfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbdffbffffffffffffbfbffd000900099a9df0ffffbcf000000090bd0b09000b09a90900090a090900000000000000009e00009000009affbffffffffffffffffffffffffffffffffffffffbffffffffffffffffffffffffffffffffffdafffffffffff9fbdbfbdfbdfdfbcba000099fedfe09f0d0ffbc00000900d0a9c0000f0bda09a9000900009000000000000000099e000b0090099fdfdfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff9afdbffbdbfeffffcfbdfafbcffdfd00000fff0f9c009e09cbc00009e9afd000000f900d009c09009000090900900000000000090000000000bfbfbfbffffffffffdfffffffffbffffffffffffffffffffffffffffffffffffffffffffffffbffdbef9ffef9f9f9fbdfadf9fbdbebfe909009bd009b0f9fe9f0900009c900000000b09f0090b900000900000000000000000000090990000009ffffffffffffffbffbfffffff9ffffffffffffffffffffffffffffffffffffffffbffbffffbff9f099eb9f9fbcbe9fabdbfeffeffdfbc00090fe9afef9e09f000000000000000000f0900b09000090000009090000009000000000000000009ff9fbfffdfbffbdfcbfffbfff0fffffffffffffffbfffffffffffffffffffffffffffffffbffeffffbe90fdfadbf9f9fdfcbfdbf9fbfff00000090dbdffed00000000000000000000b0b909f090b000000000000000000a90000000000009000bfffdbffbfdbdfbfbfdbfffffbffffffffffffffffffffffffffffffffffffffbffffffbffdfbdbe9f9f9b0bdff0fbefafbdbfdfffffeff0009000000909090090000000000000000f9cb00bfc90900900000909009009c0900000000000000099faff9ff0fab0f9fbef9fffdbfffffffffffffffffbfffffffffffffffffffffffffbffdfbffffffffefcb0b9fbdf9fdbffebfafffbdbff000900090000000000000000000009000f09099e90b00900000000000900909ada900000000000090bfdb9e90b9d9f9adbdbfffbbfffffffffffffffffffffffffffffffffffbfffffffbffffbffbff9fadbdbdbcbcfbafbbe9f9ffdfbcffffff90000000000000000000000000000000b0a9e099e9c090b090000090009000900000000000000000909bc99bcdbebffffffffadffffffffffffffffffbfffbfffffffffffffffbfffbffcfbffffdfbffdbfffaf90b9ffdffdffffbfffffffbdac0000000000000000000000000000000f9090b0090b0009a000000009000c000900000000000000000009ae9bbf9fdbfbfbfffbffffffffffffffffffffffffffffffffbffbffdfffdffbdfbdbfafdebffbcbdebd9e9fbcbfbfadffbfffbfeff909f0000000000000000000000000090fc909c900909000909009090000b9090c0900000000000000000999e9cbfafdfdffffdbffffffffffffffffffffbff9fffbfffffffffbff0ffbffbfffedfbfdfadfbdbdbef9f0fff0fdffbfcfbdedbdaf009f9f9000000000000000000000000fb09a90a90000900900900009090000a9000000000000000000000b9fbdbdbfbfbffdbffffffffffffffffffbffffffffffffffffbdfefbffbdfadf9fbfbdfbfdbedafbcbdafbf9fffbf9edbfffbffff9f000000090000000000000000000000b0f0900900b0900000b009090b00090900000090000000000900099cbcbdbfadffffbffffffffffffffffffffffdfbfbf9fdfbffffff9fff9ffbdfbeff9febe9be9bf9cbfbf9f0fadbcbffbfff0ff0f9e0000000000000000000000000000090f09f0a90090000090909e0000000000000900000000000000000000b9bdaf9ffbfbffffffffffffffffffffffffbffdffffbffdbdfbff9fbff0ffbdbdbe9fdffdbff0fbf9e9edbdbfffdbdfe9ffdbfbc9fa00000000000000000000000000000f90bd9e9009000000000909090909000900000009000000000000090e9bdbf9fffdf9fbfffffffffffffffffffffbffbdffffbffbfcbffdf0ff9efadbdbfbb9af9adbcbcbdbbebf09bfafbdbf0fad0fbc9d09000000000000000000000009000b090b0909a009000909009a0000000090009000000000000000000099adadafbdbfabffffffffffffffffffffbfdff9ffb9f9fffffbfdabffbdfb9fbebdadefdbedf0bdbfadf9f0f0f0fdeff9fbdbf09b0a90000000000000000000000000000f00b0da9090000000009000090090000000000000000009000000009adb9bdbcbedbdffffffffffffffffffffffffbffe9feff9ff9fdbffcbdaf9fe9f9e9fb9badb0bdadadbdaff9f9ffb9b0f9e9f0dbc0900000000000000000000000000000f09cb09ad0b00000000090900900000000009000000090009000000090f9e9fbdbf0bfbffffffffffffffffffffbfcf9ffdbdbf9ffbfe9fbfbf9eb9f0f9fadefdbcbcb9f9fabdb0faf0bdeff0f9e0b00b9000000000000000000000000000090be9009090909009000000009009009000000000000000e00009000009b0f9b0fbdbdbdffbffffffffffffffffffffbffbfffbcbe9fe9ff0dbcbdbde9fadb9b9bcb9dbcb0f9fdadbdb9f0a90f9adbc9f000000000000000000000000000000000f90b00f0b0c00900900900900900b09000000900000909000000000000dbc9f9cbf0bfbfffbffffffffffffffffdfffbfcbdfffdfb9fb9fbdbfada9f0dbcfcfcbdaa99adbe9adbcbcf099fbbcb099a0900000000000000000000000000000000b0f09b0909b09000000009000009000090000000009000000000900009ba9fadbf09ebdfbfffffffffffffffffffbf9fdbfebf9fbdff0ff9e9e9f9f0fb0f9b0bb0f9dadbc9bdbe9f9b9e009c90da009000000000000000000000000009000000f09bc09a900900900900009a000009b0000000900000909000090f00090da99abcb9bebdfffffffffffffffffbfffffebf9bdff0fbcbfdaf9f9f9adf09f9adbc9f09a9a9bada9da9e9e9900bcb00900000000000000000000000000000000900f009b09c0b00b0000009000090000009000000000000000090009000009bdad9dbc9d9fadfbfffffffffffffffffdbfdfcffadbfdfbdbf9fadb0f9a9f0bd9adbe9f0d0d09dada9f9b09acb090090000000000000000000000000000000000000f09a0f099090d0900000090900090090b00000090000000000000900000009a0b0b0bf9fbffffbfffffffffffffbfffbfbf9fbdbf0fbe9fbdbcbdadb0f0be9f09b0b0b0bda9bbcbc0f0d90009000000000000000000000000000000000900000b00d990b0009a000009090000900000000000000000000000000000000099b9f9f09adbfbdbfffffffffffffffffff0fdf0fbcbe9fbd9f0dadbdadb0f9bc9da9e9e9c9bda90d0990b909a0000000000000000000000000000000000000000000f09a0a090b00900000000909000000909000000090000000000000000000000909e9daf9fefbfffffffffffffffdbfffa9f0dbf9fbdbebfbf0f0b0db0d0b0b0f9a90b0009cb0f0a9c0b009000000000000000000000000000000000000090000fb09909e9c900900009000000000000009090000000000000000000000000900b090bdbe9bfffffffffffffffffff9ffdfbfbcbde9e9f9cf9f9f9fadb0f9e9f0d9f099f0b09909d0b00900000000000000000000000000000000000000000000f00009a90b0b000009009000900000000000000000000000000000000000000909a09ad9ff9fbfffffffffffffbefff0fadbcbda9bfbcbb9e9a9e99b0f09b90bab0bca09c9acb0a9090000000000000000000000000000000000000000000000f99e909da9000900000b0000009009009090009000000000000000000000000009090bdbe9ffffffffffffffffff9e9f9dbcb9ebdf0dbfde9f9f90f0dadbc0f0d0d00990a9090090000000000000000000000000000000900000000009090009be09a9a0dad900000900990000000000000900000900000000000000000000000000090b9fbffffffffffffffffffffbfadb0f9da9fad0b9f0da9f0b90b09b09b0b090ad909a9009000000000000000000000000000000000900000000009000f9f0909b09ab000000900a900000009000000000000000000000000000000000000090bcbcbfbffffffffffffffbdbdadfadf0b9f0dbf9e9fbada9f0f9cb0db0dad9a9000b000900000000000000000000000000000000090000000000000000f0b0f0000f9c900000090900900000000090900000000000000000000000000000000009b9fdfffffffffffffffefebdb0db0fad0ba90fdb0d9bf09b0b99e9ada90ad09b00090000000000000000000000000000000000000000000900090000b00f90b0b90b0000099ad0000000090900000000090000000000000000000000000000090ffbffffffffffffffdbdbdb0fb0f9d0f0d9f0b0dbad0dbcbc0e909090f9000009000000000000000000000000000000000000090900000000000000f909a9090cbc90000000b0909009000000090900000000000000000000000000000000009a9fffffffffffffffffbf09f0db0b0b9b0b0bdbad0b9a9b09b9bcbcb0000b0900900000000000000000000000000000000000000000000000900000fa9ada90b9a9a9000090000000000090900000000000000000000000000000000000000009fbffffffffffffffbde9fe9b0dbcb0f09c909c9bd0f9c9e9c90909c9b9900090000000000000000000000000000000000009090000000000090000f0009ada009c900b00009a90090009000000090900900000000000000000000000000000009fffffffffffffffffbf09bc9a990d09e9ada9a9a90b0b9a9ada9a9ac0009000000000000000000000000000000000000000000000009009000000b09bbd0909a9ac909000090000000009000090000000000000000000000000000000000009bfffffffffffffbebdbc9bc9ad0e9a9a909b09d0d0bcb9c9ad09c90909a90000000000000000000000000000000000000009000000900000000000f000cbfad00c9b090a0900000090009a000000900000000000000000000000000000000000bfffffffffffdfd9fadbf0b90b990d0d0bc0da0b0f09cb0f9a9a90f090000000000000000000000000000000000000000000000000000009090000f9a9090b0b0b00f099000000000090090900000090000000000000000000000000000000009ffffffffbd9a9e90d090d0bd0a9a90b099a99c909b090b0d09cb090a9090000000000000000000000000000000000000000000000000000000000f090b0bdbc90090bc009000000000090900000900090000000000000000000000000000009bffffff9fcbfdb9bdb9b0b9c0bd090b0da090a9a90c9ad90b0b09cb0d0000000000000000000000000000000000000000000000000000009000000b0af0d0bcb9a90bcb090090000000900a90000000000000000000000000000000000000000bffffdfbdbfcb9edb0fc99cb9900bc90909cb900da9b090f09c9a90900090000000000000000000000000000000000000000000000009090000090f9090b0f9bc900090f00000000090000909000000000000000000000000000000000000009fffffbfffdbfffb0fdb9fa90bcb909a90b0900db090c9e90f0bc90b00b000000000000000000000000000000000000000000000900000000000000fa90bcb0f0be909a9a9f000000000909000b00090900000000000000000000000000000000bfffffdffff9ffdfbfe99f9f090cb0da9cb09a09a9b090b09909a9c900900000000000000000000000000000000000000000000000000900000900f9e0909e9f99ad090da9090000000000090009000000000000000000000000000000000009bfffffbfbdfff9fbdf9fe9f09e9b090909090900d009a9c9acb0d0b090000000000000000000000000000000000000000000000000000000090000f09b00a99a9e9b0cb09e900000000000900090000000000000000000000000000000000009ffffffffffbdbffffbff9fa9f9bc9b0a9a90f09a90f090b90990b09000900000000000000000000000000000000000000000000000090000000009bac0909acbe9fcb90a90b09090000000009000909000000000000000000000000000000009fffffffffffffff9fedbfdff0f0bc0d90d0909090090f90cb0e9090e90000000000000000000000000000000000000000000000000000000090900f9b0ad09099a9bcb9c009ca00000000000090000009000000000000000000000000000000bffffffffffffdffff9fdaf9fbdf9b9a90b0a9e90b09000b09909e09009000000000000000000000000000000000000000000000000000000000090f0ad90a0b0adbcb0f9a90b90900000000090009000000000000000000000000000000000bffffffffffffffbffbffbfdbfda9e9e90f09d0900d00b09090a0909b09a000000000000000000000000000000000000000000000000000000900000b0990a9d009bcb9f00909000000000000009b00000000000000000000000000000000009ffffffffffffffffdfdf9f9bfcbfdbdb0f909a09a9009090da0d9a090c09000000000000000000000000000000000000000000000000000000009090f00ac90a9f00bcb09b09e90900090000000009000900000000000000000000000000009bfffffffffffffffffbfbfefdfbdfadbcb00f09b9c90b009a099a09f00900000000000000000000000000000000000000000000000000000000000009ab099a900bd09adad0f090000000000000000000000000000000000000000000000000bfffffffffffffffdbfdedbdbe9fb9fbcbdbb0f0c0b0909e09000900090a90900000000000000000000000000000000000000000000090000000090900f0a0a09a90a909b9a909a090000000000000009000000000000000000000000000000bfffffffffffffffbffdbf9fbdb9edfbcbdad0d0b9b0dbc90909a9cb09a090000000000000000000000000000000000000000000000000000009000009bb00909e9e99f0f0e90f09000000000000000000000000000000000000000000000009bfffffffffffbdbdfbdaf9fad9edb9a9f9e9adbbdac9a09a90a09000900d009000000000000000000000000000000000000000000000900009000909a9cf0a0b0009a00b099f00b0000009000000000000000000000000000000000000000009fffffffffffffffadf9f9e9da9b0adbd0f9bdb0da9bc9b0909090909e0909a000000000000000000000000000000000000000000000000000000000990bb0090b9a09a9cbe09b0d000000090000000000000000000000000000000000000009ffffffffffffbdf9f9be9f9ebdad9b0da9ad0bcbbde9b0dada9c000b090a0090900000000000000000000000000000000000000000000000000900000ad0f00a00ada0d0b09bc9da90000000000000000000009000000000000000000000009bfffffffffffffebf9f0db099099a9c9b0d9a9db0da9f0da9090b09000090900000000000000000000000000000000000000000000000000000000000b09ba0009a99090a9cbcb0a90000009090000000000000000000000000000000000000bffbffffffffffdbd0dadb09f0f9ad09bcb9a9cbadb9f09a909e9090090900000900000000000000000000000000000000000000000000000000900090d0bcf0a0a9aa9a09a9a90f900000000000090000000000000000000000000000000009fffffffffffffbfdbfb990f0909c90f09090d0b9dadadff90f09e9090000a90b000000000000000000000000000000000000000000000000000009000b0b09b009009ad0bc09cb90bd000000000900000000090000000000000000000000000bbfffbfffffffdfbc90dad990f90b090bcbcb090e99b9a9da909a90f09a090000909000000000000000000000000000000000000000000000000000009090f0b00a0a0b0bc9a9a9e9cb000000909000090000000000000000000000000000009ffffffffffffff9db9f9dbcf99090dad09090da990f0f9fada9ad0b9000900090000000000000000000000000000000000000000000000000000909009adb00e000090b000b009e9ab900000000009000090090000000000000000000000009fffdfbffffffdf9fbdffdbfdbdada9099a9bc9b0d0b0b9ebdb9c90bca90900090090000000000000000000000000000000000000000000000000000a0b090009b0000a90bb00da09bd0e9000000090090000000000000000000000000000000bbffbfdffffffbffdffdbffdbdbd9db9009c9a9c9ad09c99fada9a9099cb009000009000000000000000000000000000000000000000000000000009090f0090bb00a00a000b0a9f00b99a0000000090a0000009000000000000000000000009fffffbfbfffffffffdbc9009090b09cbdb0909a909a9a9adbdbd0d0bcb0090009000000000000000000000000000000000000000000000000000000090909a090f0a00a9a9a099009f0fad09000000009090009a00000000000000000000009fffff9e9fffffffdbcb09bd9a9ad09e9090dad090f09c90909bfab0bc90db0e90009000900000000000000000000000000000000000000000000000900f00090cba0000000a09a0e9b0b0909000900009000000000000000000000000000000bffbf9f9fffffffdbc99ffffadff9e909009099adb09a9ada9bcf9d090b0b00900000000000000000000000000000000000000000000000000000000009090b09b0b00a00b00b0b09acbde9a9e90000000090000909000000000000000000009fbffda9bfbfffbd9bffffffffffeff0f090a900900f0d090909b9eb0f09c90909090009000000000000000000000000000000000000000000000000909a0000000bf0000a0a0000b09b0b9c909a900900000090000000000000000000000000bffffbda9fffffd0bffffffffffffff9bfad9ad00990b0f0bc9adbdf90b0b0da9a009000000000000000000000000000000000000000000000000000090909090900b000a0900a0b0b00f9e90b09c09000000900009900000000000000000009ffbf0f99fffff00bfffffffff9ebff0bcfda9f009000909909ad0beb0f0909a90c90000000000000000000000000000000000000000000000000000000b0000a009aa000000a00000bcb9e9a90c9a90000000000000a0000000000000000009ffffff90bf9a9909ffffff9f009bdb0f0fba9cb09ad00909e9a90bdb9d0bda9090909a900000000000000000000000000000000000000000000000000090009090ba9f0a00a000a0b00b00b09a9b09a000000000900990000000000000000009bfdf990bdffdf09bfff9e9e99d000090909c0b0f009a000090da99adfa990da9e9a0000000000000000000000000000000000000000000000000000009a900000009ab00000b00000a90f90f0d09a9d9000000000000e909000000000000000bffbfe9a9b090900f9f9f9f9e9bd9b0cb090900909009090090090f9b0f00b0909090900900000000000000000000000000000000000000000000000090009009000b0f0000b0000000a9a0b09a9e9e0a9000000000009000000000000000009ffff0909d09a909b9f9f9f9f9fcb0d99090b09909090000000090b00dfbdbc9ada9cb00900000000000000000000000000000000000000000000000000090000009bcbb00a000a000a9a9ad09e9f90999c09000009009a90900000000000009fff90b9f9a9fdfbffffffffffffbfdbf0bda9cb0a90ad909090909909b90009a9090900900000000000000000000000000000000000000000000000009000000900b0a0a0000a00a00000b0bda90adb00a900000000000000000000000000000bfbe9090f9ffbfffffffffffbffdbf09f09da9bd9e99a09a9a9a9acb09e9b9ad09a9a09a0000000000000000000000000000000000000000000000090009000009009a9f00000b0000a00a00bcbd9adbd00b0900009090909000000000000009fdf9900b0fadffffffffffbdf9fbcbf09f0bdada99e9da9c90d099090b9c0d90b09c90d090900000000000000000000000000000000000000000000000000000009a00ab00a0000a000000b0b9a9ada9a9009a0000000000000000000000000bffbbcb099bdbfbffffffbfffaf9fbd09a0909909f09a99e9a9a90090900b9a0f09a990a90000000000000000000000000000000000000000000000000090000090a0b09f0000a9a0000a0b009adada9ad09000000090009090000000000000bffdbc9909bcbfffffffffffdbd9f0d0b9c99ada9f09ad0f090d09e9b09e9900990d09a09009000000000000000000000000000000000000000000900000000090bc9000aa000000000000000b0dbdb0d09e9e909000000000000000000000099fbfdbf0bc099bdbfbffffdfbca909a9009ac909b0bd0b90b0b0b0990f90b0f9e0b0b0c909a000000000000000000000000000000000000000000000000000900009a9ab0b0a000a000a00b000000bcbada909a0090000000009000000000000bfffbdbd9b9a9fadfffffff9f99e09009a99a9b0c9cbd0f0d9c90b0fb0bd0909900909b00c90909000000000000000000000000000000000000000000000000009000a90bf0000a90000000000a9b0bd0b09e909000000000090000000000009fffffffbf09d09ffbdffffbe9f099009000090c9b9a9a99b0b9bd9f90d0b9e9a0bda9009a90000000000000000000000000000000000000000000000000009009ada90a00b000000a0000a0a00900ff0b0da90f000000000000000000000009bfffbfdbd0dba9bf9fffff9fdbe9b00900909009bc0dbd0f09cbc9e90f9bda909d9009e9090a9000000000000000000000000000000000000000000000009000900900b0fba0a00b000000000a00a90b9e9a9e90b00000000009090000000000ffffffffbfbd9e99fbfffffbfdf9c9bc9b09c9b009b09a90f9bdbfbdb9e90dadb0a9b09a90900900000000000000000000000000000000000000000000000090a90a0b0b0af00000a000000000009a9cbdad09ad090000000000000000000009bfffffbdfdbe99f0bdbffffffbffbc9b0da9a090909f09f90f0f99cbcb9f9b90d9c0d0900f0900090000000909000000000000000000000000000000000009009090b00ab9b0000a0000000a00b0a9a90b9a9e90bc000000000009000000000bffffffffbff9fe9bdbffffffffdbcbd0f09d9f0f09a09e90fbdbefbdbda9e9e9a9b9a9a90900b0900009009e9ada0000000000000000000000000000000000a900ab0a900ea0000900000000000a0b09e9e9f09a900000000000900000000009ffffffbfff9ff9bcbdffffffffbfdb0b09f0b099009db9bfbdbf9bdb0f9f9b9f9ad0d09c9009000009000b0909090000000000000000000000000000000090909a9009a9abf0a0a0a00000000a09000a90bcbcbd09000000000000909000000fffffffff9fff9fdbfbffffffffdfadf9db0bc9e0d9a9cbd9dbcbfdbdf9e9e9e9c9a9a9a9a9a0900900009c909009b00000000000000000000000000000000900a90abe0a00b0000a9000000000a0a0b0bc9a9b0af0000000000000000000009bfffffffffffbfbfdbdbffffffffbdb0f0dbdbb99a09b9ebebfbf9fe9fbdb9f9b9bdb0d9090900900009009a90b00c90000000000000000000000000000000a909a990b00b0f00009a00a0a0000000900b0bcbcbd00900000000009000000000bfffffffffbdfff9fffffffffffbdffdb9a909c9a99fcbdbdf9fdf9bfbc9f9ade9e90f0bd0b09a00900009090c909b00000000000000000000000000000009009e0a0b00b0aa0a00a0a0909000a9a0a0b0f09a9b0b9e09000000000000000009fffffffffffff9ffffbffffffffdfbcb9e9cbcb0d0f0b9f9fbf9faffdbdbe9f9b99cb990a9c9000900909a09090f000000000000000000000000000000000090ba90b00b0a0f0000b009aaa0000000000b0a90c9c009a0000000000900000000bfffffffffbffffbfffffffffffbddbde90b909b0b9bdf9ebdefbdf9adbf9f0f0f0bc9e9da900900000009000b09090000000000000000000000000000009a9ad0a9aa00a00b0a000bae9000000a000090b9e9a09b90d9000000000000000009fffffffffffffbffffffffffffffbe9a9f90fbcbd0f9a9f9fbdbfbdff9f0f9f9f9f9b09a909a90909000009a90bcb00000000000000000000000000000000909a90090b00b0f0000b0b0a0a0a0a000a0a0a09a99ac09a0900000000000000000bffffffffffffffffffffffffffdf9f9f0bd09909b9cbdadbdbfdfbdbf9f9f09e90bc9f9e9e900a000909009c909000000000000000000000000000000009cada0b0a000b00a000a0a00000000000000090bbc9e090bcb000000000000000009fffffffffffffffbffffffffffffbcbd0bd0bdadb0fbdbffffdbfbdbf0f9f0bdb0bd9a9090909090900000900000900000000000000000000900000000009a90900a09a000ab000000000000a000a0000a000b09b09090b00000009000000009bfffffffffffffffffffffffffffdf0bda0f9a9bcb0daf9bcbfcbdebdbfe9f9ad9cbadada9a9e9000000090b000000000000000000000000000000000009009a0b09a00a0a0f0000000a0a0000a0000a00a9a9f0d009a9c90000000000000000fffffffffffffffffffffffffffbf9f09db09d099dbdbdffbdbffbdbfdb9f9f9ba9d909b0d09009090000000900000000000000000000000000000000000b00900a00b0009aa000000000009a000a00000000a0b9a9000b0000000000000000bfffffffffffffffffffffffffffffcbda09f9a9e9a9adaf9fff9fdbfdadfadad0db0bdad9a909a000090000900000000000000000000000000000000009009e0a900a00a9a0b000000a0a00a000a000000b0b9bcac00090c9000009000000009fffffffffdbffbffffffffffffffdbda99f0ad0909fdbd9f0b0f0bfcb9fb9db9fb0bda9a090f0909000000900b00000000000000000000000000000009009009000a90a0000e00a0a090000000a9000a000a0a0b99090a90a00000000000009bffffffbffffffffffffffffffffbf909f00990b9fa9adbebdbd9bd9bdfbdfade90f099c9f09090da90000000900000000000000000000000090000000a09a90a9a900a9a9a0b000000a0000a000a0a00000b0f0acb0090090900009090000000bffffffffbdadbdbffbffffffffdfffa9bdadbc09fdbc99dadaf0be9bdebdb9bf99f0bb09a9a9a0000000000090000000000000000000000000000000900c0b000a0a000a00f00000a0000a000b0a0000a00ba90b00909000000000000000009ffffffffbcb9b0bc9fdffffffffff09d0909099bc9a9b0f0f9d9fd9fcb9dadfc9ad0bd0f0d09c9909000000000000000000000000000000000000000909a9900b00000a900ab0a00b0000a000a0a000a000b000b0da00a009000009090000009ffffffff9f9f0d99bdafbffffffff9f0bcb0bcbc9a9c0f9b0b0a90b0b9fabda9bdabd0b909a909a0000000000000000000000000000000000000000000090a0b0a00a90a0b0a00a000a0000000090a0000a0a9a9a0d009900000000000000009bffffffffffbf9e90b99fdbfffff9e90909c909a909b90d0d09909090909da9dabd09f0cb0d0b0090000000000000000000000000000000009000009099ac9a090b00a0b000f090a00000a00000a9a00009a000a9a0900ac0900900090000000bfffffffffedbf9f9cbcbffffffffdbdb0b90b090dad0b0b0f0fbcbcbc9a99e9d0f9a9b909a9090000000000000000000000000000000000000000000a09b09a0a00b000a00a9a000000a0000a00a00a00a00a09a90b00990000000900000000ffffdffff9fbcbcbcb99f9fffffffbe909c09c90b090bc9f9bd0090909ad0b9b0b9adad0f090cb09000000000000000000000000000000000000000090da0a090b0a0a9a90ab0000a00a0000090a00000b00009adad0c900a000009000000009bff9bbff0fbc909099acbdbfffffbd99cb09a9ac9bcbdbbd0f0f9bcb0909adacbdad990b090b90000000000000000000000000000000000009000009a9a9009aa00009a0a00fa000000000000a000000a0000a0ba9a9bc9090000000000000009fffc909ffc0000000990b9bfffffada9090009900909c0fbc900090bcb09099909adad09a90009000000000000000000000000000000000000000b0c9a0b0a090b0a000000b0a0a00a0000000a0000000a00000f0f00b0f0900000000000000bff90090bff00000000090fdffffdfbcb0e99000b090b9f0fe00000090090000090909a9c90da900000000000000000000000000000000000000090b909a0f9a0a0a9a0b0a0f000000000000a0000000000000a9aa9bd0b09a000090000000009fbcb0009ef0900000090f9bfffffbd9099000b9d00900bff00000000900090b0a9a9a9cb0b0900000000000000000000000000000000000900090900eb09a00b009a9a0000b00000a00000000000000a000a09e090f0adad000000000000000ffffda9009000000099a9b0fffffbc9a090009000bd009ffc0900000000000909d090d9a909000900000000000000000000000000000000000900dac9b00a9ab0b0a0a9a000f0a0a000a0000000000000a0000abfab0f909a9000090900000099fffbda9000000900009c9fbffffffe9da0f009090a9f000f000000000009a0900b09a0900009000000000000000000000000000000000900009a09b00be9a00a000b000a00b00000a000000000000000000000009ab0f09c00900000a900000adbffffbd0b0900909c9b09ffffffbda9900900d090090900000000009000900b09e99ca909000000000000000000000000000000000000090009000b00b09a90ba00a090a0f000000000000000000a00000000baa90f9e9a900000009000009bfffbfdffbdf0f0a99a9cbffffff9ff9cb09a90a90090f0f090009000090909090c90a900000000000000000000000000000000000000000000900bd0b0a0a9a0000a90a000a00a00000000000000000a00000a0090a9a090090000000000000bffffffbe9e9b9f9da9dbbdfbffffe9cb0c90099009000909ca9900d99cb09ad0b90b909000000000000000000000000000000000000009000000090a0b0a9acab0a90a0000b0000000000000000000000000009a0a9adbe90000090009000090f9ffbfdf9f9e90b099a9fffffbff9fbc9b00900090b0909a99ca990a0909c9a9ca90c00900000000000000000000000000000000000000000090b0a9a0b00ab0000a000000f0000a0000000000000000000000a9a00009009090000000000009faf9e9ada0909009ac9e9bfffffbfcbb0c9f0f0b09090bc90b99cb990b0b0090900b0900000000000000000000000000000000000000000000000d0a9a0b000b00a9a0a000b0a000000000000000000000000a0a09a90adb00009b000090009bff9e9c9090000090d9b9fffffdfffbd0f9a090900000909a9c9a900e90d09f09a9d09a900000000000000000000000000000000000000900009090a9a090a9a00a00000000a000a00000000000000000000000900a0009000909000000000009ffff9b00000909adbaffdfbffbffadaf90090000090909ad09adbcb99e9a000090a00000000000000000000000000000000000000000000000000a9a0b0a9a00a00a0a0000f0a000000000000000000000000a0a000b0009000090900090900bfffffffbdb9fbffbdf9fbff9fffdfbdfe990090900000090bc90090009090909e090909000000000000000000000000000000000000000000909ada900b000a00000000000b00a000000000000000000000000b0a9000f00b9000a0900000909ffffffffffffff9fbffffffffffbffbf9ebd0a000000000009a9a9cb000000b0900000000000000000000000000000000000000000000000000090a0a9eba09a0a00000000f00000a00000000000000000000b0000a090090c0909000000000bfffffffffffffffffffbffffbfffffdfffdaf99090900900900d00900909090900909090000000000000000000000000000000000000000009a90a9e9a900aa000000a0000a0a00000000000000000000000a000a00000b009b000090000009ffffffffffffffbfffffffffffffffbfffbfffdef0b009009009009009cb09000000000000000000000000000000000000000000000000000000009a9a0a0a900a000000000f00a00000000000000000000000ba900a00900b00f090009000909ffffffffffffffffffffffffffffffbfffffffbdbcbda09a09a09a90b00000000000090000000000000000000000000000000000000900009090fa00090000a00000000000b00000000000000000000000000000a900009009009e9a0009009fffffffffffffffffffffffbfffbfffffffffbffffbcbdbc9f0900009090000000000000000000000000000000000000000000000000000900a0900b0a00a00000000000000e00000000000000000000000000b0a00a0000090b00909909009abfffffffffffffffffffffffffffffffffffffffadff9e9b0000090900000900000000000000000000000000000000000000000000000090090da0b0a90a000000000000000b0a00000000000000000000000a0a000000a9b0090b0bca00a909fffffffffffffffffffffffffffffffffbfffffdffb9ebd0090900000000000000000000000000000000000000000000000000000000090000b09a0090a0000000000000000f000000000000000000000000000000000000099ad0d09090900bffffffffffffffffffffffffffffffbffffffffbf9ef9009009090900000000000000000000000000000000000000000000000000009000090da00b0a000000000000000000a0000000000000000000000000000000000000ac9a90b000009c9bfffffffffffffffffffffffffffffffffffdbffff9de900900a090000009000000000000000000000000000000000000000000009000090a909a90b0a00000000000000000f00000000000000000000000000000000000090909cb0d0b0009bfffffffffffffffffffffffffffffffffffbffdaf9eb900da90900000090000000000000000000000000000000000000000000000000000090bc90a00000000000000000000b000000000000000000000000000000000000a90b0b09a90090b0ffffffffffffffffffffffffffffffffbfffffbf9f9000b0900090009000000000000000000000000000000000000000000000090000090a9ad00b000000000000000000000e00000000000000000000000000000000000090090dad0900009ffffffffffffffffffffffffffffffffffffdbdfdbcb090090909000000000900000000000000000000000000000000000000000000000009c90ba0a00000000000000000000b00000000000000000000000000000000000009ada90b00f009a9bffffffffffffffffffffffffffffffffffffb0bcbd0090b00b09000900900090000000000000000000000000000000000000900000900a90bd090000000000000000000000f00000000000000000000000000000000000a009090bcbd090009fffffffffffbffffffffffffffffffbfffa90f9db9a090d00900009000000000000000000000000000000000000000000000000000900090f00a0a000000000000000000000a0000000000000000000000000000000000000b0b0f0900b0099bfffffffffffffffffffffffffffffffffe9ff9da9c0909a90090000090900900000000000000000000000000000000000009000000000bda9a9000000000000000000000000b000000000000000000000000000000a00000909c909ebd00b0c9bfffffffffdbffffffffffffffffffffbd909ebda90009009009009000000000000000000000000000000000000000000000000090090009c00b00000000000000a00000000e000000000000000000000000000000000000009adb090ad009a0fbfffffffffffffffffffffffffffffffe9fbdb0f0900b900900000909000090000000000000000000000000000000000000000000009bca9a0000000000000000000a00000b000000000000000000000000000000000000b0a909f9f9a900999fffffffffbffffffffffffffffffffffda9fadf90009c0000900900000900000000000000000000000000000000000009000090000b00990900a0000000000000000000000a00000000000000000000000000000000000000d0be9a00dad090bfffffffffffffffffffffffffffffbff090f9f90009a9090b0090090090000009000000000000000000000000000000000000009ad9e90e00a000000000000000000000000f00000000000000000000000000000000000b09a909e9f9a909a9e9ffffffff9fffffffffffffffffffdff09f9f9a900090009000009090000900000000000000000000000000000000000000000000a09009000000000000000000000000000a000000000000000000000000000000000000009e9e9a9c9e90909bdbfffffffffffffffffffffffffffff9a9e9ed000909000900900009090000000000000000000000000000000000090000000099d0a9a0a09a00000000000000000000000b00000000000000000000000000000000000a09a909f9e9a90f09bcbfffffffdbffffffffffffffffffffbc09bda90909a00090000090900a0900009000000000000000000000000000000000000bca009c9000a000000000000000000000000e0000000000000000000000000000000000099ad00b0a9e9e90bc0b9fbfffffafffffffffffffffffff9fc99fda9000090909000909a0009090009000000000000009000000000000090000000090090b0b0a009000000000000000000000000b000000000000000000000000000000000a0a0dafd099e909e90bd0f9ffffffdbfffffffffffffffffffbf009a909009e0009a9000090900000000000090000000000000000000000000000009a0f009cbc000a00a0000000000000000000000b000000000000000000000000000000000090b09a9ac99fa99ad0b9adabffffbffffffffffffffffffffde900d0009009900000090900090909009000000000000000009000000000000000000d9009a90b00090000000000000000000000000e000000000000000a000000000000000000000dadadb0e9dad09bc09bdf9ffff9fffffffffffffffffffaf099b09000b000909000009090000000000900090000000000000000000090000000b0ad0b0da00000a000000000000000000000000b00000000000000000000000000000000000a9b0bdb0e9fada9bcbdbcb9ffff0fffffffffffffffffbf9fd0bc0009009009a900090900a09a9000900000000000000000000000000000000099c090b0da9a09a00000000000000000000000000a00a0000000000a00000000000000a0000000009cb0f9b09f9e9b0b09adbffffdbffffffffbffffffffff0c0b0b000909000009000009090000900000090000009a0090000000000000000000bda9c9a000a0000a00000000000000000000000f0000000000000000a0000000000000000000bca9cbcf0f0bcbce9cb0dadbfffadbfffdffffffbfffdbdfb09c909009e0900900090900009090000000000000000900009000000009000000b0009a0f9a009a000000000000000000000000000b00000000000000000000a00000a0000000000090b9b0f9e909b99a9cb9a9ffbdbffdfbffffffffffbefbc9a900000090009000000009090000090009000009000000000000000b0000000909e90d90009a00000000000000000000000000000a0000000000000000000000a000000000a0000b000c0fda90bcbcafdb90fdfbdcbfffffffdfffdfbdfdbc9090b090090909009090909000a9000000000909000a900009000000900000009ada90f00a0b0000000a00000000000000000000000f00000000000000a000000000000000000000000b0909adf090dbd9a9e99a9ffb9ffbffbfbfbfbfdafbdb0000000090a0000000000000090009000009000a0090000000000000c90000900909e90b00000a00000000000000000000000000000b00000000000000000a00a000a000000000a000000a909adf0b0fadda9ebda9fed9ff9fdffffdfaf9dafcb0090000090900900000900900900000900009090000009000000090a00000009a090e900a9a0000a00000000000000000000000000a000000000000a000a0000000000a000000000a009000a9a0f0f9fab9c90b9edb9a9fffbfadbffd9ebdb9c090090090000900009000000000000000909000009009000900000090000000ad0f090a90000000000000000000000000000000000f000000000000000000000000000000000000009a009e9c9f9f0f0d0da9e9c9b9e9ffdbdfdffdb9a99f9e90000000000900000000009090090009000a000000000000900000090000000990b09a000a00000a0000a0000000a00000000000000a00000000000000a00000000000000000a0000000b0090b00b0f9fafad09a9e9e9adbbefbf9fbed0ff0f0000900009000000000009000000000000909000009a90000000009a0000900bcad0a00a00000a00000000000a00000000000000a000b00000000000000000000a0000a00000000000a0000b00090cbcad9f9a9c90909c9adf9fdbf0f9a90bd9f00000000090090000000000000000900b00c09090000000900000090000009090a90b009a0000000000000000000000000000000000e000000000000a00a00a0000000000a0000000000a9009e0b09f9af0df09ada9a909b0f9adaf9e99f9a909090000000000000000000900009000900b000000900090000009000009009e0900a00b0000000a000000a00000000000000a0a0000b000000000000000000000000000000009000a000000b00909adad09a09a909c90e90db0fdbdbc9e9a9da00000009000000000090000009000a900d09009c90e900000009a0090900da09a0b09a0000b00000000000000000000000000000000a00000000000000000b00000b000a0000a0a009000b00900c000bedadbc9cb0009090bc9b0bc9b090da090000000000000000000000000009090e9a0090a0a900000000000000000b00b0b00a0000a000a0000a0000000000000000000000000b000000000000000a000a0a00000000000009000a000a00b009099a90f0b0cb0b00090bc9d0bc9adb0900000000000000000000000000900000900900090900900000009000900bc0b0b00f09a9a00000900a000a000a000000000000a000a00e000000000000a0000a00000a0a000a000000a00000000900b00009e90fcb09c0090e909a0bc9a9009000000000000000000000000090000b09a9d0b9e0000b00000009000000f00b000f0a0a000900a0a00090000000000000a000000000000b000000000000000000000000000a000a00a0000000000009009e9e90f0b0d0a900a90000909ad090000900000000000000000000000a09d0dac9a00000009c00000900a009e900b0beb0a909a9a0a09000a00a0000000000a00000000000000a0000000000000000a0000a000000090000000a000a000000090090cb0c9cbc9c9fd0009000009e000000000000009000900000009090900b0900090d009e9000000a0909a09a9b0a90090a0a000000a00000000000a000000900000090a0000f0000000000000000000a00000a000a00000009000000a00000b00b0f9b0b09a000ad00000090090000000000900000d009009000a00d0b0090bcbcb00b00000000900000dad0acbca9a0b09000a9a000a00b0000000000000a0a00000000000a00000000000a000000a09000a000a000a000000a00000900000000900c00dad09ff00000000e9000000000000009cb0000000090909a90dada90900090000009000009cb090b0b0a90e9aca0b000009009000a0000000000000000000a00000b0000000000000a00a900a0a000000000000a9a00000000a0000909a0fbc9a90ff000000000090009090000090c9a0000b00bc9a9e9e90cb000000000009009000009b0b0d0a0b009aa900b000a9a00a00a00000a000000000000000a0000000e000000000000000000a90000009a00a0000000000000a09a9000009090b0dcb00f090000090009a0009009000b00909000900bc9009cb0000000000000090a000900c9cb0b0da9a0900b009a9000000b00a0a000000000a00a0000000000000b0000000000a000000000a00a000000000a0009a0000000000a00000000daa9cb00009cb00c9ad0909e090cb0000000099e0f9000bca0000009000000900a90000e9a9a9c9eb0000bcb00a000a0b0a00000900000000000000000000000a0000a0000000a00000a0000a009000a00a09a090a0000a0000000a90000090f09d0bc90b0e90fdbad0acbc09a0900d0d0b0f0e90000bc009000090000000900d00090900d0da9b00b0fb0a00b0b0a090009000a000a000000000000000000a000000f000000000000000a000000a00000000000000a000000000000a0a000a0900a09ad009be9a0c9ad9c0b0c9009a90bc90090d0e90090000000000090f00b00000a0bda9a9ac0bcb0000b00000900a00a0a000a0000a0000a00a000a0000000000a00000a0000a000000000a00a000b00a000a0000000000000000000b0900b0d9eda0d009c9dbc9a0b9cb0ebdadad00ad000a9000000c009000000a000d000009c9009e9e9a90a0b0b00a9a9a0b00a00090a00000000000000000000000000000b0000000000000a00b00000900a000090a00000000000a00000000000a000a0b0fdaaf0f0a00addacb0d90e90000ad000ad00000009a000000000909a0090b00b0f09b09a0a9000a0b0000000000900a0090a90a000000000000000000a00000e0000000a0000b00000a9a0a000000a000000a000009000000000000009a0900b0bdd0d09d099a0bd0e0ad000009000009000000000090000000d0e0090a0c90c90be0a00900a9a0900b0a0b0a000a000a0000000b0a000a000a0a0a00000000b0000000000a0000a00000000000a0000000000000a00000000000000a0090a0000fabebeaca0c9c0a9090000000000900000000909000000909a90900c909adbaf0090b0a0b0009a0a00900009a0009a90a0a00000000000000009000000000a000000000000a0000a9a9a00a000000a00a090a00000000a00000000000a09a9a909c9c9dbd09a09c00cb000000090000000000000000000ac00000d0bcbc9a090b0a000900a9a0009a0a0a9a0009a00a09009a000000000000b0a000000000b00000000000009a000a000b0000000900000a0000000a000000a0000000000000a0a9a0a00be090a90090f090900a00000000000000000bc9090900a9090be9aac090a9a0a90000a00090b0009a000b09a0a000000a00000000009a00a00000e00000000000b0a000009a000000a00a000900000000000000000000000000a00000900909fc9cadc0f00009e000909ad0a000000009cb0000a0ac9e90f0f0b0d0b0a0900900a09000a9e000b0a00a000a0900a00a0000000000a9a000000000b000000000a000000a90a0000a00000000a0a0000000000000000000000000000000a00a0a0bfadb0b09cb0f00c00000009000009ada00c9cb09c9a90f0ba90a0b0b090a0a0000a0b09a009a00000900b000a90000000000000b0000000000a0a00000000000a0a00000000a000b00a900000000a00a00a00a000000000000000000000009000dadede0ac90f9b000000000909bc909f09a90d0b09e9af0da09a0000a00000a90000a00b0a90a09a0a00900000000000000000000a0a0000090b00000000000000900a0a090b0000000a00900a000000000000a00a00000000a00000000000b0b0b0bd090000acbcb09090dadadafca9e9cb0ad0fe9e90ba9a09a9a000000000a09a9a00b0af9a00000a0a000a00000a000a00000900000a000e00000000000000a0a0909a000b0a90000a0000009a000000000000000a0000000a00a0000a0000000ada0b00d90f0dadafadadad9bde9fadfdaf09a9a00000000009a00000000000a0b00bb0a00b0b00000000000a0000000000a000000000ab0000000000000a000000a0a9a0000a00000a009a00000000000000000000a00000000000000a9a0b0900d0db0acb0f9e90d0f9adae0bdad9a0b09a000000b0a00b0a000a90000b0b090a9acb09a00009000000000000000000a000a000009a9a0000000000a0090b00a9a90000b00090a9000000000a09000000a0000000000a000090a000900000000b09a0d09c9acbcb0b0adad9f0a90a0b0a09a9a9a0000b009000000a0a00000a00a9a0a009a0a0a00a000a0000000000000000000a000b0000000000000a0000000a0a900a00a000a9a0a000000a000000000a00a000000000a00000a00b0a0b00a09a09a009000000d090a009000900000000009a0900a0a0b00000090a9a90a9009009a009000000000000b000000009a90a0000000e000000000000000a000a90090a9000009a9009000a0000000a0009000000000000a0000000000009000900a09a0900a9a009a0a090a0a9a00090a00a00000a000000000a9a9a00000a90a0a00a09a0a9a090000a9a00a000a00a00000000a00b00000000000a00000a900a0a00009a0b00a0a00b00000000000a00a0000000000000000a0000009a0a0a0b09a0a00b00090a09000a909ac0a0a090009a00000009a9a0b0000009a0b00a0909a90a009000a0a090000b000000a90a0000a0000a0000000000000a00000a0900b00a0000a90900000090a00a00000000a00000000000a00009a0a0009090000a909000000a09a00b090a00b009000a000000b00a00000009a0a0a0000b090a0a0a009aa0b000000a00ba0a00000009a00000b00f00000000000000000009a0a00a90b0b00a0a0b000a0000000000000900a0000a00000009000090a0a000b090a000b000000a9a00a0b0b00b0a0b009a000000900a9a0a9a90090a9a00a00000909a090000a90009a0090000000a00000000000a0000000000000000a0a00090b0a00000b090000b00000b0000a00a0000000000000009a0a0900a9000a000a000a000b0b0090000900000b009000a000b0000a00000900a0a9a09a0b090b0b0a0a09a09a090a0a0000a0000a00000000000a00b000000000000000000900b0a0090a0b0000a90a0090a0009a0000000a0000a000000a00000a0a0000009a0090000a00000a0a9a00a0b0b0000a9a9000000a000009a0a9009009a9000a000009009a0ba00a0009000000a0000000a0000a0000e00000000000000000a0b0000b0a0900b0a90a0900a0000a0000090009000090000a900000900900a90a09a000a09000a00090000000000a0a900000b0a00090a0a000000a0a0a0a9a90a0a9a0a0a0bc9a900000a000b000000a0090a00009a0b000000000000000000000a900090a00000000a0000009000000a00a0a0000000a0000000a00a00000000000a000a00900000a000000009090a00a00009000a0900000000090900000a09000000090ba00a0b0a090000a9a00000a000000a000a0000000000000000000a900a9a0a90b0000b000a90a00000a000000900a000a0000a000b00090a90a09a0000090000000a00000b0000a0a0009a90a0a00a000000a09a090a0a0a90b0ba0a0b09a0a09a9000000a000a90000009000000009a0f000000000000000000000a000009a000b00009000000a00900009a000009a00009000a0000a000000000090000a000a000009000000b009009a0009000000b0a00000000a009090a0b0090000a0909a00a9a0a900a0b0a00000000a00000a00a0000000000000000000000a9a9a00b000a0000a00a9000a0000a0000a00000000a000900090a00a09a000a00a000b00000000a00a00000a0a00000a000000000b000a0a0090a00a9b0ba0b0b000a0ada9000900a09009ab00a00a0000000000b0000000000000000000a09000a9a00a900b00000000000000b0000a900a0090a000a00a0a0000090009a000000000009a00a000000b0000090a9a009a000a0b00a0090900a900a0abadb00a0b090a900a0b0a0000a0b0bcb000000000000000e000000000000000000000a0009a09a90a000a000000a000000009a000900a000000900900009a0a0a00000a90a900a00000000009000a9000a0009a000a9000ba90a0a0a000a09090ba0ab0000a09a0b000000b00000a9a0000009a00000a00b00000000000000000000000a9a09a00a09000000a0000a00a00a0000a009000000a00a0000a0090090a000000000b00a000000a0a00000a0b090a000000009abca0009009a0900a0fa00909a0b09a0b000a09a00a09a9a0a0000a0000000000a0000000000000000000000000da009a9a0a00000000000000000000900a00a00a9000000a9000000000b0b0a00a00090000a009009a0b00000a90a00000a0a90b009a0a000a0a09a009a0a0900a09ac0b09a09a09a0000090a00000a00a0000b000000000000000000000a9a0a9a000090000a0000a00000000900a00000000000a090a000a9a0a0a00000090090a0a0a00000000000000b0b0a909a000900a9a90a909a09090a09a0a9000a090a09a00a00a0b0000a0b0a00b000000000000e0000000000000000000000009a0009a9a000000000000000a00a0000a900000a0090a009000000900900a0000a00900090b00a0a9a09a0b00a9a0a000a0000000aada0a00a00a90a0900e9a90ac90a09a90b0900a9a90009ab000a00000a000b0000000000000000000a00a9a009a000000a000000000a0000000a0000a09a0090a00000a900a00a00a900a0090a00b00a009000000a0000a9000000000a0b0a9a90a900000a90a90a0a9a00a9a0a09a00a000a000000a9e000a0000a00000ba000000000000000a000090000b000a00a00000000000000000a09009a00a0000a0000a0000a090900000a09a0a00000a0000a00b0b090b0b0a9a9a9a0090000009aa9a9a9a90a90a09a9a9a900b09a00b090a0009a0b09a9a00000009a00000f000000000000000000000a9a00a0000000000000000000000000a00009090a9000b0900b0090a0a09a9090000090b0009a90000000a0000009a000000a000009a090a00000a90a09a000009a090aa0b00a009000a090a00a9a090000000000aa00000000000000000000a0000000000000000000000000000000000a0a00a00a9a00a0000a000000a00a0a9a9a0a00b0a00a9a9a9a90b0b0b09a9a00b00a00a00b0a9a9a0b00b0b09a9a9a00ba909000b00a0a0b09ab0ba9a000a0b0a0000a9b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000a00a000000000000000000000b00b0a00a000a00b000a0a9a000000000a000000000000000000000000000000000000000000105000000000000dfad05fe, N'Laura received a BA in psychology from the University of Washington.  She has also completed a course in business French.  She reads and writes French.', 2, N'http://accweb/emmployees/davolio.bmp', 'callahan@northwind.com', '234454356' ), 
( N'Dodsworth', N'Anne', N'Sales Representative', N'Ms.', N'1966-01-27T00:00:00', N'1994-11-15T00:00:00', N'7 Houndstooth Rd.', N'London', NULL, N'WG2 7LT', N'UK', N'(71) 555-4444', N'452', 0x151c2f00020000000d000e0014002100ffffffff4269746d617020496d616765005061696e742e506963747572650001050000020000000700000050427275736800000000000000000020540000424d16540000000000007600000028000000c0000000df0000000100040000000000a0530000ce0e0000d80e0000000000000000000000000000000080000080000000808000800000008000800080800000c0c0c000808080000000ff0000ff000000ffff00ff000000ff00ff00ffff0000ffffff00d999d999999d9d999db99dd9f9d9d9d99d99d9f9d999bd9fd9d9d9d9d9dfd9f9f9dbdbd9dbd9db9fd9fdfffffffffffffffffff9d9f9db9d9dfd9db9f9bdf9f9d9dbd9bd9f99dbd99999999d9dbdbd9bddd9f9dbdbd9f9d9d99d9bd999d99d9d99db99d999d9f9d9f9d9d9999d9b9bdbd99f9d9999d9dbd9fdbdbdbdbdbd9f9d9dbd9d99fd9f9dd9fdd9ffffffffffffffffffdbdf9dbdd9f9dbd9dd9dd9d9ddbd9d9dd9d9d99d99999d99d9f9d9d9dd99bd9d9d9d9f9dbd9fd9dd999db9dbd99d99d999d999d9bd9d9dbdbdd9d9dd9d9dd999999999fd9f9d9fd9d9d9d9f9d9f9d9dbdf99f9df9f9f9ffffffffffffffffffffd99df9db9df9d9d9f9f9f9f9bd9f99f9f9dbdf9d99d999d9d9d9d9f99bdd9d9f9f9f9d9d9d99bd999999d9d9f99d999999d9f9d9d99f99dd99b9d999d9b99d999d9d99fd9dbdd9dfdbdbd9d9d9f9f9d99df9fd9fd9fdffffffffffffffffffffbdf99d9dfd9f9dbd9d9d9d9dd9d9dd9d9d9d99f99999999b9dbdbd9d9d99dbd9d9d9d9f9f9d9d9bd999d9f9d99dbd9d999bd9d99d9d9d999d9d99f9f9d9db9d9999bd99f9ddb9f99d9dd9f9f9d9d9dbd99d9dbd9fd9fffffffffffffffffffffd9ddbdb9dbd9f9dbdbdbdbd99f9f99f9f9f9d99d9999d99d99d9d9dbd9f9d99f9dbdbd9d9dbd9dd9f99999dbd9999999f9d9dbd9bdbd9fd9bd99d9d9d9d9d999999d9dfd9f9dd9df9f9dbd9d9f9d9d9d9fdf9dfd9fddfffffffffffffffffffff9f9d9ddbd9f9d9d9d9d9d9fd9d9df9d9d9dbd9f999999d99d9dbd9d9d9dbd9d9d9d9dbd9d9d9b9d999d9d9d99d9d9999d9f99d9d9d99d99d99f9d99db999999d9d9df99f9ddbdf9d9dbd9d9f9dbdbdbddb9dbd9f9fffffffffffffffffffffffd9fdbdbdbd9d9dbdbdf9f9d9bd9f9d9f9f9d9d999d9d999dbdbd9f9dbd9d9f9dbd9f9d9f9dbd9d9d9999bd9f9b99999d99d9d9bd9d9d9bd99d9d9bd99d99d999f9f99fd9dbd9d9d9f9d9dbd9d9d9d9d99ddbdf9dd9ffffffffffffffffffffff9f99d9d9dfd9f9d9dd9dd9fdd9d9dbd9d9d9dbd999999d99d9d9d9d9dbd9d9d9dbd9f9d9d9d99d9f999d9d9dd9d99999fd9f9d9d9bdbdd9df99f9d9d9bd99999d9dd9d9f9dbdbdbd9f9f9d9f9f9f9dbd9bddbdf9fdffffffffffffffffffffffddf9fdbd9dbd9dbdb9f9bd99f9f9d9d9f9dbd9fd999d9bd99d9f9dbd9d9f9dbd9d9d9dbd9f9d9bd9d99999f99d999d9d99d9db99fd9d99d99dd9d9db9d9999dbddb9dbd9dbddd9d9d9d9dbd9d9d9dbd9fd9fd9df9ffffffffffffffffffffffffbdd9dd9f9d9d9d9dd9dd9fd9d9d9f9f9d9d9d9999d99d9d99f9d9d9f9d9dbd9f9dbdbd9d9db9d9f99999d9d999999dbdf9d99d9d99d9f9bddb9dbd9d99d9d9d9b9dbd9dbddb9f9f9f9fd9d9f9f9f9d9d9fdbdf9dffffffffffffffffffffffffd99f99f9dbdbdf9f9fdb9d99f9f9d9d9dbd9f9d9999d999bd9d9f9f9d9f9d9d9dbd9d9dbd9dd9d9d999d9d9d999d99d99db9dbd9d9f9d9d99dbd99d9999b9dbddd9ddf9df9ddd9d9dd9bdbd9d9d9dbdbdbddbdffffffffffffffffffffffffffdfd9fddbd9d9d9d9dd9df9fd9d9f9d9f9d9d9f99d9db9d9d99bd9d9dbd9dbdbd9dd9df9dbd99f9f9d9999f999999f99d9d9d9d9dbd9d9d9fd9d9d9bd9d99d9d9bd9b9d999f9f9f9f99dd9dbdbdbd9d9d9dbdd9ddfffffffffffffffffffffffff9fd9bddbd9f9f9f9bd99d9f9d9d9f9d9db9d9d99b9d99d9dd99f9d9dbd9d9dbdb9f99d9d9f99d9db99999d99999d9f9f9dbd9f9d9f9f9d99d9dbd99999d9dbddd9ddbdfd9d9d9d9df99f9d9d9d9f9f9f9df9f9ffffffffffffffffffffffffffd9dfdbdd9d9d9d9dd9df9d9dbd9d9d9bd9d9f99d9d9f99f99d9d9f9dd9f9f9d9dd9df9f9d9dd99f9d99d9999d9f9d9d9d9d9d9d9d9d99d9f9d9d9d999d9f9d99b9f99d9d9f9f9f9f99f9d9f9f9f9d9d9df9fdffffffffffffffffffffffffffffdbd9db9f9f9fdbdbdb9dbdbd9f9dbdd9d9f9d99999d9d99d9fdbd9f9bd9d9dbdbdb9d9dbd9b9d9d9999bd999d9dbd9dbd9dbd9dbd9d9f9d9bd9999d9bd9f9fdd9dfdbdbdd9dd9d99d9dbd9d9d9dbd9dbdf99ffffffffffffffffffffffffffff9dbdfdd9d9dd9d9d9dd9d9d9d9d9d99f9d9db9d9df9d99dbd99d9d9dddbdf9d9d9dd9f9d9d9d9f9d999d9999bd9d9f9d9f9d9f9d9dbd9d9d9df9d99d9d9dd9bd999dd9d99f9dbdfd9d9d9f9f9d9dbdbd9dfddffffffffffffffffffffffffffffdd9db9dbdb9f9f9f9bdbd9f9dbd9d9ddb9dd99999dbdd999d9fdbdbd9d9dbdbdb9fd9d9f9dbd9dbd999d99d9d9d9d9dbd9f9d9dbd9d9f9d999999d9d9f9bdd99df99dbdf9dbd999f9f9d99d9f9fd9d9f9dbfffffffffffffffffffffffffffff9bdbdd9d9dd9d9d9dd9d9f9d9d9f9d99d99f9d9ddd99bd9dbd99d9d9f9f9d9dddd9df9f9d9d9dbd999d99d9dbdbd9f9d9d9df9f9d9f9d9bd9d99d9bdbd9dd999f99fd9d9dbd9d9d9d9d9fd9f9d99f9f9ffdfffffffffffffffffffffffffffffddd9db9f9dbdbdf9f9f9fd9dbd9d9f9d9df999f9b99dd9d9d9fd9dbd9d9d9fdb9bdb9d9df9dbd9dd999b9b9d9d99d9f9d9f99d9d9d99d9d999d9bd9d9dd9bd99ddd99f9f9d9dbdbdbdbd9bd9d9fd99dfd9fffffffffffffffffffffffffffffffb9fd9d9f9d9dd9d9d9dd9f9dbd9d9f9f99d9d99ddf99db9d999f9dbdbdbdd9ddd9dd9fd9d99dbdbd99d9d99f9dbd99dbdddbd9dbdd9bd9f999d99d9f9bdd999b9df9d9d9dbd9d9d9d9fdd9f9f9fdf9ffdfffffffffffffffffffffffffffffffdd9fd9d9dbdb9f9f9f9bd9d9d9f9d9d9d9f99d999d9f9d9bddd9d9d9d9db9f9bddbdf9bdbd9d99dbd9999df9d9d9df9d9f9d9f9d9bd99d99d999dbd9dd9bd99dd99d9f9f99d9bdbdbd99bd9d9d9d99d9fffffffffffffffffffffffffffffffff9f99f9dbd9dd9d9d9dd9f9f99d999d99dd9dbd9d9d9d9dd9b9dbdbdbd9dd9dddbd99dd9d9f9ddbd9999df99dbdbd9d9f9dbd99d9dd9d99d99bd9ddbdbdd999db9dbd9d9ddbdd9d9d9fdd9f9f9f9bdffdffffffffffffffffffffffffffffffff9d9d9dbd9dbdbdbdbdbd9d9dd9fdf99f9bd9d9dbdbd9f999dd9d9d9d9f9f9f9bd9fddbdbd9db9d9d99d99df9d9d9dbd9d9d9d9f999db9d99d9d9f9d9d99d99d9d9d9dbdb9d9bdbdbd99bd9d9d9dd9d9fffffffffffffffffffffffffffffffffd9f9f9d9f9d9d9dd9d99f9f9bd9999d9ddb99f9d99d99dbd99bd9bdbd9d9ddddbd9f9dd9dbd9dbdbd9df9d9dbd9f9dbd9f9dbd9df99d99f99dbd9dbd9db999bd9dbd9d9d99d9d9d9dfd9f9f9fdbd9fdffffffffffffffffffffffffffffffffffdd99dbd9f9f9f9f9fdd9d9dd9dd9d9999d9d9d9ddbdd9d9fd99dd9dbdbdb99fdbd9f9f9d9d9d9d9d9bddbd9d9d9d9d9f9d9d9d99d999d99d9d9f9d9bd9d99d999d9f9d9f99d9f9f999d9d9d9dd9f9fffffffffffffffffffffffffffffffffff9f9dbd9d9d9d9d9d9dbdbd99f9bd9f9ddf99dbdb9d9bd9d99ddb9d9d9d9ddf9d9df9d9dbdbdbdfdbdddbd9f9f9f9f9f9dbd9f9fd9f9d9d9f9d9d9f9d9999d99df9d9dbd9dbdbd9d9ddbdbdbdb9f9dfffffffffffffffffffffffffffffffffffd9f9d9f9f9f9f9f9f9d9d9fd99d9d9db99d9d9d9d99d9db9db99d9f9f9f9f9f9df9f9dbd9d99d99dbf9df9dd9dd9dd9d9d9d9d99d99f99d9d9f9d9d99d999bd99dbd99d99d9d9dbdb9d9d9d9dd9dfffffffffffffffffffffffffffffffffffffd9dbd9d9d9d9d9d9f9f9d999d9f9999df99f9d9f9f9d99d9d9dbd9d9d9d9d9fd9d9fdd9f9ddbdfdddf9df99f9bdb9f9f9dbd9d99d99dbd9fd9f9d9db9d99d9d99d9fd9f99f9f9d9d9f9f9f99f9bdffffffffffffffffffffffffffffffffffff9f9dbdbdbdbd9f9d9d9f9ddf9d9dfd99df9d9bd9d9dbddbd9d9d9dbdbdbd9f9bdbd9bd9d9b9d99bdf9df9df9ddddd9d9dd9dbdbd99d9d9d99d9db999d999d99bd9d99d99d9d9dbdbd9d9d9df9ddfffffffffffffffffffffffffffffffffffffd9d9d9d9d9d9f9dbd9d9db99d9d999d99d99dd9f9d9d999db9d9f9d9dd9dbddd9d9fddf9dddbdfd9ddf9df9dbdb9bdbdb9f9d9d9d9f9dbd9fd999d9d9999f99d9db9d99dbdb9f9d9dbdbdbd99f9ffffffffffffffffffffffffffffffffffffff9dbd9f9f9f9d9d9dbdbd9dd9f99ddb9db9db9d9dbdbd9d99d9d99dbdbdbddb9f9fd9f9dbdbd9d9f9f9f99fdd9ddd9d9dd9d9d9dbd9d9d9d99f9d9d9bd9d99d9d99d9f9d99dd9dbd9d9d9d9fd9dffffffffffffffffffffffffffffffffffffff9d9f9dd9d9f9f9f9d9d9db9d99db99d9d99df9f9d9d9f9fd9f99d9d9d9df9dd9d99f9f9d9dbdbddfdddfd9f9db9fdbdbdf9f9f9d9dbdbdbd99d999d9999d999bddbd999d9bdbd9db9dbdbd9bd9fffffffffffffffffffffffffffffffffffffff9d9dbdbd9d9dd9f9f9f9df9df9d9d99fd99d9d9f9d9d999d9d9f9bdbd99f9f9fd9dd9f9fd9ddbddbdbdbd9dbdd9dd9d9dd9d9d9f9d9d9d9d99dbd99d99bd9fd99d9ddb9d99d9f9d9bd9d9fd9fffffffffffffffffffffffffffffffffffffff9dbdbd9d9f9db9f9d9d9d99d99d9f99d99d999f9d9f9dbddb9f99dd9d9fd9d9d9df9bdd9dbdf9dffdfdddfdf9d9f99f9f9bdbd9f9d9f9d9db9d99d9f99dd9d999f99b99d9d9f9d9bdddbdbd9dffffffffffffffffffffffffffffffffffffffff99d9d9f9d9f9dd9d9f9dbddbd9d99db9d99fd9dbd9d9d999d99d999f9d9f9f9db9dddbdbdf9dbd9f9f9f9d9df9dfd9d9ddd99d9dbd9d9f9d99d9999d999b99dd9d9d9d9dbd999dd9b9d9d9f9ffffffffffffffffffffffffffffffffffffffffdf9dbd9f99d999f9d9d9d99d9b99d99db9d99f9d9dbd9d9d9d999fd9dbd9d9f9ddbdbd9dd9fdfdfdfdf9fdf9df9dbdbdb9fdbdd9d9dbd9d9d99f9d9bd9d9d9b9d9d9d9b9d9ddb99dd9f9f9ddffffffffffffffffffffffffffffffffffffffff9dbd9d9ddf9df9d9f9dbdf99ddd9b9d9d99d99dbd9d9f9f9f9df999d9d9f9d9f99d9dbdbdf9dbddbdbdfdbddbddbddd9dd99d9bd9dbd9d9f99d9d99d999d99ddb9f9bdd99db9d9db9f9d9dbffffffffffffffffffffffffffffffffffffffffff9d9f9f999d99dbd9d9d99df99bd9d99d999d9f9d9f9d99d9db9d9f9f9f9dbd9dfdbddbdd9ffdfffdfdf9ddbd9f9db9fdb9df9ddbd9d9bd99f9999d999f99d999d99d999f99d9dbdd9dbdbdffffffffffffffffffffffffffffffffffffffffffddbd9d9fdf9fd9dbdbd9fd99dd9d999f99db9d9f9d9d9d99d9d9d9d9d9dbd9dbd9ddbddbdbd9f9dfdbdf9fdf9df9dd99dd99db9d9d9dd9d99d9db9d999d99dbd9d9d9d99d9999d99f9d9ddfffffffffffffffffffffffffffffffffffffffffff9d9dbd999d99f9d9dbd99fdb9d9bd9d999d99d9dbd9f9f9f99f99dd9f9d9f9d9f9fddbdfdffd009fdfdf9fdf9df9dfdbdf9dd9f9f9bd9f9d999d9bd9d9d99d99f99b9d9bd9f99f9d9f99ffffffffffffffffffffffffffffffffffffffffffff9db9dbddbd9d9d9d9d9d999d9bd99d9d999d9bd9dbd9d9d9dd9db9bd9f9dd9f9df9f9df9fdff909bdf9fdf9dfd9dbd9d99db9d9d9dd99d99f9d99d99f99bd9f999d9db9d9999f9dbd9dffffffffffffffffffffffffffffffffffffffffffffff9dd9d99d9fd9f9bd9f9dd99d99d9b9f99db9d99d9dbd99f9bd9d9d9d9dbdf9fd9fdfd9fdbdf09909fffdbdfdbdfd9f9fdf9df9dbd9bd99d9999d99d999d999d9d9d99d99d9d9d9d9fd9ffffffffffffffffffffffffffffffffffffffffffffd9db9dbdbd9999d9d9d9db9db9d999d99d99d9df9f9d9f9d9d9d9d9f9dbd99dd9f9dbdfdfdfd90d999ddfdf9fd9dbdd9d99d99d9d99d9db9d9f99d999d999d9999b9999d9b99f9bd999fffffffffffffffffffffffffffffffffffffffffffffff99d9d9d99dfd9d9bd999d9d9bd9d9d999d9b99d9f9d9dbd9dbdbd9f9ddfdf9fddfdbdbfdff0b00d09b9ffd9ff9dbdbdf9fd9f99fd9d9d99d9d9b9db9d9b9d9f9d99d99d9d99ddbdf9dfffffffffffffffffffffffffffffffffffffffffffff9ddbd9d9f9999f9d99f9db99d99999f99d9d9d9d99dbd9d9f9d9d9d9db9dbdf9ff9fdfdffdfc9d9099009dffd9df9dd99d99d9df99f9d99d9999d999d99d9999999db999999d99d99dfffffffffffffffffffffffffffffffffffffffffffffff9bddb9d9d9d99dbd99d9d9d9d9d9bd9db999db9ddbd9d9bd9dbd9f9fddbd9dfd9fdf9fdfff9b9099c900bd9fdf9df9fdf9fd9d99d9d9bd9b9d99999999999d9999999dbd9d9bd99f9fffffffffffffffffffffffffffffffffffffffffffffff9d999db99f99d999d9d99db99b99d9999d9d99d999d9f9d9dbd9f9d9dbddfbdbfdbdfdfffd00e909909009f9fdf9d9d99d99db9d99d9d99d99d999d9999d9999d99d99999bd99fd9dfffffffffffffffffffffffffffffffffffffffffffffffd9d9f9d9d9d9bd9d999bd9dd9d9999d9d9db9d9bddb9d9d9d9d9d9fdbddbddfddfdffdfdffb990da9d0900099b9ff9dfd9dbd9dbd9b999999999d999d99999999999999d9d9d99d99ffffffffffffffffffffffffffffffffffffffffffffffff9bd999d9999d999dbd9999999d9d9bd9b9d99d99d9d9f9f9f9f9d9fdbd9f9fbfdf9ffdfdf00cb990990db00009d9f999f9d9d9d99d999d99d9999999999999999999d99999bd9b9dffffffffffffffffffffffffffffffffffffffffffffffff9d9d9f99dbd9dbd99999b9999999bd99d99d9bd99df9d9d9d9d9fd9fddfdfdddbdfdfffff9db000990f00009e90bd9fd9d99f999d99d9999999999999999999999d9999bd9d99ddfffffffffffffffffffffffffffffffffffffffffffffffffd99bd99f9d999999999d9dbd999d99d999db9d99f999d9f9f9f9d9fd9f9f9fffffdffdfdfda909090999000090909999dbd999d9999999999999999999999999999999d9999f999ffffffffffffffffffffffffffffffffffffffffffffffffff9d99d9999999d999d9999999b99d99d9f99d99d99ddbd9d9ddf9f9dfdfdfdbdfdfdfffff09000909090099009000999999d999999999999999999990990999999999999d9d9d99ffffffffffffffffffffffffffffffffffffffffffffffffff999999d999db999999d99999d999f9999d999f9d9b9dbdbdb9df9f9fdbdfdffdfffdffff909a9090f09d000000900099999999999099999909999999909909999999d99999999dffffffffffffffffffffffffffffffffffffffffffffffffffd9d9f9999d99999d99999d99999999d999f9d999f9d9d9d9ddbdddfdbdf9ffdffdfffff99000000c990b0900900000009999999999909999999099090909999999999999bd9f9bfffffffffffffffffffffffffffffffffffffffffffffffffff999999d99999d999999999d99d9d999d999999d9d9dbdbddbddbf9fdfdffdffdffffd9d9a0009db0090000000000000000000099999909999999090909090909999999d99999dfffffffffffffffffffffffffffffffffffffffffffffffffff9999d99f99d999999999999999999999999d9dbd9bd9d9f9d9fddf9f9fdffdffff9b9bf9c900e909099009a900000000000000000099909090990000909999999999999999d9bffffffffffffbfffbfbfffffffffffffffffffffffffffffffff9d9b99999999999999999999999999999999999d9dbdd9ffd9f9dfdfdfdfffff99dc9d0900b090000900000000000000000000000000909090000900909099909999999d999dffffffffbffbdf9ffdff9fbf9ffbfffffffffffffffffffffffd9999d99999999999999909999999999099999d99d9d9bd9dbfdff9ffdffff999c9a9ff9909090a0990090900000000000000000000000000000000090909909999999999999fffffffbfffbffbbfbffbfbf9fb9bdbdbf9ffbfffffffffffffff99999999999d9999909999990990999999d99bdf9f9fdfdbdddbdffdfff909f09fdff990b00b09000990a000000000000000000000000000000009009990999909099999999ffffffdf9fbf9bdfffbbdbdbfbdbf9bbdbfbdfdbbdbffffffffffd99d999999999909999999999090909999999d99d9d9d9bddbfdfdffb909909df9bdff9d09000b0900b90900000000000000000000000000000000900909090999909999999dffffbbffbdfffbdbfdfbfbdbfbdbfdbdbdbbbfdbff9bfbfffffff9999999d99909999990990909090990999999d9f9f9fddbddffff090900090b9c9b9d909000909e9bc09000000000000000000000000000000000009099909909990990999ffffb9db9ffbf9fbfdbbdbdbdbdbf9bfbfbdfdbff9fff9fbdbffff999999999999999909990999999999999999dbd9d9d99fdbf999099000900b0db0d0b09090d000900990000000000000000000000000000000000000090099099099909909fff99fbfffbf9fbf9fbdbfbfbfbdbbdf9f9fbbbf9fbf9bf9f9ffff999999999999999099900990999999999d999d9f9dbdfdbd9900900090009099090bd99c09bda90900b0000000000000000000000000000000000000000900909909999990bffa9b9bdbdbfbdbfb9f9f9fdbdbdfbfbffbdfdbfbdbfdbfbf9bff990999999099999990999999999909999b9d9f9dbd9999990000090909090900909d909b000990000090900000000000000000000000000000000000000090090990990999df999bdbbfbdbfbdbffbfbf9bfbfb9f9f9fbfbf9f9f9bbdbdbf9dbf9990999999999099909999909099099d99999999900900009000090000900b90f0ad0909990cf909090000000000000000000000000000000000000000000900909999909fb09b0b9f9fbf9fbf9bdbdbff9ffffbffbfdbdbfbfbfdbbf9f9bb9099999999990999990909099999999999999990900000000000000090f900900099d990d9000b9a0000900000000000000000000000000000000000000000000909909999f0090999fdbfbdbdbdbdfbfbf9ff9fbdf9fdbfbfdbdbdb9f9bf9f990909999990999090999999990999999999900000000000000000009099009099b90909900009090bc900000000000000000000000000000000000000000000000000909099f909b9b9bbdbbfbfbfbbdbdbfbff9ffbffbfbdbfffbfbf9fb9b9a990990990999999990090999999990990900000000090909009000009ad090b000f0f909db09090c9009090000000000000000000000000000000000000000000000099990db090090bdbbdbdbdbdfbfbfffdbfbf9f9ff9ff9fb9f9fb9bdbd99a9909909990909099990990999099990900000000000000000000009099a90099099cb90b00000b90b000000000000000000000000000000000000000000000000000000909000909b9bbdbfbfbfbbdfdbf9bf9f9fbfbdfbffbdfbf9ffdb9bb99909099909999999090990999090000000000000000009000000000000090990ad0f9d09090909909009009000000000000000000000000000000000000000000000000900900909099bdbdbdfbdbdfbbf9ff9fbfbdf9fbfdbdfbf9fb9b9f99db0909090990909909009099909000000000000000000000090900000909009a099b9fbd09a000009090090000000000000000000000000000000000000000000000000000000000090bdbbfbf9fbffbfdbf9bbb9bdbbfbdbfffbdbf9dbfb99a909000909099990909090909000000000000000000000000000000000090a909900cf0dbd9900900b009a090090000000000000000000000000000000000000000000000090000000090b9f9fbf9f9fb9bdbf9dbf9bdb9fbdb9fbf9fbbd9fb99b9b99090990909009000090000000000000000000000000000090090000900dadb999fb909e90a09090090000000000000000000000000000000000000000000000000000000000009099f9fbdbfbfbdbfb9bbb99bdbdbbdbfffdfbf9fbf9db090900009009090900090000000000000000000000000000090900000090090b90d00b9d09999909a90090009090000000000000000000000000000000000000000000000000000000009bbfbdbfbdbdbdb9f9d99fb9b9bdbbdb9bbbdb9f9bb999b00909009909000090000000000000000000000000000000000000090a90990f909dcb9090c90090b0009a0000000000000000000000000000000000000000000000000000000000090dbdbfbdbbdbb9f99bb9b999bdb9f9bfffdfbdbbf9db090900009000000090000000000000000000000000000000000000090009090a90f90b90909b9090b009000909009000000000000000000000000000000000000000000000000000000099bf9bfbdbf9f9bbd99b9bdb9b9b9f99b9bf9f99fbbdb090900000900090000000000000000000000000000000000000000009009a9909090dfba9009a90909009000000000000000000000000000000000000000000000000000000000000900bf9fbdbf99b9bd9b9bdbdb9f9f9f9bf9fb9fbfb9f9b9909000000000000000000000000000000000000000000000000090000a909c0b0f9cb9d900b009c00a9000090b0000000000000000000000000000000000000000000000000000000009b9fbdbb9bbbdb9b9bdbdbdf9bf9f9f99b9f99b9ff9b00900000000000000000000000000000000000000000000000090009090909a9099090df09009a9b90909090000900000000000000000000000000000000000000000000000000000000bdb9fbf9f9d9b9b9f9bdbdbbfdbf9f9fbdb9ff9f9bf9b9000000000000000000000000000000000000000000000000000000000009099bc9f9ad90090900990900a90090000000000000000000000000000000000000000000000000000000000bfbdb9b9bb99d9f9f9bffdfbfdbfbf9f9db9bf9f9bf9090000000000000000000000000000000000000000000000000000009090a9ad09ad99fb0909a9b00a00990b000900000000000000000000000000000000000000000000000000000009bdbbdbdb9db9bb9ffffdbffffffdfffbfbf9f9bb9f9b90000000000000000000000000000000000000000000000090000090000bd090bd9fe9f9c90b9a90999f000909000000000000000000000000000000000000000000000000000000009bdbbdb9b99b9fbdffbdfbffbdbffbff9fdf9f9bd9fbdb00000000000000000000000000000000000000000900000000000000090900b9daf990fb90b09090f0b0d0b00090000000000000000000000000000000000000000000000000000000adbdbb9b9db9f9ff9ffbffffffffffffffbfffbdbb9b9f9000000000000000000000000000000000000000000000900000000090009900f9dfd9d0b90d00a90909b00090000000000000000000000000000000000000000000000000000000009b9bdbdb9b9fbf9fffffffffffffffffffffbdfbd9bdb9b0000000000000000000000000000000000000000009000000090090a9000bd9df9fa99909da9b9e909a909000900000000000000000000000000000000000000000000000000000009bfb9b999bdbdffffffffffffffffffffffffffffbdb9f900000000000000000000000000000000000000009000009090000ac900b000b0fdfd9c099a9b00990a909090000000000000000000000000000000000000000000009000000000009f9bdb09bbdbfbffbffffffffffffffffffffffbdbdbdb9000000000000000000000000000000000000009000090900c0000909909090999fff909bb0900090090090b009000000000000000000000000000000000000000000b0f00000000000bf9bd9bd9bfffffffffffffffffffffffffffffffbfbdb9000000000000000000000000000000000000000090000f9f0090090a09cbdbc9dfdbd99bb99a90b0000a9c90090000000000000000000000000000000000000000009af000000000b9bdb9b9bfdbdfbfdbfffffbffffffffffffffffffff9f9b0000000000000000000000000000000000000000009000f0900000990b0909909ff9e9b900a90b900090099000000000000000000000000000000000000000000000090f000000009f9b9b9fbdbffbffffffffffffbffbfbfffffbfffffdfbfd00000000900000000000000000000000000000000900909000b09000d09adf0f9f9e9900bd9db00900009a009000000000000000000000000000000000000000000ad0fb90000000f9bbdbdbdbffffffbffbffbff9ff9ffffffbffdfbffbf9fb9000000000000000000000000000000000000909009b000009090009a9adb9f9c9e9909f0b0b0900b009009000000000000000000000000000000000000000000909a090cf000009bbd9b9fbfffbffbdfbdfbfdbffbffbf9fbdfffbfffffff9ff00000000000000000000000000000000000000a900009090000090bd9dbde9f999bc9d9f9f9fab009ca90a90000000000000000000000000000000000000000000090fb9bb000009bb9db9fbfffbffbffbfdbff9ff9fffffffbffffbffffffbdf0000009b0000000000000000000000000000000090000090900090f09dbdffcbc9bdaf9b09090b0a990900090000000000000000000000000000000000000009af9a90ff000009f99fbffffdbfdfbfbdffbfdbffbff9f9fbffdbffdfbf9f9ffb90000000000000000000000000000000900009090090900000090f9b0bdbd9f99df999d0909ba9e990000900000000000000000000000000000000000000009e09009ef900009bb9fbdbdbfbfffbdfdbf9ffbfdbdb9fbfffdbffdfbfffffffbdf90000d000000000000000000000000000090000000000009090f9909d0fbff9cb9cbdb99a90da9a09bb0a9000000000000000000000000000000000000000b9b090fff00000099f9bfbffffffbffbffffb9db99b9f9dbdbffffbffbdbfbf9ffbf0000b000000000000000000000000000009000909090900b090b0fcbdfddbf9e99abc9d00b999900909000000000000000000000000000000000000000000000a9ff9000000f9bfdbdbf9fbfdbdfbf9bdb99b9db9b99bdbdbfffffffffff9bdbf00090000000000000000000000000000009000000a009009a9099ff9fbd0f9909b99b09b090a099a0009000000000000000000000000000000000000000000000fb0000009b9f9bfbfffff9ffbfdbf9b9fddfbdfdffdbdbfdbdbdbdbdbfffffda000000000000000000000000000000000000900909009909090f9ffd9e9ff990bda9db0b9090b00090000000000000000000000000000000000000000000009b90000000bdfbff9fbdbf9ffbf9bd99fdfbfbdbdbbdbffdfbfffbfbffff9f9fb90000000000000000000000000000090090a9009c090b9a90bcb9dbfffdfd00ada9bb0990b0090a900090000000000000000000000000000000000000000000000000000dbb9f9bfdfbfbffbdbdb9fffbdbdffbffdbf99b9dbdbdbdbf9fffffff909000000000000000000000000000000900090b9f99c9bc999cb990fbffbd9fb0dab009b9b09009b000000900000000000000000000000000000000000000900000000bdfbff9fbdffdbf9f9bdb99dbffbffdbfffff9f99b9fb9bdbfbfbfbfdf000000000000000000000000000000000900a90b00b909b0a9bdadbdf9fffdf9bb90dbbfb9009b9a90000000000000000000000000000000000000000000000000000bdb9f9bfbfbf9bf9f9f999fb9ffbfffbfff9ffffbd099909bfffdfdffbf00000000000000000000000000000090000bd0909990bd0b9c99dfdbdff9fbd9a9b0b9fb9b0b00090000000000000000000000000000000000000000000000000000bdbffffffdffdbf9f9b999bf9ffbdffb9fbffffbff900099bffdbfbfbdff9000000000000000000000009000000009090b09a9cbd0b909b0f9ffdf9f090bbb0b0b9b0b9090b09a000000900000000000000000000000000000000000000000009bdbf9fbfbfbfb99b9900bdbf9f9b9b9999b99f9bb900009f9fbffffffbfb0000000000000000000000000090000009e90bd0b90b990b0d99f9ffbffd990beb09099a9b9a9cb0900090000000000000000000000000000000000000009000000fbf9ffbdbdfdbdb9900090bfb9b9999d9b999999999999f9bbfdbfbdbfdffd0000000000000000000000000000909090bd0a90f90da90b090f909dbdb09bdb90a9a9b009da99a9a900000000000000000000000000000000000000000000000bf9fffbfffbfbfb990000099999999bd9b9d9f9b9d9dbfb9bdbdbbdffffbffbb000000000000000000000009000000009d0b9b09a9b09a99fd9ebfbcb0900bb0a909b0db9a99a9b0000009000000000000000000000000000000000000f90000f9ffb9f9fbdbf99f9b9d999999999f9fbfdbf9f9fbdfbfdbdbdbfdbf9f9fffd000000000000000000000090000090a9f9af90c9a9090b9b0f9f9d0099d09b9a9bfa9a9b0f9f0900b000000000000000000000000000000000000000000000000bfbffffbdbbdbfb9bdbbdb9fdbffffbdb9b9fbffdfbfdfbf9b9b9b9fbbfffbfd00000000000000000000000009000900fd0db9b09b0b0bc9ffcbab9a90b00b00a9b09a9bb909f9a9b09000900000000000000000000000000000000000b00009f9f9fbdbbd9b99fbdbdbfdfbfdbf9b9b09999b9fbffbfbdbf9bdb9f9fdbbdffb0000000000000000000000000a9000909bd909dbcbd9f9b00f9d90090b9f09abdb090990009ab09000009000000000000000000000000000000000000090000bfbffbdbdbbf9fb9b9b9f9fbffbf9f0999f9bd9f9f9fffdbdb99b9f9f9bdfbff9a0000000000000000000000090000009f09090f0bdaf9f099ff9e9f9ede90abdac900000090b909a909a0000000000000000000000000000000000000000009f9fdbdbfb9f99b9dbdbfbfbfdbdb9b9bdb99f9b9bfff9fbdb99f9f9f9bff9fffbd00000000000000000009009000909b90999cbd9f9b9b00b09dbdf9a9b99b09a9b9a09a000900b00a0009090000000000000000000000000000000000f0000abfbfbb9f9f9fbdb9b9f99fdbfbf9b999b9ff9f9f999bf9fb9b9bdbfbfdf9fbfff9000000000000000000009000900000c9e9a90f9f0909090dabc9fdff9a9000000f9a090000000b090900a000000000000000000000000000000000009b9b9d9fbdfdb9b9f9fbdb99bffbf9f9b99999f9fffff9f9f9ff9f99f9fdbdbfbf9f9ff9000000000000000000000000090009090909900fd00a9a9fddbdbfdfdff0000099a9a00090000000a009900000000000000000000000000000000009f9f9fbfbdbb9bdbf9f9fbf9b99bdbfbf9f9fbfffffffffffffdbb99b9ffbfffdffffffff00000000000000000000009000009a90909a09f90b09c9f9fbff9cbfffd000999ab00000000009009090009000000000000000000000000000000f0ffbffbdf9fbdbf9f9ffbdf9f99bdbf9f9f9ffdffffffffffffffbdb9dfdbfdffbf9ff9fbda000000000000000000090000000000bda9090909090b9bcbd9999f9fff000000090000900000000000090000000000000000000000000000000099fbdfbdbbfbdbf9bfbf9ffbf9f9999fb9ffffbfffffffffffffff999bfbffffbdfffffffff900000000000000000000000900909909c90000b009bd0d9fb09a9dffdf00009000000900000a0009a09a90090000000000000000000000000000b9ffbffbdbdbf9ffdbdffbdfffffb9b9db9fffffffffffffffffffb9f9ffffffffffffffffff0000000000000000000009000000e99f9e9090db0d0f999d0bc90bdbbf009000f009a00009a900000900000000000000000000000000000000009ff9fb9dbfbf9fbdbffbdffbdff9ff99b9fffbdffffffffffffff999fffffffffffffffffbfb000000000000000000000000090090fcb909fa90db990d09f09bd9addf00009a9e00090000000090900000000000000000000000000000000000ffbfb9fbf9fdbffbfffffbfffbfff9f999fbdfffffffffffffffdbffffffffffffffffffffdf90000000000000000009000900090bdbde9ebd9dbc0099b9f90f9090bf00000909a090000a000000a0900900000000000000000000000000000bdbdbdb9bdbfbf9ffdbfdff9ffffffffbf99fbffbfffffffffffbf9ffffffffffffffffffffffb00000000000000000000900000c9090b9f9d909df9b009d0bd0f9009909a900009909000900000090090000000000000000000000000000000fbfffbdbdbdbdbfbffffbfffffffffffffbf9f9ffffffffffffffffffffffffffffffffffffbff0000000000000000000000000b00b09090b0b90bdfdff0990bdf0b9c900000b09000009a000000909000000900000000000000000000000009bdfb9fb9bbfbfffdfffffffffffffffffffff9fbdffffffffffffffffffffffffffffffffffffdb00000000000000000090900909900b0d909009cffdf90b09090909b90000b00a09009a9a0000900a09090000000000000000000000000000bdfbdb9b9fdbdbdbffbfffffffffffffffffdbffffbfffffffffffffffffffffffffffffffffffbf90000000000000000000009a9009909b09a9f9bb9bb9090909ab0f090000090900b000090090a909000a0000000000000000000000000000fbffb9fdb9bffffffffffbffbffffffffffbffbdbfdffffffffffffffffffbdfffffffffffffffdbf00000000000000009000909a0b00b09db90909c900a9cb9b090f9b0b000a000900b0b009a09c90090909090000000000000000000000009ff9f9bb99b9bffbfbfdffdfffffffffffdfff9fffbffffffffffffffffbffffbffffffffffffffbdb00000000000009000090a909909e9f0dcbdadbbf99cb90c09a9cbd900b0900009a0900b00909a90a000000000000000000000000000000fb9b9bdbb90ffdbffffbfbffffffbfdbffbffbffbdffbffffffffffffffffbfffffffffffffffff9bd0000000000000000000090f0a9f9909b9fd9f0d90ffdadb9a9fb90b0b0b00b09a09a0b0a9ca90090090b09000000000000000000000009fbdb9f9f90f9fbfdf9fffffbffffdfbff9ffbdf9fff9ffffffffffffbf9fbdffbfbffffffffffff99b0000000000000000900b0909db9a90b0dfbffdbddf9a9b90dff9cf00009b009090a9a090b0909a0000000000000000000000000000000ff9b90bb099bffffbffbf9fffdbfbbffdbfb9fbff9fbfffffffffbfdbdbf9fb99f9fbfffffffffffb0f900000000000000000900b0a9009c909b0d9dbdfbfdf90db90fdb9bb0a0b90000b009a00ab090900b09090000000000000000000000009b9b9909b009fbfffbffffbdffffdfb9bdbdbdb9bfdfbdfffffffffbfb9b999b99bdf9ffbfffffffd9b0000000000000000900990990bdb9a9c9b90dfffdbdb090d99db0c90000b00909cba90bfb90b009a00a00000000000000000000000000f9090909009b9fdbdff9fbffbf9bb99b9a9b9b9f9bbfdbfffffffdbd9bd9b9bdb9f9bfbfdfffffffb9f9000000000000090009a090ad0b0d90b000bff9dbdf9d09fd9a9d9a0a9b0bf0babadba9a90a9a9a90909000000000000000000000000bb0900090909fffbffbffbfdbf9bd99f999999909bdf9bfffffffbbfbb99b9bd9bdbbffdfffffffff90b000000000000000009009dad9b0909090b9d99da9db09bdf9099a900000b09b0f9fbcbb9a90b9a9a0a9a900000000000000000000000990909000000b9ffbff9fdfbdbf9b9b9a9f9b099b9b9ffdffffffdf999b90990b9a9d9bbfbfffbfff9f9b0000000000000090090b09b00b09a9090099cbdff090d9ff9009a900a9ab0b0bb0fb9a9a00b00b90900a000000000000000000000000990d0909009db9fdfbfbfbfb9b09b999b9999b9090b9bbbfffffbff0909fb090090b99999b9fffff0b900000000000009000bc909e9f90f090b0fa9dbdbdbd090d9dad0ddfa09a90b0b90bffa9a9b000b00b00b9000000000000000000000009a9bb9a90000bffbfb9f9b9999099090909adb909b99f9fdfffffdb9b90bd09000009000db9f9ffff9909000000000000000009a90909eb90b09c9909d9efdb0099ff99bbf909ba9b0b00afff900f0a0000b090000000000000000000000000909f9f9090009f9bdf9f9b990000000000009f0009099bdbbfbfffb909090b00009000009a9dbfffff000000000000000000999090f009b9cbc9fbf09f9bd900090ff9ca090b0a0900a9ab0bbfebbff0b00b0ba9a9000000000000000000000090b9b09000009bffbfbfbdbdb000000000000b990090b9bdffffbdbdb90900000000000db9bffffffb00000000000000009000a9a90b9009b9fbc9dbd0d0bdb90b9adb999e99b000b00a9a90dffcbfffcfa9adbcda0000000000000000000000909b990900000dbdbdbf9bfb9f900000000000009009cb9b9fbffffbd09090900000a9b90999fbffff90000000000009000b99c909d0b90d0909fbc99999d90090dffdbc99a9000a00a9a9abbb9bffffbb0ffffbb090000000000000000000000990000000000bbf9bfdff9f9b9090900000009000999b9fbfdf9fbdbb9009909a9b9900b9fbdffffd000000000000000090009a9e99c0d0b09a90bd9dad09d9ffffdfdbda900b090bb9a9b9009a9bbbbdffff0fd000000000000000000000009000900000009bd9abdbb9b9b909b00090090000a9b0b9f9f9fbfbdb990b000099000099dbf9fbfffb0000000000009009009b09090f9db900090bd90b909ffffdbfbfbc9d0900fba9e0f000ba000909babb9fbfa000c000000000000000000090900000000009bbd9b9090909b909b90900900990999b9fbfbdbdbbdb999990009099a9b90fbdfff90000000000000000a900909090f909909ad9099d90ffdf9a9009dbdb09a9a9e9bba9a00b00a0009900a90b909a9a9000000000000000000ba9000000000099b9900000000090909090099099b0db999f9bfbdb9fbc9a99000900909b990b9fff900000000000000900b09a9f090f9009c9ffff09cbdfbdf9fff0909d900fbfbfadbac9ad0b00b0a00000000000000000000000000000000990000000009b9b000090090009000000009009a909b9fbf9f9bdb9f99b990090000909090bfdffb900000000000000b009c90d909bd90f9fdfdf9099df9fdf9fdbd0f909090bb09a9b0b9ab0b0000000a0090900000900000000000000000000000000000009000099b000090000000000009090dbdb9f9bdbdbdbbda90909000900009adfdbff9f0000000000000900909b0b09f0fffdffbbbfd90ff9fbf9bdbc9f9cb099bcbb000a90a9000000000009a00a00090a09000000000000000000000000000000900b0b0f90000000000000000909a9b9f9f9b9b9bd9bd99a90a90a009d099bff9fb900000000090000900a90d0b009099a999c0dbe9d9fc99c90990f9f9f09bb000000000b00b0000009009a0900009000000000000000000000000000000000000999909b0000000009009a90b99bdb9b9f9f9b9b9bbfbdbd9f99fda9fbe9bdbdb0900000000000000b009a909b09909dbcb990d90fd9b00bdb0bd9e9f9f90bb000000000000000000a0000f0cb0000b00000000000000000000000000000000090b0b9b0900909909d09bdb909f99bdbdb9b909dad990bdbf9ff9bdb9099fb0b900000000000000b0090090b099a0f909909a99099bd09d909090bdbd090000000000000000000000000fffff0a009000000000000000000000000000000000009099099000090009a9b09909b9b0f9b9b9da99b99bfbf9f9fb9bdb90b9f099900000000000000900d09b09c9ac9990b9c90d0000bd0bc9e9ad09990090900000000b00000000000009affffffda000000000000000000000000000000000000009a9b0b9000009a999090b90909b9bdbda99900909999b9f90909909909b900900000000000000090a000b9e9be9e900b0b09b0909d99f9fdbd000b9ad0000000000a000000000000adfffffffdf0000000000000000000000000000000000000090990900000090b99b9000090090b9b9bb9000b00b9f9bfb9000b09090b9b0000000000000009a99090099099f9e99090909909f90d9f9adbd900dbd9000000ba9000000000000a9fffffffffb000000000000000000000000000000000000099090000009000909a909900009099a9d9009909909d0bd99000b99a90b090000000000000090000090db0f0bd9f9e0a9da9a0dbda9909c9ff9a9dbc9b00000b0000000000000b09abbbffdebf0000000000000000000000000000000000000000000000090090009909b00009009f99a90900cb090b9f9b09009909090900900000000000000909b00b0909d0a9fdbd0bc909b009d09dbfdbd09a9990000000b0000000000000a000900bfbd900090000000000000000000000000000000000000000000090099000909f90000909b990090b99b009b99090b090b900009000000000000000b00909099a9909900bda9f9f0b09b9b90bdff90b09a90900000a0b00000000000b000000000ba00000f000000000000000000000000000000000000000000909009900b909900090b0da909009a9c900fb900909a9009090000000000000000009a0b0b090da90990ffdb0f9bdbc900d90ff9f9da9dad9000000000000000000b00000ac09a09009ff000d00000000000000000000000000000000000000b090b9000990b9b0090099b9900099dbb9099900b09090900000090000000000000000909090b0990da0bffb0ff09adbdbdf0990fdfffda99000000000a00090000000000bcb0a09009eb09a9a0000000000000000000000000000000000000909099000b0909900000909090009a9a99090b09099b090000009000000000000000090900b0f099a9099ffffdf99df9fdfdbd90f9e9ffff90b0000a0009a00a00000000000b0909a000bdb0000000000000000000000000000000000000000009000000909a9000000009a9000099999090f9009b09000000000000000000000000000a90999cbeda99e9ff9a9f0bdf9f0bd0b09d90f9ffd9000009a0000b00b00000000009a000090000f09e90000000000000000000000000000000000090009090900909909000009090b00000000bc90b9009b9900000000000000000000000009000e0b99fbdadfebd099090b90d9db990b0b0bcbfbcb000000000000b000000000b00000000009b09e900b000000000000000000000000000000000009000000090b000b00009000990009099b9b999009b00000090000000000000000090000090990fcbdaf9b9fa9fa0b09099ff9f99c9909b9c9bd00000b00000b00000000a0000000000000ada0b000000000000000000000000000000000000000009090909909900009009090900009a9090000009909009000000000000000000009009a000bdbdbf90fffdff999009fdf0b90a99a0f0db9cb0000b0000a00000000a00b0000000000009a9bcbd00000000000000000000000000000000000009000000900000900009000000000009090b09000000000009000000000000000000000009b90ffb090b09fbfff0a9b099dbda990bd99f9c9b000000a9000000000000b0000000000a0009ac9bcbe90000000000000000000000000000000000000090000b900000000090000090090000090090000090900000000000000000000000900000b9fde909ff9dffffd00fc9fdbda99ebe9ffbcf900b0090a0900000000000000000000900009b0fbdb0000000000000000000000000000000000000000090900009000000000000000009090009000000000000090000000000000000090090900ffb90beffffffdfa9fbdbdbc9f9a9d9ffbcbda0000a0a9a00000000000000000000b0090000090b000000000000000000000000000000000000000090000909000090a90000909b0000009000000000000090000090000000000900900a00009bff90b99fffffbfdffdf9d99f909db0b99f9fd0000000090000000000000000a0a00000000000000000000000000000000000000000000000000000000900009090090d09900a9099009000900000000000000000a900000000000a00090909a09fcb0fa9ff9f9bfdfb9d0d90d9e9fd9fa9cbb00a9a90a0000000000000000090900b09000a00000000000000000000000000000000000000000000000090000b090090b09f9009ac990b090009000000000000000000000000900909000090900bfdfdffffff099f0db990fdfdbf9f009b090000000a9a00000000000000000a0a900a0b009000000000000000000000000000000000000000000000090000000009a999a90990990b09000900000000000000009000090000000000a900a00009ffffffffdbf0fbdbc9dbdb9ad9fa9b0dbcb0000b0009000000a000000000a9090a90900900b0a900000000000000000000000000000000000000000000009909009900999a009a909009000000000000000000000000000000090090099c9000fffbffffbf09adf09db999adb0b9d09a9a900000b000000000000a9a0000000000000b0a00090c9000000000000000000000000000000000000000000000009090009b0b0d90090090900b00000000000000900000000000000000009a0b00000bfdbffbcd99dbdfd909e90bcbdba90909000a0000000000000000b0b000000a090a0090900a9a0a9000000000000000000000000000000000000000000000000990099090b009900a0909090000000000000000000000090090009009c0f9009f0fcb9fb90a99ffbdb09bd999cdb0900f00000b000a00000a09a9a9000000a00009000000b00909000000000000000000000000000000000000000000000000900b0000b09090a9090000000000000000000000000000000000900090b90b000a9bb9ed09bd9e9fd9dbd09e9cb90f09b09000b00a090000009a9a00000000090a0000000000900000000000000000000000000000000000000000000000000000900909909000909000090000000000000000000000000909000009a900ad000d9000b90f0bf9dff90909f9ff90b90fcbf0000b09a0000000a00000000000000900090a0900000000000000000000000000000000000000000000000000000090090000090b0900000900000000000000000000000000000a000b00009090b00beff99099d00fbdff9a909fdbb09a99bfd000000a9a0000000b0000a000000a00a90a090000000000000000000000000000000000000000000000000000000000009009a900009000000000000000000000000000000000009000090bcb009009fffe9f0afbd0fbd9c90f09fd0bc9eb09f00a000900000000000a09090000090090000000090b00000000000000000000000000000000000000000000000000000000900009000090000000000000000000000000000900900090900c9009a09ffffff0bdfffb9db09df9909abdbf90ff9000000a0000000b0ba900a000000000000909090a0000000000000000000000000000900000000000000000000000000000000900000000000000000000000000009000000000009a000a090b0090cfffffff9bffb09a09dbbd0f9fdfff0ffdb000000000a9a0000000b9000000000b0b000a9a900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090909a90da09bffffffb0a9ffff990b00bdf0bfbdbf9bfd0000000b00000b0b09a0a00a0000a00009a90000090000000000000000000900090000000000000000000000000000000000000000000000000000000000000000000900000000900090000fb0d0cfffffff99c909fba909bddfb90ddf09f09f0000a9a00000a000a009000009a90000a0000b0f00009000000000000000b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000a90bd00fbffffffff9afb09bf9b0fbcbfb90fbe9bfadf9000009a9a00b900b000000000a000009090a90c9000000000000000000900009000000000000000000000000000000000000000000000000000000000000000000000000000000009090c90bdbdfffffffffdf90be9f9fb9b9b09a9f9fdedbd9000a9a0009a0ab00000a00000090b000a0900bfaf0900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0b09eff9ffffffffffb099fffffc9009ada990b9b0b900000000000900000a090a9000a000a09a0b0fdfbc0000000000000000000900a00000000000000000000000000000000000009000000000000000000000000000000000000000009a9090e9b09ffffffffffff909fdff99f9b0999009009d000009a9a9a00000000900000000900009a900a9ebd9a90000000000000000900009000000000000000000000000000000000000000000000000000000000000000000000000000900000f0b900be9adfffffffffff09b9a9e9009e000d0db0a99090a000a000a00000a0a000a000a00a0f00b9f9f0a000000000000000090000900000900000000090000000000000000000900000000000000000000000000000000000000000009c9b009000099ffffffffffffff09a9d9bd9f9b0b0b90d99a0a00bb09000090a09000a9090b009090b0b000a09090000000000000000a0000000000000000000000000000000000000000000a9000000000000000000000000000000000000000b0090009000a9bfffffffffffff0d9ad0f90f090d0909f0900000ba00000a090a0090a0a00b0a000000b099a09a9000000000000000090000000000000090000000000000000000000000000c0900000000000000000000000000000000000009f00900000090cffffffffffffbb0bdb90f90bdabb09f0f00000b09a000090a090b0a900b000000000900a099a000000000000000090000000000000000000000000000000000000000000090b000000000000000000000000000000000a00090090a009000009bffffffffff90990bd9f90b909d0bc9f990009a9a90000a009aa09000b00b090000a0009bea090000000000000000000b0000000000000000000000000000000000000000a0000000000000000000000000000000000090000b90090900090b00b9b9f9bf990a00ad0d00b0d0b0b0bb09a000a000000a900a090b009a09a000a0b009a9a099000000900900000000000000000000000000b00000000000000000000000900000000000000000000000000000000000000900900f000009000090009a9a90a00000999a900b0b0b099cb90900900000000009a00000a9a09ba0900b90009a0a000000000000000000000009000a0000000000900b0000000000000000000009000000000000000000000000000000000000000909900000b09000000009a9000000a09009b0b909a0b90900a00a00a000a0ba90000a9a90a0900a90a0b0a090900909000000000009000900a0900000000000a0000000000000000000000000000000000000000000000000000000000009009a90a00000090b0000000000000000090b9a0bda90f9eb00b0000000000009a9a00900000b0b0a009a909ad0000000000900000000000000009000c00900000090000000000000000000000000000000000000000000000000000000009a90a900009000099e900000000a0000000900bd00b9bbdbdb9b0b9a0a900000000a9b00a0009a9ada90b0a9e9a9a09000b0000a900000000000000000009000000000000900000000000000000000000000000000000000000000000000000000009009f09c009a09a000000009a0a0000a0090900a9fbf00b99cb0900a0a000a09af0b9a90a000b0a9e9b0b0b09a0b00000b0000000000000000000000a00009000000000000000000000000000000000000000000000000000000000000009009090009a909090990000000000900a000909b0909a9b99acb0900a0b0009a09ab0bb0b00a9a9ab09eb0a9af0f09000909000009000000000090000090000000000000000000000000000000000000000000000000000000000000000090090a9acada9090b0009a0000000000a0a900f90ad090009a90b99090b009a9a9a0bba9bb0b00b9a9ab9ba90909a9b0a0090a000009000000000000000000000900000000000000000000000000000000000000000000000000000000000000a0b009090909000d090f00900000000009000f0099090a09000b09a90bb09a9a9a9bf09a9a90ba9a9a9be9bb0bba9a0909a00009a90a0000000000000000000000000000000000000000000000000000000000000009000000000000000000a909090f0f09a9009a9090b9a900000000a0b0b09b009f000a0009a9c9a99ba9a09ab0bbe9a9a009a9a9a9ba9af0f0f9a000000900000090000090000000000000000000000000000000000000000000000a000000000a00000000000000000900900c0909f9c9a009cb0b09000000000000000ac09a00f99000009a90dab09ab0af9fb0bb9a9a9aa9b0fa99bf9bb9a090a90900a90090000090000090000000000000000000000000000000c0b0000000f000000ad0000000000000000000000000b0b0b090b0d09a90090000000000009a00099b00999a000000f9e9a99bab90b9ba9bb0a9a9ab9bebb9bab0bb00a9000000a090000000900a0000009000000000000000009fd000000009000000009a00c0f0000090000000d0090f00009009e9c90d090bdb0b009090b0000000000a0000b0a0a90da000009b00b9bda9f0bfafb9a0b09a9ab9a9b9ba9b9b009a90a09090900009a909a90090000000900000009000000000a9a90a0000a90000a00c909a00000a000000a009a0009090a9009a9a9a9ad09cb0da90a090a00000000000b0090900a90db00000bb0a9a9abb0b9ba9ba9a0fb9eb9aba9b0b09adada90000a009a90000a000900a9009a0000000000000000009000000900900c000def00ac90c900000000009009f0b00a900b00909a9c9a90bdb09a990a909a00000009a0b9a0a90900090b0000db9e909a9bfba9b0900bb0bb9a9b9a9a9a09a9a9a009a90a0000009009a0a900000090b090000000000000000000000c0adbdefffffdffeff0e90c09ca900a900909a9c090090b090b90db9009ad00b00000900000a00bca09d000999e90000ba9a99ba9abb09a0a00bbcbb9abb9a9a000ba9a0b009000000000a0009a00909a0b00000000000009000000000900000b0d0a0b0f9b9bf99b9a90f90cb9c0090e9adad0b9a09a000da9e9b0009090a9090009a0009000b0b09b0a009a09a000009090a09a909a00090b0bbb0b09ab0b09a9000090a00a0000090009a000900a090090a0900000000000000000009a0900e90c9c9ad0a000a009a90a0b00b9ea090909a90090099a9a990009d00a0900a00b0009a00a9a00a9a090a9c9b00900000a0b9bb9a9a90000a9b0bfbbb090a0b09a9a9a0900000000a0a90000a00a900a90a090a09a9000000a00090000090a0900b0bacb0bc9a90000009090b0009cb0f0b09a9ac9a00909e99a90b0090a90900099009a09a9a90a9a0090bc9b0090b00900a90a9a00a00a90a9b0b000a090a0a000000a0b0900b000000000900000b0009000900000090090000000000c909e9f0909b0bcb000000000a0a00f0b0b090b0da9090b09a0b090a909990009000a90a00900b0a09af0a9a90b09a000a000a0a90ab9b0b000000a9a0b09a0000a90000000b0b00a000000000a90a0000000000a09a0a9a00000009090ad0f9a9eb09a0f0b0a9a90b000000a9090b0b0009abc9a9ca9a09ad9099ad9a0d009000a090009b0b0b0b0ba9a9a90a09900b0090a9090a90a0b0090000000b0a00900b00b000000000a90b00a90b00000000000000b09a0090090a00f00a0a900b00909c9a9b0f9a9cb0000a00000ca0a9009a9ad0b9dab9a9a090ada090ad9a9000a0090a9b00900b0b9e9a9ada90900b0090a90a00a909ba900a0a09a0b0b0b0a0b0b0000009a0b0a000090000000000000a00000a090a0b0a9000009090a909baf0a90bca9a0da90b0000900b0b0b0ab0a9a0b90ba90fad0b0b99990b9ad9d09090ba9009b09b0f9ab9a90a9aad0bd0b0000a90b00a9a900a00090a09000b0b0b0b0b0a90b0000090b0a00a00000000000000a0909a909009e9e9a9a0b09b0a0d0bdaf0b9e9bb0ab0b090a0000a90bc9a9adb0a909efbdabcb00a0cb00909a9090b090b9e90bcbbab9a90a9a9b0b09b0b0b09a00009ab0a0009a0a900a0bcb0b9a9a009aa0a09a9aa0090090a0a00a009a90a90a0a00a009a9a90000b0ab0a99bafafdaf0b0b0b90009aa909ab9ab0ba9e9b0f9f0bfbdebdbb0bdb99a90b099e90909e9a9b9e9b0bdab0a9adb0b09a0b0000a0000b090900b0a090a9009ebdb0a9a9a9a0909a00a90b0a00a00909000a00a90a9009a90b0a9a90a9a9cbf0b9a0009ffffdb0bcb0adaba90aa000a9cb09a9b0bb0bfbdff9fafcb0b0f0b000f9a999a9a9ab0b0ba0b9a90bcb0ba9e9a9f0a00000b000a9a0b0009aa90a0a0beffb9a9a9a9a0b00b00a9a9a9a0b0a0a0000b00a90a9000000b0b0a9000a909b009a0b0fffffef0b0b0b09ab909b0b0ab0b0b0a90a90b0fbfffffbfb09990b909a9aabc9bdb9f9f9bb0bba9ab0b0bb0bda9b09a09000009a0b0b0b009a0090b9ff9ebf9a90a9a00b00b00b0be9b0b0b09a9000b0a900000b0b0b0b00a909aba09a0090bffffffff0b0a0be90eba0b0b90a9a0b9ab9ab0bbcfbdffff0f0b0f9eb0db999ba9aba9aba90b90a9b0b0b00b0a9a9a000a00a09a9a9a0b0a9a00b0a9effeff0a9aa90b0b00b0ab0b90bcb0a09a00a0b009a00a0b0b0b0b09a90a0b009a00b0bfffffffff0b099a9abb90b9a00a9a0b90a9cadfadffeffffffff0bbfb9dbbfbebdb9a9b9a9bba0a90a9a9a9a9a90be090b00909adb9a9a0a9a9a9a9bbfbffffff009ab0b0fa0b00f0ab0b0a90a0b0900aba9a99a0bcb0b0a000a9b0b0a90b0a9efffffffff0b0a9a9a9eb0a9b09a090ab9bbffffffffffffffff909b9a9bfb9b9afa9a9a9a9009000b0b0000000a90b0a0b0a0a9b0000909a0b0b0f0fcfffffffba90b0e90b00a9a90bcabca9a90aa9009a9a0a9a9b0b0f9b0b0a0b0b0b0a9bb9fffffffffacb0a9ada90b0a9aa9aa900bcbfffffffdffffffffb009a909b9ebb9b9adab0bab00000000b0090009a90b00009a9abbb0b0a00b0fffbfbffffffffedba9a9a000f9a9ac0a90a9a9eb90abbe9a9b0a9acbcb0a0f0b9bd0a9a9b0bcbffffffffff9a09ada9ab0b0a09a90a0bfbfffffffffbfffffff000a9cb0bfb9eb0f9a90b09000000000000a000000a00b0ba9a9a90a0009adfffbcfffffffffffb0000000e9a0ac0a900e90a9a90af909a9a0a900b0b0b09a0bcb0b9b0badbf9ffffffffffe9fa9a90e09a9e9aada9fffffffffffbfdfffffff00090b0bda9a99b00b0ba9a900000000000909000090b0bcbda909ffbb0adafffffdfeffffffff00f00000000b0b00a0000b0a90a90afabc09000e0e0f0e00f0b0b0a0b09af9effffffffff9a00e0a090acbfff9afffffffffffffdfefffffff0000b090b9b9a00a90b0900000000000000000000000bcbf0b0000ffcfb0bfffffbebdfffffffff00a00a00a0c00c00ca900d0a9ca90090b0a000009a9a9e00bcbc90bcbb9ef9bffffffffffda909c0ac9acfffffffffffffffffbff9fffffffb000000000009a90000000000000000000000000000a0b0ff00000fffb0fffffffdfffffffffffe0000000000a00a00a0ca00ac0a0ca0e00000000e0f0f00f0cb09a9e900cbdedfffffffff0a0e0a0a00a0ffffffffffffffffffde9ffffffff0000000000000000000000000000000000000000000090dadb0000ffffffffffffffffffffffff00000000000000000000000000000000000000000b0f00e00a90b0000a9bfffbffffffffff00000000000fffffffffffffffffffbfffffffff0000000000000000000000000000000000000000000000bff00000000000000000000000000105000000000000aead05fe, N'Anne has a BA degree in English from St. Lawrence College.  She is fluent in French and German.', 5, N'http://accweb/emmployees/davolio.bmp', 'dodsworth@northwind.com', '2343454356' )
GO
-- insert regions
INSERT dbo.Region
  (RegionID, RegionDescription, RegionName, foo, foo2, foo3)
VALUES
( 1, N'Eastern                                           ', NULL, NULL, NULL, NULL ), 
( 2, N'Western                                           ', NULL, NULL, NULL, NULL ), 
( 3, N'Northern                                          ', NULL, NULL, NULL, NULL ), 
( 4, N'Southern                                          ', NULL, NULL, NULL, NULL )

GO
-- insert territories
INSERT dbo.Territories
  (TerritoryID, TerritoryDescription, RegionID, RegionName, RegionCode, RegionOwner, Nationality, NationalityCode)
  VALUES
( N'01581', N'Westboro                                          ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'01730', N'Bedford                                           ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'01833', N'Georgetow                                         ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'02116', N'Boston                                            ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'02139', N'Cambridge                                         ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'02184', N'Braintree                                         ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'02903', N'Providence                                        ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'03049', N'Hollis                                            ', 3, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'03801', N'Portsmouth                                        ', 3, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'06897', N'Wilton                                            ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'07960', N'Morristown                                        ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'08837', N'Edison                                            ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'10019', N'New York                                          ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'10038', N'New York                                          ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'11747', N'Mellvile                                          ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'14450', N'Fairport                                          ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'19428', N'Philadelphia                                      ', 3, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'19713', N'Neward                                            ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'20852', N'Rockville                                         ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'27403', N'Greensboro                                        ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'27511', N'Cary                                              ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'29202', N'Columbia                                          ', 4, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'30346', N'Atlanta                                           ', 4, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'31406', N'Savannah                                          ', 4, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'32859', N'Orlando                                           ', 4, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'33607', N'Tampa                                             ', 4, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'40222', N'Louisville                                        ', 1, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'44122', N'Beachwood                                         ', 3, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'45839', N'Findlay                                           ', 3, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'48075', N'Southfield                                        ', 3, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'48084', N'Troy                                              ', 3, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'48304', N'Bloomfield Hills                                  ', 3, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'53404', N'Racine                                            ', 3, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'55113', N'Roseville                                         ', 3, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'55439', N'Minneapolis                                       ', 3, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'60179', N'Hoffman Estates                                   ', 2, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'60601', N'Chicago                                           ', 2, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'72716', N'Bentonville                                       ', 4, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'75234', N'Dallas                                            ', 4, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'78759', N'Austin                                            ', 4, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'80202', N'Denver                                            ', 2, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'80909', N'Colorado Springs                                  ', 2, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'85014', N'Phoenix                                           ', 2, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'85251', N'Scottsdale                                        ', 2, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'90405', N'Santa Monica                                      ', 2, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'94025', N'Menlo Park                                        ', 2, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'94105', N'San Francisco                                     ', 2, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'95008', N'Campbell                                          ', 2, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'95054', N'Santa Clara                                       ', 2, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'95060', N'Santa Cruz                                        ', 2, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'98004', N'Bellevue                                          ', 2, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'98052', N'Redmond                                           ', 2, N'Test      ', NULL, NULL, NULL, NULL ), 
( N'98104', N'Seattle                                           ', 2, N'Test      ', NULL, NULL, NULL, NULL )
GO
-- employee territories
INSERT dbo.EmployeeTerritories (EmployeeID, TerritoryID) 
VALUES
( 1, N'06897' ), 
( 1, N'19713' ), 
( 2, N'01581' ), 
( 2, N'01730' ), 
( 2, N'01833' ), 
( 2, N'02116' ), 
( 2, N'02139' ), 
( 2, N'02184' ), 
( 2, N'40222' ), 
( 3, N'30346' ), 
( 3, N'31406' ), 
( 3, N'32859' ), 
( 3, N'33607' ), 
( 4, N'20852' ), 
( 4, N'27403' ), 
( 4, N'27511' ), 
( 5, N'02903' ), 
( 5, N'07960' ), 
( 5, N'08837' ), 
( 5, N'10019' ), 
( 5, N'10038' ), 
( 5, N'11747' ), 
( 5, N'14450' ), 
( 6, N'85014' ), 
( 6, N'85251' ), 
( 6, N'98004' ), 
( 6, N'98052' ), 
( 6, N'98104' ), 
( 7, N'60179' ), 
( 7, N'60601' ), 
( 7, N'80202' ), 
( 7, N'80909' ), 
( 7, N'90405' ), 
( 7, N'94025' ), 
( 7, N'94105' ), 
( 7, N'95008' ), 
( 7, N'95054' ), 
( 7, N'95060' ), 
( 8, N'19428' ), 
( 8, N'44122' ), 
( 8, N'45839' ), 
( 8, N'53404' ), 
( 9, N'03049' ), 
( 9, N'03801' ), 
( 9, N'48075' ), 
( 9, N'48084' ), 
( 9, N'48304' ), 
( 9, N'55113' ), 
( 9, N'55439' )
GO
-- insert shippers
INSERT dbo.Shippers
  (CompanyName, Phone, id, ShipId)
VALUES
( N'Speedy Express', N'(503) 555-9831', NULL, NULL ), 
( N'United Package', N'(503) 555-3199', NULL, NULL ), 
( N'Federal Shipping', N'(503) 555-9931', NULL, NULL )
GO
-- insert orders
SET IDENTITY_INSERT dbo.Orders ON
GO

INSERT dbo.Orders
  (ORDERID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry, ShipCountryCode)
VALUES
( 10248, N'VINET', 5, N'1996-07-04T00:00:00', N'1996-08-01T00:00:00', N'1996-07-16T00:00:00', 3, 32.3800, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'France', NULL ), 
( 10249, N'TOMSP', 6, N'1996-07-05T00:00:00', N'1996-08-16T00:00:00', N'1996-07-10T00:00:00', 1, 11.6100, N'Toms Spezialit�ten', N'Luisenstr. 48', N'M�nster', NULL, N'44087', N'Germany', NULL ), 
( 10250, N'HANAR', 4, N'1996-07-08T00:00:00', N'1996-08-05T00:00:00', N'1996-07-12T00:00:00', 2, 65.8300, N'Hanari Carnes', N'Rua do Pa�o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil', NULL ), 
( 10251, N'VICTE', 3, N'1996-07-08T00:00:00', N'1996-08-05T00:00:00', N'1996-07-15T00:00:00', 1, 41.3400, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France', NULL ), 
( 10252, N'SUPRD', 4, N'1996-07-09T00:00:00', N'1996-08-06T00:00:00', N'1996-07-11T00:00:00', 2, 51.3000, N'Supr�mes d�lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium', NULL ), 
( 10253, N'HANAR', 3, N'1996-07-10T00:00:00', N'1996-07-24T00:00:00', N'1996-07-16T00:00:00', 2, 58.1700, N'Hanari Carnes', N'Rua do Pa�o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil', NULL ), 
( 10254, N'CHOPS', 5, N'1996-07-11T00:00:00', N'1996-08-08T00:00:00', N'1996-07-23T00:00:00', 2, 22.9800, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland', NULL ), 
( 10255, N'RICSU', 9, N'1996-07-12T00:00:00', N'1996-08-09T00:00:00', N'1996-07-15T00:00:00', 3, 148.3300, N'Richter Supermarkt', N'Starenweg 5', N'Gen�ve', NULL, N'1204', N'Switzerland', NULL ), 
( 10256, N'WELLI', 3, N'1996-07-15T00:00:00', N'1996-08-12T00:00:00', N'1996-07-17T00:00:00', 2, 13.9700, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil', NULL ), 
( 10257, N'HILAA', 4, N'1996-07-16T00:00:00', N'1996-08-13T00:00:00', N'1996-07-22T00:00:00', 3, 81.9100, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 10258, N'ERNSH', 1, N'1996-07-17T00:00:00', N'1996-08-14T00:00:00', N'1996-07-23T00:00:00', 1, 140.5100, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10259, N'CENTC', 4, N'1996-07-18T00:00:00', N'1996-08-15T00:00:00', N'1996-07-25T00:00:00', 3, 3.2500, N'Centro comercial Moctezuma', N'Sierras de Granada 9993', N'M�xico D.F.', NULL, N'05022', N'Mexico', NULL ), 
( 10260, N'OTTIK', 4, N'1996-07-19T00:00:00', N'1996-08-16T00:00:00', N'1996-07-29T00:00:00', 1, 55.0900, N'Ottilies K�seladen', N'Mehrheimerstr. 369', N'K�ln', NULL, N'50739', N'Germany', NULL ), 
( 10261, N'QUEDE', 4, N'1996-07-19T00:00:00', N'1996-08-16T00:00:00', N'1996-07-30T00:00:00', 2, 3.0500, N'Que Del�cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil', NULL ), 
( 10262, N'RATTC', 8, N'1996-07-22T00:00:00', N'1996-08-19T00:00:00', N'1996-07-25T00:00:00', 3, 48.2900, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL ), 
( 10263, N'ERNSH', 9, N'1996-07-23T00:00:00', N'1996-08-20T00:00:00', N'1996-07-31T00:00:00', 3, 146.0600, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10264, N'FOLKO', 6, N'1996-07-24T00:00:00', N'1996-08-21T00:00:00', N'1996-08-23T00:00:00', 3, 3.6700, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 10265, N'BLONP', 2, N'1996-07-25T00:00:00', N'1996-08-22T00:00:00', N'1996-08-12T00:00:00', 1, 55.2800, N'Blondel p�re et fils', N'24, place Kl�ber', N'Strasbourg', NULL, N'67000', N'France', NULL ), 
( 10266, N'WARTH', 3, N'1996-07-26T00:00:00', N'1996-09-06T00:00:00', N'1996-07-31T00:00:00', 3, 25.7300, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland', NULL ), 
( 10267, N'FRANK', 4, N'1996-07-29T00:00:00', N'1996-08-26T00:00:00', N'1996-08-06T00:00:00', 1, 208.5800, N'Frankenversand', N'Berliner Platz 43', N'M�nchen', NULL, N'80805', N'Germany', NULL ), 
( 10268, N'GROSR', 8, N'1996-07-30T00:00:00', N'1996-08-27T00:00:00', N'1996-08-02T00:00:00', 3, 66.2900, N'GROSELLA-Restaurante', N'5� Ave. Los Palos Grandes', N'Caracas', N'DF', N'1081', N'Venezuela', NULL ), 
( 10269, N'WHITC', 5, N'1996-07-31T00:00:00', N'1996-08-14T00:00:00', N'1996-08-09T00:00:00', 1, 4.5600, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA', NULL ), 
( 10270, N'WARTH', 1, N'1996-08-01T00:00:00', N'1996-08-29T00:00:00', N'1996-08-02T00:00:00', 1, 136.5400, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland', NULL ), 
( 10271, N'SPLIR', 6, N'1996-08-01T00:00:00', N'1996-08-29T00:00:00', N'1996-08-30T00:00:00', 2, 4.5400, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA', NULL ), 
( 10272, N'RATTC', 6, N'1996-08-02T00:00:00', N'1996-08-30T00:00:00', N'1996-08-06T00:00:00', 2, 98.0300, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL ), 
( 10273, N'QUICK', 3, N'1996-08-05T00:00:00', N'1996-09-02T00:00:00', N'1996-08-12T00:00:00', 3, 76.0700, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10274, N'VINET', 6, N'1996-08-06T00:00:00', N'1996-09-03T00:00:00', N'1996-08-16T00:00:00', 1, 6.0100, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'France', NULL ), 
( 10275, N'MAGAA', 1, N'1996-08-07T00:00:00', N'1996-09-04T00:00:00', N'1996-08-09T00:00:00', 1, 26.9300, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy', NULL ), 
( 10276, N'TORTU', 8, N'1996-08-08T00:00:00', N'1996-08-22T00:00:00', N'1996-08-14T00:00:00', 3, 13.8400, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M�xico D.F.', NULL, N'05033', N'Mexico', NULL ), 
( 10277, N'MORGK', 2, N'1996-08-09T00:00:00', N'1996-09-06T00:00:00', N'1996-08-13T00:00:00', 3, 125.7700, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Germany', NULL ), 
( 10278, N'BERGS', 8, N'1996-08-12T00:00:00', N'1996-09-09T00:00:00', N'1996-08-16T00:00:00', 2, 92.6900, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10279, N'LEHMS', 8, N'1996-08-13T00:00:00', N'1996-09-10T00:00:00', N'1996-08-16T00:00:00', 2, 25.8300, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany', NULL ), 
( 10280, N'BERGS', 2, N'1996-08-14T00:00:00', N'1996-09-11T00:00:00', N'1996-09-12T00:00:00', 1, 8.9800, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10281, N'ROMEY', 4, N'1996-08-14T00:00:00', N'1996-08-28T00:00:00', N'1996-08-21T00:00:00', 1, 2.9400, N'Romero y tomillo', N'Gran V�a, 1', N'Madrid', NULL, N'28001', N'Spain', NULL ), 
( 10282, N'ROMEY', 4, N'1996-08-15T00:00:00', N'1996-09-12T00:00:00', N'1996-08-21T00:00:00', 1, 12.6900, N'Romero y tomillo', N'Gran V�a, 1', N'Madrid', NULL, N'28001', N'Spain', NULL ), 
( 10283, N'LILAS', 3, N'1996-08-16T00:00:00', N'1996-09-13T00:00:00', N'1996-08-23T00:00:00', 3, 84.8100, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL ), 
( 10284, N'LEHMS', 4, N'1996-08-19T00:00:00', N'1996-09-16T00:00:00', N'1996-08-27T00:00:00', 1, 76.5600, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany', NULL ), 
( 10285, N'QUICK', 1, N'1996-08-20T00:00:00', N'1996-09-17T00:00:00', N'1996-08-26T00:00:00', 2, 76.8300, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10286, N'QUICK', 8, N'1996-08-21T00:00:00', N'1996-09-18T00:00:00', N'1996-08-30T00:00:00', 3, 229.2400, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10287, N'RICAR', 8, N'1996-08-22T00:00:00', N'1996-09-19T00:00:00', N'1996-08-28T00:00:00', 3, 12.7600, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil', NULL ), 
( 10288, N'REGGC', 4, N'1996-08-23T00:00:00', N'1996-09-20T00:00:00', N'1996-09-03T00:00:00', 1, 7.4500, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy', NULL ), 
( 10289, N'BSBEV', 7, N'1996-08-26T00:00:00', N'1996-09-23T00:00:00', N'1996-08-28T00:00:00', 3, 22.7700, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK', NULL ), 
( 10290, N'COMMI', 8, N'1996-08-27T00:00:00', N'1996-09-24T00:00:00', N'1996-09-03T00:00:00', 1, 79.7000, N'Com�rcio Mineiro', N'Av. dos Lus�adas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil', NULL ), 
( 10291, N'QUEDE', 6, N'1996-08-27T00:00:00', N'1996-09-24T00:00:00', N'1996-09-04T00:00:00', 2, 6.4000, N'Que Del�cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil', NULL ), 
( 10292, N'TRADH', 1, N'1996-08-28T00:00:00', N'1996-09-25T00:00:00', N'1996-09-02T00:00:00', 2, 1.3500, N'Tradi�ao Hipermercados', N'Av. In�s de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil', NULL ), 
( 10293, N'TORTU', 1, N'1996-08-29T00:00:00', N'1996-09-26T00:00:00', N'1996-09-11T00:00:00', 3, 21.1800, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M�xico D.F.', NULL, N'05033', N'Mexico', NULL ), 
( 10294, N'RATTC', 4, N'1996-08-30T00:00:00', N'1996-09-27T00:00:00', N'1996-09-05T00:00:00', 2, 147.2600, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL ), 
( 10295, N'VINET', 2, N'1996-09-02T00:00:00', N'1996-09-30T00:00:00', N'1996-09-10T00:00:00', 2, 1.1500, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'France', NULL ), 
( 10296, N'LILAS', 6, N'1996-09-03T00:00:00', N'1996-10-01T00:00:00', N'1996-09-11T00:00:00', 1, 0.1200, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL ), 
( 10297, N'BLONP', 5, N'1996-09-04T00:00:00', N'1996-10-16T00:00:00', N'1996-09-10T00:00:00', 2, 5.7400, N'Blondel p�re et fils', N'24, place Kl�ber', N'Strasbourg', NULL, N'67000', N'France', NULL ), 
( 10298, N'HUNGO', 6, N'1996-09-05T00:00:00', N'1996-10-03T00:00:00', N'1996-09-11T00:00:00', 2, 168.2200, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10299, N'RICAR', 4, N'1996-09-06T00:00:00', N'1996-10-04T00:00:00', N'1996-09-13T00:00:00', 2, 29.7600, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil', NULL ), 
( 10300, N'MAGAA', 2, N'1996-09-09T00:00:00', N'1996-10-07T00:00:00', N'1996-09-18T00:00:00', 2, 17.6800, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy', NULL ), 
( 10301, N'WANDK', 8, N'1996-09-09T00:00:00', N'1996-10-07T00:00:00', N'1996-09-17T00:00:00', 2, 45.0800, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany', NULL ), 
( 10302, N'SUPRD', 4, N'1996-09-10T00:00:00', N'1996-10-08T00:00:00', N'1996-10-09T00:00:00', 2, 6.2700, N'Supr�mes d�lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium', NULL ), 
( 10303, N'GODOS', 7, N'1996-09-11T00:00:00', N'1996-10-09T00:00:00', N'1996-09-18T00:00:00', 2, 107.8300, N'Godos Cocina T�pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain', NULL ), 
( 10304, N'TORTU', 1, N'1996-09-12T00:00:00', N'1996-10-10T00:00:00', N'1996-09-17T00:00:00', 2, 63.7900, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M�xico D.F.', NULL, N'05033', N'Mexico', NULL ), 
( 10305, N'OLDWO', 8, N'1996-09-13T00:00:00', N'1996-10-11T00:00:00', N'1996-10-09T00:00:00', 3, 257.6200, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA', NULL ), 
( 10306, N'ROMEY', 1, N'1996-09-16T00:00:00', N'1996-10-14T00:00:00', N'1996-09-23T00:00:00', 3, 7.5600, N'Romero y tomillo', N'Gran V�a, 1', N'Madrid', NULL, N'28001', N'Spain', NULL ), 
( 10307, N'LONEP', 2, N'1996-09-17T00:00:00', N'1996-10-15T00:00:00', N'1996-09-25T00:00:00', 2, 0.5600, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA', NULL ), 
( 10308, N'ANATR', 7, N'1996-09-18T00:00:00', N'1996-10-16T00:00:00', N'1996-09-24T00:00:00', 3, 1.6100, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constituci�n 2222', N'M�xico D.F.', NULL, N'05021', N'Mexico', NULL ), 
( 10309, N'HUNGO', 3, N'1996-09-19T00:00:00', N'1996-10-17T00:00:00', N'1996-10-23T00:00:00', 1, 47.3000, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10310, N'THEBI', 8, N'1996-09-20T00:00:00', N'1996-10-18T00:00:00', N'1996-09-27T00:00:00', 2, 17.5200, N'The Big Cheese', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA', NULL ), 
( 10311, N'DUMON', 1, N'1996-09-20T00:00:00', N'1996-10-04T00:00:00', N'1996-09-26T00:00:00', 3, 24.6900, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'France', NULL ), 
( 10312, N'WANDK', 2, N'1996-09-23T00:00:00', N'1996-10-21T00:00:00', N'1996-10-03T00:00:00', 2, 40.2600, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany', NULL ), 
( 10313, N'QUICK', 2, N'1996-09-24T00:00:00', N'1996-10-22T00:00:00', N'1996-10-04T00:00:00', 2, 1.9600, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10314, N'RATTC', 1, N'1996-09-25T00:00:00', N'1996-10-23T00:00:00', N'1996-10-04T00:00:00', 2, 74.1600, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL ), 
( 10315, N'ISLAT', 4, N'1996-09-26T00:00:00', N'1996-10-24T00:00:00', N'1996-10-03T00:00:00', 2, 41.7600, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK', NULL ), 
( 10316, N'RATTC', 1, N'1996-09-27T00:00:00', N'1996-10-25T00:00:00', N'1996-10-08T00:00:00', 3, 150.1500, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL ), 
( 10317, N'LONEP', 6, N'1996-09-30T00:00:00', N'1996-10-28T00:00:00', N'1996-10-10T00:00:00', 1, 12.6900, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA', NULL ), 
( 10318, N'ISLAT', 8, N'1996-10-01T00:00:00', N'1996-10-29T00:00:00', N'1996-10-04T00:00:00', 2, 4.7300, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK', NULL ), 
( 10319, N'TORTU', 7, N'1996-10-02T00:00:00', N'1996-10-30T00:00:00', N'1996-10-11T00:00:00', 3, 64.5000, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M�xico D.F.', NULL, N'05033', N'Mexico', NULL ), 
( 10320, N'WARTH', 5, N'1996-10-03T00:00:00', N'1996-10-17T00:00:00', N'1996-10-18T00:00:00', 3, 34.5700, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland', NULL ), 
( 10321, N'ISLAT', 3, N'1996-10-03T00:00:00', N'1996-10-31T00:00:00', N'1996-10-11T00:00:00', 2, 3.4300, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK', NULL ), 
( 10322, N'PERIC', 7, N'1996-10-04T00:00:00', N'1996-11-01T00:00:00', N'1996-10-23T00:00:00', 3, 0.4000, N'Pericles Comidas cl�sicas', N'Calle Dr. Jorge Cash 321', N'M�xico D.F.', NULL, N'05033', N'Mexico', NULL ), 
( 10323, N'KOENE', 4, N'1996-10-07T00:00:00', N'1996-11-04T00:00:00', N'1996-10-14T00:00:00', 1, 4.8800, N'K�niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany', NULL ), 
( 10324, N'SAVEA', 9, N'1996-10-08T00:00:00', N'1996-11-05T00:00:00', N'1996-10-10T00:00:00', 1, 214.2700, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10325, N'KOENE', 1, N'1996-10-09T00:00:00', N'1996-10-23T00:00:00', N'1996-10-14T00:00:00', 3, 64.8600, N'K�niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany', NULL ), 
( 10326, N'BOLID', 4, N'1996-10-10T00:00:00', N'1996-11-07T00:00:00', N'1996-10-14T00:00:00', 2, 77.9200, N'B�lido Comidas preparadas', N'C/ Araquil, 67', N'Madrid', NULL, N'28023', N'Spain', NULL ), 
( 10327, N'FOLKO', 2, N'1996-10-11T00:00:00', N'1996-11-08T00:00:00', N'1996-10-14T00:00:00', 1, 63.3600, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 10328, N'FURIB', 4, N'1996-10-14T00:00:00', N'1996-11-11T00:00:00', N'1996-10-17T00:00:00', 3, 87.0300, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', NULL ), 
( 10329, N'SPLIR', 4, N'1996-10-15T00:00:00', N'1996-11-26T00:00:00', N'1996-10-23T00:00:00', 2, 191.6700, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA', NULL ), 
( 10330, N'LILAS', 3, N'1996-10-16T00:00:00', N'1996-11-13T00:00:00', N'1996-10-28T00:00:00', 1, 12.7500, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL ), 
( 10331, N'BONAP', 9, N'1996-10-16T00:00:00', N'1996-11-27T00:00:00', N'1996-10-21T00:00:00', 1, 10.1900, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', NULL ), 
( 10332, N'MEREP', 3, N'1996-10-17T00:00:00', N'1996-11-28T00:00:00', N'1996-10-21T00:00:00', 2, 52.8400, N'M�re Paillarde', N'43 rue St. Laurent', N'Montr�al', N'Qu�bec', N'H1J 1C3', N'Canada', NULL ), 
( 10333, N'WARTH', 5, N'1996-10-18T00:00:00', N'1996-11-15T00:00:00', N'1996-10-25T00:00:00', 3, 0.5900, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland', NULL ), 
( 10334, N'VICTE', 8, N'1996-10-21T00:00:00', N'1996-11-18T00:00:00', N'1996-10-28T00:00:00', 2, 8.5600, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France', NULL ), 
( 10335, N'HUNGO', 7, N'1996-10-22T00:00:00', N'1996-11-19T00:00:00', N'1996-10-24T00:00:00', 2, 42.1100, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10336, N'PRINI', 7, N'1996-10-23T00:00:00', N'1996-11-20T00:00:00', N'1996-10-25T00:00:00', 2, 15.5100, N'Princesa Isabel Vinhos', N'Estrada da sa�de n. 58', N'Lisboa', NULL, N'1756', N'Portugal', NULL ), 
( 10337, N'FRANK', 4, N'1996-10-24T00:00:00', N'1996-11-21T00:00:00', N'1996-10-29T00:00:00', 3, 108.2600, N'Frankenversand', N'Berliner Platz 43', N'M�nchen', NULL, N'80805', N'Germany', NULL ), 
( 10338, N'OLDWO', 4, N'1996-10-25T00:00:00', N'1996-11-22T00:00:00', N'1996-10-29T00:00:00', 3, 84.2100, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA', NULL ), 
( 10339, N'MEREP', 2, N'1996-10-28T00:00:00', N'1996-11-25T00:00:00', N'1996-11-04T00:00:00', 2, 15.6600, N'M�re Paillarde', N'43 rue St. Laurent', N'Montr�al', N'Qu�bec', N'H1J 1C3', N'Canada', NULL ), 
( 10340, N'BONAP', 1, N'1996-10-29T00:00:00', N'1996-11-26T00:00:00', N'1996-11-08T00:00:00', 3, 166.3100, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', NULL ), 
( 10341, N'SIMOB', 7, N'1996-10-29T00:00:00', N'1996-11-26T00:00:00', N'1996-11-05T00:00:00', 3, 26.7800, N'Simons bistro', N'Vinb�ltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark', NULL ), 
( 10342, N'FRANK', 4, N'1996-10-30T00:00:00', N'1996-11-13T00:00:00', N'1996-11-04T00:00:00', 2, 54.8300, N'Frankenversand', N'Berliner Platz 43', N'M�nchen', NULL, N'80805', N'Germany', NULL ), 
( 10343, N'LEHMS', 4, N'1996-10-31T00:00:00', N'1996-11-28T00:00:00', N'1996-11-06T00:00:00', 1, 110.3700, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany', NULL ), 
( 10344, N'WHITC', 4, N'1996-11-01T00:00:00', N'1996-11-29T00:00:00', N'1996-11-05T00:00:00', 2, 23.2900, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA', NULL ), 
( 10345, N'QUICK', 2, N'1996-11-04T00:00:00', N'1996-12-02T00:00:00', N'1996-11-11T00:00:00', 2, 249.0600, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10346, N'RATTC', 3, N'1996-11-05T00:00:00', N'1996-12-17T00:00:00', N'1996-11-08T00:00:00', 3, 142.0800, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL ), 
( 10347, N'FAMIA', 4, N'1996-11-06T00:00:00', N'1996-12-04T00:00:00', N'1996-11-08T00:00:00', 3, 3.1000, N'Familia Arquibaldo', N'Rua Or�s, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil', NULL ), 
( 10348, N'WANDK', 4, N'1996-11-07T00:00:00', N'1996-12-05T00:00:00', N'1996-11-15T00:00:00', 2, 0.7800, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany', NULL ), 
( 10349, N'SPLIR', 7, N'1996-11-08T00:00:00', N'1996-12-06T00:00:00', N'1996-11-15T00:00:00', 1, 8.6300, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA', NULL ), 
( 10350, N'LAMAI', 6, N'1996-11-11T00:00:00', N'1996-12-09T00:00:00', N'1996-12-03T00:00:00', 2, 64.1900, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France', NULL ), 
( 10351, N'ERNSH', 1, N'1996-11-11T00:00:00', N'1996-12-09T00:00:00', N'1996-11-20T00:00:00', 1, 162.3300, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10352, N'FURIB', 3, N'1996-11-12T00:00:00', N'1996-11-26T00:00:00', N'1996-11-18T00:00:00', 3, 1.3000, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', NULL ), 
( 10353, N'PICCO', 7, N'1996-11-13T00:00:00', N'1996-12-11T00:00:00', N'1996-11-25T00:00:00', 3, 360.6300, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL ), 
( 10354, N'PERIC', 8, N'1996-11-14T00:00:00', N'1996-12-12T00:00:00', N'1996-11-20T00:00:00', 3, 53.8000, N'Pericles Comidas cl�sicas', N'Calle Dr. Jorge Cash 321', N'M�xico D.F.', NULL, N'05033', N'Mexico', NULL ), 
( 10355, N'AROUT', 6, N'1996-11-15T00:00:00', N'1996-12-13T00:00:00', N'1996-11-20T00:00:00', 1, 41.9500, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK', NULL ), 
( 10356, N'WANDK', 6, N'1996-11-18T00:00:00', N'1996-12-16T00:00:00', N'1996-11-27T00:00:00', 2, 36.7100, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany', NULL ), 
( 10357, N'LILAS', 1, N'1996-11-19T00:00:00', N'1996-12-17T00:00:00', N'1996-12-02T00:00:00', 3, 34.8800, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL ), 
( 10358, N'LAMAI', 5, N'1996-11-20T00:00:00', N'1996-12-18T00:00:00', N'1996-11-27T00:00:00', 1, 19.6400, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France', NULL ), 
( 10359, N'SEVES', 5, N'1996-11-21T00:00:00', N'1996-12-19T00:00:00', N'1996-11-26T00:00:00', 3, 288.4300, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK', NULL ), 
( 10360, N'BLONP', 4, N'1996-11-22T00:00:00', N'1996-12-20T00:00:00', N'1996-12-02T00:00:00', 3, 131.7000, N'Blondel p�re et fils', N'24, place Kl�ber', N'Strasbourg', NULL, N'67000', N'France', NULL ), 
( 10361, N'QUICK', 1, N'1996-11-22T00:00:00', N'1996-12-20T00:00:00', N'1996-12-03T00:00:00', 2, 183.1700, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10362, N'BONAP', 3, N'1996-11-25T00:00:00', N'1996-12-23T00:00:00', N'1996-11-28T00:00:00', 1, 96.0400, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', NULL ), 
( 10363, N'DRACD', 4, N'1996-11-26T00:00:00', N'1996-12-24T00:00:00', N'1996-12-04T00:00:00', 3, 30.5400, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany', NULL ), 
( 10364, N'EASTC', 1, N'1996-11-26T00:00:00', N'1997-01-07T00:00:00', N'1996-12-04T00:00:00', 1, 71.9700, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK', NULL ), 
( 10365, N'ANTON', 3, N'1996-11-27T00:00:00', N'1996-12-25T00:00:00', N'1996-12-02T00:00:00', 2, 22.0000, N'Antonio Moreno Taquer�a', N'Mataderos  2312', N'M�xico D.F.', NULL, N'05023', N'Mexico', NULL ), 
( 10366, N'GALED', 8, N'1996-11-28T00:00:00', N'1997-01-09T00:00:00', N'1996-12-30T00:00:00', 2, 10.1400, N'Galer�a del gastron�mo', N'Rambla de Catalu�a, 23', N'Barcelona', NULL, N'8022', N'Spain', NULL ), 
( 10367, N'VAFFE', 7, N'1996-11-28T00:00:00', N'1996-12-26T00:00:00', N'1996-12-02T00:00:00', 3, 13.5500, N'Vaffeljernet', N'Smagsloget 45', N'�rhus', NULL, N'8200', N'Denmark', NULL ), 
( 10368, N'ERNSH', 2, N'1996-11-29T00:00:00', N'1996-12-27T00:00:00', N'1996-12-02T00:00:00', 2, 101.9500, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10369, N'SPLIR', 8, N'1996-12-02T00:00:00', N'1996-12-30T00:00:00', N'1996-12-09T00:00:00', 2, 195.6800, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA', NULL ), 
( 10370, N'CHOPS', 6, N'1996-12-03T00:00:00', N'1996-12-31T00:00:00', N'1996-12-27T00:00:00', 2, 1.1700, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland', NULL ), 
( 10371, N'LAMAI', 1, N'1996-12-03T00:00:00', N'1996-12-31T00:00:00', N'1996-12-24T00:00:00', 1, 0.4500, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France', NULL ), 
( 10372, N'QUEEN', 5, N'1996-12-04T00:00:00', N'1997-01-01T00:00:00', N'1996-12-09T00:00:00', 2, 890.7800, N'Queen Cozinha', N'Alameda dos Can�rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil', NULL ), 
( 10373, N'HUNGO', 4, N'1996-12-05T00:00:00', N'1997-01-02T00:00:00', N'1996-12-11T00:00:00', 3, 124.1200, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10374, N'WOLZA', 1, N'1996-12-05T00:00:00', N'1997-01-02T00:00:00', N'1996-12-09T00:00:00', 3, 3.9400, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland', NULL ), 
( 10375, N'HUNGC', 3, N'1996-12-06T00:00:00', N'1997-01-03T00:00:00', N'1996-12-09T00:00:00', 2, 20.1200, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA', NULL ), 
( 10376, N'MEREP', 1, N'1996-12-09T00:00:00', N'1997-01-06T00:00:00', N'1996-12-13T00:00:00', 2, 20.3900, N'M�re Paillarde', N'43 rue St. Laurent', N'Montr�al', N'Qu�bec', N'H1J 1C3', N'Canada', NULL ), 
( 10377, N'SEVES', 1, N'1996-12-09T00:00:00', N'1997-01-06T00:00:00', N'1996-12-13T00:00:00', 3, 22.2100, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK', NULL ), 
( 10378, N'FOLKO', 5, N'1996-12-10T00:00:00', N'1997-01-07T00:00:00', N'1996-12-19T00:00:00', 3, 5.4400, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 10379, N'QUEDE', 2, N'1996-12-11T00:00:00', N'1997-01-08T00:00:00', N'1996-12-13T00:00:00', 1, 45.0300, N'Que Del�cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil', NULL ), 
( 10380, N'HUNGO', 8, N'1996-12-12T00:00:00', N'1997-01-09T00:00:00', N'1997-01-16T00:00:00', 3, 35.0300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10381, N'LILAS', 3, N'1996-12-12T00:00:00', N'1997-01-09T00:00:00', N'1996-12-13T00:00:00', 3, 7.9900, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL ), 
( 10382, N'ERNSH', 4, N'1996-12-13T00:00:00', N'1997-01-10T00:00:00', N'1996-12-16T00:00:00', 1, 94.7700, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10383, N'AROUT', 8, N'1996-12-16T00:00:00', N'1997-01-13T00:00:00', N'1996-12-18T00:00:00', 3, 34.2400, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK', NULL ), 
( 10384, N'BERGS', 3, N'1996-12-16T00:00:00', N'1997-01-13T00:00:00', N'1996-12-20T00:00:00', 3, 168.6400, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10385, N'SPLIR', 1, N'1996-12-17T00:00:00', N'1997-01-14T00:00:00', N'1996-12-23T00:00:00', 2, 30.9600, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA', NULL ), 
( 10386, N'FAMIA', 9, N'1996-12-18T00:00:00', N'1997-01-01T00:00:00', N'1996-12-25T00:00:00', 3, 13.9900, N'Familia Arquibaldo', N'Rua Or�s, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil', NULL ), 
( 10387, N'SANTG', 1, N'1996-12-18T00:00:00', N'1997-01-15T00:00:00', N'1996-12-20T00:00:00', 2, 93.6300, N'Sant� Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway', NULL ), 
( 10388, N'SEVES', 2, N'1996-12-19T00:00:00', N'1997-01-16T00:00:00', N'1996-12-20T00:00:00', 1, 34.8600, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK', NULL ), 
( 10389, N'BOTTM', 4, N'1996-12-20T00:00:00', N'1997-01-17T00:00:00', N'1996-12-24T00:00:00', 2, 47.4200, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', NULL ), 
( 10390, N'ERNSH', 6, N'1996-12-23T00:00:00', N'1997-01-20T00:00:00', N'1996-12-26T00:00:00', 1, 126.3800, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10391, N'DRACD', 3, N'1996-12-23T00:00:00', N'1997-01-20T00:00:00', N'1996-12-31T00:00:00', 3, 5.4500, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany', NULL ), 
( 10392, N'PICCO', 2, N'1996-12-24T00:00:00', N'1997-01-21T00:00:00', N'1997-01-01T00:00:00', 3, 122.4600, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL ), 
( 10393, N'SAVEA', 1, N'1996-12-25T00:00:00', N'1997-01-22T00:00:00', N'1997-01-03T00:00:00', 3, 126.5600, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10394, N'HUNGC', 1, N'1996-12-25T00:00:00', N'1997-01-22T00:00:00', N'1997-01-03T00:00:00', 3, 30.3400, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA', NULL ), 
( 10395, N'HILAA', 6, N'1996-12-26T00:00:00', N'1997-01-23T00:00:00', N'1997-01-03T00:00:00', 1, 184.4100, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 10396, N'FRANK', 1, N'1996-12-27T00:00:00', N'1997-01-10T00:00:00', N'1997-01-06T00:00:00', 3, 135.3500, N'Frankenversand', N'Berliner Platz 43', N'M�nchen', NULL, N'80805', N'Germany', NULL ), 
( 10397, N'PRINI', 5, N'1996-12-27T00:00:00', N'1997-01-24T00:00:00', N'1997-01-02T00:00:00', 1, 60.2600, N'Princesa Isabel Vinhos', N'Estrada da sa�de n. 58', N'Lisboa', NULL, N'1756', N'Portugal', NULL ), 
( 10398, N'SAVEA', 2, N'1996-12-30T00:00:00', N'1997-01-27T00:00:00', N'1997-01-09T00:00:00', 3, 89.1600, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10399, N'VAFFE', 8, N'1996-12-31T00:00:00', N'1997-01-14T00:00:00', N'1997-01-08T00:00:00', 3, 27.3600, N'Vaffeljernet', N'Smagsloget 45', N'�rhus', NULL, N'8200', N'Denmark', NULL ), 
( 10400, N'EASTC', 1, N'1997-01-01T00:00:00', N'1997-01-29T00:00:00', N'1997-01-16T00:00:00', 3, 83.9300, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK', NULL ), 
( 10401, N'RATTC', 1, N'1997-01-01T00:00:00', N'1997-01-29T00:00:00', N'1997-01-10T00:00:00', 1, 12.5100, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL ), 
( 10402, N'ERNSH', 8, N'1997-01-02T00:00:00', N'1997-02-13T00:00:00', N'1997-01-10T00:00:00', 2, 67.8800, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10403, N'ERNSH', 4, N'1997-01-03T00:00:00', N'1997-01-31T00:00:00', N'1997-01-09T00:00:00', 3, 73.7900, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10404, N'MAGAA', 2, N'1997-01-03T00:00:00', N'1997-01-31T00:00:00', N'1997-01-08T00:00:00', 1, 155.9700, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy', NULL ), 
( 10405, N'LINOD', 1, N'1997-01-06T00:00:00', N'1997-02-03T00:00:00', N'1997-01-22T00:00:00', 1, 34.8200, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL ), 
( 10406, N'QUEEN', 7, N'1997-01-07T00:00:00', N'1997-02-18T00:00:00', N'1997-01-13T00:00:00', 1, 108.0400, N'Queen Cozinha', N'Alameda dos Can�rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil', NULL ), 
( 10407, N'OTTIK', 2, N'1997-01-07T00:00:00', N'1997-02-04T00:00:00', N'1997-01-30T00:00:00', 2, 91.4800, N'Ottilies K�seladen', N'Mehrheimerstr. 369', N'K�ln', NULL, N'50739', N'Germany', NULL ), 
( 10408, N'FOLIG', 8, N'1997-01-08T00:00:00', N'1997-02-05T00:00:00', N'1997-01-14T00:00:00', 1, 11.2600, N'Folies gourmandes', N'184, chauss�e de Tournai', N'Lille', NULL, N'59000', N'France', NULL ), 
( 10409, N'OCEAN', 3, N'1997-01-09T00:00:00', N'1997-02-06T00:00:00', N'1997-01-14T00:00:00', 1, 29.8300, N'Oc�ano Atl�ntico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL ), 
( 10410, N'BOTTM', 3, N'1997-01-10T00:00:00', N'1997-02-07T00:00:00', N'1997-01-15T00:00:00', 3, 2.4000, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', NULL ), 
( 10411, N'BOTTM', 9, N'1997-01-10T00:00:00', N'1997-02-07T00:00:00', N'1997-01-21T00:00:00', 3, 23.6500, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', NULL ), 
( 10412, N'WARTH', 8, N'1997-01-13T00:00:00', N'1997-02-10T00:00:00', N'1997-01-15T00:00:00', 2, 3.7700, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland', NULL ), 
( 10413, N'LAMAI', 3, N'1997-01-14T00:00:00', N'1997-02-11T00:00:00', N'1997-01-16T00:00:00', 2, 95.6600, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France', NULL ), 
( 10414, N'FAMIA', 2, N'1997-01-14T00:00:00', N'1997-02-11T00:00:00', N'1997-01-17T00:00:00', 3, 21.4800, N'Familia Arquibaldo', N'Rua Or�s, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil', NULL ), 
( 10415, N'HUNGC', 3, N'1997-01-15T00:00:00', N'1997-02-12T00:00:00', N'1997-01-24T00:00:00', 1, 0.2000, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA', NULL ), 
( 10416, N'WARTH', 8, N'1997-01-16T00:00:00', N'1997-02-13T00:00:00', N'1997-01-27T00:00:00', 3, 22.7200, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland', NULL ), 
( 10417, N'SIMOB', 4, N'1997-01-16T00:00:00', N'1997-02-13T00:00:00', N'1997-01-28T00:00:00', 3, 70.2900, N'Simons bistro', N'Vinb�ltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark', NULL ), 
( 10418, N'QUICK', 4, N'1997-01-17T00:00:00', N'1997-02-14T00:00:00', N'1997-01-24T00:00:00', 1, 17.5500, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10419, N'RICSU', 4, N'1997-01-20T00:00:00', N'1997-02-17T00:00:00', N'1997-01-30T00:00:00', 2, 137.3500, N'Richter Supermarkt', N'Starenweg 5', N'Gen�ve', NULL, N'1204', N'Switzerland', NULL ), 
( 10420, N'WELLI', 3, N'1997-01-21T00:00:00', N'1997-02-18T00:00:00', N'1997-01-27T00:00:00', 1, 44.1200, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil', NULL ), 
( 10421, N'QUEDE', 8, N'1997-01-21T00:00:00', N'1997-03-04T00:00:00', N'1997-01-27T00:00:00', 1, 99.2300, N'Que Del�cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil', NULL ), 
( 10422, N'FRANS', 2, N'1997-01-22T00:00:00', N'1997-02-19T00:00:00', N'1997-01-31T00:00:00', 1, 3.0200, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy', NULL ), 
( 10423, N'GOURL', 6, N'1997-01-23T00:00:00', N'1997-02-06T00:00:00', N'1997-02-24T00:00:00', 3, 24.5000, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil', NULL ), 
( 10424, N'MEREP', 7, N'1997-01-23T00:00:00', N'1997-02-20T00:00:00', N'1997-01-27T00:00:00', 2, 370.6100, N'M�re Paillarde', N'43 rue St. Laurent', N'Montr�al', N'Qu�bec', N'H1J 1C3', N'Canada', NULL ), 
( 10425, N'LAMAI', 6, N'1997-01-24T00:00:00', N'1997-02-21T00:00:00', N'1997-02-14T00:00:00', 2, 7.9300, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France', NULL ), 
( 10426, N'GALED', 4, N'1997-01-27T00:00:00', N'1997-02-24T00:00:00', N'1997-02-06T00:00:00', 1, 18.6900, N'Galer�a del gastron�mo', N'Rambla de Catalu�a, 23', N'Barcelona', NULL, N'8022', N'Spain', NULL ), 
( 10427, N'PICCO', 4, N'1997-01-27T00:00:00', N'1997-02-24T00:00:00', N'1997-03-03T00:00:00', 2, 31.2900, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL ), 
( 10428, N'REGGC', 7, N'1997-01-28T00:00:00', N'1997-02-25T00:00:00', N'1997-02-04T00:00:00', 1, 11.0900, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy', NULL ), 
( 10429, N'HUNGO', 3, N'1997-01-29T00:00:00', N'1997-03-12T00:00:00', N'1997-02-07T00:00:00', 2, 56.6300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10430, N'ERNSH', 4, N'1997-01-30T00:00:00', N'1997-02-13T00:00:00', N'1997-02-03T00:00:00', 1, 458.7800, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10431, N'BOTTM', 4, N'1997-01-30T00:00:00', N'1997-02-13T00:00:00', N'1997-02-07T00:00:00', 2, 44.1700, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', NULL ), 
( 10432, N'SPLIR', 3, N'1997-01-31T00:00:00', N'1997-02-14T00:00:00', N'1997-02-07T00:00:00', 2, 4.3400, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA', NULL ), 
( 10433, N'PRINI', 3, N'1997-02-03T00:00:00', N'1997-03-03T00:00:00', N'1997-03-04T00:00:00', 3, 73.8300, N'Princesa Isabel Vinhos', N'Estrada da sa�de n. 58', N'Lisboa', NULL, N'1756', N'Portugal', NULL ), 
( 10434, N'FOLKO', 3, N'1997-02-03T00:00:00', N'1997-03-03T00:00:00', N'1997-02-13T00:00:00', 2, 17.9200, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 10435, N'CONSH', 8, N'1997-02-04T00:00:00', N'1997-03-18T00:00:00', N'1997-02-07T00:00:00', 2, 9.2100, N'Consolidated Holdings', N'Berkeley Gardens 12  Brewery', N'London', NULL, N'WX1 6LT', N'UK', NULL ), 
( 10436, N'BLONP', 3, N'1997-02-05T00:00:00', N'1997-03-05T00:00:00', N'1997-02-11T00:00:00', 2, 156.6600, N'Blondel p�re et fils', N'24, place Kl�ber', N'Strasbourg', NULL, N'67000', N'France', NULL ), 
( 10437, N'WARTH', 8, N'1997-02-05T00:00:00', N'1997-03-05T00:00:00', N'1997-02-12T00:00:00', 1, 19.9700, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland', NULL ), 
( 10438, N'TOMSP', 3, N'1997-02-06T00:00:00', N'1997-03-06T00:00:00', N'1997-02-14T00:00:00', 2, 8.2400, N'Toms Spezialit�ten', N'Luisenstr. 48', N'M�nster', NULL, N'44087', N'Germany', NULL ), 
( 10439, N'MEREP', 6, N'1997-02-07T00:00:00', N'1997-03-07T00:00:00', N'1997-02-10T00:00:00', 3, 4.0700, N'M�re Paillarde', N'43 rue St. Laurent', N'Montr�al', N'Qu�bec', N'H1J 1C3', N'Canada', NULL ), 
( 10440, N'SAVEA', 4, N'1997-02-10T00:00:00', N'1997-03-10T00:00:00', N'1997-02-28T00:00:00', 2, 86.5300, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10441, N'OLDWO', 3, N'1997-02-10T00:00:00', N'1997-03-24T00:00:00', N'1997-03-14T00:00:00', 2, 73.0200, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA', NULL ), 
( 10442, N'ERNSH', 3, N'1997-02-11T00:00:00', N'1997-03-11T00:00:00', N'1997-02-18T00:00:00', 2, 47.9400, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10443, N'REGGC', 8, N'1997-02-12T00:00:00', N'1997-03-12T00:00:00', N'1997-02-14T00:00:00', 1, 13.9500, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy', NULL ), 
( 10444, N'BERGS', 3, N'1997-02-12T00:00:00', N'1997-03-12T00:00:00', N'1997-02-21T00:00:00', 3, 3.5000, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10445, N'BERGS', 3, N'1997-02-13T00:00:00', N'1997-03-13T00:00:00', N'1997-02-20T00:00:00', 1, 9.3000, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10446, N'TOMSP', 6, N'1997-02-14T00:00:00', N'1997-03-14T00:00:00', N'1997-02-19T00:00:00', 1, 14.6800, N'Toms Spezialit�ten', N'Luisenstr. 48', N'M�nster', NULL, N'44087', N'Germany', NULL ), 
( 10447, N'RICAR', 4, N'1997-02-14T00:00:00', N'1997-03-14T00:00:00', N'1997-03-07T00:00:00', 2, 68.6600, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil', NULL ), 
( 10448, N'RANCH', 4, N'1997-02-17T00:00:00', N'1997-03-17T00:00:00', N'1997-02-24T00:00:00', 2, 38.8200, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL ), 
( 10449, N'BLONP', 3, N'1997-02-18T00:00:00', N'1997-03-18T00:00:00', N'1997-02-27T00:00:00', 2, 53.3000, N'Blondel p�re et fils', N'24, place Kl�ber', N'Strasbourg', NULL, N'67000', N'France', NULL ), 
( 10450, N'VICTE', 8, N'1997-02-19T00:00:00', N'1997-03-19T00:00:00', N'1997-03-11T00:00:00', 2, 7.2300, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France', NULL ), 
( 10451, N'QUICK', 4, N'1997-02-19T00:00:00', N'1997-03-05T00:00:00', N'1997-03-12T00:00:00', 3, 189.0900, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10452, N'SAVEA', 8, N'1997-02-20T00:00:00', N'1997-03-20T00:00:00', N'1997-02-26T00:00:00', 1, 140.2600, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10453, N'AROUT', 1, N'1997-02-21T00:00:00', N'1997-03-21T00:00:00', N'1997-02-26T00:00:00', 2, 25.3600, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK', NULL ), 
( 10454, N'LAMAI', 4, N'1997-02-21T00:00:00', N'1997-03-21T00:00:00', N'1997-02-25T00:00:00', 3, 2.7400, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France', NULL ), 
( 10455, N'WARTH', 8, N'1997-02-24T00:00:00', N'1997-04-07T00:00:00', N'1997-03-03T00:00:00', 2, 180.4500, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland', NULL ), 
( 10456, N'KOENE', 8, N'1997-02-25T00:00:00', N'1997-04-08T00:00:00', N'1997-02-28T00:00:00', 2, 8.1200, N'K�niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany', NULL ), 
( 10457, N'KOENE', 2, N'1997-02-25T00:00:00', N'1997-03-25T00:00:00', N'1997-03-03T00:00:00', 1, 11.5700, N'K�niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany', NULL ), 
( 10458, N'SUPRD', 7, N'1997-02-26T00:00:00', N'1997-03-26T00:00:00', N'1997-03-04T00:00:00', 3, 147.0600, N'Supr�mes d�lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium', NULL ), 
( 10459, N'VICTE', 4, N'1997-02-27T00:00:00', N'1997-03-27T00:00:00', N'1997-02-28T00:00:00', 2, 25.0900, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France', NULL ), 
( 10460, N'FOLKO', 8, N'1997-02-28T00:00:00', N'1997-03-28T00:00:00', N'1997-03-03T00:00:00', 1, 16.2700, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 10461, N'LILAS', 1, N'1997-02-28T00:00:00', N'1997-03-28T00:00:00', N'1997-03-05T00:00:00', 3, 148.6100, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL ), 
( 10462, N'CONSH', 2, N'1997-03-03T00:00:00', N'1997-03-31T00:00:00', N'1997-03-18T00:00:00', 1, 6.1700, N'Consolidated Holdings', N'Berkeley Gardens 12  Brewery', N'London', NULL, N'WX1 6LT', N'UK', NULL ), 
( 10463, N'SUPRD', 5, N'1997-03-04T00:00:00', N'1997-04-01T00:00:00', N'1997-03-06T00:00:00', 3, 14.7800, N'Supr�mes d�lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium', NULL ), 
( 10464, N'FURIB', 4, N'1997-03-04T00:00:00', N'1997-04-01T00:00:00', N'1997-03-14T00:00:00', 2, 89.0000, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', NULL ), 
( 10465, N'VAFFE', 1, N'1997-03-05T00:00:00', N'1997-04-02T00:00:00', N'1997-03-14T00:00:00', 3, 145.0400, N'Vaffeljernet', N'Smagsloget 45', N'�rhus', NULL, N'8200', N'Denmark', NULL ), 
( 10466, N'COMMI', 4, N'1997-03-06T00:00:00', N'1997-04-03T00:00:00', N'1997-03-13T00:00:00', 1, 11.9300, N'Com�rcio Mineiro', N'Av. dos Lus�adas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil', NULL ), 
( 10467, N'MAGAA', 8, N'1997-03-06T00:00:00', N'1997-04-03T00:00:00', N'1997-03-11T00:00:00', 2, 4.9300, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy', NULL ), 
( 10468, N'KOENE', 3, N'1997-03-07T00:00:00', N'1997-04-04T00:00:00', N'1997-03-12T00:00:00', 3, 44.1200, N'K�niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany', NULL ), 
( 10469, N'WHITC', 1, N'1997-03-10T00:00:00', N'1997-04-07T00:00:00', N'1997-03-14T00:00:00', 1, 60.1800, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA', NULL ), 
( 10470, N'BONAP', 4, N'1997-03-11T00:00:00', N'1997-04-08T00:00:00', N'1997-03-14T00:00:00', 2, 64.5600, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', NULL ), 
( 10471, N'BSBEV', 2, N'1997-03-11T00:00:00', N'1997-04-08T00:00:00', N'1997-03-18T00:00:00', 3, 45.5900, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK', NULL ), 
( 10472, N'SEVES', 8, N'1997-03-12T00:00:00', N'1997-04-09T00:00:00', N'1997-03-19T00:00:00', 1, 4.2000, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK', NULL ), 
( 10473, N'ISLAT', 1, N'1997-03-13T00:00:00', N'1997-03-27T00:00:00', N'1997-03-21T00:00:00', 3, 16.3700, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK', NULL ), 
( 10474, N'PERIC', 5, N'1997-03-13T00:00:00', N'1997-04-10T00:00:00', N'1997-03-21T00:00:00', 2, 83.4900, N'Pericles Comidas cl�sicas', N'Calle Dr. Jorge Cash 321', N'M�xico D.F.', NULL, N'05033', N'Mexico', NULL ), 
( 10475, N'SUPRD', 9, N'1997-03-14T00:00:00', N'1997-04-11T00:00:00', N'1997-04-04T00:00:00', 1, 68.5200, N'Supr�mes d�lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium', NULL ), 
( 10476, N'HILAA', 8, N'1997-03-17T00:00:00', N'1997-04-14T00:00:00', N'1997-03-24T00:00:00', 3, 4.4100, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 10477, N'PRINI', 5, N'1997-03-17T00:00:00', N'1997-04-14T00:00:00', N'1997-03-25T00:00:00', 2, 13.0200, N'Princesa Isabel Vinhos', N'Estrada da sa�de n. 58', N'Lisboa', NULL, N'1756', N'Portugal', NULL ), 
( 10478, N'VICTE', 2, N'1997-03-18T00:00:00', N'1997-04-01T00:00:00', N'1997-03-26T00:00:00', 3, 4.8100, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France', NULL ), 
( 10479, N'RATTC', 3, N'1997-03-19T00:00:00', N'1997-04-16T00:00:00', N'1997-03-21T00:00:00', 3, 708.9500, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL ), 
( 10480, N'FOLIG', 6, N'1997-03-20T00:00:00', N'1997-04-17T00:00:00', N'1997-03-24T00:00:00', 2, 1.3500, N'Folies gourmandes', N'184, chauss�e de Tournai', N'Lille', NULL, N'59000', N'France', NULL ), 
( 10481, N'RICAR', 8, N'1997-03-20T00:00:00', N'1997-04-17T00:00:00', N'1997-03-25T00:00:00', 2, 64.3300, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil', NULL ), 
( 10482, N'LAZYK', 1, N'1997-03-21T00:00:00', N'1997-04-18T00:00:00', N'1997-04-10T00:00:00', 3, 7.4800, N'Lazy K Kountry Store', N'12 Orchestra Terrace', N'Walla Walla', N'WA', N'99362', N'USA', NULL ), 
( 10483, N'WHITC', 7, N'1997-03-24T00:00:00', N'1997-04-21T00:00:00', N'1997-04-25T00:00:00', 2, 15.2800, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA', NULL ), 
( 10484, N'BSBEV', 3, N'1997-03-24T00:00:00', N'1997-04-21T00:00:00', N'1997-04-01T00:00:00', 3, 6.8800, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK', NULL ), 
( 10485, N'LINOD', 4, N'1997-03-25T00:00:00', N'1997-04-08T00:00:00', N'1997-03-31T00:00:00', 2, 64.4500, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL ), 
( 10486, N'HILAA', 1, N'1997-03-26T00:00:00', N'1997-04-23T00:00:00', N'1997-04-02T00:00:00', 2, 30.5300, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 10487, N'QUEEN', 2, N'1997-03-26T00:00:00', N'1997-04-23T00:00:00', N'1997-03-28T00:00:00', 2, 71.0700, N'Queen Cozinha', N'Alameda dos Can�rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil', NULL ), 
( 10488, N'FRANK', 8, N'1997-03-27T00:00:00', N'1997-04-24T00:00:00', N'1997-04-02T00:00:00', 2, 4.9300, N'Frankenversand', N'Berliner Platz 43', N'M�nchen', NULL, N'80805', N'Germany', NULL ), 
( 10489, N'PICCO', 6, N'1997-03-28T00:00:00', N'1997-04-25T00:00:00', N'1997-04-09T00:00:00', 2, 5.2900, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL ), 
( 10490, N'HILAA', 7, N'1997-03-31T00:00:00', N'1997-04-28T00:00:00', N'1997-04-03T00:00:00', 2, 210.1900, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 10491, N'FURIB', 8, N'1997-03-31T00:00:00', N'1997-04-28T00:00:00', N'1997-04-08T00:00:00', 3, 16.9600, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', NULL ), 
( 10492, N'BOTTM', 3, N'1997-04-01T00:00:00', N'1997-04-29T00:00:00', N'1997-04-11T00:00:00', 1, 62.8900, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', NULL ), 
( 10493, N'LAMAI', 4, N'1997-04-02T00:00:00', N'1997-04-30T00:00:00', N'1997-04-10T00:00:00', 3, 10.6400, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France', NULL ), 
( 10494, N'COMMI', 4, N'1997-04-02T00:00:00', N'1997-04-30T00:00:00', N'1997-04-09T00:00:00', 2, 65.9900, N'Com�rcio Mineiro', N'Av. dos Lus�adas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil', NULL ), 
( 10495, N'LAUGB', 3, N'1997-04-03T00:00:00', N'1997-05-01T00:00:00', N'1997-04-11T00:00:00', 3, 4.6500, N'Laughing Bacchus Wine Cellars', N'2319 Elm St.', N'Vancouver', N'BC', N'V3F 2K1', N'Canada', NULL ), 
( 10496, N'TRADH', 7, N'1997-04-04T00:00:00', N'1997-05-02T00:00:00', N'1997-04-07T00:00:00', 2, 46.7700, N'Tradi�ao Hipermercados', N'Av. In�s de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil', NULL ), 
( 10497, N'LEHMS', 7, N'1997-04-04T00:00:00', N'1997-05-02T00:00:00', N'1997-04-07T00:00:00', 1, 36.2100, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany', NULL ), 
( 10498, N'HILAA', 8, N'1997-04-07T00:00:00', N'1997-05-05T00:00:00', N'1997-04-11T00:00:00', 2, 29.7500, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 10499, N'LILAS', 4, N'1997-04-08T00:00:00', N'1997-05-06T00:00:00', N'1997-04-16T00:00:00', 2, 102.0200, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL ), 
( 10500, N'LAMAI', 6, N'1997-04-09T00:00:00', N'1997-05-07T00:00:00', N'1997-04-17T00:00:00', 1, 42.6800, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France', NULL ), 
( 10501, N'BLAUS', 9, N'1997-04-09T00:00:00', N'1997-05-07T00:00:00', N'1997-04-16T00:00:00', 3, 8.8500, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany', NULL ), 
( 10502, N'PERIC', 2, N'1997-04-10T00:00:00', N'1997-05-08T00:00:00', N'1997-04-29T00:00:00', 1, 69.3200, N'Pericles Comidas cl�sicas', N'Calle Dr. Jorge Cash 321', N'M�xico D.F.', NULL, N'05033', N'Mexico', NULL ), 
( 10503, N'HUNGO', 6, N'1997-04-11T00:00:00', N'1997-05-09T00:00:00', N'1997-04-16T00:00:00', 2, 16.7400, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10504, N'WHITC', 4, N'1997-04-11T00:00:00', N'1997-05-09T00:00:00', N'1997-04-18T00:00:00', 3, 59.1300, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA', NULL ), 
( 10505, N'MEREP', 3, N'1997-04-14T00:00:00', N'1997-05-12T00:00:00', N'1997-04-21T00:00:00', 3, 7.1300, N'M�re Paillarde', N'43 rue St. Laurent', N'Montr�al', N'Qu�bec', N'H1J 1C3', N'Canada', NULL ), 
( 10506, N'KOENE', 9, N'1997-04-15T00:00:00', N'1997-05-13T00:00:00', N'1997-05-02T00:00:00', 2, 21.1900, N'K�niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany', NULL ), 
( 10507, N'ANTON', 7, N'1997-04-15T00:00:00', N'1997-05-13T00:00:00', N'1997-04-22T00:00:00', 1, 47.4500, N'Antonio Moreno Taquer�a', N'Mataderos  2312', N'M�xico D.F.', NULL, N'05023', N'Mexico', NULL ), 
( 10508, N'OTTIK', 1, N'1997-04-16T00:00:00', N'1997-05-14T00:00:00', N'1997-05-13T00:00:00', 2, 4.9900, N'Ottilies K�seladen', N'Mehrheimerstr. 369', N'K�ln', NULL, N'50739', N'Germany', NULL ), 
( 10509, N'BLAUS', 4, N'1997-04-17T00:00:00', N'1997-05-15T00:00:00', N'1997-04-29T00:00:00', 1, 0.1500, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany', NULL ), 
( 10510, N'SAVEA', 6, N'1997-04-18T00:00:00', N'1997-05-16T00:00:00', N'1997-04-28T00:00:00', 3, 367.6300, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10511, N'BONAP', 4, N'1997-04-18T00:00:00', N'1997-05-16T00:00:00', N'1997-04-21T00:00:00', 3, 350.6400, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', NULL ), 
( 10512, N'FAMIA', 7, N'1997-04-21T00:00:00', N'1997-05-19T00:00:00', N'1997-04-24T00:00:00', 2, 3.5300, N'Familia Arquibaldo', N'Rua Or�s, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil', NULL ), 
( 10513, N'WANDK', 7, N'1997-04-22T00:00:00', N'1997-06-03T00:00:00', N'1997-04-28T00:00:00', 1, 105.6500, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany', NULL ), 
( 10514, N'ERNSH', 3, N'1997-04-22T00:00:00', N'1997-05-20T00:00:00', N'1997-05-16T00:00:00', 2, 789.9500, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10515, N'QUICK', 2, N'1997-04-23T00:00:00', N'1997-05-07T00:00:00', N'1997-05-23T00:00:00', 1, 204.4700, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10516, N'HUNGO', 2, N'1997-04-24T00:00:00', N'1997-05-22T00:00:00', N'1997-05-01T00:00:00', 3, 62.7800, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10517, N'NORTS', 3, N'1997-04-24T00:00:00', N'1997-05-22T00:00:00', N'1997-04-29T00:00:00', 3, 32.0700, N'North/South', N'South House 300 Queensbridge', N'London', NULL, N'SW7 1RZ', N'UK', NULL ), 
( 10518, N'TORTU', 4, N'1997-04-25T00:00:00', N'1997-05-09T00:00:00', N'1997-05-05T00:00:00', 2, 218.1500, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M�xico D.F.', NULL, N'05033', N'Mexico', NULL ), 
( 10519, N'CHOPS', 6, N'1997-04-28T00:00:00', N'1997-05-26T00:00:00', N'1997-05-01T00:00:00', 3, 91.7600, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland', NULL ), 
( 10520, N'SANTG', 7, N'1997-04-29T00:00:00', N'1997-05-27T00:00:00', N'1997-05-01T00:00:00', 1, 13.3700, N'Sant� Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway', NULL ), 
( 10521, N'CACTU', 8, N'1997-04-29T00:00:00', N'1997-05-27T00:00:00', N'1997-05-02T00:00:00', 2, 17.2200, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL ), 
( 10522, N'LEHMS', 4, N'1997-04-30T00:00:00', N'1997-05-28T00:00:00', N'1997-05-06T00:00:00', 1, 45.3300, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany', NULL ), 
( 10523, N'SEVES', 7, N'1997-05-01T00:00:00', N'1997-05-29T00:00:00', N'1997-05-30T00:00:00', 2, 77.6300, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK', NULL ), 
( 10524, N'BERGS', 1, N'1997-05-01T00:00:00', N'1997-05-29T00:00:00', N'1997-05-07T00:00:00', 2, 244.7900, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10525, N'BONAP', 1, N'1997-05-02T00:00:00', N'1997-05-30T00:00:00', N'1997-05-23T00:00:00', 2, 11.0600, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', NULL ), 
( 10526, N'WARTH', 4, N'1997-05-05T00:00:00', N'1997-06-02T00:00:00', N'1997-05-15T00:00:00', 2, 58.5900, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland', NULL ), 
( 10527, N'QUICK', 7, N'1997-05-05T00:00:00', N'1997-06-02T00:00:00', N'1997-05-07T00:00:00', 1, 41.9000, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10528, N'GREAL', 6, N'1997-05-06T00:00:00', N'1997-05-20T00:00:00', N'1997-05-09T00:00:00', 2, 3.3500, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA', NULL ), 
( 10529, N'MAISD', 5, N'1997-05-07T00:00:00', N'1997-06-04T00:00:00', N'1997-05-09T00:00:00', 2, 66.6900, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium', NULL ), 
( 10530, N'PICCO', 3, N'1997-05-08T00:00:00', N'1997-06-05T00:00:00', N'1997-05-12T00:00:00', 2, 339.2200, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL ), 
( 10531, N'OCEAN', 7, N'1997-05-08T00:00:00', N'1997-06-05T00:00:00', N'1997-05-19T00:00:00', 1, 8.1200, N'Oc�ano Atl�ntico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL ), 
( 10532, N'EASTC', 7, N'1997-05-09T00:00:00', N'1997-06-06T00:00:00', N'1997-05-12T00:00:00', 3, 74.4600, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK', NULL ), 
( 10533, N'FOLKO', 8, N'1997-05-12T00:00:00', N'1997-06-09T00:00:00', N'1997-05-22T00:00:00', 1, 188.0400, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 10534, N'LEHMS', 8, N'1997-05-12T00:00:00', N'1997-06-09T00:00:00', N'1997-05-14T00:00:00', 2, 27.9400, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany', NULL ), 
( 10535, N'ANTON', 4, N'1997-05-13T00:00:00', N'1997-06-10T00:00:00', N'1997-05-21T00:00:00', 1, 15.6400, N'Antonio Moreno Taquer�a', N'Mataderos  2312', N'M�xico D.F.', NULL, N'05023', N'Mexico', NULL ), 
( 10536, N'LEHMS', 3, N'1997-05-14T00:00:00', N'1997-06-11T00:00:00', N'1997-06-06T00:00:00', 2, 58.8800, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany', NULL ), 
( 10537, N'RICSU', 1, N'1997-05-14T00:00:00', N'1997-05-28T00:00:00', N'1997-05-19T00:00:00', 1, 78.8500, N'Richter Supermarkt', N'Starenweg 5', N'Gen�ve', NULL, N'1204', N'Switzerland', NULL ), 
( 10538, N'BSBEV', 9, N'1997-05-15T00:00:00', N'1997-06-12T00:00:00', N'1997-05-16T00:00:00', 3, 4.8700, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK', NULL ), 
( 10539, N'BSBEV', 6, N'1997-05-16T00:00:00', N'1997-06-13T00:00:00', N'1997-05-23T00:00:00', 3, 12.3600, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK', NULL ), 
( 10540, N'QUICK', 3, N'1997-05-19T00:00:00', N'1997-06-16T00:00:00', N'1997-06-13T00:00:00', 3, 1007.6400, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10541, N'HANAR', 2, N'1997-05-19T00:00:00', N'1997-06-16T00:00:00', N'1997-05-29T00:00:00', 1, 68.6500, N'Hanari Carnes', N'Rua do Pa�o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil', NULL ), 
( 10542, N'KOENE', 1, N'1997-05-20T00:00:00', N'1997-06-17T00:00:00', N'1997-05-26T00:00:00', 3, 10.9500, N'K�niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany', NULL ), 
( 10543, N'LILAS', 8, N'1997-05-21T00:00:00', N'1997-06-18T00:00:00', N'1997-05-23T00:00:00', 2, 48.1700, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL ), 
( 10544, N'LONEP', 4, N'1997-05-21T00:00:00', N'1997-06-18T00:00:00', N'1997-05-30T00:00:00', 1, 24.9100, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA', NULL ), 
( 10545, N'LAZYK', 8, N'1997-05-22T00:00:00', N'1997-06-19T00:00:00', N'1997-06-26T00:00:00', 2, 11.9200, N'Lazy K Kountry Store', N'12 Orchestra Terrace', N'Walla Walla', N'WA', N'99362', N'USA', NULL ), 
( 10546, N'VICTE', 1, N'1997-05-23T00:00:00', N'1997-06-20T00:00:00', N'1997-05-27T00:00:00', 3, 194.7200, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France', NULL ), 
( 10547, N'SEVES', 3, N'1997-05-23T00:00:00', N'1997-06-20T00:00:00', N'1997-06-02T00:00:00', 2, 178.4300, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK', NULL ), 
( 10548, N'TOMSP', 3, N'1997-05-26T00:00:00', N'1997-06-23T00:00:00', N'1997-06-02T00:00:00', 2, 1.4300, N'Toms Spezialit�ten', N'Luisenstr. 48', N'M�nster', NULL, N'44087', N'Germany', NULL ), 
( 10549, N'QUICK', 5, N'1997-05-27T00:00:00', N'1997-06-10T00:00:00', N'1997-05-30T00:00:00', 1, 171.2400, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10550, N'GODOS', 7, N'1997-05-28T00:00:00', N'1997-06-25T00:00:00', N'1997-06-06T00:00:00', 3, 4.3200, N'Godos Cocina T�pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain', NULL ), 
( 10551, N'FURIB', 4, N'1997-05-28T00:00:00', N'1997-07-09T00:00:00', N'1997-06-06T00:00:00', 3, 72.9500, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', NULL ), 
( 10552, N'HILAA', 2, N'1997-05-29T00:00:00', N'1997-06-26T00:00:00', N'1997-06-05T00:00:00', 1, 83.2200, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 10553, N'WARTH', 2, N'1997-05-30T00:00:00', N'1997-06-27T00:00:00', N'1997-06-03T00:00:00', 2, 149.4900, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland', NULL ), 
( 10554, N'OTTIK', 4, N'1997-05-30T00:00:00', N'1997-06-27T00:00:00', N'1997-06-05T00:00:00', 3, 120.9700, N'Ottilies K�seladen', N'Mehrheimerstr. 369', N'K�ln', NULL, N'50739', N'Germany', NULL ), 
( 10555, N'SAVEA', 6, N'1997-06-02T00:00:00', N'1997-06-30T00:00:00', N'1997-06-04T00:00:00', 3, 252.4900, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10556, N'SIMOB', 2, N'1997-06-03T00:00:00', N'1997-07-15T00:00:00', N'1997-06-13T00:00:00', 1, 9.8000, N'Simons bistro', N'Vinb�ltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark', NULL ), 
( 10557, N'LEHMS', 9, N'1997-06-03T00:00:00', N'1997-06-17T00:00:00', N'1997-06-06T00:00:00', 2, 96.7200, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany', NULL ), 
( 10558, N'AROUT', 1, N'1997-06-04T00:00:00', N'1997-07-02T00:00:00', N'1997-06-10T00:00:00', 2, 72.9700, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK', NULL ), 
( 10559, N'BLONP', 6, N'1997-06-05T00:00:00', N'1997-07-03T00:00:00', N'1997-06-13T00:00:00', 1, 8.0500, N'Blondel p�re et fils', N'24, place Kl�ber', N'Strasbourg', NULL, N'67000', N'France', NULL ), 
( 10560, N'FRANK', 8, N'1997-06-06T00:00:00', N'1997-07-04T00:00:00', N'1997-06-09T00:00:00', 1, 36.6500, N'Frankenversand', N'Berliner Platz 43', N'M�nchen', NULL, N'80805', N'Germany', NULL ), 
( 10561, N'FOLKO', 2, N'1997-06-06T00:00:00', N'1997-07-04T00:00:00', N'1997-06-09T00:00:00', 2, 242.2100, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 10562, N'REGGC', 1, N'1997-06-09T00:00:00', N'1997-07-07T00:00:00', N'1997-06-12T00:00:00', 1, 22.9500, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy', NULL ), 
( 10563, N'RICAR', 2, N'1997-06-10T00:00:00', N'1997-07-22T00:00:00', N'1997-06-24T00:00:00', 2, 60.4300, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil', NULL ), 
( 10564, N'RATTC', 4, N'1997-06-10T00:00:00', N'1997-07-08T00:00:00', N'1997-06-16T00:00:00', 3, 13.7500, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL ), 
( 10565, N'MEREP', 8, N'1997-06-11T00:00:00', N'1997-07-09T00:00:00', N'1997-06-18T00:00:00', 2, 7.1500, N'M�re Paillarde', N'43 rue St. Laurent', N'Montr�al', N'Qu�bec', N'H1J 1C3', N'Canada', NULL ), 
( 10566, N'BLONP', 9, N'1997-06-12T00:00:00', N'1997-07-10T00:00:00', N'1997-06-18T00:00:00', 1, 88.4000, N'Blondel p�re et fils', N'24, place Kl�ber', N'Strasbourg', NULL, N'67000', N'France', NULL ), 
( 10567, N'HUNGO', 1, N'1997-06-12T00:00:00', N'1997-07-10T00:00:00', N'1997-06-17T00:00:00', 1, 33.9700, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10568, N'GALED', 3, N'1997-06-13T00:00:00', N'1997-07-11T00:00:00', N'1997-07-09T00:00:00', 3, 6.5400, N'Galer�a del gastron�mo', N'Rambla de Catalu�a, 23', N'Barcelona', NULL, N'8022', N'Spain', NULL ), 
( 10569, N'RATTC', 5, N'1997-06-16T00:00:00', N'1997-07-14T00:00:00', N'1997-07-11T00:00:00', 1, 58.9800, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL ), 
( 10570, N'MEREP', 3, N'1997-06-17T00:00:00', N'1997-07-15T00:00:00', N'1997-06-19T00:00:00', 3, 188.9900, N'M�re Paillarde', N'43 rue St. Laurent', N'Montr�al', N'Qu�bec', N'H1J 1C3', N'Canada', NULL ), 
( 10571, N'ERNSH', 8, N'1997-06-17T00:00:00', N'1997-07-29T00:00:00', N'1997-07-04T00:00:00', 3, 26.0600, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10572, N'BERGS', 3, N'1997-06-18T00:00:00', N'1997-07-16T00:00:00', N'1997-06-25T00:00:00', 2, 116.4300, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10573, N'ANTON', 7, N'1997-06-19T00:00:00', N'1997-07-17T00:00:00', N'1997-06-20T00:00:00', 3, 84.8400, N'Antonio Moreno Taquer�a', N'Mataderos  2312', N'M�xico D.F.', NULL, N'05023', N'Mexico', NULL ), 
( 10574, N'TRAIH', 4, N'1997-06-19T00:00:00', N'1997-07-17T00:00:00', N'1997-06-30T00:00:00', 2, 37.6000, N'Trail''s Head Gourmet Provisioners', N'722 DaVinci Blvd.', N'Kirkland', N'WA', N'98034', N'USA', NULL ), 
( 10575, N'MORGK', 5, N'1997-06-20T00:00:00', N'1997-07-04T00:00:00', N'1997-06-30T00:00:00', 1, 127.3400, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Germany', NULL ), 
( 10576, N'TORTU', 3, N'1997-06-23T00:00:00', N'1997-07-07T00:00:00', N'1997-06-30T00:00:00', 3, 18.5600, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M�xico D.F.', NULL, N'05033', N'Mexico', NULL ), 
( 10577, N'TRAIH', 9, N'1997-06-23T00:00:00', N'1997-08-04T00:00:00', N'1997-06-30T00:00:00', 2, 25.4100, N'Trail''s Head Gourmet Provisioners', N'722 DaVinci Blvd.', N'Kirkland', N'WA', N'98034', N'USA', NULL ), 
( 10578, N'BSBEV', 4, N'1997-06-24T00:00:00', N'1997-07-22T00:00:00', N'1997-07-25T00:00:00', 3, 29.6000, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK', NULL ), 
( 10579, N'LETSS', 1, N'1997-06-25T00:00:00', N'1997-07-23T00:00:00', N'1997-07-04T00:00:00', 2, 13.7300, N'Let''s Stop N Shop', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA', NULL ), 
( 10580, N'OTTIK', 4, N'1997-06-26T00:00:00', N'1997-07-24T00:00:00', N'1997-07-01T00:00:00', 3, 75.8900, N'Ottilies K�seladen', N'Mehrheimerstr. 369', N'K�ln', NULL, N'50739', N'Germany', NULL ), 
( 10581, N'FAMIA', 3, N'1997-06-26T00:00:00', N'1997-07-24T00:00:00', N'1997-07-02T00:00:00', 1, 3.0100, N'Familia Arquibaldo', N'Rua Or�s, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil', NULL ), 
( 10582, N'BLAUS', 3, N'1997-06-27T00:00:00', N'1997-07-25T00:00:00', N'1997-07-14T00:00:00', 2, 27.7100, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany', NULL ), 
( 10583, N'WARTH', 2, N'1997-06-30T00:00:00', N'1997-07-28T00:00:00', N'1997-07-04T00:00:00', 2, 7.2800, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland', NULL ), 
( 10584, N'BLONP', 4, N'1997-06-30T00:00:00', N'1997-07-28T00:00:00', N'1997-07-04T00:00:00', 1, 59.1400, N'Blondel p�re et fils', N'24, place Kl�ber', N'Strasbourg', NULL, N'67000', N'France', NULL ), 
( 10585, N'WELLI', 7, N'1997-07-01T00:00:00', N'1997-07-29T00:00:00', N'1997-07-10T00:00:00', 1, 13.4100, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil', NULL ), 
( 10586, N'REGGC', 9, N'1997-07-02T00:00:00', N'1997-07-30T00:00:00', N'1997-07-09T00:00:00', 1, 0.4800, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy', NULL ), 
( 10587, N'QUEDE', 1, N'1997-07-02T00:00:00', N'1997-07-30T00:00:00', N'1997-07-09T00:00:00', 1, 62.5200, N'Que Del�cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil', NULL ), 
( 10588, N'QUICK', 2, N'1997-07-03T00:00:00', N'1997-07-31T00:00:00', N'1997-07-10T00:00:00', 3, 194.6700, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10589, N'GREAL', 8, N'1997-07-04T00:00:00', N'1997-08-01T00:00:00', N'1997-07-14T00:00:00', 2, 4.4200, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA', NULL ), 
( 10590, N'MEREP', 4, N'1997-07-07T00:00:00', N'1997-08-04T00:00:00', N'1997-07-14T00:00:00', 3, 44.7700, N'M�re Paillarde', N'43 rue St. Laurent', N'Montr�al', N'Qu�bec', N'H1J 1C3', N'Canada', NULL ), 
( 10591, N'VAFFE', 1, N'1997-07-07T00:00:00', N'1997-07-21T00:00:00', N'1997-07-16T00:00:00', 1, 55.9200, N'Vaffeljernet', N'Smagsloget 45', N'�rhus', NULL, N'8200', N'Denmark', NULL ), 
( 10592, N'LEHMS', 3, N'1997-07-08T00:00:00', N'1997-08-05T00:00:00', N'1997-07-16T00:00:00', 1, 32.1000, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany', NULL ), 
( 10593, N'LEHMS', 7, N'1997-07-09T00:00:00', N'1997-08-06T00:00:00', N'1997-08-13T00:00:00', 2, 174.2000, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany', NULL ), 
( 10594, N'OLDWO', 3, N'1997-07-09T00:00:00', N'1997-08-06T00:00:00', N'1997-07-16T00:00:00', 2, 5.2400, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA', NULL ), 
( 10595, N'ERNSH', 2, N'1997-07-10T00:00:00', N'1997-08-07T00:00:00', N'1997-07-14T00:00:00', 1, 96.7800, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10596, N'WHITC', 8, N'1997-07-11T00:00:00', N'1997-08-08T00:00:00', N'1997-08-12T00:00:00', 1, 16.3400, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA', NULL ), 
( 10597, N'PICCO', 7, N'1997-07-11T00:00:00', N'1997-08-08T00:00:00', N'1997-07-18T00:00:00', 3, 35.1200, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL ), 
( 10598, N'RATTC', 1, N'1997-07-14T00:00:00', N'1997-08-11T00:00:00', N'1997-07-18T00:00:00', 3, 44.4200, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL ), 
( 10599, N'BSBEV', 6, N'1997-07-15T00:00:00', N'1997-08-26T00:00:00', N'1997-07-21T00:00:00', 3, 29.9800, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK', NULL ), 
( 10600, N'HUNGC', 4, N'1997-07-16T00:00:00', N'1997-08-13T00:00:00', N'1997-07-21T00:00:00', 1, 45.1300, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA', NULL ), 
( 10601, N'HILAA', 7, N'1997-07-16T00:00:00', N'1997-08-27T00:00:00', N'1997-07-22T00:00:00', 1, 58.3000, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 10602, N'VAFFE', 8, N'1997-07-17T00:00:00', N'1997-08-14T00:00:00', N'1997-07-22T00:00:00', 2, 2.9200, N'Vaffeljernet', N'Smagsloget 45', N'�rhus', NULL, N'8200', N'Denmark', NULL ), 
( 10603, N'SAVEA', 8, N'1997-07-18T00:00:00', N'1997-08-15T00:00:00', N'1997-08-08T00:00:00', 2, 48.7700, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10604, N'FURIB', 1, N'1997-07-18T00:00:00', N'1997-08-15T00:00:00', N'1997-07-29T00:00:00', 1, 7.4600, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', NULL ), 
( 10605, N'MEREP', 1, N'1997-07-21T00:00:00', N'1997-08-18T00:00:00', N'1997-07-29T00:00:00', 2, 379.1300, N'M�re Paillarde', N'43 rue St. Laurent', N'Montr�al', N'Qu�bec', N'H1J 1C3', N'Canada', NULL ), 
( 10606, N'TRADH', 4, N'1997-07-22T00:00:00', N'1997-08-19T00:00:00', N'1997-07-31T00:00:00', 3, 79.4000, N'Tradi�ao Hipermercados', N'Av. In�s de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil', NULL ), 
( 10607, N'SAVEA', 5, N'1997-07-22T00:00:00', N'1997-08-19T00:00:00', N'1997-07-25T00:00:00', 1, 200.2400, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10608, N'TOMSP', 4, N'1997-07-23T00:00:00', N'1997-08-20T00:00:00', N'1997-08-01T00:00:00', 2, 27.7900, N'Toms Spezialit�ten', N'Luisenstr. 48', N'M�nster', NULL, N'44087', N'Germany', NULL ), 
( 10609, N'DUMON', 7, N'1997-07-24T00:00:00', N'1997-08-21T00:00:00', N'1997-07-30T00:00:00', 2, 1.8500, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'France', NULL ), 
( 10610, N'LAMAI', 8, N'1997-07-25T00:00:00', N'1997-08-22T00:00:00', N'1997-08-06T00:00:00', 1, 26.7800, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France', NULL ), 
( 10611, N'WOLZA', 6, N'1997-07-25T00:00:00', N'1997-08-22T00:00:00', N'1997-08-01T00:00:00', 2, 80.6500, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland', NULL ), 
( 10612, N'SAVEA', 1, N'1997-07-28T00:00:00', N'1997-08-25T00:00:00', N'1997-08-01T00:00:00', 2, 544.0800, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10613, N'HILAA', 4, N'1997-07-29T00:00:00', N'1997-08-26T00:00:00', N'1997-08-01T00:00:00', 2, 8.1100, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 10614, N'BLAUS', 8, N'1997-07-29T00:00:00', N'1997-08-26T00:00:00', N'1997-08-01T00:00:00', 3, 1.9300, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany', NULL ), 
( 10615, N'WILMK', 2, N'1997-07-30T00:00:00', N'1997-08-27T00:00:00', N'1997-08-06T00:00:00', 3, 0.7500, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland', NULL ), 
( 10616, N'GREAL', 1, N'1997-07-31T00:00:00', N'1997-08-28T00:00:00', N'1997-08-05T00:00:00', 2, 116.5300, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA', NULL ), 
( 10617, N'GREAL', 4, N'1997-07-31T00:00:00', N'1997-08-28T00:00:00', N'1997-08-04T00:00:00', 2, 18.5300, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA', NULL ), 
( 10618, N'MEREP', 1, N'1997-08-01T00:00:00', N'1997-09-12T00:00:00', N'1997-08-08T00:00:00', 1, 154.6800, N'M�re Paillarde', N'43 rue St. Laurent', N'Montr�al', N'Qu�bec', N'H1J 1C3', N'Canada', NULL ), 
( 10619, N'MEREP', 3, N'1997-08-04T00:00:00', N'1997-09-01T00:00:00', N'1997-08-07T00:00:00', 3, 91.0500, N'M�re Paillarde', N'43 rue St. Laurent', N'Montr�al', N'Qu�bec', N'H1J 1C3', N'Canada', NULL ), 
( 10620, N'LAUGB', 2, N'1997-08-05T00:00:00', N'1997-09-02T00:00:00', N'1997-08-14T00:00:00', 3, 0.9400, N'Laughing Bacchus Wine Cellars', N'2319 Elm St.', N'Vancouver', N'BC', N'V3F 2K1', N'Canada', NULL ), 
( 10621, N'ISLAT', 4, N'1997-08-05T00:00:00', N'1997-09-02T00:00:00', N'1997-08-11T00:00:00', 2, 23.7300, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK', NULL ), 
( 10622, N'RICAR', 4, N'1997-08-06T00:00:00', N'1997-09-03T00:00:00', N'1997-08-11T00:00:00', 3, 50.9700, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil', NULL ), 
( 10623, N'FRANK', 8, N'1997-08-07T00:00:00', N'1997-09-04T00:00:00', N'1997-08-12T00:00:00', 2, 97.1800, N'Frankenversand', N'Berliner Platz 43', N'M�nchen', NULL, N'80805', N'Germany', NULL ), 
( 10624, N'THECR', 4, N'1997-08-07T00:00:00', N'1997-09-04T00:00:00', N'1997-08-19T00:00:00', 2, 94.8000, N'The Cracker Box', N'55 Grizzly Peak Rd.', N'Butte', N'MT', N'59801', N'USA', NULL ), 
( 10625, N'ANATR', 3, N'1997-08-08T00:00:00', N'1997-09-05T00:00:00', N'1997-08-14T00:00:00', 1, 43.9000, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constituci�n 2222', N'M�xico D.F.', NULL, N'05021', N'Mexico', NULL ), 
( 10626, N'BERGS', 1, N'1997-08-11T00:00:00', N'1997-09-08T00:00:00', N'1997-08-20T00:00:00', 2, 138.6900, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10627, N'SAVEA', 8, N'1997-08-11T00:00:00', N'1997-09-22T00:00:00', N'1997-08-21T00:00:00', 3, 107.4600, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10628, N'BLONP', 4, N'1997-08-12T00:00:00', N'1997-09-09T00:00:00', N'1997-08-20T00:00:00', 3, 30.3600, N'Blondel p�re et fils', N'24, place Kl�ber', N'Strasbourg', NULL, N'67000', N'France', NULL ), 
( 10629, N'GODOS', 4, N'1997-08-12T00:00:00', N'1997-09-09T00:00:00', N'1997-08-20T00:00:00', 3, 85.4600, N'Godos Cocina T�pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain', NULL ), 
( 10630, N'KOENE', 1, N'1997-08-13T00:00:00', N'1997-09-10T00:00:00', N'1997-08-19T00:00:00', 2, 32.3500, N'K�niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany', NULL ), 
( 10631, N'LAMAI', 8, N'1997-08-14T00:00:00', N'1997-09-11T00:00:00', N'1997-08-15T00:00:00', 1, 0.8700, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France', NULL ), 
( 10632, N'WANDK', 8, N'1997-08-14T00:00:00', N'1997-09-11T00:00:00', N'1997-08-19T00:00:00', 1, 41.3800, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany', NULL ), 
( 10633, N'ERNSH', 7, N'1997-08-15T00:00:00', N'1997-09-12T00:00:00', N'1997-08-18T00:00:00', 3, 477.9000, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10634, N'FOLIG', 4, N'1997-08-15T00:00:00', N'1997-09-12T00:00:00', N'1997-08-21T00:00:00', 3, 487.3800, N'Folies gourmandes', N'184, chauss�e de Tournai', N'Lille', NULL, N'59000', N'France', NULL ), 
( 10635, N'MAGAA', 8, N'1997-08-18T00:00:00', N'1997-09-15T00:00:00', N'1997-08-21T00:00:00', 3, 47.4600, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy', NULL ), 
( 10636, N'WARTH', 4, N'1997-08-19T00:00:00', N'1997-09-16T00:00:00', N'1997-08-26T00:00:00', 1, 1.1500, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland', NULL ), 
( 10637, N'QUEEN', 6, N'1997-08-19T00:00:00', N'1997-09-16T00:00:00', N'1997-08-26T00:00:00', 1, 201.2900, N'Queen Cozinha', N'Alameda dos Can�rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil', NULL ), 
( 10638, N'LINOD', 3, N'1997-08-20T00:00:00', N'1997-09-17T00:00:00', N'1997-09-01T00:00:00', 1, 158.4400, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL ), 
( 10639, N'SANTG', 7, N'1997-08-20T00:00:00', N'1997-09-17T00:00:00', N'1997-08-27T00:00:00', 3, 38.6400, N'Sant� Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway', NULL ), 
( 10640, N'WANDK', 4, N'1997-08-21T00:00:00', N'1997-09-18T00:00:00', N'1997-08-28T00:00:00', 1, 23.5500, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany', NULL ), 
( 10641, N'HILAA', 4, N'1997-08-22T00:00:00', N'1997-09-19T00:00:00', N'1997-08-26T00:00:00', 2, 179.6100, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 10642, N'SIMOB', 7, N'1997-08-22T00:00:00', N'1997-09-19T00:00:00', N'1997-09-05T00:00:00', 3, 41.8900, N'Simons bistro', N'Vinb�ltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark', NULL ), 
( 10643, N'ALFKI', 6, N'1997-08-25T00:00:00', N'1997-09-22T00:00:00', N'1997-09-02T00:00:00', 1, 29.4600, N'Alfreds Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany', NULL ), 
( 10644, N'WELLI', 3, N'1997-08-25T00:00:00', N'1997-09-22T00:00:00', N'1997-09-01T00:00:00', 2, 0.1400, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil', NULL ), 
( 10645, N'HANAR', 4, N'1997-08-26T00:00:00', N'1997-09-23T00:00:00', N'1997-09-02T00:00:00', 1, 12.4100, N'Hanari Carnes', N'Rua do Pa�o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil', NULL ), 
( 10646, N'HUNGO', 9, N'1997-08-27T00:00:00', N'1997-10-08T00:00:00', N'1997-09-03T00:00:00', 3, 142.3300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10647, N'QUEDE', 4, N'1997-08-27T00:00:00', N'1997-09-10T00:00:00', N'1997-09-03T00:00:00', 2, 45.5400, N'Que Del�cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil', NULL ), 
( 10648, N'RICAR', 5, N'1997-08-28T00:00:00', N'1997-10-09T00:00:00', N'1997-09-09T00:00:00', 2, 14.2500, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil', NULL ), 
( 10649, N'MAISD', 5, N'1997-08-28T00:00:00', N'1997-09-25T00:00:00', N'1997-08-29T00:00:00', 3, 6.2000, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium', NULL ), 
( 10650, N'FAMIA', 5, N'1997-08-29T00:00:00', N'1997-09-26T00:00:00', N'1997-09-03T00:00:00', 3, 176.8100, N'Familia Arquibaldo', N'Rua Or�s, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil', NULL ), 
( 10651, N'WANDK', 8, N'1997-09-01T00:00:00', N'1997-09-29T00:00:00', N'1997-09-11T00:00:00', 2, 20.6000, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany', NULL ), 
( 10652, N'GOURL', 4, N'1997-09-01T00:00:00', N'1997-09-29T00:00:00', N'1997-09-08T00:00:00', 2, 7.1400, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil', NULL ), 
( 10653, N'FRANK', 1, N'1997-09-02T00:00:00', N'1997-09-30T00:00:00', N'1997-09-19T00:00:00', 1, 93.2500, N'Frankenversand', N'Berliner Platz 43', N'M�nchen', NULL, N'80805', N'Germany', NULL ), 
( 10654, N'BERGS', 5, N'1997-09-02T00:00:00', N'1997-09-30T00:00:00', N'1997-09-11T00:00:00', 1, 55.2600, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10655, N'REGGC', 1, N'1997-09-03T00:00:00', N'1997-10-01T00:00:00', N'1997-09-11T00:00:00', 2, 4.4100, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy', NULL ), 
( 10656, N'GREAL', 6, N'1997-09-04T00:00:00', N'1997-10-02T00:00:00', N'1997-09-10T00:00:00', 1, 57.1500, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA', NULL ), 
( 10657, N'SAVEA', 2, N'1997-09-04T00:00:00', N'1997-10-02T00:00:00', N'1997-09-15T00:00:00', 2, 352.6900, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10658, N'QUICK', 4, N'1997-09-05T00:00:00', N'1997-10-03T00:00:00', N'1997-09-08T00:00:00', 1, 364.1500, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10659, N'QUEEN', 7, N'1997-09-05T00:00:00', N'1997-10-03T00:00:00', N'1997-09-10T00:00:00', 2, 105.8100, N'Queen Cozinha', N'Alameda dos Can�rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil', NULL ), 
( 10660, N'HUNGC', 8, N'1997-09-08T00:00:00', N'1997-10-06T00:00:00', N'1997-10-15T00:00:00', 1, 111.2900, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA', NULL ), 
( 10661, N'HUNGO', 7, N'1997-09-09T00:00:00', N'1997-10-07T00:00:00', N'1997-09-15T00:00:00', 3, 17.5500, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10662, N'LONEP', 3, N'1997-09-09T00:00:00', N'1997-10-07T00:00:00', N'1997-09-18T00:00:00', 2, 1.2800, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA', NULL ), 
( 10663, N'BONAP', 2, N'1997-09-10T00:00:00', N'1997-09-24T00:00:00', N'1997-10-03T00:00:00', 2, 113.1500, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', NULL ), 
( 10664, N'FURIB', 1, N'1997-09-10T00:00:00', N'1997-10-08T00:00:00', N'1997-09-19T00:00:00', 3, 1.2700, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', NULL ), 
( 10665, N'LONEP', 1, N'1997-09-11T00:00:00', N'1997-10-09T00:00:00', N'1997-09-17T00:00:00', 2, 26.3100, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA', NULL ), 
( 10666, N'RICSU', 7, N'1997-09-12T00:00:00', N'1997-10-10T00:00:00', N'1997-09-22T00:00:00', 2, 232.4200, N'Richter Supermarkt', N'Starenweg 5', N'Gen�ve', NULL, N'1204', N'Switzerland', NULL ), 
( 10667, N'ERNSH', 7, N'1997-09-12T00:00:00', N'1997-10-10T00:00:00', N'1997-09-19T00:00:00', 1, 78.0900, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10668, N'WANDK', 1, N'1997-09-15T00:00:00', N'1997-10-13T00:00:00', N'1997-09-23T00:00:00', 2, 47.2200, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany', NULL ), 
( 10669, N'SIMOB', 2, N'1997-09-15T00:00:00', N'1997-10-13T00:00:00', N'1997-09-22T00:00:00', 1, 24.3900, N'Simons bistro', N'Vinb�ltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark', NULL ), 
( 10670, N'FRANK', 4, N'1997-09-16T00:00:00', N'1997-10-14T00:00:00', N'1997-09-18T00:00:00', 1, 203.4800, N'Frankenversand', N'Berliner Platz 43', N'M�nchen', NULL, N'80805', N'Germany', NULL ), 
( 10671, N'FRANR', 1, N'1997-09-17T00:00:00', N'1997-10-15T00:00:00', N'1997-09-24T00:00:00', 1, 30.3400, N'France restauration', N'54, rue Royale', N'Nantes', NULL, N'44000', N'France', NULL ), 
( 10672, N'BERGS', 9, N'1997-09-17T00:00:00', N'1997-10-01T00:00:00', N'1997-09-26T00:00:00', 2, 95.7500, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10673, N'WILMK', 2, N'1997-09-18T00:00:00', N'1997-10-16T00:00:00', N'1997-09-19T00:00:00', 1, 22.7600, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland', NULL ), 
( 10674, N'ISLAT', 4, N'1997-09-18T00:00:00', N'1997-10-16T00:00:00', N'1997-09-30T00:00:00', 2, 0.9000, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK', NULL ), 
( 10675, N'FRANK', 5, N'1997-09-19T00:00:00', N'1997-10-17T00:00:00', N'1997-09-23T00:00:00', 2, 31.8500, N'Frankenversand', N'Berliner Platz 43', N'M�nchen', NULL, N'80805', N'Germany', NULL ), 
( 10676, N'TORTU', 2, N'1997-09-22T00:00:00', N'1997-10-20T00:00:00', N'1997-09-29T00:00:00', 2, 2.0100, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M�xico D.F.', NULL, N'05033', N'Mexico', NULL ), 
( 10677, N'ANTON', 1, N'1997-09-22T00:00:00', N'1997-10-20T00:00:00', N'1997-09-26T00:00:00', 3, 4.0300, N'Antonio Moreno Taquer�a', N'Mataderos  2312', N'M�xico D.F.', NULL, N'05023', N'Mexico', NULL ), 
( 10678, N'SAVEA', 7, N'1997-09-23T00:00:00', N'1997-10-21T00:00:00', N'1997-10-16T00:00:00', 3, 388.9800, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10679, N'BLONP', 8, N'1997-09-23T00:00:00', N'1997-10-21T00:00:00', N'1997-09-30T00:00:00', 3, 27.9400, N'Blondel p�re et fils', N'24, place Kl�ber', N'Strasbourg', NULL, N'67000', N'France', NULL ), 
( 10680, N'OLDWO', 1, N'1997-09-24T00:00:00', N'1997-10-22T00:00:00', N'1997-09-26T00:00:00', 1, 26.6100, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA', NULL ), 
( 10681, N'GREAL', 3, N'1997-09-25T00:00:00', N'1997-10-23T00:00:00', N'1997-09-30T00:00:00', 3, 76.1300, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA', NULL ), 
( 10682, N'ANTON', 3, N'1997-09-25T00:00:00', N'1997-10-23T00:00:00', N'1997-10-01T00:00:00', 2, 36.1300, N'Antonio Moreno Taquer�a', N'Mataderos  2312', N'M�xico D.F.', NULL, N'05023', N'Mexico', NULL ), 
( 10683, N'DUMON', 2, N'1997-09-26T00:00:00', N'1997-10-24T00:00:00', N'1997-10-01T00:00:00', 1, 4.4000, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'France', NULL ), 
( 10684, N'OTTIK', 3, N'1997-09-26T00:00:00', N'1997-10-24T00:00:00', N'1997-09-30T00:00:00', 1, 145.6300, N'Ottilies K�seladen', N'Mehrheimerstr. 369', N'K�ln', NULL, N'50739', N'Germany', NULL ), 
( 10685, N'GOURL', 4, N'1997-09-29T00:00:00', N'1997-10-13T00:00:00', N'1997-10-03T00:00:00', 2, 33.7500, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil', NULL ), 
( 10686, N'PICCO', 2, N'1997-09-30T00:00:00', N'1997-10-28T00:00:00', N'1997-10-08T00:00:00', 1, 96.5000, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL ), 
( 10687, N'HUNGO', 9, N'1997-09-30T00:00:00', N'1997-10-28T00:00:00', N'1997-10-30T00:00:00', 2, 296.4300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10688, N'VAFFE', 4, N'1997-10-01T00:00:00', N'1997-10-15T00:00:00', N'1997-10-07T00:00:00', 2, 299.0900, N'Vaffeljernet', N'Smagsloget 45', N'�rhus', NULL, N'8200', N'Denmark', NULL ), 
( 10689, N'BERGS', 1, N'1997-10-01T00:00:00', N'1997-10-29T00:00:00', N'1997-10-07T00:00:00', 2, 13.4200, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10690, N'HANAR', 1, N'1997-10-02T00:00:00', N'1997-10-30T00:00:00', N'1997-10-03T00:00:00', 1, 15.8000, N'Hanari Carnes', N'Rua do Pa�o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil', NULL ), 
( 10691, N'QUICK', 2, N'1997-10-03T00:00:00', N'1997-11-14T00:00:00', N'1997-10-22T00:00:00', 2, 810.0500, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10692, N'ALFKI', 4, N'1997-10-03T00:00:00', N'1997-10-31T00:00:00', N'1997-10-13T00:00:00', 2, 61.0200, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany', NULL ), 
( 10693, N'WHITC', 3, N'1997-10-06T00:00:00', N'1997-10-20T00:00:00', N'1997-10-10T00:00:00', 3, 139.3400, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA', NULL ), 
( 10694, N'QUICK', 8, N'1997-10-06T00:00:00', N'1997-11-03T00:00:00', N'1997-10-09T00:00:00', 3, 398.3600, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10695, N'WILMK', 7, N'1997-10-07T00:00:00', N'1997-11-18T00:00:00', N'1997-10-14T00:00:00', 1, 16.7200, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland', NULL ), 
( 10696, N'WHITC', 8, N'1997-10-08T00:00:00', N'1997-11-19T00:00:00', N'1997-10-14T00:00:00', 3, 102.5500, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA', NULL ), 
( 10697, N'LINOD', 3, N'1997-10-08T00:00:00', N'1997-11-05T00:00:00', N'1997-10-14T00:00:00', 1, 45.5200, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL ), 
( 10698, N'ERNSH', 4, N'1997-10-09T00:00:00', N'1997-11-06T00:00:00', N'1997-10-17T00:00:00', 1, 272.4700, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10699, N'MORGK', 3, N'1997-10-09T00:00:00', N'1997-11-06T00:00:00', N'1997-10-13T00:00:00', 3, 0.5800, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Germany', NULL ), 
( 10700, N'SAVEA', 3, N'1997-10-10T00:00:00', N'1997-11-07T00:00:00', N'1997-10-16T00:00:00', 1, 65.1000, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10701, N'HUNGO', 6, N'1997-10-13T00:00:00', N'1997-10-27T00:00:00', N'1997-10-15T00:00:00', 3, 220.3100, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10702, N'ALFKI', 4, N'1997-10-13T00:00:00', N'1997-11-24T00:00:00', N'1997-10-21T00:00:00', 1, 23.9400, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany', NULL ), 
( 10703, N'FOLKO', 6, N'1997-10-14T00:00:00', N'1997-11-11T00:00:00', N'1997-10-20T00:00:00', 2, 152.3000, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 10704, N'QUEEN', 6, N'1997-10-14T00:00:00', N'1997-11-11T00:00:00', N'1997-11-07T00:00:00', 1, 4.7800, N'Queen Cozinha', N'Alameda dos Can�rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil', NULL ), 
( 10705, N'HILAA', 9, N'1997-10-15T00:00:00', N'1997-11-12T00:00:00', N'1997-11-18T00:00:00', 2, 3.5200, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 10706, N'OLDWO', 8, N'1997-10-16T00:00:00', N'1997-11-13T00:00:00', N'1997-10-21T00:00:00', 3, 135.6300, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA', NULL ), 
( 10707, N'AROUT', 4, N'1997-10-16T00:00:00', N'1997-10-30T00:00:00', N'1997-10-23T00:00:00', 3, 21.7400, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK', NULL ), 
( 10708, N'THEBI', 6, N'1997-10-17T00:00:00', N'1997-11-28T00:00:00', N'1997-11-05T00:00:00', 2, 2.9600, N'The Big Cheese', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA', NULL ), 
( 10709, N'GOURL', 1, N'1997-10-17T00:00:00', N'1997-11-14T00:00:00', N'1997-11-20T00:00:00', 3, 210.8000, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil', NULL ), 
( 10710, N'FRANS', 1, N'1997-10-20T00:00:00', N'1997-11-17T00:00:00', N'1997-10-23T00:00:00', 1, 4.9800, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy', NULL ), 
( 10711, N'SAVEA', 5, N'1997-10-21T00:00:00', N'1997-12-02T00:00:00', N'1997-10-29T00:00:00', 2, 52.4100, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10712, N'HUNGO', 3, N'1997-10-21T00:00:00', N'1997-11-18T00:00:00', N'1997-10-31T00:00:00', 1, 89.9300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10713, N'SAVEA', 1, N'1997-10-22T00:00:00', N'1997-11-19T00:00:00', N'1997-10-24T00:00:00', 1, 167.0500, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10714, N'SAVEA', 5, N'1997-10-22T00:00:00', N'1997-11-19T00:00:00', N'1997-10-27T00:00:00', 3, 24.4900, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10715, N'BONAP', 3, N'1997-10-23T00:00:00', N'1997-11-06T00:00:00', N'1997-10-29T00:00:00', 1, 63.2000, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', NULL ), 
( 10716, N'RANCH', 4, N'1997-10-24T00:00:00', N'1997-11-21T00:00:00', N'1997-10-27T00:00:00', 2, 22.5700, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL ), 
( 10717, N'FRANK', 1, N'1997-10-24T00:00:00', N'1997-11-21T00:00:00', N'1997-10-29T00:00:00', 2, 59.2500, N'Frankenversand', N'Berliner Platz 43', N'M�nchen', NULL, N'80805', N'Germany', NULL ), 
( 10718, N'KOENE', 1, N'1997-10-27T00:00:00', N'1997-11-24T00:00:00', N'1997-10-29T00:00:00', 3, 170.8800, N'K�niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany', NULL ), 
( 10719, N'LETSS', 8, N'1997-10-27T00:00:00', N'1997-11-24T00:00:00', N'1997-11-05T00:00:00', 2, 51.4400, N'Let''s Stop N Shop', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA', NULL ), 
( 10720, N'QUEDE', 8, N'1997-10-28T00:00:00', N'1997-11-11T00:00:00', N'1997-11-05T00:00:00', 2, 9.5300, N'Que Del�cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil', NULL ), 
( 10721, N'QUICK', 5, N'1997-10-29T00:00:00', N'1997-11-26T00:00:00', N'1997-10-31T00:00:00', 3, 48.9200, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10722, N'SAVEA', 8, N'1997-10-29T00:00:00', N'1997-12-10T00:00:00', N'1997-11-04T00:00:00', 1, 74.5800, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10723, N'WHITC', 3, N'1997-10-30T00:00:00', N'1997-11-27T00:00:00', N'1997-11-25T00:00:00', 1, 21.7200, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA', NULL ), 
( 10724, N'MEREP', 8, N'1997-10-30T00:00:00', N'1997-12-11T00:00:00', N'1997-11-05T00:00:00', 2, 57.7500, N'M�re Paillarde', N'43 rue St. Laurent', N'Montr�al', N'Qu�bec', N'H1J 1C3', N'Canada', NULL ), 
( 10725, N'FAMIA', 4, N'1997-10-31T00:00:00', N'1997-11-28T00:00:00', N'1997-11-05T00:00:00', 3, 10.8300, N'Familia Arquibaldo', N'Rua Or�s, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil', NULL ), 
( 10726, N'EASTC', 4, N'1997-11-03T00:00:00', N'1997-11-17T00:00:00', N'1997-12-05T00:00:00', 1, 16.5600, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK', NULL ), 
( 10727, N'REGGC', 2, N'1997-11-03T00:00:00', N'1997-12-01T00:00:00', N'1997-12-05T00:00:00', 1, 89.9000, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy', NULL ), 
( 10728, N'QUEEN', 4, N'1997-11-04T00:00:00', N'1997-12-02T00:00:00', N'1997-11-11T00:00:00', 2, 58.3300, N'Queen Cozinha', N'Alameda dos Can�rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil', NULL ), 
( 10729, N'LINOD', 8, N'1997-11-04T00:00:00', N'1997-12-16T00:00:00', N'1997-11-14T00:00:00', 3, 141.0600, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL ), 
( 10730, N'BONAP', 5, N'1997-11-05T00:00:00', N'1997-12-03T00:00:00', N'1997-11-14T00:00:00', 1, 20.1200, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', NULL ), 
( 10731, N'CHOPS', 7, N'1997-11-06T00:00:00', N'1997-12-04T00:00:00', N'1997-11-14T00:00:00', 1, 96.6500, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland', NULL ), 
( 10732, N'BONAP', 3, N'1997-11-06T00:00:00', N'1997-12-04T00:00:00', N'1997-11-07T00:00:00', 1, 16.9700, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', NULL ), 
( 10733, N'BERGS', 1, N'1997-11-07T00:00:00', N'1997-12-05T00:00:00', N'1997-11-10T00:00:00', 3, 110.1100, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10734, N'GOURL', 2, N'1997-11-07T00:00:00', N'1997-12-05T00:00:00', N'1997-11-12T00:00:00', 3, 1.6300, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil', NULL ), 
( 10735, N'LETSS', 6, N'1997-11-10T00:00:00', N'1997-12-08T00:00:00', N'1997-11-21T00:00:00', 2, 45.9700, N'Let''s Stop N Shop', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA', NULL ), 
( 10736, N'HUNGO', 9, N'1997-11-11T00:00:00', N'1997-12-09T00:00:00', N'1997-11-21T00:00:00', 2, 44.1000, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10737, N'VINET', 2, N'1997-11-11T00:00:00', N'1997-12-09T00:00:00', N'1997-11-18T00:00:00', 2, 7.7900, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'France', NULL ), 
( 10738, N'SPECD', 2, N'1997-11-12T00:00:00', N'1997-12-10T00:00:00', N'1997-11-18T00:00:00', 1, 2.9100, N'Sp�cialit�s du monde', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'France', NULL ), 
( 10739, N'VINET', 3, N'1997-11-12T00:00:00', N'1997-12-10T00:00:00', N'1997-11-17T00:00:00', 3, 11.0800, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'France', NULL ), 
( 10740, N'WHITC', 4, N'1997-11-13T00:00:00', N'1997-12-11T00:00:00', N'1997-11-25T00:00:00', 2, 81.8800, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA', NULL ), 
( 10741, N'AROUT', 4, N'1997-11-14T00:00:00', N'1997-11-28T00:00:00', N'1997-11-18T00:00:00', 3, 10.9600, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK', NULL ), 
( 10742, N'BOTTM', 3, N'1997-11-14T00:00:00', N'1997-12-12T00:00:00', N'1997-11-18T00:00:00', 3, 243.7300, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', NULL ), 
( 10743, N'AROUT', 1, N'1997-11-17T00:00:00', N'1997-12-15T00:00:00', N'1997-11-21T00:00:00', 2, 23.7200, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK', NULL ), 
( 10744, N'VAFFE', 6, N'1997-11-17T00:00:00', N'1997-12-15T00:00:00', N'1997-11-24T00:00:00', 1, 69.1900, N'Vaffeljernet', N'Smagsloget 45', N'�rhus', NULL, N'8200', N'Denmark', NULL ), 
( 10745, N'QUICK', 9, N'1997-11-18T00:00:00', N'1997-12-16T00:00:00', N'1997-11-27T00:00:00', 1, 3.5200, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10746, N'CHOPS', 1, N'1997-11-19T00:00:00', N'1997-12-17T00:00:00', N'1997-11-21T00:00:00', 3, 31.4300, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland', NULL ), 
( 10747, N'PICCO', 6, N'1997-11-19T00:00:00', N'1997-12-17T00:00:00', N'1997-11-26T00:00:00', 1, 117.3300, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL ), 
( 10748, N'SAVEA', 3, N'1997-11-20T00:00:00', N'1997-12-18T00:00:00', N'1997-11-28T00:00:00', 1, 232.5500, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10749, N'ISLAT', 4, N'1997-11-20T00:00:00', N'1997-12-18T00:00:00', N'1997-12-19T00:00:00', 2, 61.5300, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK', NULL ), 
( 10750, N'WARTH', 9, N'1997-11-21T00:00:00', N'1997-12-19T00:00:00', N'1997-11-24T00:00:00', 1, 79.3000, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland', NULL ), 
( 10751, N'RICSU', 3, N'1997-11-24T00:00:00', N'1997-12-22T00:00:00', N'1997-12-03T00:00:00', 3, 130.7900, N'Richter Supermarkt', N'Starenweg 5', N'Gen�ve', NULL, N'1204', N'Switzerland', NULL ), 
( 10752, N'NORTS', 2, N'1997-11-24T00:00:00', N'1997-12-22T00:00:00', N'1997-11-28T00:00:00', 3, 1.3900, N'North/South', N'South House 300 Queensbridge', N'London', NULL, N'SW7 1RZ', N'UK', NULL ), 
( 10753, N'FRANS', 3, N'1997-11-25T00:00:00', N'1997-12-23T00:00:00', N'1997-11-27T00:00:00', 1, 7.7000, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy', NULL ), 
( 10754, N'MAGAA', 6, N'1997-11-25T00:00:00', N'1997-12-23T00:00:00', N'1997-11-27T00:00:00', 3, 2.3800, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy', NULL ), 
( 10755, N'BONAP', 4, N'1997-11-26T00:00:00', N'1997-12-24T00:00:00', N'1997-11-28T00:00:00', 2, 16.7100, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', NULL ), 
( 10756, N'SPLIR', 8, N'1997-11-27T00:00:00', N'1997-12-25T00:00:00', N'1997-12-02T00:00:00', 2, 73.2100, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA', NULL ), 
( 10757, N'SAVEA', 6, N'1997-11-27T00:00:00', N'1997-12-25T00:00:00', N'1997-12-15T00:00:00', 1, 8.1900, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10758, N'RICSU', 3, N'1997-11-28T00:00:00', N'1997-12-26T00:00:00', N'1997-12-04T00:00:00', 3, 138.1700, N'Richter Supermarkt', N'Starenweg 5', N'Gen�ve', NULL, N'1204', N'Switzerland', NULL ), 
( 10759, N'ANATR', 3, N'1997-11-28T00:00:00', N'1997-12-26T00:00:00', N'1997-12-12T00:00:00', 3, 11.9900, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constituci�n 2222', N'M�xico D.F.', NULL, N'05021', N'Mexico', NULL ), 
( 10760, N'MAISD', 4, N'1997-12-01T00:00:00', N'1997-12-29T00:00:00', N'1997-12-10T00:00:00', 1, 155.6400, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium', NULL ), 
( 10761, N'RATTC', 5, N'1997-12-02T00:00:00', N'1997-12-30T00:00:00', N'1997-12-08T00:00:00', 2, 18.6600, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL ), 
( 10762, N'FOLKO', 3, N'1997-12-02T00:00:00', N'1997-12-30T00:00:00', N'1997-12-09T00:00:00', 1, 328.7400, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 10763, N'FOLIG', 3, N'1997-12-03T00:00:00', N'1997-12-31T00:00:00', N'1997-12-08T00:00:00', 3, 37.3500, N'Folies gourmandes', N'184, chauss�e de Tournai', N'Lille', NULL, N'59000', N'France', NULL ), 
( 10764, N'ERNSH', 6, N'1997-12-03T00:00:00', N'1997-12-31T00:00:00', N'1997-12-08T00:00:00', 3, 145.4500, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10765, N'QUICK', 3, N'1997-12-04T00:00:00', N'1998-01-01T00:00:00', N'1997-12-09T00:00:00', 3, 42.7400, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10766, N'OTTIK', 4, N'1997-12-05T00:00:00', N'1998-01-02T00:00:00', N'1997-12-09T00:00:00', 1, 157.5500, N'Ottilies K�seladen', N'Mehrheimerstr. 369', N'K�ln', NULL, N'50739', N'Germany', NULL ), 
( 10767, N'SUPRD', 4, N'1997-12-05T00:00:00', N'1998-01-02T00:00:00', N'1997-12-15T00:00:00', 3, 1.5900, N'Supr�mes d�lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium', NULL ), 
( 10768, N'AROUT', 3, N'1997-12-08T00:00:00', N'1998-01-05T00:00:00', N'1997-12-15T00:00:00', 2, 146.3200, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK', NULL ), 
( 10769, N'VAFFE', 3, N'1997-12-08T00:00:00', N'1998-01-05T00:00:00', N'1997-12-12T00:00:00', 1, 65.0600, N'Vaffeljernet', N'Smagsloget 45', N'�rhus', NULL, N'8200', N'Denmark', NULL ), 
( 10770, N'HANAR', 8, N'1997-12-09T00:00:00', N'1998-01-06T00:00:00', N'1997-12-17T00:00:00', 3, 5.3200, N'Hanari Carnes', N'Rua do Pa�o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil', NULL ), 
( 10771, N'ERNSH', 9, N'1997-12-10T00:00:00', N'1998-01-07T00:00:00', N'1998-01-02T00:00:00', 2, 11.1900, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10772, N'LEHMS', 3, N'1997-12-10T00:00:00', N'1998-01-07T00:00:00', N'1997-12-19T00:00:00', 2, 91.2800, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany', NULL ), 
( 10773, N'ERNSH', 1, N'1997-12-11T00:00:00', N'1998-01-08T00:00:00', N'1997-12-16T00:00:00', 3, 96.4300, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10774, N'FOLKO', 4, N'1997-12-11T00:00:00', N'1997-12-25T00:00:00', N'1997-12-12T00:00:00', 1, 48.2000, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 10775, N'THECR', 7, N'1997-12-12T00:00:00', N'1998-01-09T00:00:00', N'1997-12-26T00:00:00', 1, 20.2500, N'The Cracker Box', N'55 Grizzly Peak Rd.', N'Butte', N'MT', N'59801', N'USA', NULL ), 
( 10776, N'ERNSH', 1, N'1997-12-15T00:00:00', N'1998-01-12T00:00:00', N'1997-12-18T00:00:00', 3, 351.5300, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10777, N'GOURL', 7, N'1997-12-15T00:00:00', N'1997-12-29T00:00:00', N'1998-01-21T00:00:00', 2, 3.0100, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil', NULL ), 
( 10778, N'BERGS', 3, N'1997-12-16T00:00:00', N'1998-01-13T00:00:00', N'1997-12-24T00:00:00', 1, 6.7900, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10779, N'MORGK', 3, N'1997-12-16T00:00:00', N'1998-01-13T00:00:00', N'1998-01-14T00:00:00', 2, 58.1300, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Germany', NULL ), 
( 10780, N'LILAS', 2, N'1997-12-16T00:00:00', N'1997-12-30T00:00:00', N'1997-12-25T00:00:00', 1, 42.1300, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL ), 
( 10781, N'WARTH', 2, N'1997-12-17T00:00:00', N'1998-01-14T00:00:00', N'1997-12-19T00:00:00', 3, 73.1600, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland', NULL ), 
( 10782, N'CACTU', 9, N'1997-12-17T00:00:00', N'1998-01-14T00:00:00', N'1997-12-22T00:00:00', 3, 1.1000, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL ), 
( 10783, N'HANAR', 4, N'1997-12-18T00:00:00', N'1998-01-15T00:00:00', N'1997-12-19T00:00:00', 2, 124.9800, N'Hanari Carnes', N'Rua do Pa�o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil', NULL ), 
( 10784, N'MAGAA', 4, N'1997-12-18T00:00:00', N'1998-01-15T00:00:00', N'1997-12-22T00:00:00', 3, 70.0900, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy', NULL ), 
( 10785, N'GROSR', 1, N'1997-12-18T00:00:00', N'1998-01-15T00:00:00', N'1997-12-24T00:00:00', 3, 1.5100, N'GROSELLA-Restaurante', N'5� Ave. Los Palos Grandes', N'Caracas', N'DF', N'1081', N'Venezuela', NULL ), 
( 10786, N'QUEEN', 8, N'1997-12-19T00:00:00', N'1998-01-16T00:00:00', N'1997-12-23T00:00:00', 1, 110.8700, N'Queen Cozinha', N'Alameda dos Can�rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil', NULL ), 
( 10787, N'LAMAI', 2, N'1997-12-19T00:00:00', N'1998-01-02T00:00:00', N'1997-12-26T00:00:00', 1, 249.9300, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France', NULL ), 
( 10788, N'QUICK', 1, N'1997-12-22T00:00:00', N'1998-01-19T00:00:00', N'1998-01-19T00:00:00', 2, 42.7000, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10789, N'FOLIG', 1, N'1997-12-22T00:00:00', N'1998-01-19T00:00:00', N'1997-12-31T00:00:00', 2, 100.6000, N'Folies gourmandes', N'184, chauss�e de Tournai', N'Lille', NULL, N'59000', N'France', NULL ), 
( 10790, N'GOURL', 6, N'1997-12-22T00:00:00', N'1998-01-19T00:00:00', N'1997-12-26T00:00:00', 1, 28.2300, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil', NULL ), 
( 10791, N'FRANK', 6, N'1997-12-23T00:00:00', N'1998-01-20T00:00:00', N'1998-01-01T00:00:00', 2, 16.8500, N'Frankenversand', N'Berliner Platz 43', N'M�nchen', NULL, N'80805', N'Germany', NULL ), 
( 10792, N'WOLZA', 1, N'1997-12-23T00:00:00', N'1998-01-20T00:00:00', N'1997-12-31T00:00:00', 3, 23.7900, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland', NULL ), 
( 10793, N'AROUT', 3, N'1997-12-24T00:00:00', N'1998-01-21T00:00:00', N'1998-01-08T00:00:00', 3, 4.5200, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK', NULL ), 
( 10794, N'QUEDE', 6, N'1997-12-24T00:00:00', N'1998-01-21T00:00:00', N'1998-01-02T00:00:00', 1, 21.4900, N'Que Del�cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil', NULL ), 
( 10795, N'ERNSH', 8, N'1997-12-24T00:00:00', N'1998-01-21T00:00:00', N'1998-01-20T00:00:00', 2, 126.6600, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10796, N'HILAA', 3, N'1997-12-25T00:00:00', N'1998-01-22T00:00:00', N'1998-01-14T00:00:00', 1, 26.5200, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 10797, N'DRACD', 7, N'1997-12-25T00:00:00', N'1998-01-22T00:00:00', N'1998-01-05T00:00:00', 2, 33.3500, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany', NULL ), 
( 10798, N'ISLAT', 2, N'1997-12-26T00:00:00', N'1998-01-23T00:00:00', N'1998-01-05T00:00:00', 1, 2.3300, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK', NULL ), 
( 10799, N'KOENE', 9, N'1997-12-26T00:00:00', N'1998-02-06T00:00:00', N'1998-01-05T00:00:00', 3, 30.7600, N'K�niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany', NULL ), 
( 10800, N'SEVES', 1, N'1997-12-26T00:00:00', N'1998-01-23T00:00:00', N'1998-01-05T00:00:00', 3, 137.4400, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK', NULL ), 
( 10801, N'BOLID', 4, N'1997-12-29T00:00:00', N'1998-01-26T00:00:00', N'1997-12-31T00:00:00', 2, 97.0900, N'B�lido Comidas preparadas', N'C/ Araquil, 67', N'Madrid', NULL, N'28023', N'Spain', NULL ), 
( 10802, N'SIMOB', 4, N'1997-12-29T00:00:00', N'1998-01-26T00:00:00', N'1998-01-02T00:00:00', 2, 257.2600, N'Simons bistro', N'Vinb�ltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark', NULL ), 
( 10803, N'WELLI', 4, N'1997-12-30T00:00:00', N'1998-01-27T00:00:00', N'1998-01-06T00:00:00', 1, 55.2300, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil', NULL ), 
( 10804, N'SEVES', 6, N'1997-12-30T00:00:00', N'1998-01-27T00:00:00', N'1998-01-07T00:00:00', 2, 27.3300, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK', NULL ), 
( 10805, N'THEBI', 2, N'1997-12-30T00:00:00', N'1998-01-27T00:00:00', N'1998-01-09T00:00:00', 3, 237.3400, N'The Big Cheese', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA', NULL ), 
( 10806, N'VICTE', 3, N'1997-12-31T00:00:00', N'1998-01-28T00:00:00', N'1998-01-05T00:00:00', 2, 22.1100, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France', NULL ), 
( 10807, N'FRANS', 4, N'1997-12-31T00:00:00', N'1998-01-28T00:00:00', N'1998-01-30T00:00:00', 1, 1.3600, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy', NULL ), 
( 10808, N'OLDWO', 2, N'1998-01-01T00:00:00', N'1998-01-29T00:00:00', N'1998-01-09T00:00:00', 3, 45.5300, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA', NULL ), 
( 10809, N'WELLI', 7, N'1998-01-01T00:00:00', N'1998-01-29T00:00:00', N'1998-01-07T00:00:00', 1, 4.8700, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil', NULL ), 
( 10810, N'LAUGB', 2, N'1998-01-01T00:00:00', N'1998-01-29T00:00:00', N'1998-01-07T00:00:00', 3, 4.3300, N'Laughing Bacchus Wine Cellars', N'2319 Elm St.', N'Vancouver', N'BC', N'V3F 2K1', N'Canada', NULL ), 
( 10811, N'LINOD', 8, N'1998-01-02T00:00:00', N'1998-01-30T00:00:00', N'1998-01-08T00:00:00', 1, 31.2200, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL ), 
( 10812, N'REGGC', 5, N'1998-01-02T00:00:00', N'1998-01-30T00:00:00', N'1998-01-12T00:00:00', 1, 59.7800, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy', NULL ), 
( 10813, N'RICAR', 1, N'1998-01-05T00:00:00', N'1998-02-02T00:00:00', N'1998-01-09T00:00:00', 1, 47.3800, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil', NULL ), 
( 10814, N'VICTE', 3, N'1998-01-05T00:00:00', N'1998-02-02T00:00:00', N'1998-01-14T00:00:00', 3, 130.9400, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France', NULL ), 
( 10815, N'SAVEA', 2, N'1998-01-05T00:00:00', N'1998-02-02T00:00:00', N'1998-01-14T00:00:00', 3, 14.6200, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10816, N'GREAL', 4, N'1998-01-06T00:00:00', N'1998-02-03T00:00:00', N'1998-02-04T00:00:00', 2, 719.7800, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA', NULL ), 
( 10817, N'KOENE', 3, N'1998-01-06T00:00:00', N'1998-01-20T00:00:00', N'1998-01-13T00:00:00', 2, 306.0700, N'K�niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany', NULL ), 
( 10818, N'MAGAA', 7, N'1998-01-07T00:00:00', N'1998-02-04T00:00:00', N'1998-01-12T00:00:00', 3, 65.4800, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy', NULL ), 
( 10819, N'CACTU', 2, N'1998-01-07T00:00:00', N'1998-02-04T00:00:00', N'1998-01-16T00:00:00', 3, 19.7600, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL ), 
( 10820, N'RATTC', 3, N'1998-01-07T00:00:00', N'1998-02-04T00:00:00', N'1998-01-13T00:00:00', 2, 37.5200, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL ), 
( 10821, N'SPLIR', 1, N'1998-01-08T00:00:00', N'1998-02-05T00:00:00', N'1998-01-15T00:00:00', 1, 36.6800, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA', NULL ), 
( 10822, N'TRAIH', 6, N'1998-01-08T00:00:00', N'1998-02-05T00:00:00', N'1998-01-16T00:00:00', 3, 7.0000, N'Trail''s Head Gourmet Provisioners', N'722 DaVinci Blvd.', N'Kirkland', N'WA', N'98034', N'USA', NULL ), 
( 10823, N'LILAS', 5, N'1998-01-09T00:00:00', N'1998-02-06T00:00:00', N'1998-01-13T00:00:00', 2, 163.9700, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL ), 
( 10824, N'FOLKO', 8, N'1998-01-09T00:00:00', N'1998-02-06T00:00:00', N'1998-01-30T00:00:00', 1, 1.2300, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 10825, N'DRACD', 1, N'1998-01-09T00:00:00', N'1998-02-06T00:00:00', N'1998-01-14T00:00:00', 1, 79.2500, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany', NULL ), 
( 10826, N'BLONP', 6, N'1998-01-12T00:00:00', N'1998-02-09T00:00:00', N'1998-02-06T00:00:00', 1, 7.0900, N'Blondel p�re et fils', N'24, place Kl�ber', N'Strasbourg', NULL, N'67000', N'France', NULL ), 
( 10827, N'BONAP', 1, N'1998-01-12T00:00:00', N'1998-01-26T00:00:00', N'1998-02-06T00:00:00', 2, 63.5400, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', NULL ), 
( 10828, N'RANCH', 9, N'1998-01-13T00:00:00', N'1998-01-27T00:00:00', N'1998-02-04T00:00:00', 1, 90.8500, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL ), 
( 10829, N'ISLAT', 9, N'1998-01-13T00:00:00', N'1998-02-10T00:00:00', N'1998-01-23T00:00:00', 1, 154.7200, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK', NULL ), 
( 10830, N'TRADH', 4, N'1998-01-13T00:00:00', N'1998-02-24T00:00:00', N'1998-01-21T00:00:00', 2, 81.8300, N'Tradi�ao Hipermercados', N'Av. In�s de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil', NULL ), 
( 10831, N'SANTG', 3, N'1998-01-14T00:00:00', N'1998-02-11T00:00:00', N'1998-01-23T00:00:00', 2, 72.1900, N'Sant� Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway', NULL ), 
( 10832, N'LAMAI', 2, N'1998-01-14T00:00:00', N'1998-02-11T00:00:00', N'1998-01-19T00:00:00', 2, 43.2600, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France', NULL ), 
( 10833, N'OTTIK', 6, N'1998-01-15T00:00:00', N'1998-02-12T00:00:00', N'1998-01-23T00:00:00', 2, 71.4900, N'Ottilies K�seladen', N'Mehrheimerstr. 369', N'K�ln', NULL, N'50739', N'Germany', NULL ), 
( 10834, N'TRADH', 1, N'1998-01-15T00:00:00', N'1998-02-12T00:00:00', N'1998-01-19T00:00:00', 3, 29.7800, N'Tradi�ao Hipermercados', N'Av. In�s de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil', NULL ), 
( 10835, N'ALFKI', 1, N'1998-01-15T00:00:00', N'1998-02-12T00:00:00', N'1998-01-21T00:00:00', 3, 69.5300, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany', NULL ), 
( 10836, N'ERNSH', 7, N'1998-01-16T00:00:00', N'1998-02-13T00:00:00', N'1998-01-21T00:00:00', 1, 411.8800, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10837, N'BERGS', 9, N'1998-01-16T00:00:00', N'1998-02-13T00:00:00', N'1998-01-23T00:00:00', 3, 13.3200, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10838, N'LINOD', 3, N'1998-01-19T00:00:00', N'1998-02-16T00:00:00', N'1998-01-23T00:00:00', 3, 59.2800, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL ), 
( 10839, N'TRADH', 3, N'1998-01-19T00:00:00', N'1998-02-16T00:00:00', N'1998-01-22T00:00:00', 3, 35.4300, N'Tradi�ao Hipermercados', N'Av. In�s de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil', NULL ), 
( 10840, N'LINOD', 4, N'1998-01-19T00:00:00', N'1998-03-02T00:00:00', N'1998-02-16T00:00:00', 2, 2.7100, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL ), 
( 10841, N'SUPRD', 5, N'1998-01-20T00:00:00', N'1998-02-17T00:00:00', N'1998-01-29T00:00:00', 2, 424.3000, N'Supr�mes d�lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium', NULL ), 
( 10842, N'TORTU', 1, N'1998-01-20T00:00:00', N'1998-02-17T00:00:00', N'1998-01-29T00:00:00', 3, 54.4200, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M�xico D.F.', NULL, N'05033', N'Mexico', NULL ), 
( 10843, N'VICTE', 4, N'1998-01-21T00:00:00', N'1998-02-18T00:00:00', N'1998-01-26T00:00:00', 2, 9.2600, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France', NULL ), 
( 10844, N'PICCO', 8, N'1998-01-21T00:00:00', N'1998-02-18T00:00:00', N'1998-01-26T00:00:00', 2, 25.2200, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL ), 
( 10845, N'QUICK', 8, N'1998-01-21T00:00:00', N'1998-02-04T00:00:00', N'1998-01-30T00:00:00', 1, 212.9800, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10846, N'SUPRD', 2, N'1998-01-22T00:00:00', N'1998-03-05T00:00:00', N'1998-01-23T00:00:00', 3, 56.4600, N'Supr�mes d�lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium', NULL ), 
( 10847, N'SAVEA', 4, N'1998-01-22T00:00:00', N'1998-02-05T00:00:00', N'1998-02-10T00:00:00', 3, 487.5700, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10848, N'CONSH', 7, N'1998-01-23T00:00:00', N'1998-02-20T00:00:00', N'1998-01-29T00:00:00', 2, 38.2400, N'Consolidated Holdings', N'Berkeley Gardens 12  Brewery', N'London', NULL, N'WX1 6LT', N'UK', NULL ), 
( 10849, N'KOENE', 9, N'1998-01-23T00:00:00', N'1998-02-20T00:00:00', N'1998-01-30T00:00:00', 2, 0.5600, N'K�niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany', NULL ), 
( 10850, N'VICTE', 1, N'1998-01-23T00:00:00', N'1998-03-06T00:00:00', N'1998-01-30T00:00:00', 1, 49.1900, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France', NULL ), 
( 10851, N'RICAR', 5, N'1998-01-26T00:00:00', N'1998-02-23T00:00:00', N'1998-02-02T00:00:00', 1, 160.5500, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil', NULL ), 
( 10852, N'RATTC', 8, N'1998-01-26T00:00:00', N'1998-02-09T00:00:00', N'1998-01-30T00:00:00', 1, 174.0500, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL ), 
( 10853, N'BLAUS', 9, N'1998-01-27T00:00:00', N'1998-02-24T00:00:00', N'1998-02-03T00:00:00', 2, 53.8300, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany', NULL ), 
( 10854, N'ERNSH', 3, N'1998-01-27T00:00:00', N'1998-02-24T00:00:00', N'1998-02-05T00:00:00', 2, 100.2200, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10855, N'OLDWO', 3, N'1998-01-27T00:00:00', N'1998-02-24T00:00:00', N'1998-02-04T00:00:00', 1, 170.9700, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA', NULL ), 
( 10856, N'ANTON', 3, N'1998-01-28T00:00:00', N'1998-02-25T00:00:00', N'1998-02-10T00:00:00', 2, 58.4300, N'Antonio Moreno Taquer�a', N'Mataderos  2312', N'M�xico D.F.', NULL, N'05023', N'Mexico', NULL ), 
( 10857, N'BERGS', 8, N'1998-01-28T00:00:00', N'1998-02-25T00:00:00', N'1998-02-06T00:00:00', 2, 188.8500, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10858, N'LACOR', 2, N'1998-01-29T00:00:00', N'1998-02-26T00:00:00', N'1998-02-03T00:00:00', 1, 52.5100, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'France', NULL ), 
( 10859, N'FRANK', 1, N'1998-01-29T00:00:00', N'1998-02-26T00:00:00', N'1998-02-02T00:00:00', 2, 76.1000, N'Frankenversand', N'Berliner Platz 43', N'M�nchen', NULL, N'80805', N'Germany', NULL ), 
( 10860, N'FRANR', 3, N'1998-01-29T00:00:00', N'1998-02-26T00:00:00', N'1998-02-04T00:00:00', 3, 19.2600, N'France restauration', N'54, rue Royale', N'Nantes', NULL, N'44000', N'France', NULL ), 
( 10861, N'WHITC', 4, N'1998-01-30T00:00:00', N'1998-02-27T00:00:00', N'1998-02-17T00:00:00', 2, 14.9300, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA', NULL ), 
( 10862, N'LEHMS', 8, N'1998-01-30T00:00:00', N'1998-03-13T00:00:00', N'1998-02-02T00:00:00', 2, 53.2300, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany', NULL ), 
( 10863, N'HILAA', 4, N'1998-02-02T00:00:00', N'1998-03-02T00:00:00', N'1998-02-17T00:00:00', 2, 30.2600, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 10864, N'AROUT', 4, N'1998-02-02T00:00:00', N'1998-03-02T00:00:00', N'1998-02-09T00:00:00', 2, 3.0400, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK', NULL ), 
( 10865, N'QUICK', 2, N'1998-02-02T00:00:00', N'1998-02-16T00:00:00', N'1998-02-12T00:00:00', 1, 348.1400, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10866, N'BERGS', 5, N'1998-02-03T00:00:00', N'1998-03-03T00:00:00', N'1998-02-12T00:00:00', 1, 109.1100, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10867, N'LONEP', 6, N'1998-02-03T00:00:00', N'1998-03-17T00:00:00', N'1998-02-11T00:00:00', 1, 1.9300, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA', NULL ), 
( 10868, N'QUEEN', 7, N'1998-02-04T00:00:00', N'1998-03-04T00:00:00', N'1998-02-23T00:00:00', 2, 191.2700, N'Queen Cozinha', N'Alameda dos Can�rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil', NULL ), 
( 10869, N'SEVES', 5, N'1998-02-04T00:00:00', N'1998-03-04T00:00:00', N'1998-02-09T00:00:00', 1, 143.2800, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK', NULL ), 
( 10870, N'WOLZA', 5, N'1998-02-04T00:00:00', N'1998-03-04T00:00:00', N'1998-02-13T00:00:00', 3, 12.0400, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland', NULL ), 
( 10871, N'BONAP', 9, N'1998-02-05T00:00:00', N'1998-03-05T00:00:00', N'1998-02-10T00:00:00', 2, 112.2700, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', NULL ), 
( 10872, N'GODOS', 5, N'1998-02-05T00:00:00', N'1998-03-05T00:00:00', N'1998-02-09T00:00:00', 2, 175.3200, N'Godos Cocina T�pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain', NULL ), 
( 10873, N'WILMK', 4, N'1998-02-06T00:00:00', N'1998-03-06T00:00:00', N'1998-02-09T00:00:00', 1, 0.8200, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland', NULL ), 
( 10874, N'GODOS', 5, N'1998-02-06T00:00:00', N'1998-03-06T00:00:00', N'1998-02-11T00:00:00', 2, 19.5800, N'Godos Cocina T�pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain', NULL ), 
( 10875, N'BERGS', 4, N'1998-02-06T00:00:00', N'1998-03-06T00:00:00', N'1998-03-03T00:00:00', 2, 32.3700, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10876, N'BONAP', 7, N'1998-02-09T00:00:00', N'1998-03-09T00:00:00', N'1998-02-12T00:00:00', 3, 60.4200, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', NULL ), 
( 10877, N'RICAR', 1, N'1998-02-09T00:00:00', N'1998-03-09T00:00:00', N'1998-02-19T00:00:00', 1, 38.0600, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil', NULL ), 
( 10878, N'QUICK', 4, N'1998-02-10T00:00:00', N'1998-03-10T00:00:00', N'1998-02-12T00:00:00', 1, 46.6900, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10879, N'WILMK', 3, N'1998-02-10T00:00:00', N'1998-03-10T00:00:00', N'1998-02-12T00:00:00', 3, 8.5000, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland', NULL ), 
( 10880, N'FOLKO', 7, N'1998-02-10T00:00:00', N'1998-03-24T00:00:00', N'1998-02-18T00:00:00', 1, 88.0100, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 10881, N'CACTU', 4, N'1998-02-11T00:00:00', N'1998-03-11T00:00:00', N'1998-02-18T00:00:00', 1, 2.8400, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL ), 
( 10882, N'SAVEA', 4, N'1998-02-11T00:00:00', N'1998-03-11T00:00:00', N'1998-02-20T00:00:00', 3, 23.1000, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10883, N'LONEP', 8, N'1998-02-12T00:00:00', N'1998-03-12T00:00:00', N'1998-02-20T00:00:00', 3, 0.5300, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA', NULL ), 
( 10884, N'LETSS', 4, N'1998-02-12T00:00:00', N'1998-03-12T00:00:00', N'1998-02-13T00:00:00', 2, 90.9700, N'Let''s Stop N Shop', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA', NULL ), 
( 10885, N'SUPRD', 6, N'1998-02-12T00:00:00', N'1998-03-12T00:00:00', N'1998-02-18T00:00:00', 3, 5.6400, N'Supr�mes d�lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium', NULL ), 
( 10886, N'HANAR', 1, N'1998-02-13T00:00:00', N'1998-03-13T00:00:00', N'1998-03-02T00:00:00', 1, 4.9900, N'Hanari Carnes', N'Rua do Pa�o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil', NULL ), 
( 10887, N'GALED', 8, N'1998-02-13T00:00:00', N'1998-03-13T00:00:00', N'1998-02-16T00:00:00', 3, 1.2500, N'Galer�a del gastron�mo', N'Rambla de Catalu�a, 23', N'Barcelona', NULL, N'8022', N'Spain', NULL ), 
( 10888, N'GODOS', 1, N'1998-02-16T00:00:00', N'1998-03-16T00:00:00', N'1998-02-23T00:00:00', 2, 51.8700, N'Godos Cocina T�pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain', NULL ), 
( 10889, N'RATTC', 9, N'1998-02-16T00:00:00', N'1998-03-16T00:00:00', N'1998-02-23T00:00:00', 3, 280.6100, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL ), 
( 10890, N'DUMON', 7, N'1998-02-16T00:00:00', N'1998-03-16T00:00:00', N'1998-02-18T00:00:00', 1, 32.7600, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'France', NULL ), 
( 10891, N'LEHMS', 7, N'1998-02-17T00:00:00', N'1998-03-17T00:00:00', N'1998-02-19T00:00:00', 2, 20.3700, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany', NULL ), 
( 10892, N'MAISD', 4, N'1998-02-17T00:00:00', N'1998-03-17T00:00:00', N'1998-02-19T00:00:00', 2, 120.2700, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium', NULL ), 
( 10893, N'KOENE', 9, N'1998-02-18T00:00:00', N'1998-03-18T00:00:00', N'1998-02-20T00:00:00', 2, 77.7800, N'K�niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany', NULL ), 
( 10894, N'SAVEA', 1, N'1998-02-18T00:00:00', N'1998-03-18T00:00:00', N'1998-02-20T00:00:00', 1, 116.1300, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10895, N'ERNSH', 3, N'1998-02-18T00:00:00', N'1998-03-18T00:00:00', N'1998-02-23T00:00:00', 1, 162.7500, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10896, N'MAISD', 7, N'1998-02-19T00:00:00', N'1998-03-19T00:00:00', N'1998-02-27T00:00:00', 3, 32.4500, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium', NULL ), 
( 10897, N'HUNGO', 3, N'1998-02-19T00:00:00', N'1998-03-19T00:00:00', N'1998-02-25T00:00:00', 2, 603.5400, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10898, N'OCEAN', 4, N'1998-02-20T00:00:00', N'1998-03-20T00:00:00', N'1998-03-06T00:00:00', 2, 1.2700, N'Oc�ano Atl�ntico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL ), 
( 10899, N'LILAS', 5, N'1998-02-20T00:00:00', N'1998-03-20T00:00:00', N'1998-02-26T00:00:00', 3, 1.2100, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL ), 
( 10900, N'WELLI', 1, N'1998-02-20T00:00:00', N'1998-03-20T00:00:00', N'1998-03-04T00:00:00', 2, 1.6600, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil', NULL ), 
( 10901, N'HILAA', 4, N'1998-02-23T00:00:00', N'1998-03-23T00:00:00', N'1998-02-26T00:00:00', 1, 62.0900, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 10902, N'FOLKO', 1, N'1998-02-23T00:00:00', N'1998-03-23T00:00:00', N'1998-03-03T00:00:00', 1, 44.1500, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 10903, N'HANAR', 3, N'1998-02-24T00:00:00', N'1998-03-24T00:00:00', N'1998-03-04T00:00:00', 3, 36.7100, N'Hanari Carnes', N'Rua do Pa�o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil', NULL ), 
( 10904, N'WHITC', 3, N'1998-02-24T00:00:00', N'1998-03-24T00:00:00', N'1998-02-27T00:00:00', 3, 162.9500, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA', NULL ), 
( 10905, N'WELLI', 9, N'1998-02-24T00:00:00', N'1998-03-24T00:00:00', N'1998-03-06T00:00:00', 2, 13.7200, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil', NULL ), 
( 10906, N'WOLZA', 4, N'1998-02-25T00:00:00', N'1998-03-11T00:00:00', N'1998-03-03T00:00:00', 3, 26.2900, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland', NULL ), 
( 10907, N'SPECD', 6, N'1998-02-25T00:00:00', N'1998-03-25T00:00:00', N'1998-02-27T00:00:00', 3, 9.1900, N'Sp�cialit�s du monde', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'France', NULL ), 
( 10908, N'REGGC', 4, N'1998-02-26T00:00:00', N'1998-03-26T00:00:00', N'1998-03-06T00:00:00', 2, 32.9600, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy', NULL ), 
( 10909, N'SANTG', 1, N'1998-02-26T00:00:00', N'1998-03-26T00:00:00', N'1998-03-10T00:00:00', 2, 53.0500, N'Sant� Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway', NULL ), 
( 10910, N'WILMK', 1, N'1998-02-26T00:00:00', N'1998-03-26T00:00:00', N'1998-03-04T00:00:00', 3, 38.1100, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland', NULL ), 
( 10911, N'GODOS', 3, N'1998-02-26T00:00:00', N'1998-03-26T00:00:00', N'1998-03-05T00:00:00', 1, 38.1900, N'Godos Cocina T�pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain', NULL ), 
( 10912, N'HUNGO', 2, N'1998-02-26T00:00:00', N'1998-03-26T00:00:00', N'1998-03-18T00:00:00', 2, 580.9100, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10913, N'QUEEN', 4, N'1998-02-26T00:00:00', N'1998-03-26T00:00:00', N'1998-03-04T00:00:00', 1, 33.0500, N'Queen Cozinha', N'Alameda dos Can�rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil', NULL ), 
( 10914, N'QUEEN', 6, N'1998-02-27T00:00:00', N'1998-03-27T00:00:00', N'1998-03-02T00:00:00', 1, 21.1900, N'Queen Cozinha', N'Alameda dos Can�rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil', NULL ), 
( 10915, N'TORTU', 2, N'1998-02-27T00:00:00', N'1998-03-27T00:00:00', N'1998-03-02T00:00:00', 2, 3.5100, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M�xico D.F.', NULL, N'05033', N'Mexico', NULL ), 
( 10916, N'RANCH', 1, N'1998-02-27T00:00:00', N'1998-03-27T00:00:00', N'1998-03-09T00:00:00', 2, 63.7700, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL ), 
( 10917, N'ROMEY', 4, N'1998-03-02T00:00:00', N'1998-03-30T00:00:00', N'1998-03-11T00:00:00', 2, 8.2900, N'Romero y tomillo', N'Gran V�a, 1', N'Madrid', NULL, N'28001', N'Spain', NULL ), 
( 10918, N'BOTTM', 3, N'1998-03-02T00:00:00', N'1998-03-30T00:00:00', N'1998-03-11T00:00:00', 3, 48.8300, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', NULL ), 
( 10919, N'LINOD', 2, N'1998-03-02T00:00:00', N'1998-03-30T00:00:00', N'1998-03-04T00:00:00', 2, 19.8000, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL ), 
( 10920, N'AROUT', 4, N'1998-03-03T00:00:00', N'1998-03-31T00:00:00', N'1998-03-09T00:00:00', 2, 29.6100, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK', NULL ), 
( 10921, N'VAFFE', 1, N'1998-03-03T00:00:00', N'1998-04-14T00:00:00', N'1998-03-09T00:00:00', 1, 176.4800, N'Vaffeljernet', N'Smagsloget 45', N'�rhus', NULL, N'8200', N'Denmark', NULL ), 
( 10922, N'HANAR', 5, N'1998-03-03T00:00:00', N'1998-03-31T00:00:00', N'1998-03-05T00:00:00', 3, 62.7400, N'Hanari Carnes', N'Rua do Pa�o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil', NULL ), 
( 10923, N'LAMAI', 7, N'1998-03-03T00:00:00', N'1998-04-14T00:00:00', N'1998-03-13T00:00:00', 3, 68.2600, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France', NULL ), 
( 10924, N'BERGS', 3, N'1998-03-04T00:00:00', N'1998-04-01T00:00:00', N'1998-04-08T00:00:00', 2, 151.5200, N'Berglunds snabbk�p', N'Berguvsv�gen  8', N'Lule�', NULL, N'S-958 22', N'Sweden', NULL ), 
( 10925, N'HANAR', 3, N'1998-03-04T00:00:00', N'1998-04-01T00:00:00', N'1998-03-13T00:00:00', 1, 2.2700, N'Hanari Carnes', N'Rua do Pa�o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil', NULL ), 
( 10926, N'ANATR', 4, N'1998-03-04T00:00:00', N'1998-04-01T00:00:00', N'1998-03-11T00:00:00', 3, 39.9200, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constituci�n 2222', N'M�xico D.F.', NULL, N'05021', N'Mexico', NULL ), 
( 10927, N'LACOR', 4, N'1998-03-05T00:00:00', N'1998-04-02T00:00:00', N'1998-04-08T00:00:00', 1, 19.7900, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'France', NULL ), 
( 10928, N'GALED', 1, N'1998-03-05T00:00:00', N'1998-04-02T00:00:00', N'1998-03-18T00:00:00', 1, 1.3600, N'Galer�a del gastron�mo', N'Rambla de Catalu�a, 23', N'Barcelona', NULL, N'8022', N'Spain', NULL ), 
( 10929, N'FRANK', 6, N'1998-03-05T00:00:00', N'1998-04-02T00:00:00', N'1998-03-12T00:00:00', 1, 33.9300, N'Frankenversand', N'Berliner Platz 43', N'M�nchen', NULL, N'80805', N'Germany', NULL ), 
( 10930, N'SUPRD', 4, N'1998-03-06T00:00:00', N'1998-04-17T00:00:00', N'1998-03-18T00:00:00', 3, 15.5500, N'Supr�mes d�lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium', NULL ), 
( 10931, N'RICSU', 4, N'1998-03-06T00:00:00', N'1998-03-20T00:00:00', N'1998-03-19T00:00:00', 2, 13.6000, N'Richter Supermarkt', N'Starenweg 5', N'Gen�ve', NULL, N'1204', N'Switzerland', NULL ), 
( 10932, N'BONAP', 8, N'1998-03-06T00:00:00', N'1998-04-03T00:00:00', N'1998-03-24T00:00:00', 1, 134.6400, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', NULL ), 
( 10933, N'ISLAT', 6, N'1998-03-06T00:00:00', N'1998-04-03T00:00:00', N'1998-03-16T00:00:00', 3, 54.1500, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK', NULL ), 
( 10934, N'LEHMS', 3, N'1998-03-09T00:00:00', N'1998-04-06T00:00:00', N'1998-03-12T00:00:00', 3, 32.0100, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany', NULL ), 
( 10935, N'WELLI', 4, N'1998-03-09T00:00:00', N'1998-04-06T00:00:00', N'1998-03-18T00:00:00', 3, 47.5900, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil', NULL ), 
( 10936, N'GREAL', 3, N'1998-03-09T00:00:00', N'1998-04-06T00:00:00', N'1998-03-18T00:00:00', 2, 33.6800, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA', NULL ), 
( 10937, N'CACTU', 7, N'1998-03-10T00:00:00', N'1998-03-24T00:00:00', N'1998-03-13T00:00:00', 3, 31.5100, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL ), 
( 10938, N'QUICK', 3, N'1998-03-10T00:00:00', N'1998-04-07T00:00:00', N'1998-03-16T00:00:00', 2, 31.8900, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10939, N'MAGAA', 2, N'1998-03-10T00:00:00', N'1998-04-07T00:00:00', N'1998-03-13T00:00:00', 2, 76.3300, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy', NULL ), 
( 10940, N'BONAP', 8, N'1998-03-11T00:00:00', N'1998-04-08T00:00:00', N'1998-03-23T00:00:00', 3, 19.7700, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', NULL ), 
( 10941, N'SAVEA', 7, N'1998-03-11T00:00:00', N'1998-04-08T00:00:00', N'1998-03-20T00:00:00', 2, 400.8100, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10942, N'REGGC', 9, N'1998-03-11T00:00:00', N'1998-04-08T00:00:00', N'1998-03-18T00:00:00', 3, 17.9500, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy', NULL ), 
( 10943, N'BSBEV', 4, N'1998-03-11T00:00:00', N'1998-04-08T00:00:00', N'1998-03-19T00:00:00', 2, 2.1700, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK', NULL ), 
( 10944, N'BOTTM', 6, N'1998-03-12T00:00:00', N'1998-03-26T00:00:00', N'1998-03-13T00:00:00', 3, 52.9200, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', NULL ), 
( 10945, N'MORGK', 4, N'1998-03-12T00:00:00', N'1998-04-09T00:00:00', N'1998-03-18T00:00:00', 1, 10.2200, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Germany', NULL ), 
( 10946, N'VAFFE', 1, N'1998-03-12T00:00:00', N'1998-04-09T00:00:00', N'1998-03-19T00:00:00', 2, 27.2000, N'Vaffeljernet', N'Smagsloget 45', N'�rhus', NULL, N'8200', N'Denmark', NULL ), 
( 10947, N'BSBEV', 3, N'1998-03-13T00:00:00', N'1998-04-10T00:00:00', N'1998-03-16T00:00:00', 2, 3.2600, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK', NULL ), 
( 10948, N'GODOS', 3, N'1998-03-13T00:00:00', N'1998-04-10T00:00:00', N'1998-03-19T00:00:00', 3, 23.3900, N'Godos Cocina T�pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain', NULL ), 
( 10949, N'BOTTM', 2, N'1998-03-13T00:00:00', N'1998-04-10T00:00:00', N'1998-03-17T00:00:00', 3, 74.4400, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', NULL ), 
( 10950, N'MAGAA', 1, N'1998-03-16T00:00:00', N'1998-04-13T00:00:00', N'1998-03-23T00:00:00', 2, 2.5000, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy', NULL ), 
( 10951, N'RICSU', 9, N'1998-03-16T00:00:00', N'1998-04-27T00:00:00', N'1998-04-07T00:00:00', 2, 30.8500, N'Richter Supermarkt', N'Starenweg 5', N'Gen�ve', NULL, N'1204', N'Switzerland', NULL ), 
( 10952, N'ALFKI', 1, N'1998-03-16T00:00:00', N'1998-04-27T00:00:00', N'1998-03-24T00:00:00', 1, 40.4200, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany', NULL ), 
( 10953, N'AROUT', 9, N'1998-03-16T00:00:00', N'1998-03-30T00:00:00', N'1998-03-25T00:00:00', 2, 23.7200, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK', NULL ), 
( 10954, N'LINOD', 5, N'1998-03-17T00:00:00', N'1998-04-28T00:00:00', N'1998-03-20T00:00:00', 1, 27.9100, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL ), 
( 10955, N'FOLKO', 8, N'1998-03-17T00:00:00', N'1998-04-14T00:00:00', N'1998-03-20T00:00:00', 2, 3.2600, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 10956, N'BLAUS', 6, N'1998-03-17T00:00:00', N'1998-04-28T00:00:00', N'1998-03-20T00:00:00', 2, 44.6500, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany', NULL ), 
( 10957, N'HILAA', 8, N'1998-03-18T00:00:00', N'1998-04-15T00:00:00', N'1998-03-27T00:00:00', 3, 105.3600, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 10958, N'OCEAN', 7, N'1998-03-18T00:00:00', N'1998-04-15T00:00:00', N'1998-03-27T00:00:00', 2, 49.5600, N'Oc�ano Atl�ntico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL ), 
( 10959, N'GOURL', 6, N'1998-03-18T00:00:00', N'1998-04-29T00:00:00', N'1998-03-23T00:00:00', 2, 4.9800, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil', NULL ), 
( 10960, N'HILAA', 3, N'1998-03-19T00:00:00', N'1998-04-02T00:00:00', N'1998-04-08T00:00:00', 1, 2.0800, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 10961, N'QUEEN', 8, N'1998-03-19T00:00:00', N'1998-04-16T00:00:00', N'1998-03-30T00:00:00', 1, 104.4700, N'Queen Cozinha', N'Alameda dos Can�rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil', NULL ), 
( 10962, N'QUICK', 8, N'1998-03-19T00:00:00', N'1998-04-16T00:00:00', N'1998-03-23T00:00:00', 2, 275.7900, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10963, N'FURIB', 9, N'1998-03-19T00:00:00', N'1998-04-16T00:00:00', N'1998-03-26T00:00:00', 3, 2.7000, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', NULL ), 
( 10964, N'SPECD', 3, N'1998-03-20T00:00:00', N'1998-04-17T00:00:00', N'1998-03-24T00:00:00', 2, 87.3800, N'Sp�cialit�s du monde', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'France', NULL ), 
( 10965, N'OLDWO', 6, N'1998-03-20T00:00:00', N'1998-04-17T00:00:00', N'1998-03-30T00:00:00', 3, 144.3800, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA', NULL ), 
( 10966, N'CHOPS', 4, N'1998-03-20T00:00:00', N'1998-04-17T00:00:00', N'1998-04-08T00:00:00', 1, 27.1900, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland', NULL ), 
( 10967, N'TOMSP', 2, N'1998-03-23T00:00:00', N'1998-04-20T00:00:00', N'1998-04-02T00:00:00', 2, 62.2200, N'Toms Spezialit�ten', N'Luisenstr. 48', N'M�nster', NULL, N'44087', N'Germany', NULL ), 
( 10968, N'ERNSH', 1, N'1998-03-23T00:00:00', N'1998-04-20T00:00:00', N'1998-04-01T00:00:00', 3, 74.6000, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10969, N'COMMI', 1, N'1998-03-23T00:00:00', N'1998-04-20T00:00:00', N'1998-03-30T00:00:00', 2, 0.2100, N'Com�rcio Mineiro', N'Av. dos Lus�adas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil', NULL ), 
( 10970, N'BOLID', 9, N'1998-03-24T00:00:00', N'1998-04-07T00:00:00', N'1998-04-24T00:00:00', 1, 16.1600, N'B�lido Comidas preparadas', N'C/ Araquil, 67', N'Madrid', NULL, N'28023', N'Spain', NULL ), 
( 10971, N'FRANR', 2, N'1998-03-24T00:00:00', N'1998-04-21T00:00:00', N'1998-04-02T00:00:00', 2, 121.8200, N'France restauration', N'54, rue Royale', N'Nantes', NULL, N'44000', N'France', NULL ), 
( 10972, N'LACOR', 4, N'1998-03-24T00:00:00', N'1998-04-21T00:00:00', N'1998-03-26T00:00:00', 2, 0.0200, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'France', NULL ), 
( 10973, N'LACOR', 6, N'1998-03-24T00:00:00', N'1998-04-21T00:00:00', N'1998-03-27T00:00:00', 2, 15.1700, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'France', NULL ), 
( 10974, N'SPLIR', 3, N'1998-03-25T00:00:00', N'1998-04-08T00:00:00', N'1998-04-03T00:00:00', 3, 12.9600, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA', NULL ), 
( 10975, N'BOTTM', 1, N'1998-03-25T00:00:00', N'1998-04-22T00:00:00', N'1998-03-27T00:00:00', 3, 32.2700, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', NULL ), 
( 10976, N'HILAA', 1, N'1998-03-25T00:00:00', N'1998-05-06T00:00:00', N'1998-04-03T00:00:00', 1, 37.9700, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 10977, N'FOLKO', 8, N'1998-03-26T00:00:00', N'1998-04-23T00:00:00', N'1998-04-10T00:00:00', 3, 208.5000, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 10978, N'MAISD', 9, N'1998-03-26T00:00:00', N'1998-04-23T00:00:00', N'1998-04-23T00:00:00', 2, 32.8200, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium', NULL ), 
( 10979, N'ERNSH', 8, N'1998-03-26T00:00:00', N'1998-04-23T00:00:00', N'1998-03-31T00:00:00', 2, 353.0700, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10980, N'FOLKO', 4, N'1998-03-27T00:00:00', N'1998-05-08T00:00:00', N'1998-04-17T00:00:00', 1, 1.2600, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 10981, N'HANAR', 1, N'1998-03-27T00:00:00', N'1998-04-24T00:00:00', N'1998-04-02T00:00:00', 2, 193.3700, N'Hanari Carnes', N'Rua do Pa�o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil', NULL ), 
( 10982, N'BOTTM', 2, N'1998-03-27T00:00:00', N'1998-04-24T00:00:00', N'1998-04-08T00:00:00', 1, 14.0100, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', NULL ), 
( 10983, N'SAVEA', 2, N'1998-03-27T00:00:00', N'1998-04-24T00:00:00', N'1998-04-06T00:00:00', 2, 657.5400, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10984, N'SAVEA', 1, N'1998-03-30T00:00:00', N'1998-04-27T00:00:00', N'1998-04-03T00:00:00', 3, 211.2200, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 10985, N'HUNGO', 2, N'1998-03-30T00:00:00', N'1998-04-27T00:00:00', N'1998-04-02T00:00:00', 1, 91.5100, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 10986, N'OCEAN', 8, N'1998-03-30T00:00:00', N'1998-04-27T00:00:00', N'1998-04-21T00:00:00', 2, 217.8600, N'Oc�ano Atl�ntico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL ), 
( 10987, N'EASTC', 8, N'1998-03-31T00:00:00', N'1998-04-28T00:00:00', N'1998-04-06T00:00:00', 1, 185.4800, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK', NULL ), 
( 10988, N'RATTC', 3, N'1998-03-31T00:00:00', N'1998-04-28T00:00:00', N'1998-04-10T00:00:00', 2, 61.1400, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL ), 
( 10989, N'QUEDE', 2, N'1998-03-31T00:00:00', N'1998-04-28T00:00:00', N'1998-04-02T00:00:00', 1, 34.7600, N'Que Del�cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil', NULL ), 
( 10990, N'ERNSH', 2, N'1998-04-01T00:00:00', N'1998-05-13T00:00:00', N'1998-04-07T00:00:00', 3, 117.6100, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 10991, N'QUICK', 1, N'1998-04-01T00:00:00', N'1998-04-29T00:00:00', N'1998-04-07T00:00:00', 1, 38.5100, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10992, N'THEBI', 1, N'1998-04-01T00:00:00', N'1998-04-29T00:00:00', N'1998-04-03T00:00:00', 3, 4.2700, N'The Big Cheese', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA', NULL ), 
( 10993, N'FOLKO', 7, N'1998-04-01T00:00:00', N'1998-04-29T00:00:00', N'1998-04-10T00:00:00', 3, 8.8100, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 10994, N'VAFFE', 2, N'1998-04-02T00:00:00', N'1998-04-16T00:00:00', N'1998-04-09T00:00:00', 3, 65.5300, N'Vaffeljernet', N'Smagsloget 45', N'�rhus', NULL, N'8200', N'Denmark', NULL ), 
( 10995, N'PERIC', 1, N'1998-04-02T00:00:00', N'1998-04-30T00:00:00', N'1998-04-06T00:00:00', 3, 46.0000, N'Pericles Comidas cl�sicas', N'Calle Dr. Jorge Cash 321', N'M�xico D.F.', NULL, N'05033', N'Mexico', NULL ), 
( 10996, N'QUICK', 4, N'1998-04-02T00:00:00', N'1998-04-30T00:00:00', N'1998-04-10T00:00:00', 2, 1.1200, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 10997, N'LILAS', 8, N'1998-04-03T00:00:00', N'1998-05-15T00:00:00', N'1998-04-13T00:00:00', 2, 73.9100, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL ), 
( 10998, N'WOLZA', 8, N'1998-04-03T00:00:00', N'1998-04-17T00:00:00', N'1998-04-17T00:00:00', 2, 20.3100, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland', NULL ), 
( 10999, N'OTTIK', 6, N'1998-04-03T00:00:00', N'1998-05-01T00:00:00', N'1998-04-10T00:00:00', 2, 96.3500, N'Ottilies K�seladen', N'Mehrheimerstr. 369', N'K�ln', NULL, N'50739', N'Germany', NULL ), 
( 11000, N'RATTC', 2, N'1998-04-06T00:00:00', N'1998-05-04T00:00:00', N'1998-04-14T00:00:00', 3, 55.1200, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL ), 
( 11001, N'FOLKO', 2, N'1998-04-06T00:00:00', N'1998-05-04T00:00:00', N'1998-04-14T00:00:00', 2, 197.3000, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 11002, N'SAVEA', 4, N'1998-04-06T00:00:00', N'1998-05-04T00:00:00', N'1998-04-16T00:00:00', 1, 141.1600, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 11003, N'THECR', 3, N'1998-04-06T00:00:00', N'1998-05-04T00:00:00', N'1998-04-08T00:00:00', 3, 14.9100, N'The Cracker Box', N'55 Grizzly Peak Rd.', N'Butte', N'MT', N'59801', N'USA', NULL ), 
( 11004, N'MAISD', 3, N'1998-04-07T00:00:00', N'1998-05-05T00:00:00', N'1998-04-20T00:00:00', 1, 44.8400, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium', NULL ), 
( 11005, N'WILMK', 2, N'1998-04-07T00:00:00', N'1998-05-05T00:00:00', N'1998-04-10T00:00:00', 1, 0.7500, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland', NULL ), 
( 11006, N'GREAL', 3, N'1998-04-07T00:00:00', N'1998-05-05T00:00:00', N'1998-04-15T00:00:00', 2, 25.1900, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA', NULL ), 
( 11007, N'PRINI', 8, N'1998-04-08T00:00:00', N'1998-05-06T00:00:00', N'1998-04-13T00:00:00', 2, 202.2400, N'Princesa Isabel Vinhos', N'Estrada da sa�de n. 58', N'Lisboa', NULL, N'1756', N'Portugal', NULL ), 
( 11008, N'ERNSH', 7, N'1998-04-08T00:00:00', N'1998-05-06T00:00:00', NULL, 3, 79.4600, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 11009, N'GODOS', 2, N'1998-04-08T00:00:00', N'1998-05-06T00:00:00', N'1998-04-10T00:00:00', 1, 59.1100, N'Godos Cocina T�pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain', NULL ), 
( 11010, N'REGGC', 2, N'1998-04-09T00:00:00', N'1998-05-07T00:00:00', N'1998-04-21T00:00:00', 2, 28.7100, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy', NULL ), 
( 11011, N'ALFKI', 3, N'1998-04-09T00:00:00', N'1998-05-07T00:00:00', N'1998-04-13T00:00:00', 1, 1.2100, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany', NULL ), 
( 11012, N'FRANK', 1, N'1998-04-09T00:00:00', N'1998-04-23T00:00:00', N'1998-04-17T00:00:00', 3, 242.9500, N'Frankenversand', N'Berliner Platz 43', N'M�nchen', NULL, N'80805', N'Germany', NULL ), 
( 11013, N'ROMEY', 2, N'1998-04-09T00:00:00', N'1998-05-07T00:00:00', N'1998-04-10T00:00:00', 1, 32.9900, N'Romero y tomillo', N'Gran V�a, 1', N'Madrid', NULL, N'28001', N'Spain', NULL ), 
( 11014, N'LINOD', 2, N'1998-04-10T00:00:00', N'1998-05-08T00:00:00', N'1998-04-15T00:00:00', 3, 23.6000, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL ), 
( 11015, N'SANTG', 2, N'1998-04-10T00:00:00', N'1998-04-24T00:00:00', N'1998-04-20T00:00:00', 2, 4.6200, N'Sant� Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway', NULL ), 
( 11016, N'AROUT', 9, N'1998-04-10T00:00:00', N'1998-05-08T00:00:00', N'1998-04-13T00:00:00', 2, 33.8000, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK', NULL ), 
( 11017, N'ERNSH', 9, N'1998-04-13T00:00:00', N'1998-05-11T00:00:00', N'1998-04-20T00:00:00', 2, 754.2600, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 11018, N'LONEP', 4, N'1998-04-13T00:00:00', N'1998-05-11T00:00:00', N'1998-04-16T00:00:00', 2, 11.6500, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA', NULL ), 
( 11019, N'RANCH', 6, N'1998-04-13T00:00:00', N'1998-05-11T00:00:00', NULL, 3, 3.1700, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL ), 
( 11020, N'OTTIK', 2, N'1998-04-14T00:00:00', N'1998-05-12T00:00:00', N'1998-04-16T00:00:00', 2, 43.3000, N'Ottilies K�seladen', N'Mehrheimerstr. 369', N'K�ln', NULL, N'50739', N'Germany', NULL ), 
( 11021, N'QUICK', 3, N'1998-04-14T00:00:00', N'1998-05-12T00:00:00', N'1998-04-21T00:00:00', 1, 297.1800, N'QUICK-Stop', N'Taucherstra�e 10', N'Cunewalde', NULL, N'01307', N'Germany', NULL ), 
( 11022, N'HANAR', 9, N'1998-04-14T00:00:00', N'1998-05-12T00:00:00', N'1998-05-04T00:00:00', 2, 6.2700, N'Hanari Carnes', N'Rua do Pa�o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil', NULL ), 
( 11023, N'BSBEV', 1, N'1998-04-14T00:00:00', N'1998-04-28T00:00:00', N'1998-04-24T00:00:00', 2, 123.8300, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK', NULL ), 
( 11024, N'EASTC', 4, N'1998-04-15T00:00:00', N'1998-05-13T00:00:00', N'1998-04-20T00:00:00', 1, 74.3600, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK', NULL ), 
( 11025, N'WARTH', 6, N'1998-04-15T00:00:00', N'1998-05-13T00:00:00', N'1998-04-24T00:00:00', 3, 29.1700, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland', NULL ), 
( 11026, N'FRANS', 4, N'1998-04-15T00:00:00', N'1998-05-13T00:00:00', N'1998-04-28T00:00:00', 1, 47.0900, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy', NULL ), 
( 11027, N'BOTTM', 1, N'1998-04-16T00:00:00', N'1998-05-14T00:00:00', N'1998-04-20T00:00:00', 1, 52.5200, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', NULL ), 
( 11028, N'KOENE', 2, N'1998-04-16T00:00:00', N'1998-05-14T00:00:00', N'1998-04-22T00:00:00', 1, 29.5900, N'K�niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany', NULL ), 
( 11029, N'CHOPS', 4, N'1998-04-16T00:00:00', N'1998-05-14T00:00:00', N'1998-04-27T00:00:00', 1, 47.8400, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland', NULL ), 
( 11030, N'SAVEA', 7, N'1998-04-17T00:00:00', N'1998-05-15T00:00:00', N'1998-04-27T00:00:00', 2, 830.7500, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 11031, N'SAVEA', 6, N'1998-04-17T00:00:00', N'1998-05-15T00:00:00', N'1998-04-24T00:00:00', 2, 227.2200, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 11032, N'WHITC', 2, N'1998-04-17T00:00:00', N'1998-05-15T00:00:00', N'1998-04-23T00:00:00', 3, 606.1900, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA', NULL ), 
( 11033, N'RICSU', 7, N'1998-04-17T00:00:00', N'1998-05-15T00:00:00', N'1998-04-23T00:00:00', 3, 84.7400, N'Richter Supermarkt', N'Starenweg 5', N'Gen�ve', NULL, N'1204', N'Switzerland', NULL ), 
( 11034, N'OLDWO', 8, N'1998-04-20T00:00:00', N'1998-06-01T00:00:00', N'1998-04-27T00:00:00', 1, 40.3200, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA', NULL ), 
( 11035, N'SUPRD', 2, N'1998-04-20T00:00:00', N'1998-05-18T00:00:00', N'1998-04-24T00:00:00', 2, 0.1700, N'Supr�mes d�lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium', NULL ), 
( 11036, N'DRACD', 8, N'1998-04-20T00:00:00', N'1998-05-18T00:00:00', N'1998-04-22T00:00:00', 3, 149.4700, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany', NULL ), 
( 11037, N'GODOS', 7, N'1998-04-21T00:00:00', N'1998-05-19T00:00:00', N'1998-04-27T00:00:00', 1, 3.2000, N'Godos Cocina T�pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain', NULL ), 
( 11038, N'SUPRD', 1, N'1998-04-21T00:00:00', N'1998-05-19T00:00:00', N'1998-04-30T00:00:00', 2, 29.5900, N'Supr�mes d�lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium', NULL ), 
( 11039, N'LINOD', 1, N'1998-04-21T00:00:00', N'1998-05-19T00:00:00', NULL, 2, 65.0000, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL ), 
( 11040, N'GREAL', 4, N'1998-04-22T00:00:00', N'1998-05-20T00:00:00', NULL, 3, 18.8400, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA', NULL ), 
( 11041, N'CHOPS', 3, N'1998-04-22T00:00:00', N'1998-05-20T00:00:00', N'1998-04-28T00:00:00', 2, 48.2200, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland', NULL ), 
( 11042, N'COMMI', 2, N'1998-04-22T00:00:00', N'1998-05-06T00:00:00', N'1998-05-01T00:00:00', 1, 29.9900, N'Com�rcio Mineiro', N'Av. dos Lus�adas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil', NULL ), 
( 11043, N'SPECD', 5, N'1998-04-22T00:00:00', N'1998-05-20T00:00:00', N'1998-04-29T00:00:00', 2, 8.8000, N'Sp�cialit�s du monde', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'France', NULL ), 
( 11044, N'WOLZA', 4, N'1998-04-23T00:00:00', N'1998-05-21T00:00:00', N'1998-05-01T00:00:00', 1, 8.7200, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland', NULL ), 
( 11045, N'BOTTM', 6, N'1998-04-23T00:00:00', N'1998-05-21T00:00:00', NULL, 2, 70.5800, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', NULL ), 
( 11046, N'WANDK', 8, N'1998-04-23T00:00:00', N'1998-05-21T00:00:00', N'1998-04-24T00:00:00', 2, 71.6400, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany', NULL ), 
( 11047, N'EASTC', 7, N'1998-04-24T00:00:00', N'1998-05-22T00:00:00', N'1998-05-01T00:00:00', 3, 46.6200, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK', NULL ), 
( 11048, N'BOTTM', 7, N'1998-04-24T00:00:00', N'1998-05-22T00:00:00', N'1998-04-30T00:00:00', 3, 24.1200, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', NULL ), 
( 11049, N'GOURL', 3, N'1998-04-24T00:00:00', N'1998-05-22T00:00:00', N'1998-05-04T00:00:00', 1, 8.3400, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil', NULL ), 
( 11050, N'FOLKO', 8, N'1998-04-27T00:00:00', N'1998-05-25T00:00:00', N'1998-05-05T00:00:00', 2, 59.4100, N'Folk och f� HB', N'�kergatan 24', N'Br�cke', NULL, N'S-844 67', N'Sweden', NULL ), 
( 11051, N'LAMAI', 7, N'1998-04-27T00:00:00', N'1998-05-25T00:00:00', NULL, 3, 2.7900, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France', NULL ), 
( 11052, N'HANAR', 3, N'1998-04-27T00:00:00', N'1998-05-25T00:00:00', N'1998-05-01T00:00:00', 1, 67.2600, N'Hanari Carnes', N'Rua do Pa�o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil', NULL ), 
( 11053, N'PICCO', 2, N'1998-04-27T00:00:00', N'1998-05-25T00:00:00', N'1998-04-29T00:00:00', 2, 53.0500, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL ), 
( 11054, N'CACTU', 8, N'1998-04-28T00:00:00', N'1998-05-26T00:00:00', NULL, 1, 0.3300, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL ), 
( 11055, N'HILAA', 7, N'1998-04-28T00:00:00', N'1998-05-26T00:00:00', N'1998-05-05T00:00:00', 2, 120.9200, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'5022', N'Venezuela', NULL ), 
( 11056, N'EASTC', 8, N'1998-04-28T00:00:00', N'1998-05-12T00:00:00', N'1998-05-01T00:00:00', 2, 278.9600, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK', NULL ), 
( 11057, N'NORTS', 3, N'1998-04-29T00:00:00', N'1998-05-27T00:00:00', N'1998-05-01T00:00:00', 3, 4.1300, N'North/South', N'South House 300 Queensbridge', N'London', NULL, N'SW7 1RZ', N'UK', NULL ), 
( 11058, N'BLAUS', 9, N'1998-04-29T00:00:00', N'1998-05-27T00:00:00', NULL, 3, 31.1400, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany', NULL ), 
( 11059, N'RICAR', 2, N'1998-04-29T00:00:00', N'1998-06-10T00:00:00', NULL, 2, 85.8000, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil', NULL ), 
( 11060, N'FRANS', 2, N'1998-04-30T00:00:00', N'1998-05-28T00:00:00', N'1998-05-04T00:00:00', 2, 10.9800, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy', NULL ), 
( 11061, N'GREAL', 4, N'1998-04-30T00:00:00', N'1998-06-11T00:00:00', NULL, 3, 14.0100, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA', NULL ), 
( 11062, N'REGGC', 4, N'1998-04-30T00:00:00', N'1998-05-28T00:00:00', NULL, 2, 29.9300, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy', NULL ), 
( 11063, N'HUNGO', 3, N'1998-04-30T00:00:00', N'1998-05-28T00:00:00', N'1998-05-06T00:00:00', 2, 81.7300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', NULL ), 
( 11064, N'SAVEA', 1, N'1998-05-01T00:00:00', N'1998-05-29T00:00:00', N'1998-05-04T00:00:00', 1, 30.0900, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', NULL ), 
( 11065, N'LILAS', 8, N'1998-05-01T00:00:00', N'1998-05-29T00:00:00', NULL, 1, 12.9100, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL ), 
( 11066, N'WHITC', 7, N'1998-05-01T00:00:00', N'1998-05-29T00:00:00', N'1998-05-04T00:00:00', 2, 44.7200, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA', NULL ), 
( 11067, N'DRACD', 1, N'1998-05-04T00:00:00', N'1998-05-18T00:00:00', N'1998-05-06T00:00:00', 2, 7.9800, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany', NULL ), 
( 11068, N'QUEEN', 8, N'1998-05-04T00:00:00', N'1998-06-01T00:00:00', NULL, 2, 81.7500, N'Queen Cozinha', N'Alameda dos Can�rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil', NULL ), 
( 11069, N'TORTU', 1, N'1998-05-04T00:00:00', N'1998-06-01T00:00:00', N'1998-05-06T00:00:00', 2, 15.6700, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M�xico D.F.', NULL, N'05033', N'Mexico', NULL ), 
( 11070, N'LEHMS', 2, N'1998-05-05T00:00:00', N'1998-06-02T00:00:00', NULL, 1, 136.0000, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany', NULL ), 
( 11071, N'LILAS', 1, N'1998-05-05T00:00:00', N'1998-06-02T00:00:00', NULL, 1, 0.9300, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL ), 
( 11072, N'ERNSH', 4, N'1998-05-05T00:00:00', N'1998-06-02T00:00:00', NULL, 2, 258.6400, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL ), 
( 11073, N'PERIC', 2, N'1998-05-05T00:00:00', N'1998-06-02T00:00:00', NULL, 2, 24.9500, N'Pericles Comidas cl�sicas', N'Calle Dr. Jorge Cash 321', N'M�xico D.F.', NULL, N'05033', N'Mexico', NULL ), 
( 11074, N'SIMOB', 7, N'1998-05-06T00:00:00', N'1998-06-03T00:00:00', NULL, 2, 18.4400, N'Simons bistro', N'Vinb�ltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark', NULL ), 
( 11075, N'RICSU', 8, N'1998-05-06T00:00:00', N'1998-06-03T00:00:00', NULL, 2, 6.1900, N'Richter Supermarkt', N'Starenweg 5', N'Gen�ve', NULL, N'1204', N'Switzerland', NULL ), 
( 11076, N'BONAP', 4, N'1998-05-06T00:00:00', N'1998-06-03T00:00:00', NULL, 2, 38.2800, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', NULL ), 
( 11077, N'RATTC', 1, N'1998-05-06T00:00:00', N'1998-06-03T00:00:00', NULL, 2, 8.5300, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', NULL )

GO
SET IDENTITY_INSERT dbo.Orders OFF
GO
-- insert suppliers
SET IDENTITY_INSERT dbo.Suppliers ON
GO
INSERT dbo.Suppliers
  (SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage, CreditLimit)
VALUES
( 1, N'Exotic Liquids', N'Charlotte Cooper', N'Purchasing Manager', N'49 Gilbert St.', N'London', NULL, N'EC1 4SD', N'UK', N'(171) 555-2222', NULL, NULL, 1000 ), 
( 2, N'New Orleans Cajun Delights', N'Shelley Burke', N'Order Administrator', N'P.O. Box 78934', N'New Orleans', N'LA', N'70117', N'USA', N'(100) 555-4822', NULL, N'#CAJUN.HTM#', 1000 ), 
( 3, N'Grandma Kelly''s Homestead', N'Regina Murphy', N'Sales Representative', N'707 Oxford Rd.', N'Ann Arbor', N'MI', N'48104', N'USA', N'(313) 555-5735', N'(313) 555-3349', NULL, 1000 ), 
( 4, N'Tokyo Traders', N'Yoshi Nagase', N'Marketing Manager', N'9-8 Sekimai Musashino-shi', N'Tokyo', NULL, N'100', N'Japan', N'(03) 3555-5011', NULL, NULL, 1000 ), 
( 5, N'Cooperativa de Quesos ''Las Cabras''', N'Antonio del Valle Saavedra', N'Export Administrator', N'Calle del Rosal 4', N'Oviedo', N'Asturias', N'33007', N'Spain', N'(98) 598 76 54', NULL, NULL, 1000 ), 
( 6, N'Mayumi''s', N'Mayumi Ohno', N'Marketing Representative', N'92 Setsuko Chuo-ku', N'Osaka', NULL, N'545', N'Japan', N'(06) 431-7877', NULL, N'Mayumi''s (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/mayumi.htm#', 5000 ), 
( 7, N'Pavlova, Ltd.', N'Ian Devling', N'Marketing Manager', N'74 Rose St. Moonie Ponds', N'Melbourne', N'Victoria', N'3058', N'Australia', N'(03) 444-2343', N'(03) 444-6588', NULL, 2000 ), 
( 8, N'Specialty Biscuits, Ltd.', N'Peter Wilson', N'Sales Representative', N'29 King''s Way', N'Manchester', NULL, N'M14 GSD', N'UK', N'(161) 555-4448', NULL, NULL, 4000 ), 
( 9, N'PB Kn?ckebr?d AB', N'Lars Peterson', N'Sales Agent', N'Kaloadagatan 13', N'G?teborg', NULL, N'S-345 67', N'Sweden', N'031-987 65 43', N'031-987 65 91', NULL, 5000 ), 
( 10, N'Refrescos Americanas LTDA', N'Carlos Diaz', N'Marketing Manager', N'Av. das Americanas 12.890', N'Sao Paulo', NULL, N'5442', N'Brazil', N'(11) 555 4640', NULL, NULL, 10000 ), 
( 11, N'Heli S??waren GmbH & Co. KG', N'Petra Winkler', N'Sales Manager', N'Tiergartenstra?e 5', N'Berlin', NULL, N'10785', N'Germany', N'(010) 9984510', NULL, NULL, 10000 ), 
( 12, N'Plutzer Lebensmittelgro?m?rkte AG', N'Martin Bein', N'International Marketing Mgr.', N'Bogenallee 51', N'Frankfurt', NULL, N'60439', N'Germany', N'(069) 992755', NULL, N'Plutzer (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/plutzer.htm#', 1000 ), 
( 13, N'Nord-Ost-Fisch Handelsgesellschaft mbH', N'Sven Petersen', N'Coordinator Foreign Markets', N'Frahmredder 112a', N'Cuxhaven', NULL, N'27478', N'Germany', N'(04721) 8713', N'(04721) 8714', NULL, 1000 ), 
( 14, N'Formaggi Fortini s.r.l.', N'Elio Rossi', N'Sales Representative', N'Viale Dante, 75', N'Ravenna', NULL, N'48100', N'Italy', N'(0544) 60323', N'(0544) 60603', N'#FORMAGGI.HTM#', 1000 ), 
( 15, N'Norske Meierier', N'Beate Vileid', N'Marketing Manager', N'Hatlevegen 5', N'Sandvika', NULL, N'1320', N'Norway', N'(0)2-953010', NULL, NULL, 1000 ), 
( 16, N'Bigfoot Breweries', N'Cheryl Saylor', N'Regional Account Rep.', N'3400 - 8th Avenue Suite 210', N'Bend', N'OR', N'97101', N'USA', N'(503) 555-9931', NULL, NULL, 1000 ), 
( 17, N'Svensk Sj?f?da AB', N'Michael Bj?rn', N'Sales Representative', N'Brovallav?gen 231', N'Stockholm', NULL, N'S-123 45', N'Sweden', N'08-123 45 67', NULL, NULL, 5000 ), 
( 18, N'Aux joyeux eccl?siastiques', N'Guyl?ne Nodier', N'Sales Manager', N'203, Rue des Francs-Bourgeois', N'Paris', NULL, N'75004', N'France', N'(1) 03.83.00.68', N'(1) 03.83.00.62', NULL, 5000 ), 
( 19, N'New England Seafood Cannery', N'Robb Merchant', N'Wholesale Account Agent', N'Order Processing Dept. 2100 Paul Revere Blvd.', N'Boston', N'MA', N'02134', N'USA', N'(617) 555-3267', N'(617) 555-3389', NULL, 8000 ), 
( 20, N'Leka Trading', N'Chandra Leka', N'Owner', N'471 Serangoon Loop, Suite #402', N'Singapore', NULL, N'0512', N'Singapore', N'555-8787', NULL, NULL, 7000 ), 
( 21, N'Lyngbysild', N'Niels Petersen', N'Sales Manager', N'Lyngbysild Fiskebakken 10', N'Lyngby', NULL, N'2800', N'Denmark', N'43844108', N'43844115', NULL, 8000 ), 
( 22, N'Zaanse Snoepfabriek', N'Dirk Luchte', N'Accounting Manager', N'Verkoop Rijnweg 22', N'Zaandam', NULL, N'9999 ZZ', N'Netherlands', N'(12345) 1212', N'(12345) 1210', NULL, 1000 ), 
( 23, N'Karkki Oy', N'Anne Heikkonen', N'Product Manager', N'Valtakatu 12', N'Lappeenranta', NULL, N'53120', N'Finland', N'(953) 10956', NULL, NULL, 8000 ), 
( 24, N'G''day, Mate', N'Wendy Mackenzie', N'Sales Representative', N'170 Prince Edward Parade Hunter''s Hill', N'Sydney', N'NSW', N'2042', N'Australia', N'(02) 555-5914', N'(02) 555-4873', N'G''day Mate (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/gdaymate.htm#', 12000 ), 
( 25, N'Ma Maison', N'Jean-Guy Lauzon', N'Marketing Manager', N'2960 Rue St. Laurent', N'Montr?al', N'Qu?bec', N'H1J 1C3', N'Canada', N'(514) 555-9022', NULL, NULL, 1000 ), 
( 26, N'Pasta Buttini s.r.l.', N'Giovanni Giudici', N'Order Administrator', N'Via dei Gelsomini, 153', N'Salerno', NULL, N'84100', N'Italy', N'(089) 6547665', N'(089) 6547667', NULL, 1000 ), 
( 27, N'Escargots Nouveaux', N'Marie Delamare', N'Sales Manager', N'22, rue H. Voiron', N'Montceau', NULL, N'71300', N'France', N'85.57.00.07', NULL, NULL, 1000 ), 
( 28, N'Gai p?turage', N'Eliane Noz', N'Sales Representative', N'Bat. B 3, rue des Alpes', N'Annecy', NULL, N'74000', N'France', N'38.76.98.06', N'38.76.98.58', NULL , 1000), 
( 29, N'For?ts d''?rables', N'Chantal Goulet', N'Accounting Manager', N'148 rue Chasseur', N'Ste-Hyacinthe', N'Qu?bec', N'J2S 7S8', N'Canada', N'(514) 555-2955', N'(514) 555-2921', NULL, 1000 )

GO
SET IDENTITY_INSERT dbo.Suppliers OFF
GO
-- insert products
SET IDENTITY_INSERT dbo.Products ON
GO
INSERT dbo.Products
  (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, Colour, Colour2, Colour3)
VALUES
( 1, N'Chai', 1, 1, N'10 boxes x 20 bags', 18.0000, 39, 0, 10, 0, NULL, NULL, NULL ), 
( 2, N'Chang', 1, 1, N'24 - 12 oz bottles', 19.0000, 17, 40, 25, 0, NULL, NULL, NULL ), 
( 3, N'Aniseed Syrup', 1, 2, N'12 - 550 ml bottles', 10.0000, 13, 70, 25, 0, NULL, NULL, NULL ), 
( 4, N'Chef Anton''s Cajun Seasoning', 2, 2, N'48 - 6 oz jars', 22.0000, 53, 0, 0, 0, NULL, NULL, NULL ), 
( 5, N'Chef Anton''s Gumbo Mix', 2, 2, N'36 boxes', 21.3500, 0, 0, 0, 1, NULL, NULL, NULL ), 
( 6, N'Grandma''s Boysenberry Spread', 3, 2, N'12 - 8 oz jars', 25.0000, 120, 0, 25, 0, NULL, NULL, NULL ), 
( 7, N'Uncle Bob''s Organic Dried Pears', 3, 7, N'12 - 1 lb pkgs.', 30.0000, 15, 0, 10, 0, NULL, NULL, NULL ), 
( 8, N'Northwoods Cranberry Sauce', 3, 2, N'12 - 12 oz jars', 40.0000, 6, 0, 0, 0, NULL, NULL, NULL ), 
( 9, N'Mishi Kobe Niku', 4, 6, N'18 - 500 g pkgs.', 97.0000, 29, 0, 0, 1, NULL, NULL, NULL ), 
( 10, N'Ikura', 4, 8, N'12 - 200 ml jars', 31.0000, 31, 0, 0, 0, NULL, NULL, NULL ), 
( 11, N'Queso Cabrales', 5, 4, N'1 kg pkg.', 21.0000, 22, 30, 30, 0, NULL, NULL, NULL ), 
( 12, N'Queso Manchego La Pastora', 5, 4, N'10 - 500 g pkgs.', 38.0000, 86, 0, 0, 0, NULL, NULL, NULL ), 
( 13, N'Konbu', 6, 8, N'2 kg box', 6.0000, 24, 0, 5, 0, NULL, NULL, NULL ), 
( 14, N'Tofu', 6, 7, N'40 - 100 g pkgs.', 23.2500, 35, 0, 0, 0, NULL, NULL, NULL ), 
( 15, N'Genen Shouyu', 6, 2, N'24 - 250 ml bottles', 15.5000, 39, 0, 5, 0, NULL, NULL, NULL ), 
( 16, N'Pavlova', 7, 3, N'32 - 500 g boxes', 17.4500, 29, 0, 10, 0, NULL, NULL, NULL ), 
( 17, N'Alice Mutton', 7, 6, N'20 - 1 kg tins', 39.0000, 0, 0, 0, 1, NULL, NULL, NULL ), 
( 18, N'Carnarvon Tigers', 7, 8, N'16 kg pkg.', 62.5000, 42, 0, 0, 0, NULL, NULL, NULL ), 
( 19, N'Teatime Chocolate Biscuits', 8, 3, N'10 boxes x 12 pieces', 9.2000, 25, 0, 5, 0, NULL, NULL, NULL ), 
( 20, N'Sir Rodney''s Marmalade', 8, 3, N'30 gift boxes', 81.0000, 40, 0, 0, 0, NULL, NULL, NULL ), 
( 21, N'Sir Rodney''s Scones', 8, 3, N'24 pkgs. x 4 pieces', 10.0000, 3, 40, 5, 0, NULL, NULL, NULL ), 
( 22, N'Gustaf''s Kn?ckebr?d', 9, 5, N'24 - 500 g pkgs.', 21.0000, 104, 0, 25, 0, NULL, NULL, NULL ), 
( 23, N'Tunnbr?d', 9, 5, N'12 - 250 g pkgs.', 9.0000, 61, 0, 25, 0, NULL, NULL, NULL ), 
( 24, N'Guaran? Fant?stica', 10, 1, N'12 - 355 ml cans', 4.5000, 20, 0, 0, 1, NULL, NULL, NULL ), 
( 25, N'NuNuCa Nu?-Nougat-Creme', 11, 3, N'20 - 450 g glasses', 14.0000, 76, 0, 30, 0, NULL, NULL, NULL ), 
( 26, N'Gumb?r Gummib?rchen', 11, 3, N'100 - 250 g bags', 31.2300, 15, 0, 0, 0, NULL, NULL, NULL ), 
( 27, N'Schoggi Schokolade', 11, 3, N'100 - 100 g pieces', 43.9000, 49, 0, 30, 0, NULL, NULL, NULL ), 
( 28, N'R?ssle Sauerkraut', 12, 7, N'25 - 825 g cans', 45.6000, 26, 0, 0, 1, NULL, NULL, NULL ), 
( 29, N'Th?ringer Rostbratwurst', 12, 6, N'50 bags x 30 sausgs.', 123.7900, 0, 0, 0, 1, NULL, NULL, NULL ), 
( 30, N'Nord-Ost Matjeshering', 13, 8, N'10 - 200 g glasses', 25.8900, 10, 0, 15, 0, NULL, NULL, NULL ), 
( 31, N'Gorgonzola Telino', 14, 4, N'12 - 100 g pkgs', 12.5000, 0, 70, 20, 0, NULL, NULL, NULL ), 
( 32, N'Mascarpone Fabioli', 14, 4, N'24 - 200 g pkgs.', 32.0000, 9, 40, 25, 0, NULL, NULL, NULL ), 
( 33, N'Geitost', 15, 4, N'500 g', 2.5000, 112, 0, 20, 0, NULL, NULL, NULL ), 
( 34, N'Sasquatch Ale', 16, 1, N'24 - 12 oz bottles', 14.0000, 111, 0, 15, 0, NULL, NULL, NULL ), 
( 35, N'Steeleye Stout', 16, 1, N'24 - 12 oz bottles', 18.0000, 20, 0, 15, 0, NULL, NULL, NULL ), 
( 36, N'Inlagd Sill', 17, 8, N'24 - 250 g  jars', 19.0000, 112, 0, 20, 0, NULL, NULL, NULL ), 
( 37, N'Gravad lax', 17, 8, N'12 - 500 g pkgs.', 26.0000, 11, 50, 25, 0, NULL, NULL, NULL ), 
( 38, N'C?te de Blaye', 18, 1, N'12 - 75 cl bottles', 263.5000, 17, 0, 15, 0, NULL, NULL, NULL ), 
( 39, N'Chartreuse verte', 18, 1, N'750 cc per bottle', 18.0000, 69, 0, 5, 0, NULL, NULL, NULL ), 
( 40, N'Boston Crab Meat', 19, 8, N'24 - 4 oz tins', 18.4000, 123, 0, 30, 0, NULL, NULL, NULL ), 
( 41, N'Jack''s New England Clam Chowder', 19, 8, N'12 - 12 oz cans', 9.6500, 85, 0, 10, 0, NULL, NULL, NULL ), 
( 42, N'Singaporean Hokkien Fried Mee', 20, 5, N'32 - 1 kg pkgs.', 14.0000, 26, 0, 0, 1, NULL, NULL, NULL ), 
( 43, N'Ipoh Coffee', 20, 1, N'16 - 500 g tins', 46.0000, 17, 10, 25, 0, NULL, NULL, NULL ), 
( 44, N'Gula Malacca', 20, 2, N'20 - 2 kg bags', 19.4500, 27, 0, 15, 0, NULL, NULL, NULL ), 
( 45, N'Rogede sild', 21, 8, N'1k pkg.', 9.5000, 5, 70, 15, 0, NULL, NULL, NULL ), 
( 46, N'Spegesild', 21, 8, N'4 - 450 g glasses', 12.0000, 95, 0, 0, 0, NULL, NULL, NULL ), 
( 47, N'Zaanse koeken', 22, 3, N'10 - 4 oz boxes', 9.5000, 36, 0, 0, 0, NULL, NULL, NULL ), 
( 48, N'Chocolade', 22, 3, N'10 pkgs.', 12.7500, 15, 70, 25, 0, NULL, NULL, NULL ), 
( 49, N'Maxilaku', 23, 3, N'24 - 50 g pkgs.', 20.0000, 10, 60, 15, 0, NULL, NULL, NULL ), 
( 50, N'Valkoinen suklaa', 23, 3, N'12 - 100 g bars', 16.2500, 65, 0, 30, 0, NULL, NULL, NULL ), 
( 51, N'Manjimup Dried Apples', 24, 7, N'50 - 300 g pkgs.', 53.0000, 20, 0, 10, 0, NULL, NULL, NULL ), 
( 52, N'Filo Mix', 24, 5, N'16 - 2 kg boxes', 7.0000, 38, 0, 25, 0, NULL, NULL, NULL ), 
( 53, N'Perth Pasties', 24, 6, N'48 pieces', 32.8000, 0, 0, 0, 1, NULL, NULL, NULL ), 
( 54, N'Tourti?re', 25, 6, N'16 pies', 7.4500, 21, 0, 10, 0, NULL, NULL, NULL ), 
( 55, N'P?t? chinois', 25, 6, N'24 boxes x 2 pies', 24.0000, 115, 0, 20, 0, NULL, NULL, NULL ), 
( 56, N'Gnocchi di nonna Alice', 26, 5, N'24 - 250 g pkgs.', 38.0000, 21, 10, 30, 0, NULL, NULL, NULL ), 
( 57, N'Ravioli Angelo', 26, 5, N'24 - 250 g pkgs.', 19.5000, 36, 0, 20, 0, NULL, NULL, NULL ), 
( 58, N'Escargots de Bourgogne', 27, 8, N'24 pieces', 13.2500, 62, 0, 20, 0, NULL, NULL, NULL ), 
( 59, N'Raclette Courdavault', 28, 4, N'5 kg pkg.', 55.0000, 79, 0, 0, 0, NULL, NULL, NULL ), 
( 60, N'Camembert Pierrot', 28, 4, N'15 - 300 g rounds', 34.0000, 19, 0, 0, 0, NULL, NULL, NULL ), 
( 61, N'Sirop d''?rable', 29, 2, N'24 - 500 ml bottles', 28.5000, 113, 0, 25, 0, NULL, NULL, NULL ), 
( 62, N'Tarte au sucre', 29, 3, N'48 pies', 49.3000, 17, 0, 0, 0, NULL, NULL, NULL ), 
( 63, N'Vegie-spread', 7, 2, N'15 - 625 g jars', 43.9000, 24, 0, 5, 0, NULL, NULL, NULL ), 
( 64, N'Wimmers gute Semmelkn?del', 12, 5, N'20 bags x 4 pieces', 33.2500, 22, 80, 30, 0, NULL, NULL, NULL ), 
( 65, N'Louisiana Fiery Hot Pepper Sauce', 2, 2, N'32 - 8 oz bottles', 21.0500, 76, 0, 0, 0, NULL, NULL, NULL ), 
( 66, N'Louisiana Hot Spiced Okra', 2, 2, N'24 - 8 oz jars', 17.0000, 4, 100, 20, 0, NULL, NULL, NULL ), 
( 67, N'Laughing Lumberjack Lager', 16, 1, N'24 - 12 oz bottles', 14.0000, 52, 0, 10, 0, NULL, NULL, NULL ), 
( 68, N'Scottish Longbreads', 8, 3, N'10 boxes x 8 pieces', 12.5000, 6, 10, 15, 0, NULL, NULL, NULL ), 
( 69, N'Gudbrandsdalsost', 15, 4, N'10 kg pkg.', 36.0000, 26, 0, 15, 0, NULL, NULL, NULL ), 
( 70, N'Outback Lager', 7, 1, N'24 - 355 ml bottles', 15.0000, 15, 10, 30, 0, NULL, NULL, NULL ), 
( 71, N'Flotemysost', 15, 4, N'10 - 500 g pkgs.', 21.5000, 26, 0, 0, 0, NULL, NULL, NULL ), 
( 72, N'Mozzarella di Giovanni', 14, 4, N'24 - 200 g pkgs.', 34.8000, 14, 0, 0, 0, NULL, NULL, NULL ), 
( 73, N'R?d Kaviar', 17, 8, N'24 - 150 g jars', 15.0000, 101, 0, 5, 0, NULL, NULL, NULL ), 
( 74, N'Longlife Tofu', 4, 7, N'5 kg pkg.', 10.0000, 4, 20, 5, 0, NULL, NULL, NULL ), 
( 75, N'Rh?nbr?u Klosterbier', 12, 1, N'24 - 0.5 l bottles', 7.7500, 125, 0, 25, 0, NULL, NULL, NULL ), 
( 76, N'Lakkalik??ri', 23, 1, N'500 ml', 18.0000, 57, 0, 20, 0, NULL, NULL, NULL ), 
( 77, N'Original Frankfurter gr?ne So?e', 12, 2, N'12 boxes', 13.0000, 32, 0, 15, 0, NULL, NULL, NULL )

GO
SET IDENTITY_INSERT dbo.Products OFF
GO

-- insert order details
INSERT dbo.[Order Details]
  (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES
( 10248, 11, 14.0000, 12, 0 )
, ( 10248, 42, 9.8000, 10, 0 )
, ( 10248, 72, 34.8000, 5, 0 )
, ( 10249, 14, 18.6000, 9, 0 )
, ( 10249, 51, 42.4000, 40, 0 )
, ( 10250, 41, 7.7000, 10, 0 )
, ( 10250, 51, 42.4000, 35, 0.15 )
, ( 10250, 65, 16.8000, 15, 0.15 )
, ( 10251, 22, 16.8000, 6, 0.05 )
, ( 10251, 57, 15.6000, 15, 0.05 )
, ( 10251, 65, 16.8000, 20, 0 )
, ( 10252, 20, 64.8000, 40, 0.05 )
, ( 10252, 33, 2.0000, 25, 0.05 )
, ( 10252, 60, 27.2000, 40, 0 )
, ( 10253, 31, 10.0000, 20, 0 )
, ( 10253, 39, 14.4000, 42, 0 )
, ( 10253, 49, 16.0000, 40, 0 )
, ( 10254, 24, 3.6000, 15, 0.15 )
, ( 10254, 55, 19.2000, 21, 0.15 )
, ( 10254, 74, 8.0000, 21, 0 )
, ( 10255, 2, 15.2000, 20, 0 )
, ( 10255, 16, 13.9000, 35, 0 )
, ( 10255, 36, 15.2000, 25, 0 )
, ( 10255, 59, 44.0000, 30, 0 )
, ( 10256, 53, 26.2000, 15, 0 )
, ( 10256, 77, 10.4000, 12, 0 )
, ( 10257, 27, 35.1000, 25, 0 )
, ( 10257, 39, 14.4000, 6, 0 )
, ( 10257, 77, 10.4000, 15, 0 )
, ( 10258, 2, 15.2000, 50, 0.2 )
, ( 10258, 5, 17.0000, 65, 0.2 )
, ( 10258, 32, 25.6000, 6, 0.2 )
, ( 10259, 21, 8.0000, 10, 0 )
, ( 10259, 37, 20.8000, 1, 0 )
, ( 10260, 41, 7.7000, 16, 0.25 )
, ( 10260, 57, 15.6000, 50, 0 )
, ( 10260, 62, 39.4000, 15, 0.25 )
, ( 10260, 70, 12.0000, 21, 0.25 )
, ( 10261, 21, 8.0000, 20, 0 )
, ( 10261, 35, 14.4000, 20, 0 )
, ( 10262, 5, 17.0000, 12, 0.2 )
, ( 10262, 7, 24.0000, 15, 0 )
, ( 10262, 56, 30.4000, 2, 0 )
, ( 10263, 16, 13.9000, 60, 0.25 )
, ( 10263, 24, 3.6000, 28, 0 )
, ( 10263, 30, 20.7000, 60, 0.25 )
, ( 10263, 74, 8.0000, 36, 0.25 )
, ( 10264, 2, 15.2000, 35, 0 )
, ( 10264, 41, 7.7000, 25, 0.15 )
, ( 10265, 17, 31.2000, 30, 0 )
, ( 10265, 70, 12.0000, 20, 0 )
, ( 10266, 12, 30.4000, 12, 0.05 )
, ( 10267, 40, 14.7000, 50, 0 )
, ( 10267, 59, 44.0000, 70, 0.15 )
, ( 10267, 76, 14.4000, 15, 0.15 )
, ( 10268, 29, 99.0000, 10, 0 )
, ( 10268, 72, 27.8000, 4, 0 )
, ( 10269, 33, 2.0000, 60, 0.05 )
, ( 10269, 72, 27.8000, 20, 0.05 )
, ( 10270, 36, 15.2000, 30, 0 )
, ( 10270, 43, 36.8000, 25, 0 )
, ( 10271, 33, 2.0000, 24, 0 )
, ( 10272, 20, 64.8000, 6, 0 )
, ( 10272, 31, 10.0000, 40, 0 )
, ( 10272, 72, 27.8000, 24, 0 )
, ( 10273, 10, 24.8000, 24, 0.05 )
, ( 10273, 31, 10.0000, 15, 0.05 )
, ( 10273, 33, 2.0000, 20, 0 )
, ( 10273, 40, 14.7000, 60, 0.05 )
, ( 10273, 76, 14.4000, 33, 0.05 )
, ( 10274, 71, 17.2000, 20, 0 )
, ( 10274, 72, 27.8000, 7, 0 )
, ( 10275, 24, 3.6000, 12, 0.05 )
, ( 10275, 59, 44.0000, 6, 0.05 )
, ( 10276, 10, 24.8000, 15, 0 )
, ( 10276, 13, 4.8000, 10, 0 )
, ( 10277, 28, 36.4000, 20, 0 )
, ( 10277, 62, 39.4000, 12, 0 )
, ( 10278, 44, 15.5000, 16, 0 )
, ( 10278, 59, 44.0000, 15, 0 )
, ( 10278, 63, 35.1000, 8, 0 )
, ( 10278, 73, 12.0000, 25, 0 )
, ( 10279, 17, 31.2000, 15, 0.25 )
, ( 10280, 24, 3.6000, 12, 0 )
, ( 10280, 55, 19.2000, 20, 0 )
, ( 10280, 75, 6.2000, 30, 0 )
, ( 10281, 19, 7.3000, 1, 0 )
, ( 10281, 24, 3.6000, 6, 0 )
, ( 10281, 35, 14.4000, 4, 0 )
, ( 10282, 30, 20.7000, 6, 0 )
, ( 10282, 57, 15.6000, 2, 0 )
, ( 10283, 15, 12.4000, 20, 0 )
, ( 10283, 19, 7.3000, 18, 0 )
, ( 10283, 60, 27.2000, 35, 0 )
, ( 10283, 72, 27.8000, 3, 0 )
, ( 10284, 27, 35.1000, 15, 0.25 )
, ( 10284, 44, 15.5000, 21, 0 )
, ( 10284, 60, 27.2000, 20, 0.25 )
, ( 10284, 67, 11.2000, 5, 0.25 )
, ( 10285, 1, 14.4000, 45, 0.2 )
, ( 10285, 40, 14.7000, 40, 0.2 )
, ( 10285, 53, 26.2000, 36, 0.2 )
, ( 10286, 35, 14.4000, 100, 0 )
, ( 10286, 62, 39.4000, 40, 0 )
, ( 10287, 16, 13.9000, 40, 0.15 )
, ( 10287, 34, 11.2000, 20, 0 )
, ( 10287, 46, 9.6000, 15, 0.15 )
, ( 10288, 54, 5.9000, 10, 0.1 )
, ( 10288, 68, 10.0000, 3, 0.1 )
, ( 10289, 3, 8.0000, 30, 0 )
, ( 10289, 64, 26.6000, 9, 0 )
, ( 10290, 5, 17.0000, 20, 0 )
, ( 10290, 29, 99.0000, 15, 0 )
, ( 10290, 49, 16.0000, 15, 0 )
, ( 10290, 77, 10.4000, 10, 0 )
, ( 10291, 13, 4.8000, 20, 0.1 )
, ( 10291, 44, 15.5000, 24, 0.1 )
, ( 10291, 51, 42.4000, 2, 0.1 )
, ( 10292, 20, 64.8000, 20, 0 )
, ( 10293, 18, 50.0000, 12, 0 )
, ( 10293, 24, 3.6000, 10, 0 )
, ( 10293, 63, 35.1000, 5, 0 )
, ( 10293, 75, 6.2000, 6, 0 )
, ( 10294, 1, 14.4000, 18, 0 )
, ( 10294, 17, 31.2000, 15, 0 )
, ( 10294, 43, 36.8000, 15, 0 )
, ( 10294, 60, 27.2000, 21, 0 )
, ( 10294, 75, 6.2000, 6, 0 )
, ( 10295, 56, 30.4000, 4, 0 )
, ( 10296, 11, 16.8000, 12, 0 )
, ( 10296, 16, 13.9000, 30, 0 )
, ( 10296, 69, 28.8000, 15, 0 )
, ( 10297, 39, 14.4000, 60, 0 )
, ( 10297, 72, 27.8000, 20, 0 )
GO
INSERT dbo.[Order Details]
  (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES
 ( 10298, 2, 15.2000, 40, 0 )
, ( 10298, 36, 15.2000, 40, 0.25 )
, ( 10298, 59, 44.0000, 30, 0.25 )
, ( 10298, 62, 39.4000, 15, 0 )
, ( 10299, 19, 7.3000, 15, 0 )
, ( 10299, 70, 12.0000, 20, 0 )
, ( 10300, 66, 13.6000, 30, 0 )
, ( 10300, 68, 10.0000, 20, 0 )
, ( 10301, 40, 14.7000, 10, 0 )
, ( 10301, 56, 30.4000, 20, 0 )
, ( 10302, 17, 31.2000, 40, 0 )
, ( 10302, 28, 36.4000, 28, 0 )
, ( 10302, 43, 36.8000, 12, 0 )
, ( 10303, 40, 14.7000, 40, 0.1 )
, ( 10303, 65, 16.8000, 30, 0.1 )
, ( 10303, 68, 10.0000, 15, 0.1 )
, ( 10304, 49, 16.0000, 30, 0 )
, ( 10304, 59, 44.0000, 10, 0 )
, ( 10304, 71, 17.2000, 2, 0 )
, ( 10305, 18, 50.0000, 25, 0.1 )
, ( 10305, 29, 99.0000, 25, 0.1 )
, ( 10305, 39, 14.4000, 30, 0.1 )
, ( 10306, 30, 20.7000, 10, 0 )
, ( 10306, 53, 26.2000, 10, 0 )
, ( 10306, 54, 5.9000, 5, 0 )
, ( 10307, 62, 39.4000, 10, 0 )
, ( 10307, 68, 10.0000, 3, 0 )
, ( 10308, 69, 28.8000, 1, 0 )
, ( 10308, 70, 12.0000, 5, 0 )
, ( 10309, 4, 17.6000, 20, 0 )
, ( 10309, 6, 20.0000, 30, 0 )
, ( 10309, 42, 11.2000, 2, 0 )
, ( 10309, 43, 36.8000, 20, 0 )
, ( 10309, 71, 17.2000, 3, 0 )
, ( 10310, 16, 13.9000, 10, 0 )
, ( 10310, 62, 39.4000, 5, 0 )
, ( 10311, 42, 11.2000, 6, 0 )
, ( 10311, 69, 28.8000, 7, 0 )
, ( 10312, 28, 36.4000, 4, 0 )
, ( 10312, 43, 36.8000, 24, 0 )
, ( 10312, 53, 26.2000, 20, 0 )
, ( 10312, 75, 6.2000, 10, 0 )
, ( 10313, 36, 15.2000, 12, 0 )
, ( 10314, 32, 25.6000, 40, 0.1 )
, ( 10314, 58, 10.6000, 30, 0.1 )
, ( 10314, 62, 39.4000, 25, 0.1 )
, ( 10315, 34, 11.2000, 14, 0 )
, ( 10315, 70, 12.0000, 30, 0 )
, ( 10316, 41, 7.7000, 10, 0 )
, ( 10316, 62, 39.4000, 70, 0 )
, ( 10317, 1, 14.4000, 20, 0 )
, ( 10318, 41, 7.7000, 20, 0 )
, ( 10318, 76, 14.4000, 6, 0 )
, ( 10319, 17, 31.2000, 8, 0 )
, ( 10319, 28, 36.4000, 14, 0 )
, ( 10319, 76, 14.4000, 30, 0 )
, ( 10320, 71, 17.2000, 30, 0 )
, ( 10321, 35, 14.4000, 10, 0 )
, ( 10322, 52, 5.6000, 20, 0 )
, ( 10323, 15, 12.4000, 5, 0 )
, ( 10323, 25, 11.2000, 4, 0 )
, ( 10323, 39, 14.4000, 4, 0 )
, ( 10324, 16, 13.9000, 21, 0.15 )
, ( 10324, 35, 14.4000, 70, 0.15 )
, ( 10324, 46, 9.6000, 30, 0 )
, ( 10324, 59, 44.0000, 40, 0.15 )
, ( 10324, 63, 35.1000, 80, 0.15 )
, ( 10325, 6, 20.0000, 6, 0 )
, ( 10325, 13, 4.8000, 12, 0 )
, ( 10325, 14, 18.6000, 9, 0 )
, ( 10325, 31, 10.0000, 4, 0 )
, ( 10325, 72, 27.8000, 40, 0 )
, ( 10326, 4, 17.6000, 24, 0 )
, ( 10326, 57, 15.6000, 16, 0 )
, ( 10326, 75, 6.2000, 50, 0 )
, ( 10327, 2, 15.2000, 25, 0.2 )
, ( 10327, 11, 16.8000, 50, 0.2 )
, ( 10327, 30, 20.7000, 35, 0.2 )
, ( 10327, 58, 10.6000, 30, 0.2 )
, ( 10328, 59, 44.0000, 9, 0 )
, ( 10328, 65, 16.8000, 40, 0 )
, ( 10328, 68, 10.0000, 10, 0 )
, ( 10329, 19, 7.3000, 10, 0.05 )
, ( 10329, 30, 20.7000, 8, 0.05 )
, ( 10329, 38, 210.8000, 20, 0.05 )
, ( 10329, 56, 30.4000, 12, 0.05 )
, ( 10330, 26, 24.9000, 50, 0.15 )
, ( 10330, 72, 27.8000, 25, 0.15 )
, ( 10331, 54, 5.9000, 15, 0 )
, ( 10332, 18, 50.0000, 40, 0.2 )
, ( 10332, 42, 11.2000, 10, 0.2 )
, ( 10332, 47, 7.6000, 16, 0.2 )
, ( 10333, 14, 18.6000, 10, 0 )
, ( 10333, 21, 8.0000, 10, 0.1 )
, ( 10333, 71, 17.2000, 40, 0.1 )
, ( 10334, 52, 5.6000, 8, 0 )
, ( 10334, 68, 10.0000, 10, 0 )
, ( 10335, 2, 15.2000, 7, 0.2 )
, ( 10335, 31, 10.0000, 25, 0.2 )
, ( 10335, 32, 25.6000, 6, 0.2 )
, ( 10335, 51, 42.4000, 48, 0.2 )
, ( 10336, 4, 17.6000, 18, 0.1 )
, ( 10337, 23, 7.2000, 40, 0 )
, ( 10337, 26, 24.9000, 24, 0 )
, ( 10337, 36, 15.2000, 20, 0 )
, ( 10337, 37, 20.8000, 28, 0 )
, ( 10337, 72, 27.8000, 25, 0 )
, ( 10338, 17, 31.2000, 20, 0 )
, ( 10338, 30, 20.7000, 15, 0 )
, ( 10339, 4, 17.6000, 10, 0 )
, ( 10339, 17, 31.2000, 70, 0.05 )
, ( 10339, 62, 39.4000, 28, 0 )
, ( 10340, 18, 50.0000, 20, 0.05 )
, ( 10340, 41, 7.7000, 12, 0.05 )
, ( 10340, 43, 36.8000, 40, 0.05 )
, ( 10341, 33, 2.0000, 8, 0 )
, ( 10341, 59, 44.0000, 9, 0.15 )
, ( 10342, 2, 15.2000, 24, 0.2 )
, ( 10342, 31, 10.0000, 56, 0.2 )
, ( 10342, 36, 15.2000, 40, 0.2 )
, ( 10342, 55, 19.2000, 40, 0.2 )
, ( 10343, 64, 26.6000, 50, 0 )
, ( 10343, 68, 10.0000, 4, 0.05 )
, ( 10343, 76, 14.4000, 15, 0 )
, ( 10344, 4, 17.6000, 35, 0 )
, ( 10344, 8, 32.0000, 70, 0.25 )
, ( 10345, 8, 32.0000, 70, 0 )
, ( 10345, 19, 7.3000, 80, 0 )
, ( 10345, 42, 11.2000, 9, 0 )
, ( 10346, 17, 31.2000, 36, 0.1 )
, ( 10346, 56, 30.4000, 20, 0 )
, ( 10347, 25, 11.2000, 10, 0 )
, ( 10347, 39, 14.4000, 50, 0.15 )
, ( 10347, 40, 14.7000, 4, 0 )
, ( 10347, 75, 6.2000, 6, 0.15 )
, ( 10348, 1, 14.4000, 15, 0.15 )
, ( 10348, 23, 7.2000, 25, 0 )
, ( 10349, 54, 5.9000, 24, 0 )
, ( 10350, 50, 13.0000, 15, 0.1 )
, ( 10350, 69, 28.8000, 18, 0.1 )
, ( 10351, 38, 210.8000, 20, 0.05 )
, ( 10351, 41, 7.7000, 13, 0 )
, ( 10351, 44, 15.5000, 77, 0.05 )
, ( 10351, 65, 16.8000, 10, 0.05 )
, ( 10352, 24, 3.6000, 10, 0 )
, ( 10352, 54, 5.9000, 20, 0.15 )
, ( 10353, 11, 16.8000, 12, 0.2 )
, ( 10353, 38, 210.8000, 50, 0.2 )
, ( 10354, 1, 14.4000, 12, 0 )
, ( 10354, 29, 99.0000, 4, 0 )
, ( 10355, 24, 3.6000, 25, 0 )
, ( 10355, 57, 15.6000, 25, 0 )
, ( 10356, 31, 10.0000, 30, 0 )
, ( 10356, 55, 19.2000, 12, 0 )
, ( 10356, 69, 28.8000, 20, 0 )
, ( 10357, 10, 24.8000, 30, 0.2 )
, ( 10357, 26, 24.9000, 16, 0 )
, ( 10357, 60, 27.2000, 8, 0.2 )
, ( 10358, 24, 3.6000, 10, 0.05 )
, ( 10358, 34, 11.2000, 10, 0.05 )
, ( 10358, 36, 15.2000, 20, 0.05 )
, ( 10359, 16, 13.9000, 56, 0.05 )
, ( 10359, 31, 10.0000, 70, 0.05 )
, ( 10359, 60, 27.2000, 80, 0.05 )
, ( 10360, 28, 36.4000, 30, 0 )
, ( 10360, 29, 99.0000, 35, 0 )
, ( 10360, 38, 210.8000, 10, 0 )
, ( 10360, 49, 16.0000, 35, 0 )
, ( 10360, 54, 5.9000, 28, 0 )
, ( 10361, 39, 14.4000, 54, 0.1 )
, ( 10361, 60, 27.2000, 55, 0.1 )
, ( 10362, 25, 11.2000, 50, 0 )
, ( 10362, 51, 42.4000, 20, 0 )
, ( 10362, 54, 5.9000, 24, 0 )
, ( 10363, 31, 10.0000, 20, 0 )
, ( 10363, 75, 6.2000, 12, 0 )
, ( 10363, 76, 14.4000, 12, 0 )
, ( 10364, 69, 28.8000, 30, 0 )
, ( 10364, 71, 17.2000, 5, 0 )
, ( 10365, 11, 16.8000, 24, 0 )
, ( 10366, 65, 16.8000, 5, 0 )
, ( 10366, 77, 10.4000, 5, 0 )
, ( 10367, 34, 11.2000, 36, 0 )
, ( 10367, 54, 5.9000, 18, 0 )
, ( 10367, 65, 16.8000, 15, 0 )
, ( 10367, 77, 10.4000, 7, 0 )
, ( 10368, 21, 8.0000, 5, 0.1 )
, ( 10368, 28, 36.4000, 13, 0.1 )
, ( 10368, 57, 15.6000, 25, 0 )
, ( 10368, 64, 26.6000, 35, 0.1 )
, ( 10369, 29, 99.0000, 20, 0 )
, ( 10369, 56, 30.4000, 18, 0.25 )
, ( 10370, 1, 14.4000, 15, 0.15 )
, ( 10370, 64, 26.6000, 30, 0 )
, ( 10370, 74, 8.0000, 20, 0.15 )
, ( 10371, 36, 15.2000, 6, 0.2 )
, ( 10372, 20, 64.8000, 12, 0.25 )
, ( 10372, 38, 210.8000, 40, 0.25 )
, ( 10372, 60, 27.2000, 70, 0.25 )
, ( 10372, 72, 27.8000, 42, 0.25 )
, ( 10373, 58, 10.6000, 80, 0.2 )
, ( 10373, 71, 17.2000, 50, 0.2 )
, ( 10374, 31, 10.0000, 30, 0 )
, ( 10374, 58, 10.6000, 15, 0 )
, ( 10375, 14, 18.6000, 15, 0 )
, ( 10375, 54, 5.9000, 10, 0 )
, ( 10376, 31, 10.0000, 42, 0.05 )
, ( 10377, 28, 36.4000, 20, 0.15 )
, ( 10377, 39, 14.4000, 20, 0.15 )
, ( 10378, 71, 17.2000, 6, 0 )
, ( 10379, 41, 7.7000, 8, 0.1 )
, ( 10379, 63, 35.1000, 16, 0.1 )
, ( 10379, 65, 16.8000, 20, 0.1 )
, ( 10380, 30, 20.7000, 18, 0.1 )
, ( 10380, 53, 26.2000, 20, 0.1 )
, ( 10380, 60, 27.2000, 6, 0.1 )
, ( 10380, 70, 12.0000, 30, 0 )
, ( 10381, 74, 8.0000, 14, 0 )
, ( 10382, 5, 17.0000, 32, 0 )
, ( 10382, 18, 50.0000, 9, 0 )
, ( 10382, 29, 99.0000, 14, 0 )
, ( 10382, 33, 2.0000, 60, 0 )
, ( 10382, 74, 8.0000, 50, 0 )
, ( 10383, 13, 4.8000, 20, 0 )
, ( 10383, 50, 13.0000, 15, 0 )
, ( 10383, 56, 30.4000, 20, 0 )
, ( 10384, 20, 64.8000, 28, 0 )
, ( 10384, 60, 27.2000, 15, 0 )
, ( 10385, 7, 24.0000, 10, 0.2 )
, ( 10385, 60, 27.2000, 20, 0.2 )
, ( 10385, 68, 10.0000, 8, 0.2 )
, ( 10386, 24, 3.6000, 15, 0 )
, ( 10386, 34, 11.2000, 10, 0 )
, ( 10387, 24, 3.6000, 15, 0 )
, ( 10387, 28, 36.4000, 6, 0 )
, ( 10387, 59, 44.0000, 12, 0 )
, ( 10387, 71, 17.2000, 15, 0 )
, ( 10388, 45, 7.6000, 15, 0.2 )
, ( 10388, 52, 5.6000, 20, 0.2 )
, ( 10388, 53, 26.2000, 40, 0 )
, ( 10389, 10, 24.8000, 16, 0 )
, ( 10389, 55, 19.2000, 15, 0 )
, ( 10389, 62, 39.4000, 20, 0 )
, ( 10389, 70, 12.0000, 30, 0 )
, ( 10390, 31, 10.0000, 60, 0.1 )
, ( 10390, 35, 14.4000, 40, 0.1 )
, ( 10390, 46, 9.6000, 45, 0 )
, ( 10390, 72, 27.8000, 24, 0.1 )
, ( 10391, 13, 4.8000, 18, 0 )
, ( 10392, 69, 28.8000, 50, 0 )
, ( 10393, 2, 15.2000, 25, 0.25 )
, ( 10393, 14, 18.6000, 42, 0.25 )
, ( 10393, 25, 11.2000, 7, 0.25 )
, ( 10393, 26, 24.9000, 70, 0.25 )
, ( 10393, 31, 10.0000, 32, 0 )
, ( 10394, 13, 4.8000, 10, 0 )
, ( 10394, 62, 39.4000, 10, 0 )
, ( 10395, 46, 9.6000, 28, 0.1 )
, ( 10395, 53, 26.2000, 70, 0.1 )
, ( 10395, 69, 28.8000, 8, 0 )
, ( 10396, 23, 7.2000, 40, 0 )
, ( 10396, 71, 17.2000, 60, 0 )
, ( 10396, 72, 27.8000, 21, 0 )
, ( 10397, 21, 8.0000, 10, 0.15 )
, ( 10397, 51, 42.4000, 18, 0.15 )
, ( 10398, 35, 14.4000, 30, 0 )
, ( 10398, 55, 19.2000, 120, 0.1 )
, ( 10399, 68, 10.0000, 60, 0 )
, ( 10399, 71, 17.2000, 30, 0 )
, ( 10399, 76, 14.4000, 35, 0 )
, ( 10399, 77, 10.4000, 14, 0 )
, ( 10400, 29, 99.0000, 21, 0 )
, ( 10400, 35, 14.4000, 35, 0 )
, ( 10400, 49, 16.0000, 30, 0 )
, ( 10401, 30, 20.7000, 18, 0 )
, ( 10401, 56, 30.4000, 70, 0 )
, ( 10401, 65, 16.8000, 20, 0 )
, ( 10401, 71, 17.2000, 60, 0 )
, ( 10402, 23, 7.2000, 60, 0 )
, ( 10402, 63, 35.1000, 65, 0 )
, ( 10403, 16, 13.9000, 21, 0.15 )
, ( 10403, 48, 10.2000, 70, 0.15 )
, ( 10404, 26, 24.9000, 30, 0.05 )
, ( 10404, 42, 11.2000, 40, 0.05 )
, ( 10404, 49, 16.0000, 30, 0.05 )
, ( 10405, 3, 8.0000, 50, 0 )
, ( 10406, 1, 14.4000, 10, 0 )
, ( 10406, 21, 8.0000, 30, 0.1 )
, ( 10406, 28, 36.4000, 42, 0.1 )
, ( 10406, 36, 15.2000, 5, 0.1 )
, ( 10406, 40, 14.7000, 2, 0.1 )
, ( 10407, 11, 16.8000, 30, 0 )
, ( 10407, 69, 28.8000, 15, 0 )
, ( 10407, 71, 17.2000, 15, 0 )
, ( 10408, 37, 20.8000, 10, 0 )
, ( 10408, 54, 5.9000, 6, 0 )
, ( 10408, 62, 39.4000, 35, 0 )
, ( 10409, 14, 18.6000, 12, 0 )
, ( 10409, 21, 8.0000, 12, 0 )
, ( 10410, 33, 2.0000, 49, 0 )
, ( 10410, 59, 44.0000, 16, 0 )
, ( 10411, 41, 7.7000, 25, 0.2 )
, ( 10411, 44, 15.5000, 40, 0.2 )
, ( 10411, 59, 44.0000, 9, 0.2 )
, ( 10412, 14, 18.6000, 20, 0.1 )
, ( 10413, 1, 14.4000, 24, 0 )
, ( 10413, 62, 39.4000, 40, 0 )
, ( 10413, 76, 14.4000, 14, 0 )
, ( 10414, 19, 7.3000, 18, 0.05 )
, ( 10414, 33, 2.0000, 50, 0 )
, ( 10415, 17, 31.2000, 2, 0 )
, ( 10415, 33, 2.0000, 20, 0 )
, ( 10416, 19, 7.3000, 20, 0 )
, ( 10416, 53, 26.2000, 10, 0 )
, ( 10416, 57, 15.6000, 20, 0 )
, ( 10417, 38, 210.8000, 50, 0 )
, ( 10417, 46, 9.6000, 2, 0.25 )
, ( 10417, 68, 10.0000, 36, 0.25 )
, ( 10417, 77, 10.4000, 35, 0 )
, ( 10418, 2, 15.2000, 60, 0 )
, ( 10418, 47, 7.6000, 55, 0 )
, ( 10418, 61, 22.8000, 16, 0 )
, ( 10418, 74, 8.0000, 15, 0 )
, ( 10419, 60, 27.2000, 60, 0.05 )
, ( 10419, 69, 28.8000, 20, 0.05 )
, ( 10420, 9, 77.6000, 20, 0.1 )
, ( 10420, 13, 4.8000, 2, 0.1 )
, ( 10420, 70, 12.0000, 8, 0.1 )
, ( 10420, 73, 12.0000, 20, 0.1 )
, ( 10421, 19, 7.3000, 4, 0.15 )
, ( 10421, 26, 24.9000, 30, 0 )
, ( 10421, 53, 26.2000, 15, 0.15 )
, ( 10421, 77, 10.4000, 10, 0.15 )
, ( 10422, 26, 24.9000, 2, 0 )
, ( 10423, 31, 10.0000, 14, 0 )
, ( 10423, 59, 44.0000, 20, 0 )
, ( 10424, 35, 14.4000, 60, 0.2 )
, ( 10424, 38, 210.8000, 49, 0.2 )
, ( 10424, 68, 10.0000, 30, 0.2 )
, ( 10425, 55, 19.2000, 10, 0.25 )
, ( 10425, 76, 14.4000, 20, 0.25 )
, ( 10426, 56, 30.4000, 5, 0 )
, ( 10426, 64, 26.6000, 7, 0 )
, ( 10427, 14, 18.6000, 35, 0 )
, ( 10428, 46, 9.6000, 20, 0 )
, ( 10429, 50, 13.0000, 40, 0 )
, ( 10429, 63, 35.1000, 35, 0.25 )
, ( 10430, 17, 31.2000, 45, 0.2 )
, ( 10430, 21, 8.0000, 50, 0 )
, ( 10430, 56, 30.4000, 30, 0 )
, ( 10430, 59, 44.0000, 70, 0.2 )
, ( 10431, 17, 31.2000, 50, 0.25 )
, ( 10431, 40, 14.7000, 50, 0.25 )
, ( 10431, 47, 7.6000, 30, 0.25 )
, ( 10432, 26, 24.9000, 10, 0 )
, ( 10432, 54, 5.9000, 40, 0 )
, ( 10433, 56, 30.4000, 28, 0 )
, ( 10434, 11, 16.8000, 6, 0 )
, ( 10434, 76, 14.4000, 18, 0.15 )
, ( 10435, 2, 15.2000, 10, 0 )
, ( 10435, 22, 16.8000, 12, 0 )
, ( 10435, 72, 27.8000, 10, 0 )
, ( 10436, 46, 9.6000, 5, 0 )
, ( 10436, 56, 30.4000, 40, 0.1 )
, ( 10436, 64, 26.6000, 30, 0.1 )
, ( 10436, 75, 6.2000, 24, 0.1 )
, ( 10437, 53, 26.2000, 15, 0 )
, ( 10438, 19, 7.3000, 15, 0.2 )
, ( 10438, 34, 11.2000, 20, 0.2 )
, ( 10438, 57, 15.6000, 15, 0.2 )
, ( 10439, 12, 30.4000, 15, 0 )
, ( 10439, 16, 13.9000, 16, 0 )
, ( 10439, 64, 26.6000, 6, 0 )
, ( 10439, 74, 8.0000, 30, 0 )
, ( 10440, 2, 15.2000, 45, 0.15 )
, ( 10440, 16, 13.9000, 49, 0.15 )
, ( 10440, 29, 99.0000, 24, 0.15 )
, ( 10440, 61, 22.8000, 90, 0.15 )
, ( 10441, 27, 35.1000, 50, 0 )
, ( 10442, 11, 16.8000, 30, 0 )
, ( 10442, 54, 5.9000, 80, 0 )
, ( 10442, 66, 13.6000, 60, 0 )
, ( 10443, 11, 16.8000, 6, 0.2 )
, ( 10443, 28, 36.4000, 12, 0 )
, ( 10444, 17, 31.2000, 10, 0 )
, ( 10444, 26, 24.9000, 15, 0 )
, ( 10444, 35, 14.4000, 8, 0 )
, ( 10444, 41, 7.7000, 30, 0 )
, ( 10445, 39, 14.4000, 6, 0 )
, ( 10445, 54, 5.9000, 15, 0 )
, ( 10446, 19, 7.3000, 12, 0.1 )
, ( 10446, 24, 3.6000, 20, 0.1 )
, ( 10446, 31, 10.0000, 3, 0.1 )
, ( 10446, 52, 5.6000, 15, 0.1 )
, ( 10447, 19, 7.3000, 40, 0 )
, ( 10447, 65, 16.8000, 35, 0 )
, ( 10447, 71, 17.2000, 2, 0 )
, ( 10448, 26, 24.9000, 6, 0 )
, ( 10448, 40, 14.7000, 20, 0 )
, ( 10449, 10, 24.8000, 14, 0 )
, ( 10449, 52, 5.6000, 20, 0 )
, ( 10449, 62, 39.4000, 35, 0 )
, ( 10450, 10, 24.8000, 20, 0.2 )
, ( 10450, 54, 5.9000, 6, 0.2 )
, ( 10451, 55, 19.2000, 120, 0.1 )
, ( 10451, 64, 26.6000, 35, 0.1 )
, ( 10451, 65, 16.8000, 28, 0.1 )
, ( 10451, 77, 10.4000, 55, 0.1 )
, ( 10452, 28, 36.4000, 15, 0 )
, ( 10452, 44, 15.5000, 100, 0.05 )
, ( 10453, 48, 10.2000, 15, 0.1 )
, ( 10453, 70, 12.0000, 25, 0.1 )
, ( 10454, 16, 13.9000, 20, 0.2 )
, ( 10454, 33, 2.0000, 20, 0.2 )
, ( 10454, 46, 9.6000, 10, 0.2 )
, ( 10455, 39, 14.4000, 20, 0 )
, ( 10455, 53, 26.2000, 50, 0 )
, ( 10455, 61, 22.8000, 25, 0 )
, ( 10455, 71, 17.2000, 30, 0 )
, ( 10456, 21, 8.0000, 40, 0.15 )
, ( 10456, 49, 16.0000, 21, 0.15 )
, ( 10457, 59, 44.0000, 36, 0 )
, ( 10458, 26, 24.9000, 30, 0 )
, ( 10458, 28, 36.4000, 30, 0 )
, ( 10458, 43, 36.8000, 20, 0 )
, ( 10458, 56, 30.4000, 15, 0 )
, ( 10458, 71, 17.2000, 50, 0 )
, ( 10459, 7, 24.0000, 16, 0.05 )
, ( 10459, 46, 9.6000, 20, 0.05 )
, ( 10459, 72, 27.8000, 40, 0 )
, ( 10460, 68, 10.0000, 21, 0.25 )
, ( 10460, 75, 6.2000, 4, 0.25 )
, ( 10461, 21, 8.0000, 40, 0.25 )
, ( 10461, 30, 20.7000, 28, 0.25 )
, ( 10461, 55, 19.2000, 60, 0.25 )
, ( 10462, 13, 4.8000, 1, 0 )
, ( 10462, 23, 7.2000, 21, 0 )
, ( 10463, 19, 7.3000, 21, 0 )
, ( 10463, 42, 11.2000, 50, 0 )
, ( 10464, 4, 17.6000, 16, 0.2 )
, ( 10464, 43, 36.8000, 3, 0 )
, ( 10464, 56, 30.4000, 30, 0.2 )
, ( 10464, 60, 27.2000, 20, 0 )
, ( 10465, 24, 3.6000, 25, 0 )
, ( 10465, 29, 99.0000, 18, 0.1 )
, ( 10465, 40, 14.7000, 20, 0 )
, ( 10465, 45, 7.6000, 30, 0.1 )
, ( 10465, 50, 13.0000, 25, 0 )
, ( 10466, 11, 16.8000, 10, 0 )
, ( 10466, 46, 9.6000, 5, 0 )
, ( 10467, 24, 3.6000, 28, 0 )
, ( 10467, 25, 11.2000, 12, 0 )
, ( 10468, 30, 20.7000, 8, 0 )
, ( 10468, 43, 36.8000, 15, 0 )
, ( 10469, 2, 15.2000, 40, 0.15 )
, ( 10469, 16, 13.9000, 35, 0.15 )
, ( 10469, 44, 15.5000, 2, 0.15 )
, ( 10470, 18, 50.0000, 30, 0 )
, ( 10470, 23, 7.2000, 15, 0 )
, ( 10470, 64, 26.6000, 8, 0 )
, ( 10471, 7, 24.0000, 30, 0 )
, ( 10471, 56, 30.4000, 20, 0 )
, ( 10472, 24, 3.6000, 80, 0.05 )
, ( 10472, 51, 42.4000, 18, 0 )
, ( 10473, 33, 2.0000, 12, 0 )
, ( 10473, 71, 17.2000, 12, 0 )
, ( 10474, 14, 18.6000, 12, 0 )
, ( 10474, 28, 36.4000, 18, 0 )
, ( 10474, 40, 14.7000, 21, 0 )
, ( 10474, 75, 6.2000, 10, 0 )
, ( 10475, 31, 10.0000, 35, 0.15 )
, ( 10475, 66, 13.6000, 60, 0.15 )
, ( 10475, 76, 14.4000, 42, 0.15 )
, ( 10476, 55, 19.2000, 2, 0.05 )
, ( 10476, 70, 12.0000, 12, 0 )
, ( 10477, 1, 14.4000, 15, 0 )
, ( 10477, 21, 8.0000, 21, 0.25 )
, ( 10477, 39, 14.4000, 20, 0.25 )
, ( 10478, 10, 24.8000, 20, 0.05 )
, ( 10479, 38, 210.8000, 30, 0 )
, ( 10479, 53, 26.2000, 28, 0 )
, ( 10479, 59, 44.0000, 60, 0 )
, ( 10479, 64, 26.6000, 30, 0 )
, ( 10480, 47, 7.6000, 30, 0 )
, ( 10480, 59, 44.0000, 12, 0 )
, ( 10481, 49, 16.0000, 24, 0 )
, ( 10481, 60, 27.2000, 40, 0 )
, ( 10482, 40, 14.7000, 10, 0 )
, ( 10483, 34, 11.2000, 35, 0.05 )
, ( 10483, 77, 10.4000, 30, 0.05 )
, ( 10484, 21, 8.0000, 14, 0 )
, ( 10484, 40, 14.7000, 10, 0 )
, ( 10484, 51, 42.4000, 3, 0 )
, ( 10485, 2, 15.2000, 20, 0.1 )
, ( 10485, 3, 8.0000, 20, 0.1 )
, ( 10485, 55, 19.2000, 30, 0.1 )
, ( 10485, 70, 12.0000, 60, 0.1 )
, ( 10486, 11, 16.8000, 5, 0 )
, ( 10486, 51, 42.4000, 25, 0 )
, ( 10486, 74, 8.0000, 16, 0 )
, ( 10487, 19, 7.3000, 5, 0 )
, ( 10487, 26, 24.9000, 30, 0 )
, ( 10487, 54, 5.9000, 24, 0.25 )
, ( 10488, 59, 44.0000, 30, 0 )
, ( 10488, 73, 12.0000, 20, 0.2 )
, ( 10489, 11, 16.8000, 15, 0.25 )
, ( 10489, 16, 13.9000, 18, 0 )
, ( 10490, 59, 44.0000, 60, 0 )
, ( 10490, 68, 10.0000, 30, 0 )
, ( 10490, 75, 6.2000, 36, 0 )
, ( 10491, 44, 15.5000, 15, 0.15 )
, ( 10491, 77, 10.4000, 7, 0.15 )
, ( 10492, 25, 11.2000, 60, 0.05 )
, ( 10492, 42, 11.2000, 20, 0.05 )
, ( 10493, 65, 16.8000, 15, 0.1 )
, ( 10493, 66, 13.6000, 10, 0.1 )
, ( 10493, 69, 28.8000, 10, 0.1 )
, ( 10494, 56, 30.4000, 30, 0 )
, ( 10495, 23, 7.2000, 10, 0 )
, ( 10495, 41, 7.7000, 20, 0 )
, ( 10495, 77, 10.4000, 5, 0 )
, ( 10496, 31, 10.0000, 20, 0.05 )
, ( 10497, 56, 30.4000, 14, 0 )
, ( 10497, 72, 27.8000, 25, 0 )
, ( 10497, 77, 10.4000, 25, 0 )
, ( 10498, 24, 4.5000, 14, 0 )
, ( 10498, 40, 18.4000, 5, 0 )
, ( 10498, 42, 14.0000, 30, 0 )
, ( 10499, 28, 45.6000, 20, 0 )
, ( 10499, 49, 20.0000, 25, 0 )
, ( 10500, 15, 15.5000, 12, 0.05 )
, ( 10500, 28, 45.6000, 8, 0.05 )
, ( 10501, 54, 7.4500, 20, 0 )
, ( 10502, 45, 9.5000, 21, 0 )
, ( 10502, 53, 32.8000, 6, 0 )
, ( 10502, 67, 14.0000, 30, 0 )
, ( 10503, 14, 23.2500, 70, 0 )
, ( 10503, 65, 21.0500, 20, 0 )
, ( 10504, 2, 19.0000, 12, 0 )
, ( 10504, 21, 10.0000, 12, 0 )
, ( 10504, 53, 32.8000, 10, 0 )
, ( 10504, 61, 28.5000, 25, 0 )
, ( 10505, 62, 49.3000, 3, 0 )
, ( 10506, 25, 14.0000, 18, 0.1 )
, ( 10506, 70, 15.0000, 14, 0.1 )
, ( 10507, 43, 46.0000, 15, 0.15 )
, ( 10507, 48, 12.7500, 15, 0.15 )
GO
INSERT dbo.[Order Details]
  (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES
( 10508, 13, 6.0000, 10, 0 )
, ( 10508, 39, 18.0000, 10, 0 )
, ( 10509, 28, 45.6000, 3, 0 )
, ( 10510, 29, 123.7900, 36, 0 )
, ( 10510, 75, 7.7500, 36, 0.1 )
, ( 10511, 4, 22.0000, 50, 0.15 )
, ( 10511, 7, 30.0000, 50, 0.15 )
, ( 10511, 8, 40.0000, 10, 0.15 )
, ( 10512, 24, 4.5000, 10, 0.15 )
, ( 10512, 46, 12.0000, 9, 0.15 )
, ( 10512, 47, 9.5000, 6, 0.15 )
, ( 10512, 60, 34.0000, 12, 0.15 )
, ( 10513, 21, 10.0000, 40, 0.2 )
, ( 10513, 32, 32.0000, 50, 0.2 )
, ( 10513, 61, 28.5000, 15, 0.2 )
, ( 10514, 20, 81.0000, 39, 0 )
, ( 10514, 28, 45.6000, 35, 0 )
, ( 10514, 56, 38.0000, 70, 0 )
, ( 10514, 65, 21.0500, 39, 0 )
, ( 10514, 75, 7.7500, 50, 0 )
, ( 10515, 9, 97.0000, 16, 0.15 )
, ( 10515, 16, 17.4500, 50, 0 )
, ( 10515, 27, 43.9000, 120, 0 )
, ( 10515, 33, 2.5000, 16, 0.15 )
, ( 10515, 60, 34.0000, 84, 0.15 )
, ( 10516, 18, 62.5000, 25, 0.1 )
, ( 10516, 41, 9.6500, 80, 0.1 )
, ( 10516, 42, 14.0000, 20, 0 )
, ( 10517, 52, 7.0000, 6, 0 )
, ( 10517, 59, 55.0000, 4, 0 )
, ( 10517, 70, 15.0000, 6, 0 )
, ( 10518, 24, 4.5000, 5, 0 )
, ( 10518, 38, 263.5000, 15, 0 )
, ( 10518, 44, 19.4500, 9, 0 )
, ( 10519, 10, 31.0000, 16, 0.05 )
, ( 10519, 56, 38.0000, 40, 0 )
, ( 10519, 60, 34.0000, 10, 0.05 )
, ( 10520, 24, 4.5000, 8, 0 )
, ( 10520, 53, 32.8000, 5, 0 )
, ( 10521, 35, 18.0000, 3, 0 )
, ( 10521, 41, 9.6500, 10, 0 )
, ( 10521, 68, 12.5000, 6, 0 )
, ( 10522, 1, 18.0000, 40, 0.2 )
, ( 10522, 8, 40.0000, 24, 0 )
, ( 10522, 30, 25.8900, 20, 0.2 )
, ( 10522, 40, 18.4000, 25, 0.2 )
, ( 10523, 17, 39.0000, 25, 0.1 )
, ( 10523, 20, 81.0000, 15, 0.1 )
, ( 10523, 37, 26.0000, 18, 0.1 )
, ( 10523, 41, 9.6500, 6, 0.1 )
, ( 10524, 10, 31.0000, 2, 0 )
, ( 10524, 30, 25.8900, 10, 0 )
, ( 10524, 43, 46.0000, 60, 0 )
, ( 10524, 54, 7.4500, 15, 0 )
, ( 10525, 36, 19.0000, 30, 0 )
, ( 10525, 40, 18.4000, 15, 0.1 )
, ( 10526, 1, 18.0000, 8, 0.15 )
, ( 10526, 13, 6.0000, 10, 0 )
, ( 10526, 56, 38.0000, 30, 0.15 )
, ( 10527, 4, 22.0000, 50, 0.1 )
, ( 10527, 36, 19.0000, 30, 0.1 )
, ( 10528, 11, 21.0000, 3, 0 )
, ( 10528, 33, 2.5000, 8, 0.2 )
, ( 10528, 72, 34.8000, 9, 0 )
, ( 10529, 55, 24.0000, 14, 0 )
, ( 10529, 68, 12.5000, 20, 0 )
, ( 10529, 69, 36.0000, 10, 0 )
, ( 10530, 17, 39.0000, 40, 0 )
, ( 10530, 43, 46.0000, 25, 0 )
, ( 10530, 61, 28.5000, 20, 0 )
, ( 10530, 76, 18.0000, 50, 0 )
, ( 10531, 59, 55.0000, 2, 0 )
, ( 10532, 30, 25.8900, 15, 0 )
, ( 10532, 66, 17.0000, 24, 0 )
, ( 10533, 4, 22.0000, 50, 0.05 )
, ( 10533, 72, 34.8000, 24, 0 )
, ( 10533, 73, 15.0000, 24, 0.05 )
, ( 10534, 30, 25.8900, 10, 0 )
, ( 10534, 40, 18.4000, 10, 0.2 )
, ( 10534, 54, 7.4500, 10, 0.2 )
, ( 10535, 11, 21.0000, 50, 0.1 )
, ( 10535, 40, 18.4000, 10, 0.1 )
, ( 10535, 57, 19.5000, 5, 0.1 )
, ( 10535, 59, 55.0000, 15, 0.1 )
, ( 10536, 12, 38.0000, 15, 0.25 )
, ( 10536, 31, 12.5000, 20, 0 )
, ( 10536, 33, 2.5000, 30, 0 )
, ( 10536, 60, 34.0000, 35, 0.25 )
, ( 10537, 31, 12.5000, 30, 0 )
, ( 10537, 51, 53.0000, 6, 0 )
, ( 10537, 58, 13.2500, 20, 0 )
, ( 10537, 72, 34.8000, 21, 0 )
, ( 10537, 73, 15.0000, 9, 0 )
, ( 10538, 70, 15.0000, 7, 0 )
, ( 10538, 72, 34.8000, 1, 0 )
, ( 10539, 13, 6.0000, 8, 0 )
, ( 10539, 21, 10.0000, 15, 0 )
, ( 10539, 33, 2.5000, 15, 0 )
, ( 10539, 49, 20.0000, 6, 0 )
, ( 10540, 3, 10.0000, 60, 0 )
, ( 10540, 26, 31.2300, 40, 0 )
, ( 10540, 38, 263.5000, 30, 0 )
, ( 10540, 68, 12.5000, 35, 0 )
, ( 10541, 24, 4.5000, 35, 0.1 )
, ( 10541, 38, 263.5000, 4, 0.1 )
, ( 10541, 65, 21.0500, 36, 0.1 )
, ( 10541, 71, 21.5000, 9, 0.1 )
, ( 10542, 11, 21.0000, 15, 0.05 )
, ( 10542, 54, 7.4500, 24, 0.05 )
, ( 10543, 12, 38.0000, 30, 0.15 )
, ( 10543, 23, 9.0000, 70, 0.15 )
, ( 10544, 28, 45.6000, 7, 0 )
, ( 10544, 67, 14.0000, 7, 0 )
, ( 10545, 11, 21.0000, 10, 0 )
, ( 10546, 7, 30.0000, 10, 0 )
, ( 10546, 35, 18.0000, 30, 0 )
, ( 10546, 62, 49.3000, 40, 0 )
, ( 10547, 32, 32.0000, 24, 0.15 )
, ( 10547, 36, 19.0000, 60, 0 )
, ( 10548, 34, 14.0000, 10, 0.25 )
, ( 10548, 41, 9.6500, 14, 0 )
, ( 10549, 31, 12.5000, 55, 0.15 )
, ( 10549, 45, 9.5000, 100, 0.15 )
, ( 10549, 51, 53.0000, 48, 0.15 )
, ( 10550, 17, 39.0000, 8, 0.1 )
, ( 10550, 19, 9.2000, 10, 0 )
, ( 10550, 21, 10.0000, 6, 0.1 )
, ( 10550, 61, 28.5000, 10, 0.1 )
, ( 10551, 16, 17.4500, 40, 0.15 )
, ( 10551, 35, 18.0000, 20, 0.15 )
, ( 10551, 44, 19.4500, 40, 0 )
, ( 10552, 69, 36.0000, 18, 0 )
, ( 10552, 75, 7.7500, 30, 0 )
, ( 10553, 11, 21.0000, 15, 0 )
, ( 10553, 16, 17.4500, 14, 0 )
, ( 10553, 22, 21.0000, 24, 0 )
, ( 10553, 31, 12.5000, 30, 0 )
, ( 10553, 35, 18.0000, 6, 0 )
, ( 10554, 16, 17.4500, 30, 0.05 )
, ( 10554, 23, 9.0000, 20, 0.05 )
, ( 10554, 62, 49.3000, 20, 0.05 )
, ( 10554, 77, 13.0000, 10, 0.05 )
, ( 10555, 14, 23.2500, 30, 0.2 )
, ( 10555, 19, 9.2000, 35, 0.2 )
, ( 10555, 24, 4.5000, 18, 0.2 )
, ( 10555, 51, 53.0000, 20, 0.2 )
, ( 10555, 56, 38.0000, 40, 0.2 )
, ( 10556, 72, 34.8000, 24, 0 )
, ( 10557, 64, 33.2500, 30, 0 )
, ( 10557, 75, 7.7500, 20, 0 )
, ( 10558, 47, 9.5000, 25, 0 )
, ( 10558, 51, 53.0000, 20, 0 )
, ( 10558, 52, 7.0000, 30, 0 )
, ( 10558, 53, 32.8000, 18, 0 )
, ( 10558, 73, 15.0000, 3, 0 )
, ( 10559, 41, 9.6500, 12, 0.05 )
, ( 10559, 55, 24.0000, 18, 0.05 )
, ( 10560, 30, 25.8900, 20, 0 )
, ( 10560, 62, 49.3000, 15, 0.25 )
, ( 10561, 44, 19.4500, 10, 0 )
, ( 10561, 51, 53.0000, 50, 0 )
, ( 10562, 33, 2.5000, 20, 0.1 )
, ( 10562, 62, 49.3000, 10, 0.1 )
, ( 10563, 36, 19.0000, 25, 0 )
, ( 10563, 52, 7.0000, 70, 0 )
, ( 10564, 17, 39.0000, 16, 0.05 )
, ( 10564, 31, 12.5000, 6, 0.05 )
, ( 10564, 55, 24.0000, 25, 0.05 )
, ( 10565, 24, 4.5000, 25, 0.1 )
, ( 10565, 64, 33.2500, 18, 0.1 )
, ( 10566, 11, 21.0000, 35, 0.15 )
, ( 10566, 18, 62.5000, 18, 0.15 )
, ( 10566, 76, 18.0000, 10, 0 )
, ( 10567, 31, 12.5000, 60, 0.2 )
, ( 10567, 51, 53.0000, 3, 0 )
, ( 10567, 59, 55.0000, 40, 0.2 )
, ( 10568, 10, 31.0000, 5, 0 )
, ( 10569, 31, 12.5000, 35, 0.2 )
, ( 10569, 76, 18.0000, 30, 0 )
, ( 10570, 11, 21.0000, 15, 0.05 )
, ( 10570, 56, 38.0000, 60, 0.05 )
, ( 10571, 14, 23.2500, 11, 0.15 )
, ( 10571, 42, 14.0000, 28, 0.15 )
, ( 10572, 16, 17.4500, 12, 0.1 )
, ( 10572, 32, 32.0000, 10, 0.1 )
, ( 10572, 40, 18.4000, 50, 0 )
, ( 10572, 75, 7.7500, 15, 0.1 )
, ( 10573, 17, 39.0000, 18, 0 )
, ( 10573, 34, 14.0000, 40, 0 )
, ( 10573, 53, 32.8000, 25, 0 )
, ( 10574, 33, 2.5000, 14, 0 )
, ( 10574, 40, 18.4000, 2, 0 )
, ( 10574, 62, 49.3000, 10, 0 )
, ( 10574, 64, 33.2500, 6, 0 )
, ( 10575, 59, 55.0000, 12, 0 )
, ( 10575, 63, 43.9000, 6, 0 )
, ( 10575, 72, 34.8000, 30, 0 )
, ( 10575, 76, 18.0000, 10, 0 )
, ( 10576, 1, 18.0000, 10, 0 )
, ( 10576, 31, 12.5000, 20, 0 )
, ( 10576, 44, 19.4500, 21, 0 )
, ( 10577, 39, 18.0000, 10, 0 )
, ( 10577, 75, 7.7500, 20, 0 )
, ( 10577, 77, 13.0000, 18, 0 )
, ( 10578, 35, 18.0000, 20, 0 )
, ( 10578, 57, 19.5000, 6, 0 )
, ( 10579, 15, 15.5000, 10, 0 )
, ( 10579, 75, 7.7500, 21, 0 )
, ( 10580, 14, 23.2500, 15, 0.05 )
, ( 10580, 41, 9.6500, 9, 0.05 )
, ( 10580, 65, 21.0500, 30, 0.05 )
, ( 10581, 75, 7.7500, 50, 0.2 )
, ( 10582, 57, 19.5000, 4, 0 )
, ( 10582, 76, 18.0000, 14, 0 )
, ( 10583, 29, 123.7900, 10, 0 )
, ( 10583, 60, 34.0000, 24, 0.15 )
, ( 10583, 69, 36.0000, 10, 0.15 )
, ( 10584, 31, 12.5000, 50, 0.05 )
, ( 10585, 47, 9.5000, 15, 0 )
, ( 10586, 52, 7.0000, 4, 0.15 )
, ( 10587, 26, 31.2300, 6, 0 )
, ( 10587, 35, 18.0000, 20, 0 )
, ( 10587, 77, 13.0000, 20, 0 )
, ( 10588, 18, 62.5000, 40, 0.2 )
, ( 10588, 42, 14.0000, 100, 0.2 )
, ( 10589, 35, 18.0000, 4, 0 )
, ( 10590, 1, 18.0000, 20, 0 )
, ( 10590, 77, 13.0000, 60, 0.05 )
, ( 10591, 3, 10.0000, 14, 0 )
, ( 10591, 7, 30.0000, 10, 0 )
, ( 10591, 54, 7.4500, 50, 0 )
, ( 10592, 15, 15.5000, 25, 0.05 )
, ( 10592, 26, 31.2300, 5, 0.05 )
, ( 10593, 20, 81.0000, 21, 0.2 )
, ( 10593, 69, 36.0000, 20, 0.2 )
, ( 10593, 76, 18.0000, 4, 0.2 )
, ( 10594, 52, 7.0000, 24, 0 )
, ( 10594, 58, 13.2500, 30, 0 )
, ( 10595, 35, 18.0000, 30, 0.25 )
, ( 10595, 61, 28.5000, 120, 0.25 )
, ( 10595, 69, 36.0000, 65, 0.25 )
, ( 10596, 56, 38.0000, 5, 0.2 )
, ( 10596, 63, 43.9000, 24, 0.2 )
, ( 10596, 75, 7.7500, 30, 0.2 )
, ( 10597, 24, 4.5000, 35, 0.2 )
, ( 10597, 57, 19.5000, 20, 0 )
, ( 10597, 65, 21.0500, 12, 0.2 )
, ( 10598, 27, 43.9000, 50, 0 )
, ( 10598, 71, 21.5000, 9, 0 )
, ( 10599, 62, 49.3000, 10, 0 )
, ( 10600, 54, 7.4500, 4, 0 )
, ( 10600, 73, 15.0000, 30, 0 )
, ( 10601, 13, 6.0000, 60, 0 )
, ( 10601, 59, 55.0000, 35, 0 )
, ( 10602, 77, 13.0000, 5, 0.25 )
, ( 10603, 22, 21.0000, 48, 0 )
, ( 10603, 49, 20.0000, 25, 0.05 )
, ( 10604, 48, 12.7500, 6, 0.1 )
, ( 10604, 76, 18.0000, 10, 0.1 )
, ( 10605, 16, 17.4500, 30, 0.05 )
, ( 10605, 59, 55.0000, 20, 0.05 )
, ( 10605, 60, 34.0000, 70, 0.05 )
, ( 10605, 71, 21.5000, 15, 0.05 )
, ( 10606, 4, 22.0000, 20, 0.2 )
, ( 10606, 55, 24.0000, 20, 0.2 )
, ( 10606, 62, 49.3000, 10, 0.2 )
, ( 10607, 7, 30.0000, 45, 0 )
, ( 10607, 17, 39.0000, 100, 0 )
, ( 10607, 33, 2.5000, 14, 0 )
, ( 10607, 40, 18.4000, 42, 0 )
, ( 10607, 72, 34.8000, 12, 0 )
, ( 10608, 56, 38.0000, 28, 0 )
, ( 10609, 1, 18.0000, 3, 0 )
, ( 10609, 10, 31.0000, 10, 0 )
, ( 10609, 21, 10.0000, 6, 0 )
, ( 10610, 36, 19.0000, 21, 0.25 )
, ( 10611, 1, 18.0000, 6, 0 )
, ( 10611, 2, 19.0000, 10, 0 )
, ( 10611, 60, 34.0000, 15, 0 )
, ( 10612, 10, 31.0000, 70, 0 )
, ( 10612, 36, 19.0000, 55, 0 )
, ( 10612, 49, 20.0000, 18, 0 )
, ( 10612, 60, 34.0000, 40, 0 )
, ( 10612, 76, 18.0000, 80, 0 )
, ( 10613, 13, 6.0000, 8, 0.1 )
, ( 10613, 75, 7.7500, 40, 0 )
, ( 10614, 11, 21.0000, 14, 0 )
, ( 10614, 21, 10.0000, 8, 0 )
, ( 10614, 39, 18.0000, 5, 0 )
, ( 10615, 55, 24.0000, 5, 0 )
, ( 10616, 38, 263.5000, 15, 0.05 )
, ( 10616, 56, 38.0000, 14, 0 )
, ( 10616, 70, 15.0000, 15, 0.05 )
, ( 10616, 71, 21.5000, 15, 0.05 )
, ( 10617, 59, 55.0000, 30, 0.15 )
, ( 10618, 6, 25.0000, 70, 0 )
, ( 10618, 56, 38.0000, 20, 0 )
, ( 10618, 68, 12.5000, 15, 0 )
, ( 10619, 21, 10.0000, 42, 0 )
, ( 10619, 22, 21.0000, 40, 0 )
, ( 10620, 24, 4.5000, 5, 0 )
, ( 10620, 52, 7.0000, 5, 0 )
, ( 10621, 19, 9.2000, 5, 0 )
, ( 10621, 23, 9.0000, 10, 0 )
, ( 10621, 70, 15.0000, 20, 0 )
, ( 10621, 71, 21.5000, 15, 0 )
, ( 10622, 2, 19.0000, 20, 0 )
, ( 10622, 68, 12.5000, 18, 0.2 )
, ( 10623, 14, 23.2500, 21, 0 )
, ( 10623, 19, 9.2000, 15, 0.1 )
, ( 10623, 21, 10.0000, 25, 0.1 )
, ( 10623, 24, 4.5000, 3, 0 )
, ( 10623, 35, 18.0000, 30, 0.1 )
, ( 10624, 28, 45.6000, 10, 0 )
, ( 10624, 29, 123.7900, 6, 0 )
, ( 10624, 44, 19.4500, 10, 0 )
, ( 10625, 14, 23.2500, 3, 0 )
, ( 10625, 42, 14.0000, 5, 0 )
, ( 10625, 60, 34.0000, 10, 0 )
, ( 10626, 53, 32.8000, 12, 0 )
, ( 10626, 60, 34.0000, 20, 0 )
, ( 10626, 71, 21.5000, 20, 0 )
, ( 10627, 62, 49.3000, 15, 0 )
, ( 10627, 73, 15.0000, 35, 0.15 )
, ( 10628, 1, 18.0000, 25, 0 )
, ( 10629, 29, 123.7900, 20, 0 )
, ( 10629, 64, 33.2500, 9, 0 )
, ( 10630, 55, 24.0000, 12, 0.05 )
, ( 10630, 76, 18.0000, 35, 0 )
, ( 10631, 75, 7.7500, 8, 0.1 )
, ( 10632, 2, 19.0000, 30, 0.05 )
, ( 10632, 33, 2.5000, 20, 0.05 )
, ( 10633, 12, 38.0000, 36, 0.15 )
, ( 10633, 13, 6.0000, 13, 0.15 )
, ( 10633, 26, 31.2300, 35, 0.15 )
, ( 10633, 62, 49.3000, 80, 0.15 )
, ( 10634, 7, 30.0000, 35, 0 )
, ( 10634, 18, 62.5000, 50, 0 )
, ( 10634, 51, 53.0000, 15, 0 )
, ( 10634, 75, 7.7500, 2, 0 )
, ( 10635, 4, 22.0000, 10, 0.1 )
, ( 10635, 5, 21.3500, 15, 0.1 )
, ( 10635, 22, 21.0000, 40, 0 )
, ( 10636, 4, 22.0000, 25, 0 )
, ( 10636, 58, 13.2500, 6, 0 )
, ( 10637, 11, 21.0000, 10, 0 )
, ( 10637, 50, 16.2500, 25, 0.05 )
, ( 10637, 56, 38.0000, 60, 0.05 )
, ( 10638, 45, 9.5000, 20, 0 )
, ( 10638, 65, 21.0500, 21, 0 )
, ( 10638, 72, 34.8000, 60, 0 )
, ( 10639, 18, 62.5000, 8, 0 )
, ( 10640, 69, 36.0000, 20, 0.25 )
, ( 10640, 70, 15.0000, 15, 0.25 )
, ( 10641, 2, 19.0000, 50, 0 )
, ( 10641, 40, 18.4000, 60, 0 )
, ( 10642, 21, 10.0000, 30, 0.2 )
, ( 10642, 61, 28.5000, 20, 0.2 )
, ( 10643, 28, 45.6000, 15, 0.25 )
, ( 10643, 39, 18.0000, 21, 0.25 )
, ( 10643, 46, 12.0000, 2, 0.25 )
, ( 10644, 18, 62.5000, 4, 0.1 )
, ( 10644, 43, 46.0000, 20, 0 )
, ( 10644, 46, 12.0000, 21, 0.1 )
, ( 10645, 18, 62.5000, 20, 0 )
, ( 10645, 36, 19.0000, 15, 0 )
, ( 10646, 1, 18.0000, 15, 0.25 )
, ( 10646, 10, 31.0000, 18, 0.25 )
, ( 10646, 71, 21.5000, 30, 0.25 )
, ( 10646, 77, 13.0000, 35, 0.25 )
, ( 10647, 19, 9.2000, 30, 0 )
, ( 10647, 39, 18.0000, 20, 0 )
, ( 10648, 22, 21.0000, 15, 0 )
, ( 10648, 24, 4.5000, 15, 0.15 )
, ( 10649, 28, 45.6000, 20, 0 )
, ( 10649, 72, 34.8000, 15, 0 )
, ( 10650, 30, 25.8900, 30, 0 )
, ( 10650, 53, 32.8000, 25, 0.05 )
, ( 10650, 54, 7.4500, 30, 0 )
, ( 10651, 19, 9.2000, 12, 0.25 )
, ( 10651, 22, 21.0000, 20, 0.25 )
, ( 10652, 30, 25.8900, 2, 0.25 )
, ( 10652, 42, 14.0000, 20, 0 )
, ( 10653, 16, 17.4500, 30, 0.1 )
, ( 10653, 60, 34.0000, 20, 0.1 )
, ( 10654, 4, 22.0000, 12, 0.1 )
, ( 10654, 39, 18.0000, 20, 0.1 )
, ( 10654, 54, 7.4500, 6, 0.1 )
, ( 10655, 41, 9.6500, 20, 0.2 )
, ( 10656, 14, 23.2500, 3, 0.1 )
, ( 10656, 44, 19.4500, 28, 0.1 )
, ( 10656, 47, 9.5000, 6, 0.1 )
, ( 10657, 15, 15.5000, 50, 0 )
, ( 10657, 41, 9.6500, 24, 0 )
, ( 10657, 46, 12.0000, 45, 0 )
, ( 10657, 47, 9.5000, 10, 0 )
, ( 10657, 56, 38.0000, 45, 0 )
, ( 10657, 60, 34.0000, 30, 0 )
, ( 10658, 21, 10.0000, 60, 0 )
, ( 10658, 40, 18.4000, 70, 0.05 )
, ( 10658, 60, 34.0000, 55, 0.05 )
, ( 10658, 77, 13.0000, 70, 0.05 )
, ( 10659, 31, 12.5000, 20, 0.05 )
, ( 10659, 40, 18.4000, 24, 0.05 )
, ( 10659, 70, 15.0000, 40, 0.05 )
, ( 10660, 20, 81.0000, 21, 0 )
, ( 10661, 39, 18.0000, 3, 0.2 )
, ( 10661, 58, 13.2500, 49, 0.2 )
, ( 10662, 68, 12.5000, 10, 0 )
, ( 10663, 40, 18.4000, 30, 0.05 )
, ( 10663, 42, 14.0000, 30, 0.05 )
, ( 10663, 51, 53.0000, 20, 0.05 )
, ( 10664, 10, 31.0000, 24, 0.15 )
, ( 10664, 56, 38.0000, 12, 0.15 )
, ( 10664, 65, 21.0500, 15, 0.15 )
, ( 10665, 51, 53.0000, 20, 0 )
, ( 10665, 59, 55.0000, 1, 0 )
, ( 10665, 76, 18.0000, 10, 0 )
, ( 10666, 29, 123.7900, 36, 0 )
, ( 10666, 65, 21.0500, 10, 0 )
, ( 10667, 69, 36.0000, 45, 0.2 )
, ( 10667, 71, 21.5000, 14, 0.2 )
, ( 10668, 31, 12.5000, 8, 0.1 )
, ( 10668, 55, 24.0000, 4, 0.1 )
, ( 10668, 64, 33.2500, 15, 0.1 )
, ( 10669, 36, 19.0000, 30, 0 )
, ( 10670, 23, 9.0000, 32, 0 )
, ( 10670, 46, 12.0000, 60, 0 )
, ( 10670, 67, 14.0000, 25, 0 )
, ( 10670, 73, 15.0000, 50, 0 )
, ( 10670, 75, 7.7500, 25, 0 )
, ( 10671, 16, 17.4500, 10, 0 )
, ( 10671, 62, 49.3000, 10, 0 )
, ( 10671, 65, 21.0500, 12, 0 )
, ( 10672, 38, 263.5000, 15, 0.1 )
, ( 10672, 71, 21.5000, 12, 0 )
, ( 10673, 16, 17.4500, 3, 0 )
, ( 10673, 42, 14.0000, 6, 0 )
, ( 10673, 43, 46.0000, 6, 0 )
, ( 10674, 23, 9.0000, 5, 0 )
, ( 10675, 14, 23.2500, 30, 0 )
, ( 10675, 53, 32.8000, 10, 0 )
, ( 10675, 58, 13.2500, 30, 0 )
, ( 10676, 10, 31.0000, 2, 0 )
, ( 10676, 19, 9.2000, 7, 0 )
, ( 10676, 44, 19.4500, 21, 0 )
, ( 10677, 26, 31.2300, 30, 0.15 )
, ( 10677, 33, 2.5000, 8, 0.15 )
, ( 10678, 12, 38.0000, 100, 0 )
, ( 10678, 33, 2.5000, 30, 0 )
, ( 10678, 41, 9.6500, 120, 0 )
, ( 10678, 54, 7.4500, 30, 0 )
, ( 10679, 59, 55.0000, 12, 0 )
, ( 10680, 16, 17.4500, 50, 0.25 )
, ( 10680, 31, 12.5000, 20, 0.25 )
, ( 10680, 42, 14.0000, 40, 0.25 )
, ( 10681, 19, 9.2000, 30, 0.1 )
, ( 10681, 21, 10.0000, 12, 0.1 )
, ( 10681, 64, 33.2500, 28, 0 )
, ( 10682, 33, 2.5000, 30, 0 )
, ( 10682, 66, 17.0000, 4, 0 )
, ( 10682, 75, 7.7500, 30, 0 )
, ( 10683, 52, 7.0000, 9, 0 )
, ( 10684, 40, 18.4000, 20, 0 )
, ( 10684, 47, 9.5000, 40, 0 )
, ( 10684, 60, 34.0000, 30, 0 )
, ( 10685, 10, 31.0000, 20, 0 )
, ( 10685, 41, 9.6500, 4, 0 )
, ( 10685, 47, 9.5000, 15, 0 )
, ( 10686, 17, 39.0000, 30, 0.2 )
, ( 10686, 26, 31.2300, 15, 0 )
, ( 10687, 9, 97.0000, 50, 0.25 )
, ( 10687, 29, 123.7900, 10, 0 )
, ( 10687, 36, 19.0000, 6, 0.25 )
, ( 10688, 10, 31.0000, 18, 0.1 )
, ( 10688, 28, 45.6000, 60, 0.1 )
, ( 10688, 34, 14.0000, 14, 0 )
, ( 10689, 1, 18.0000, 35, 0.25 )
, ( 10690, 56, 38.0000, 20, 0.25 )
, ( 10690, 77, 13.0000, 30, 0.25 )
, ( 10691, 1, 18.0000, 30, 0 )
, ( 10691, 29, 123.7900, 40, 0 )
, ( 10691, 43, 46.0000, 40, 0 )
, ( 10691, 44, 19.4500, 24, 0 )
, ( 10691, 62, 49.3000, 48, 0 )
, ( 10692, 63, 43.9000, 20, 0 )
, ( 10693, 9, 97.0000, 6, 0 )
, ( 10693, 54, 7.4500, 60, 0.15 )
, ( 10693, 69, 36.0000, 30, 0.15 )
, ( 10693, 73, 15.0000, 15, 0.15 )
, ( 10694, 7, 30.0000, 90, 0 )
, ( 10694, 59, 55.0000, 25, 0 )
, ( 10694, 70, 15.0000, 50, 0 )
, ( 10695, 8, 40.0000, 10, 0 )
, ( 10695, 12, 38.0000, 4, 0 )
, ( 10695, 24, 4.5000, 20, 0 )
, ( 10696, 17, 39.0000, 20, 0 )
, ( 10696, 46, 12.0000, 18, 0 )
, ( 10697, 19, 9.2000, 7, 0.25 )
, ( 10697, 35, 18.0000, 9, 0.25 )
, ( 10697, 58, 13.2500, 30, 0.25 )
, ( 10697, 70, 15.0000, 30, 0.25 )
, ( 10698, 11, 21.0000, 15, 0 )
, ( 10698, 17, 39.0000, 8, 0.05 )
, ( 10698, 29, 123.7900, 12, 0.05 )
, ( 10698, 65, 21.0500, 65, 0.05 )
, ( 10698, 70, 15.0000, 8, 0.05 )
, ( 10699, 47, 9.5000, 12, 0 )
, ( 10700, 1, 18.0000, 5, 0.2 )
, ( 10700, 34, 14.0000, 12, 0.2 )
, ( 10700, 68, 12.5000, 40, 0.2 )
, ( 10700, 71, 21.5000, 60, 0.2 )
, ( 10701, 59, 55.0000, 42, 0.15 )
, ( 10701, 71, 21.5000, 20, 0.15 )
, ( 10701, 76, 18.0000, 35, 0.15 )
, ( 10702, 3, 10.0000, 6, 0 )
, ( 10702, 76, 18.0000, 15, 0 )
, ( 10703, 2, 19.0000, 5, 0 )
, ( 10703, 59, 55.0000, 35, 0 )
, ( 10703, 73, 15.0000, 35, 0 )
, ( 10704, 4, 22.0000, 6, 0 )
, ( 10704, 24, 4.5000, 35, 0 )
, ( 10704, 48, 12.7500, 24, 0 )
, ( 10705, 31, 12.5000, 20, 0 )
, ( 10705, 32, 32.0000, 4, 0 )
, ( 10706, 16, 17.4500, 20, 0 )
, ( 10706, 43, 46.0000, 24, 0 )
, ( 10706, 59, 55.0000, 8, 0 )
, ( 10707, 55, 24.0000, 21, 0 )
, ( 10707, 57, 19.5000, 40, 0 )
, ( 10707, 70, 15.0000, 28, 0.15 )
, ( 10708, 5, 21.3500, 4, 0 )
, ( 10708, 36, 19.0000, 5, 0 )
, ( 10709, 8, 40.0000, 40, 0 )
, ( 10709, 51, 53.0000, 28, 0 )
, ( 10709, 60, 34.0000, 10, 0 )
, ( 10710, 19, 9.2000, 5, 0 )
, ( 10710, 47, 9.5000, 5, 0 )
, ( 10711, 19, 9.2000, 12, 0 )
, ( 10711, 41, 9.6500, 42, 0 )
, ( 10711, 53, 32.8000, 120, 0 )
, ( 10712, 53, 32.8000, 3, 0.05 )
, ( 10712, 56, 38.0000, 30, 0 )
, ( 10713, 10, 31.0000, 18, 0 )
, ( 10713, 26, 31.2300, 30, 0 )
, ( 10713, 45, 9.5000, 110, 0 )
, ( 10713, 46, 12.0000, 24, 0 )
, ( 10714, 2, 19.0000, 30, 0.25 )
, ( 10714, 17, 39.0000, 27, 0.25 )
, ( 10714, 47, 9.5000, 50, 0.25 )
, ( 10714, 56, 38.0000, 18, 0.25 )
, ( 10714, 58, 13.2500, 12, 0.25 )
, ( 10715, 10, 31.0000, 21, 0 )
, ( 10715, 71, 21.5000, 30, 0 )
, ( 10716, 21, 10.0000, 5, 0 )
, ( 10716, 51, 53.0000, 7, 0 )
, ( 10716, 61, 28.5000, 10, 0 )
, ( 10717, 21, 10.0000, 32, 0.05 )
, ( 10717, 54, 7.4500, 15, 0 )
, ( 10717, 69, 36.0000, 25, 0.05 )
, ( 10718, 12, 38.0000, 36, 0 )
, ( 10718, 16, 17.4500, 20, 0 )
, ( 10718, 36, 19.0000, 40, 0 )
, ( 10718, 62, 49.3000, 20, 0 )
, ( 10719, 18, 62.5000, 12, 0.25 )
, ( 10719, 30, 25.8900, 3, 0.25 )
, ( 10719, 54, 7.4500, 40, 0.25 )
, ( 10720, 35, 18.0000, 21, 0 )
, ( 10720, 71, 21.5000, 8, 0 )
, ( 10721, 44, 19.4500, 50, 0.05 )
, ( 10722, 2, 19.0000, 3, 0 )
, ( 10722, 31, 12.5000, 50, 0 )
, ( 10722, 68, 12.5000, 45, 0 )
, ( 10722, 75, 7.7500, 42, 0 )
, ( 10723, 26, 31.2300, 15, 0 )
, ( 10724, 10, 31.0000, 16, 0 )
, ( 10724, 61, 28.5000, 5, 0 )
, ( 10725, 41, 9.6500, 12, 0 )
, ( 10725, 52, 7.0000, 4, 0 )
, ( 10725, 55, 24.0000, 6, 0 )
, ( 10726, 4, 22.0000, 25, 0 )
, ( 10726, 11, 21.0000, 5, 0 )
, ( 10727, 17, 39.0000, 20, 0.05 )
, ( 10727, 56, 38.0000, 10, 0.05 )
, ( 10727, 59, 55.0000, 10, 0.05 )
, ( 10728, 30, 25.8900, 15, 0 )
, ( 10728, 40, 18.4000, 6, 0 )
, ( 10728, 55, 24.0000, 12, 0 )
, ( 10728, 60, 34.0000, 15, 0 )
, ( 10729, 1, 18.0000, 50, 0 )
, ( 10729, 21, 10.0000, 30, 0 )
, ( 10729, 50, 16.2500, 40, 0 )
, ( 10730, 16, 17.4500, 15, 0.05 )
, ( 10730, 31, 12.5000, 3, 0.05 )
, ( 10730, 65, 21.0500, 10, 0.05 )
, ( 10731, 21, 10.0000, 40, 0.05 )
, ( 10731, 51, 53.0000, 30, 0.05 )
, ( 10732, 76, 18.0000, 20, 0 )
, ( 10733, 14, 23.2500, 16, 0 )
, ( 10733, 28, 45.6000, 20, 0 )
, ( 10733, 52, 7.0000, 25, 0 )
, ( 10734, 6, 25.0000, 30, 0 )
, ( 10734, 30, 25.8900, 15, 0 )
, ( 10734, 76, 18.0000, 20, 0 )
, ( 10735, 61, 28.5000, 20, 0.1 )
, ( 10735, 77, 13.0000, 2, 0.1 )
, ( 10736, 65, 21.0500, 40, 0 )
, ( 10736, 75, 7.7500, 20, 0 )
, ( 10737, 13, 6.0000, 4, 0 )
, ( 10737, 41, 9.6500, 12, 0 )
, ( 10738, 16, 17.4500, 3, 0 )
, ( 10739, 36, 19.0000, 6, 0 )
, ( 10739, 52, 7.0000, 18, 0 )
, ( 10740, 28, 45.6000, 5, 0.2 )
, ( 10740, 35, 18.0000, 35, 0.2 )
, ( 10740, 45, 9.5000, 40, 0.2 )
, ( 10740, 56, 38.0000, 14, 0.2 )
, ( 10741, 2, 19.0000, 15, 0.2 )
, ( 10742, 3, 10.0000, 20, 0 )
, ( 10742, 60, 34.0000, 50, 0 )
, ( 10742, 72, 34.8000, 35, 0 )
, ( 10743, 46, 12.0000, 28, 0.05 )
, ( 10744, 40, 18.4000, 50, 0.2 )
, ( 10745, 18, 62.5000, 24, 0 )
, ( 10745, 44, 19.4500, 16, 0 )
, ( 10745, 59, 55.0000, 45, 0 )
, ( 10745, 72, 34.8000, 7, 0 )
, ( 10746, 13, 6.0000, 6, 0 )
, ( 10746, 42, 14.0000, 28, 0 )
, ( 10746, 62, 49.3000, 9, 0 )
, ( 10746, 69, 36.0000, 40, 0 )
, ( 10747, 31, 12.5000, 8, 0 )
, ( 10747, 41, 9.6500, 35, 0 )
, ( 10747, 63, 43.9000, 9, 0 )
, ( 10747, 69, 36.0000, 30, 0 )
, ( 10748, 23, 9.0000, 44, 0 )
, ( 10748, 40, 18.4000, 40, 0 )
, ( 10748, 56, 38.0000, 28, 0 )
, ( 10749, 56, 38.0000, 15, 0 )
, ( 10749, 59, 55.0000, 6, 0 )
, ( 10749, 76, 18.0000, 10, 0 )
, ( 10750, 14, 23.2500, 5, 0.15 )
, ( 10750, 45, 9.5000, 40, 0.15 )
, ( 10750, 59, 55.0000, 25, 0.15 )
, ( 10751, 26, 31.2300, 12, 0.1 )
, ( 10751, 30, 25.8900, 30, 0 )
, ( 10751, 50, 16.2500, 20, 0.1 )
, ( 10751, 73, 15.0000, 15, 0 )
, ( 10752, 1, 18.0000, 8, 0 )
, ( 10752, 69, 36.0000, 3, 0 )
, ( 10753, 45, 9.5000, 4, 0 )
, ( 10753, 74, 10.0000, 5, 0 )
, ( 10754, 40, 18.4000, 3, 0 )
, ( 10755, 47, 9.5000, 30, 0.25 )
, ( 10755, 56, 38.0000, 30, 0.25 )
, ( 10755, 57, 19.5000, 14, 0.25 )
, ( 10755, 69, 36.0000, 25, 0.25 )
, ( 10756, 18, 62.5000, 21, 0.2 )
, ( 10756, 36, 19.0000, 20, 0.2 )
, ( 10756, 68, 12.5000, 6, 0.2 )
, ( 10756, 69, 36.0000, 20, 0.2 )
, ( 10757, 34, 14.0000, 30, 0 )
, ( 10757, 59, 55.0000, 7, 0 )
, ( 10757, 62, 49.3000, 30, 0 )
, ( 10757, 64, 33.2500, 24, 0 )
, ( 10758, 26, 31.2300, 20, 0 )
, ( 10758, 52, 7.0000, 60, 0 )
, ( 10758, 70, 15.0000, 40, 0 )
, ( 10759, 32, 32.0000, 10, 0 )
, ( 10760, 25, 14.0000, 12, 0.25 )
, ( 10760, 27, 43.9000, 40, 0 )
, ( 10760, 43, 46.0000, 30, 0.25 )
, ( 10761, 25, 14.0000, 35, 0.25 )
, ( 10761, 75, 7.7500, 18, 0 )
, ( 10762, 39, 18.0000, 16, 0 )
, ( 10762, 47, 9.5000, 30, 0 )
, ( 10762, 51, 53.0000, 28, 0 )
, ( 10762, 56, 38.0000, 60, 0 )
, ( 10763, 21, 10.0000, 40, 0 )
, ( 10763, 22, 21.0000, 6, 0 )
, ( 10763, 24, 4.5000, 20, 0 )
, ( 10764, 3, 10.0000, 20, 0.1 )
, ( 10764, 39, 18.0000, 130, 0.1 )
, ( 10765, 65, 21.0500, 80, 0.1 )
, ( 10766, 2, 19.0000, 40, 0 )
, ( 10766, 7, 30.0000, 35, 0 )
, ( 10766, 68, 12.5000, 40, 0 )
, ( 10767, 42, 14.0000, 2, 0 )
, ( 10768, 22, 21.0000, 4, 0 )
, ( 10768, 31, 12.5000, 50, 0 )
, ( 10768, 60, 34.0000, 15, 0 )
, ( 10768, 71, 21.5000, 12, 0 )
, ( 10769, 41, 9.6500, 30, 0.05 )
, ( 10769, 52, 7.0000, 15, 0.05 )
, ( 10769, 61, 28.5000, 20, 0 )
, ( 10769, 62, 49.3000, 15, 0 )
, ( 10770, 11, 21.0000, 15, 0.25 )
, ( 10771, 71, 21.5000, 16, 0 )
, ( 10772, 29, 123.7900, 18, 0 )
, ( 10772, 59, 55.0000, 25, 0 )
, ( 10773, 17, 39.0000, 33, 0 )
, ( 10773, 31, 12.5000, 70, 0.2 )
, ( 10773, 75, 7.7500, 7, 0.2 )
, ( 10774, 31, 12.5000, 2, 0.25 )
, ( 10774, 66, 17.0000, 50, 0 )
, ( 10775, 10, 31.0000, 6, 0 )
, ( 10775, 67, 14.0000, 3, 0 )
, ( 10776, 31, 12.5000, 16, 0.05 )
, ( 10776, 42, 14.0000, 12, 0.05 )
, ( 10776, 45, 9.5000, 27, 0.05 )
, ( 10776, 51, 53.0000, 120, 0.05 )
, ( 10777, 42, 14.0000, 20, 0.2 )
, ( 10778, 41, 9.6500, 10, 0 )
, ( 10779, 16, 17.4500, 20, 0 )
, ( 10779, 62, 49.3000, 20, 0 )
, ( 10780, 70, 15.0000, 35, 0 )
, ( 10780, 77, 13.0000, 15, 0 )
, ( 10781, 54, 7.4500, 3, 0.2 )
, ( 10781, 56, 38.0000, 20, 0.2 )
, ( 10781, 74, 10.0000, 35, 0 )
, ( 10782, 31, 12.5000, 1, 0 )
, ( 10783, 31, 12.5000, 10, 0 )
, ( 10783, 38, 263.5000, 5, 0 )
, ( 10784, 36, 19.0000, 30, 0 )
, ( 10784, 39, 18.0000, 2, 0.15 )
, ( 10784, 72, 34.8000, 30, 0.15 )
, ( 10785, 10, 31.0000, 10, 0 )
, ( 10785, 75, 7.7500, 10, 0 )
, ( 10786, 8, 40.0000, 30, 0.2 )
, ( 10786, 30, 25.8900, 15, 0.2 )
, ( 10786, 75, 7.7500, 42, 0.2 )
, ( 10787, 2, 19.0000, 15, 0.05 )
, ( 10787, 29, 123.7900, 20, 0.05 )
, ( 10788, 19, 9.2000, 50, 0.05 )
, ( 10788, 75, 7.7500, 40, 0.05 )
, ( 10789, 18, 62.5000, 30, 0 )
, ( 10789, 35, 18.0000, 15, 0 )
, ( 10789, 63, 43.9000, 30, 0 )
, ( 10789, 68, 12.5000, 18, 0 )
, ( 10790, 7, 30.0000, 3, 0.15 )
, ( 10790, 56, 38.0000, 20, 0.15 )
, ( 10791, 29, 123.7900, 14, 0.05 )
, ( 10791, 41, 9.6500, 20, 0.05 )
, ( 10792, 2, 19.0000, 10, 0 )
, ( 10792, 54, 7.4500, 3, 0 )
, ( 10792, 68, 12.5000, 15, 0 )
, ( 10793, 41, 9.6500, 14, 0 )
, ( 10793, 52, 7.0000, 8, 0 )
, ( 10794, 14, 23.2500, 15, 0.2 )
, ( 10794, 54, 7.4500, 6, 0.2 )
, ( 10795, 16, 17.4500, 65, 0 )
, ( 10795, 17, 39.0000, 35, 0.25 )
, ( 10796, 26, 31.2300, 21, 0.2 )
, ( 10796, 44, 19.4500, 10, 0 )
, ( 10796, 64, 33.2500, 35, 0.2 )
, ( 10796, 69, 36.0000, 24, 0.2 )
, ( 10797, 11, 21.0000, 20, 0 )
, ( 10798, 62, 49.3000, 2, 0 )
, ( 10798, 72, 34.8000, 10, 0 )
, ( 10799, 13, 6.0000, 20, 0.15 )
, ( 10799, 24, 4.5000, 20, 0.15 )
, ( 10799, 59, 55.0000, 25, 0 )
, ( 10800, 11, 21.0000, 50, 0.1 )
, ( 10800, 51, 53.0000, 10, 0.1 )
, ( 10800, 54, 7.4500, 7, 0.1 )
, ( 10801, 17, 39.0000, 40, 0.25 )
, ( 10801, 29, 123.7900, 20, 0.25 )
, ( 10802, 30, 25.8900, 25, 0.25 )
GO
INSERT dbo.[Order Details]
  (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES
 ( 10802, 51, 53.0000, 30, 0.25 )
, ( 10802, 55, 24.0000, 60, 0.25 )
, ( 10802, 62, 49.3000, 5, 0.25 )
, ( 10803, 19, 9.2000, 24, 0.05 )
, ( 10803, 25, 14.0000, 15, 0.05 )
, ( 10803, 59, 55.0000, 15, 0.05 )
, ( 10804, 10, 31.0000, 36, 0 )
, ( 10804, 28, 45.6000, 24, 0 )
, ( 10804, 49, 20.0000, 4, 0.15 )
, ( 10805, 34, 14.0000, 10, 0 )
, ( 10805, 38, 263.5000, 10, 0 )
, ( 10806, 2, 19.0000, 20, 0.25 )
, ( 10806, 65, 21.0500, 2, 0 )
, ( 10806, 74, 10.0000, 15, 0.25 )
, ( 10807, 40, 18.4000, 1, 0 )
, ( 10808, 56, 38.0000, 20, 0.15 )
, ( 10808, 76, 18.0000, 50, 0.15 )
, ( 10809, 52, 7.0000, 20, 0 )
, ( 10810, 13, 6.0000, 7, 0 )
, ( 10810, 25, 14.0000, 5, 0 )
, ( 10810, 70, 15.0000, 5, 0 )
, ( 10811, 19, 9.2000, 15, 0 )
, ( 10811, 23, 9.0000, 18, 0 )
, ( 10811, 40, 18.4000, 30, 0 )
, ( 10812, 31, 12.5000, 16, 0.1 )
, ( 10812, 72, 34.8000, 40, 0.1 )
, ( 10812, 77, 13.0000, 20, 0 )
, ( 10813, 2, 19.0000, 12, 0.2 )
, ( 10813, 46, 12.0000, 35, 0 )
, ( 10814, 41, 9.6500, 20, 0 )
, ( 10814, 43, 46.0000, 20, 0.15 )
, ( 10814, 48, 12.7500, 8, 0.15 )
, ( 10814, 61, 28.5000, 30, 0.15 )
, ( 10815, 33, 2.5000, 16, 0 )
, ( 10816, 38, 263.5000, 30, 0.05 )
, ( 10816, 62, 49.3000, 20, 0.05 )
, ( 10817, 26, 31.2300, 40, 0.15 )
, ( 10817, 38, 263.5000, 30, 0 )
, ( 10817, 40, 18.4000, 60, 0.15 )
, ( 10817, 62, 49.3000, 25, 0.15 )
, ( 10818, 32, 32.0000, 20, 0 )
, ( 10818, 41, 9.6500, 20, 0 )
, ( 10819, 43, 46.0000, 7, 0 )
, ( 10819, 75, 7.7500, 20, 0 )
, ( 10820, 56, 38.0000, 30, 0 )
, ( 10821, 35, 18.0000, 20, 0 )
, ( 10821, 51, 53.0000, 6, 0 )
, ( 10822, 62, 49.3000, 3, 0 )
, ( 10822, 70, 15.0000, 6, 0 )
, ( 10823, 11, 21.0000, 20, 0.1 )
, ( 10823, 57, 19.5000, 15, 0 )
, ( 10823, 59, 55.0000, 40, 0.1 )
, ( 10823, 77, 13.0000, 15, 0.1 )
, ( 10824, 41, 9.6500, 12, 0 )
, ( 10824, 70, 15.0000, 9, 0 )
, ( 10825, 26, 31.2300, 12, 0 )
, ( 10825, 53, 32.8000, 20, 0 )
, ( 10826, 31, 12.5000, 35, 0 )
, ( 10826, 57, 19.5000, 15, 0 )
, ( 10827, 10, 31.0000, 15, 0 )
, ( 10827, 39, 18.0000, 21, 0 )
, ( 10828, 20, 81.0000, 5, 0 )
, ( 10828, 38, 263.5000, 2, 0 )
, ( 10829, 2, 19.0000, 10, 0 )
, ( 10829, 8, 40.0000, 20, 0 )
, ( 10829, 13, 6.0000, 10, 0 )
, ( 10829, 60, 34.0000, 21, 0 )
, ( 10830, 6, 25.0000, 6, 0 )
, ( 10830, 39, 18.0000, 28, 0 )
, ( 10830, 60, 34.0000, 30, 0 )
, ( 10830, 68, 12.5000, 24, 0 )
, ( 10831, 19, 9.2000, 2, 0 )
, ( 10831, 35, 18.0000, 8, 0 )
, ( 10831, 38, 263.5000, 8, 0 )
, ( 10831, 43, 46.0000, 9, 0 )
, ( 10832, 13, 6.0000, 3, 0.2 )
, ( 10832, 25, 14.0000, 10, 0.2 )
, ( 10832, 44, 19.4500, 16, 0.2 )
, ( 10832, 64, 33.2500, 3, 0 )
, ( 10833, 7, 30.0000, 20, 0.1 )
, ( 10833, 31, 12.5000, 9, 0.1 )
, ( 10833, 53, 32.8000, 9, 0.1 )
, ( 10834, 29, 123.7900, 8, 0.05 )
, ( 10834, 30, 25.8900, 20, 0.05 )
, ( 10835, 59, 55.0000, 15, 0 )
, ( 10835, 77, 13.0000, 2, 0.2 )
, ( 10836, 22, 21.0000, 52, 0 )
, ( 10836, 35, 18.0000, 6, 0 )
, ( 10836, 57, 19.5000, 24, 0 )
, ( 10836, 60, 34.0000, 60, 0 )
, ( 10836, 64, 33.2500, 30, 0 )
, ( 10837, 13, 6.0000, 6, 0 )
, ( 10837, 40, 18.4000, 25, 0 )
, ( 10837, 47, 9.5000, 40, 0.25 )
, ( 10837, 76, 18.0000, 21, 0.25 )
, ( 10838, 1, 18.0000, 4, 0.25 )
, ( 10838, 18, 62.5000, 25, 0.25 )
, ( 10838, 36, 19.0000, 50, 0.25 )
, ( 10839, 58, 13.2500, 30, 0.1 )
, ( 10839, 72, 34.8000, 15, 0.1 )
, ( 10840, 25, 14.0000, 6, 0.2 )
, ( 10840, 39, 18.0000, 10, 0.2 )
, ( 10841, 10, 31.0000, 16, 0 )
, ( 10841, 56, 38.0000, 30, 0 )
, ( 10841, 59, 55.0000, 50, 0 )
, ( 10841, 77, 13.0000, 15, 0 )
, ( 10842, 11, 21.0000, 15, 0 )
, ( 10842, 43, 46.0000, 5, 0 )
, ( 10842, 68, 12.5000, 20, 0 )
, ( 10842, 70, 15.0000, 12, 0 )
, ( 10843, 51, 53.0000, 4, 0.25 )
, ( 10844, 22, 21.0000, 35, 0 )
, ( 10845, 23, 9.0000, 70, 0.1 )
, ( 10845, 35, 18.0000, 25, 0.1 )
, ( 10845, 42, 14.0000, 42, 0.1 )
, ( 10845, 58, 13.2500, 60, 0.1 )
, ( 10845, 64, 33.2500, 48, 0 )
, ( 10846, 4, 22.0000, 21, 0 )
, ( 10846, 70, 15.0000, 30, 0 )
, ( 10846, 74, 10.0000, 20, 0 )
, ( 10847, 1, 18.0000, 80, 0.2 )
, ( 10847, 19, 9.2000, 12, 0.2 )
, ( 10847, 37, 26.0000, 60, 0.2 )
, ( 10847, 45, 9.5000, 36, 0.2 )
, ( 10847, 60, 34.0000, 45, 0.2 )
, ( 10847, 71, 21.5000, 55, 0.2 )
, ( 10848, 5, 21.3500, 30, 0 )
, ( 10848, 9, 97.0000, 3, 0 )
, ( 10849, 3, 10.0000, 49, 0 )
, ( 10849, 26, 31.2300, 18, 0.15 )
, ( 10850, 25, 14.0000, 20, 0.15 )
, ( 10850, 33, 2.5000, 4, 0.15 )
, ( 10850, 70, 15.0000, 30, 0.15 )
, ( 10851, 2, 19.0000, 5, 0.05 )
, ( 10851, 25, 14.0000, 10, 0.05 )
, ( 10851, 57, 19.5000, 10, 0.05 )
, ( 10851, 59, 55.0000, 42, 0.05 )
, ( 10852, 2, 19.0000, 15, 0 )
, ( 10852, 17, 39.0000, 6, 0 )
, ( 10852, 62, 49.3000, 50, 0 )
, ( 10853, 18, 62.5000, 10, 0 )
, ( 10854, 10, 31.0000, 100, 0.15 )
, ( 10854, 13, 6.0000, 65, 0.15 )
, ( 10855, 16, 17.4500, 50, 0 )
, ( 10855, 31, 12.5000, 14, 0 )
, ( 10855, 56, 38.0000, 24, 0 )
, ( 10855, 65, 21.0500, 15, 0.15 )
, ( 10856, 2, 19.0000, 20, 0 )
, ( 10856, 42, 14.0000, 20, 0 )
, ( 10857, 3, 10.0000, 30, 0 )
, ( 10857, 26, 31.2300, 35, 0.25 )
, ( 10857, 29, 123.7900, 10, 0.25 )
, ( 10858, 7, 30.0000, 5, 0 )
, ( 10858, 27, 43.9000, 10, 0 )
, ( 10858, 70, 15.0000, 4, 0 )
, ( 10859, 24, 4.5000, 40, 0.25 )
, ( 10859, 54, 7.4500, 35, 0.25 )
, ( 10859, 64, 33.2500, 30, 0.25 )
, ( 10860, 51, 53.0000, 3, 0 )
, ( 10860, 76, 18.0000, 20, 0 )
, ( 10861, 17, 39.0000, 42, 0 )
, ( 10861, 18, 62.5000, 20, 0 )
, ( 10861, 21, 10.0000, 40, 0 )
, ( 10861, 33, 2.5000, 35, 0 )
, ( 10861, 62, 49.3000, 3, 0 )
, ( 10862, 11, 21.0000, 25, 0 )
, ( 10862, 52, 7.0000, 8, 0 )
, ( 10863, 1, 18.0000, 20, 0.15 )
, ( 10863, 58, 13.2500, 12, 0.15 )
, ( 10864, 35, 18.0000, 4, 0 )
, ( 10864, 67, 14.0000, 15, 0 )
, ( 10865, 38, 263.5000, 60, 0.05 )
, ( 10865, 39, 18.0000, 80, 0.05 )
, ( 10866, 2, 19.0000, 21, 0.25 )
, ( 10866, 24, 4.5000, 6, 0.25 )
, ( 10866, 30, 25.8900, 40, 0.25 )
, ( 10867, 53, 32.8000, 3, 0 )
, ( 10868, 26, 31.2300, 20, 0 )
, ( 10868, 35, 18.0000, 30, 0 )
, ( 10868, 49, 20.0000, 42, 0.1 )
, ( 10869, 1, 18.0000, 40, 0 )
, ( 10869, 11, 21.0000, 10, 0 )
, ( 10869, 23, 9.0000, 50, 0 )
, ( 10869, 68, 12.5000, 20, 0 )
, ( 10870, 35, 18.0000, 3, 0 )
, ( 10870, 51, 53.0000, 2, 0 )
, ( 10871, 6, 25.0000, 50, 0.05 )
, ( 10871, 16, 17.4500, 12, 0.05 )
, ( 10871, 17, 39.0000, 16, 0.05 )
, ( 10872, 55, 24.0000, 10, 0.05 )
, ( 10872, 62, 49.3000, 20, 0.05 )
, ( 10872, 64, 33.2500, 15, 0.05 )
, ( 10872, 65, 21.0500, 21, 0.05 )
, ( 10873, 21, 10.0000, 20, 0 )
, ( 10873, 28, 45.6000, 3, 0 )
, ( 10874, 10, 31.0000, 10, 0 )
, ( 10875, 19, 9.2000, 25, 0 )
, ( 10875, 47, 9.5000, 21, 0.1 )
, ( 10875, 49, 20.0000, 15, 0 )
, ( 10876, 46, 12.0000, 21, 0 )
, ( 10876, 64, 33.2500, 20, 0 )
, ( 10877, 16, 17.4500, 30, 0.25 )
, ( 10877, 18, 62.5000, 25, 0 )
, ( 10878, 20, 81.0000, 20, 0.05 )
, ( 10879, 40, 18.4000, 12, 0 )
, ( 10879, 65, 21.0500, 10, 0 )
, ( 10879, 76, 18.0000, 10, 0 )
, ( 10880, 23, 9.0000, 30, 0.2 )
, ( 10880, 61, 28.5000, 30, 0.2 )
, ( 10880, 70, 15.0000, 50, 0.2 )
, ( 10881, 73, 15.0000, 10, 0 )
, ( 10882, 42, 14.0000, 25, 0 )
, ( 10882, 49, 20.0000, 20, 0.15 )
, ( 10882, 54, 7.4500, 32, 0.15 )
, ( 10883, 24, 4.5000, 8, 0 )
, ( 10884, 21, 10.0000, 40, 0.05 )
, ( 10884, 56, 38.0000, 21, 0.05 )
, ( 10884, 65, 21.0500, 12, 0.05 )
, ( 10885, 2, 19.0000, 20, 0 )
, ( 10885, 24, 4.5000, 12, 0 )
, ( 10885, 70, 15.0000, 30, 0 )
, ( 10885, 77, 13.0000, 25, 0 )
, ( 10886, 10, 31.0000, 70, 0 )
, ( 10886, 31, 12.5000, 35, 0 )
, ( 10886, 77, 13.0000, 40, 0 )
, ( 10887, 25, 14.0000, 5, 0 )
, ( 10888, 2, 19.0000, 20, 0 )
, ( 10888, 68, 12.5000, 18, 0 )
, ( 10889, 11, 21.0000, 40, 0 )
, ( 10889, 38, 263.5000, 40, 0 )
, ( 10890, 17, 39.0000, 15, 0 )
, ( 10890, 34, 14.0000, 10, 0 )
, ( 10890, 41, 9.6500, 14, 0 )
, ( 10891, 30, 25.8900, 15, 0.05 )
, ( 10892, 59, 55.0000, 40, 0.05 )
, ( 10893, 8, 40.0000, 30, 0 )
, ( 10893, 24, 4.5000, 10, 0 )
, ( 10893, 29, 123.7900, 24, 0 )
, ( 10893, 30, 25.8900, 35, 0 )
, ( 10893, 36, 19.0000, 20, 0 )
, ( 10894, 13, 6.0000, 28, 0.05 )
, ( 10894, 69, 36.0000, 50, 0.05 )
, ( 10894, 75, 7.7500, 120, 0.05 )
, ( 10895, 24, 4.5000, 110, 0 )
, ( 10895, 39, 18.0000, 45, 0 )
, ( 10895, 40, 18.4000, 91, 0 )
, ( 10895, 60, 34.0000, 100, 0 )
, ( 10896, 45, 9.5000, 15, 0 )
, ( 10896, 56, 38.0000, 16, 0 )
, ( 10897, 29, 123.7900, 80, 0 )
, ( 10897, 30, 25.8900, 36, 0 )
, ( 10898, 13, 6.0000, 5, 0 )
, ( 10899, 39, 18.0000, 8, 0.15 )
, ( 10900, 70, 15.0000, 3, 0.25 )
, ( 10901, 41, 9.6500, 30, 0 )
, ( 10901, 71, 21.5000, 30, 0 )
, ( 10902, 55, 24.0000, 30, 0.15 )
, ( 10902, 62, 49.3000, 6, 0.15 )
, ( 10903, 13, 6.0000, 40, 0 )
, ( 10903, 65, 21.0500, 21, 0 )
, ( 10903, 68, 12.5000, 20, 0 )
, ( 10904, 58, 13.2500, 15, 0 )
, ( 10904, 62, 49.3000, 35, 0 )
, ( 10905, 1, 18.0000, 20, 0.05 )
, ( 10906, 61, 28.5000, 15, 0 )
, ( 10907, 75, 7.7500, 14, 0 )
, ( 10908, 7, 30.0000, 20, 0.05 )
, ( 10908, 52, 7.0000, 14, 0.05 )
, ( 10909, 7, 30.0000, 12, 0 )
, ( 10909, 16, 17.4500, 15, 0 )
, ( 10909, 41, 9.6500, 5, 0 )
, ( 10910, 19, 9.2000, 12, 0 )
, ( 10910, 49, 20.0000, 10, 0 )
, ( 10910, 61, 28.5000, 5, 0 )
, ( 10911, 1, 18.0000, 10, 0 )
, ( 10911, 17, 39.0000, 12, 0 )
, ( 10911, 67, 14.0000, 15, 0 )
, ( 10912, 11, 21.0000, 40, 0.25 )
, ( 10912, 29, 123.7900, 60, 0.25 )
, ( 10913, 4, 22.0000, 30, 0.25 )
, ( 10913, 33, 2.5000, 40, 0.25 )
, ( 10913, 58, 13.2500, 15, 0 )
, ( 10914, 71, 21.5000, 25, 0 )
, ( 10915, 17, 39.0000, 10, 0 )
, ( 10915, 33, 2.5000, 30, 0 )
, ( 10915, 54, 7.4500, 10, 0 )
, ( 10916, 16, 17.4500, 6, 0 )
, ( 10916, 32, 32.0000, 6, 0 )
, ( 10916, 57, 19.5000, 20, 0 )
, ( 10917, 30, 25.8900, 1, 0 )
, ( 10917, 60, 34.0000, 10, 0 )
, ( 10918, 1, 18.0000, 60, 0.25 )
, ( 10918, 60, 34.0000, 25, 0.25 )
, ( 10919, 16, 17.4500, 24, 0 )
, ( 10919, 25, 14.0000, 24, 0 )
, ( 10919, 40, 18.4000, 20, 0 )
, ( 10920, 50, 16.2500, 24, 0 )
, ( 10921, 35, 18.0000, 10, 0 )
, ( 10921, 63, 43.9000, 40, 0 )
, ( 10922, 17, 39.0000, 15, 0 )
, ( 10922, 24, 4.5000, 35, 0 )
, ( 10923, 42, 14.0000, 10, 0.2 )
, ( 10923, 43, 46.0000, 10, 0.2 )
, ( 10923, 67, 14.0000, 24, 0.2 )
, ( 10924, 10, 31.0000, 20, 0.1 )
, ( 10924, 28, 45.6000, 30, 0.1 )
, ( 10924, 75, 7.7500, 6, 0 )
, ( 10925, 36, 19.0000, 25, 0.15 )
, ( 10925, 52, 7.0000, 12, 0.15 )
, ( 10926, 11, 21.0000, 2, 0 )
, ( 10926, 13, 6.0000, 10, 0 )
, ( 10926, 19, 9.2000, 7, 0 )
, ( 10926, 72, 34.8000, 10, 0 )
, ( 10927, 20, 81.0000, 5, 0 )
, ( 10927, 52, 7.0000, 5, 0 )
, ( 10927, 76, 18.0000, 20, 0 )
, ( 10928, 47, 9.5000, 5, 0 )
, ( 10928, 76, 18.0000, 5, 0 )
, ( 10929, 21, 10.0000, 60, 0 )
, ( 10929, 75, 7.7500, 49, 0 )
, ( 10929, 77, 13.0000, 15, 0 )
, ( 10930, 21, 10.0000, 36, 0 )
, ( 10930, 27, 43.9000, 25, 0 )
, ( 10930, 55, 24.0000, 25, 0.2 )
, ( 10930, 58, 13.2500, 30, 0.2 )
, ( 10931, 13, 6.0000, 42, 0.15 )
, ( 10931, 57, 19.5000, 30, 0 )
, ( 10932, 16, 17.4500, 30, 0.1 )
, ( 10932, 62, 49.3000, 14, 0.1 )
, ( 10932, 72, 34.8000, 16, 0 )
, ( 10932, 75, 7.7500, 20, 0.1 )
, ( 10933, 53, 32.8000, 2, 0 )
, ( 10933, 61, 28.5000, 30, 0 )
, ( 10934, 6, 25.0000, 20, 0 )
, ( 10935, 1, 18.0000, 21, 0 )
, ( 10935, 18, 62.5000, 4, 0.25 )
, ( 10935, 23, 9.0000, 8, 0.25 )
, ( 10936, 36, 19.0000, 30, 0.2 )
, ( 10937, 28, 45.6000, 8, 0 )
, ( 10937, 34, 14.0000, 20, 0 )
, ( 10938, 13, 6.0000, 20, 0.25 )
, ( 10938, 43, 46.0000, 24, 0.25 )
, ( 10938, 60, 34.0000, 49, 0.25 )
, ( 10938, 71, 21.5000, 35, 0.25 )
, ( 10939, 2, 19.0000, 10, 0.15 )
, ( 10939, 67, 14.0000, 40, 0.15 )
, ( 10940, 7, 30.0000, 8, 0 )
, ( 10940, 13, 6.0000, 20, 0 )
, ( 10941, 31, 12.5000, 44, 0.25 )
, ( 10941, 62, 49.3000, 30, 0.25 )
, ( 10941, 68, 12.5000, 80, 0.25 )
, ( 10941, 72, 34.8000, 50, 0 )
, ( 10942, 49, 20.0000, 28, 0 )
, ( 10943, 13, 6.0000, 15, 0 )
, ( 10943, 22, 21.0000, 21, 0 )
, ( 10943, 46, 12.0000, 15, 0 )
, ( 10944, 11, 21.0000, 5, 0.25 )
, ( 10944, 44, 19.4500, 18, 0.25 )
, ( 10944, 56, 38.0000, 18, 0 )
, ( 10945, 13, 6.0000, 20, 0 )
, ( 10945, 31, 12.5000, 10, 0 )
, ( 10946, 10, 31.0000, 25, 0 )
, ( 10946, 24, 4.5000, 25, 0 )
, ( 10946, 77, 13.0000, 40, 0 )
, ( 10947, 59, 55.0000, 4, 0 )
, ( 10948, 50, 16.2500, 9, 0 )
, ( 10948, 51, 53.0000, 40, 0 )
, ( 10948, 55, 24.0000, 4, 0 )
, ( 10949, 6, 25.0000, 12, 0 )
, ( 10949, 10, 31.0000, 30, 0 )
, ( 10949, 17, 39.0000, 6, 0 )
, ( 10949, 62, 49.3000, 60, 0 )
, ( 10950, 4, 22.0000, 5, 0 )
, ( 10951, 33, 2.5000, 15, 0.05 )
, ( 10951, 41, 9.6500, 6, 0.05 )
, ( 10951, 75, 7.7500, 50, 0.05 )
, ( 10952, 6, 25.0000, 16, 0.05 )
, ( 10952, 28, 45.6000, 2, 0 )
, ( 10953, 20, 81.0000, 50, 0.05 )
, ( 10953, 31, 12.5000, 50, 0.05 )
, ( 10954, 16, 17.4500, 28, 0.15 )
, ( 10954, 31, 12.5000, 25, 0.15 )
, ( 10954, 45, 9.5000, 30, 0 )
, ( 10954, 60, 34.0000, 24, 0.15 )
, ( 10955, 75, 7.7500, 12, 0.2 )
, ( 10956, 21, 10.0000, 12, 0 )
, ( 10956, 47, 9.5000, 14, 0 )
, ( 10956, 51, 53.0000, 8, 0 )
, ( 10957, 30, 25.8900, 30, 0 )
, ( 10957, 35, 18.0000, 40, 0 )
, ( 10957, 64, 33.2500, 8, 0 )
, ( 10958, 5, 21.3500, 20, 0 )
, ( 10958, 7, 30.0000, 6, 0 )
, ( 10958, 72, 34.8000, 5, 0 )
, ( 10959, 75, 7.7500, 20, 0.15 )
, ( 10960, 24, 4.5000, 10, 0.25 )
, ( 10960, 41, 9.6500, 24, 0 )
, ( 10961, 52, 7.0000, 6, 0.05 )
, ( 10961, 76, 18.0000, 60, 0 )
, ( 10962, 7, 30.0000, 45, 0 )
, ( 10962, 13, 6.0000, 77, 0 )
, ( 10962, 53, 32.8000, 20, 0 )
, ( 10962, 69, 36.0000, 9, 0 )
, ( 10962, 76, 18.0000, 44, 0 )
, ( 10963, 60, 34.0000, 2, 0.15 )
, ( 10964, 18, 62.5000, 6, 0 )
, ( 10964, 38, 263.5000, 5, 0 )
, ( 10964, 69, 36.0000, 10, 0 )
, ( 10965, 51, 53.0000, 16, 0 )
, ( 10966, 37, 26.0000, 8, 0 )
, ( 10966, 56, 38.0000, 12, 0.15 )
, ( 10966, 62, 49.3000, 12, 0.15 )
, ( 10967, 19, 9.2000, 12, 0 )
, ( 10967, 49, 20.0000, 40, 0 )
, ( 10968, 12, 38.0000, 30, 0 )
, ( 10968, 24, 4.5000, 30, 0 )
, ( 10968, 64, 33.2500, 4, 0 )
, ( 10969, 46, 12.0000, 9, 0 )
, ( 10970, 52, 7.0000, 40, 0.2 )
, ( 10971, 29, 123.7900, 14, 0 )
, ( 10972, 17, 39.0000, 6, 0 )
, ( 10972, 33, 2.5000, 7, 0 )
, ( 10973, 26, 31.2300, 5, 0 )
, ( 10973, 41, 9.6500, 6, 0 )
, ( 10973, 75, 7.7500, 10, 0 )
, ( 10974, 63, 43.9000, 10, 0 )
, ( 10975, 8, 40.0000, 16, 0 )
, ( 10975, 75, 7.7500, 10, 0 )
, ( 10976, 28, 45.6000, 20, 0 )
, ( 10977, 39, 18.0000, 30, 0 )
, ( 10977, 47, 9.5000, 30, 0 )
, ( 10977, 51, 53.0000, 10, 0 )
, ( 10977, 63, 43.9000, 20, 0 )
, ( 10978, 8, 40.0000, 20, 0.15 )
, ( 10978, 21, 10.0000, 40, 0.15 )
, ( 10978, 40, 18.4000, 10, 0 )
, ( 10978, 44, 19.4500, 6, 0.15 )
, ( 10979, 7, 30.0000, 18, 0 )
, ( 10979, 12, 38.0000, 20, 0 )
, ( 10979, 24, 4.5000, 80, 0 )
, ( 10979, 27, 43.9000, 30, 0 )
, ( 10979, 31, 12.5000, 24, 0 )
, ( 10979, 63, 43.9000, 35, 0 )
, ( 10980, 75, 7.7500, 40, 0.2 )
, ( 10981, 38, 263.5000, 60, 0 )
, ( 10982, 7, 30.0000, 20, 0 )
, ( 10982, 43, 46.0000, 9, 0 )
, ( 10983, 13, 6.0000, 84, 0.15 )
, ( 10983, 57, 19.5000, 15, 0 )
, ( 10984, 16, 17.4500, 55, 0 )
, ( 10984, 24, 4.5000, 20, 0 )
, ( 10984, 36, 19.0000, 40, 0 )
, ( 10985, 16, 17.4500, 36, 0.1 )
, ( 10985, 18, 62.5000, 8, 0.1 )
, ( 10985, 32, 32.0000, 35, 0.1 )
, ( 10986, 11, 21.0000, 30, 0 )
, ( 10986, 20, 81.0000, 15, 0 )
, ( 10986, 76, 18.0000, 10, 0 )
, ( 10986, 77, 13.0000, 15, 0 )
, ( 10987, 7, 30.0000, 60, 0 )
, ( 10987, 43, 46.0000, 6, 0 )
, ( 10987, 72, 34.8000, 20, 0 )
, ( 10988, 7, 30.0000, 60, 0 )
, ( 10988, 62, 49.3000, 40, 0.1 )
, ( 10989, 6, 25.0000, 40, 0 )
, ( 10989, 11, 21.0000, 15, 0 )
, ( 10989, 41, 9.6500, 4, 0 )
, ( 10990, 21, 10.0000, 65, 0 )
, ( 10990, 34, 14.0000, 60, 0.15 )
, ( 10990, 55, 24.0000, 65, 0.15 )
, ( 10990, 61, 28.5000, 66, 0.15 )
, ( 10991, 2, 19.0000, 50, 0.2 )
, ( 10991, 70, 15.0000, 20, 0.2 )
, ( 10991, 76, 18.0000, 90, 0.2 )
, ( 10992, 72, 34.8000, 2, 0 )
, ( 10993, 29, 123.7900, 50, 0.25 )
, ( 10993, 41, 9.6500, 35, 0.25 )
, ( 10994, 59, 55.0000, 18, 0.05 )
, ( 10995, 51, 53.0000, 20, 0 )
, ( 10995, 60, 34.0000, 4, 0 )
, ( 10996, 42, 14.0000, 40, 0 )
, ( 10997, 32, 32.0000, 50, 0 )
, ( 10997, 46, 12.0000, 20, 0.25 )
, ( 10997, 52, 7.0000, 20, 0.25 )
, ( 10998, 24, 4.5000, 12, 0 )
, ( 10998, 61, 28.5000, 7, 0 )
, ( 10998, 74, 10.0000, 20, 0 )
, ( 10998, 75, 7.7500, 30, 0 )
, ( 10999, 41, 9.6500, 20, 0.05 )
, ( 10999, 51, 53.0000, 15, 0.05 )
, ( 10999, 77, 13.0000, 21, 0.05 )
, ( 11000, 4, 22.0000, 25, 0.25 )
, ( 11000, 24, 4.5000, 30, 0.25 )
, ( 11000, 77, 13.0000, 30, 0 )
, ( 11001, 7, 30.0000, 60, 0 )
, ( 11001, 22, 21.0000, 25, 0 )
, ( 11001, 46, 12.0000, 25, 0 )
, ( 11001, 55, 24.0000, 6, 0 )
, ( 11002, 13, 6.0000, 56, 0 )
, ( 11002, 35, 18.0000, 15, 0.15 )
, ( 11002, 42, 14.0000, 24, 0.15 )
, ( 11002, 55, 24.0000, 40, 0 )
, ( 11003, 1, 18.0000, 4, 0 )
, ( 11003, 40, 18.4000, 10, 0 )
, ( 11003, 52, 7.0000, 10, 0 )
, ( 11004, 26, 31.2300, 6, 0 )
, ( 11004, 76, 18.0000, 6, 0 )
, ( 11005, 1, 18.0000, 2, 0 )
, ( 11005, 59, 55.0000, 10, 0 )
, ( 11006, 1, 18.0000, 8, 0 )
, ( 11006, 29, 123.7900, 2, 0.25 )
, ( 11007, 8, 40.0000, 30, 0 )
, ( 11007, 29, 123.7900, 10, 0 )
, ( 11007, 42, 14.0000, 14, 0 )
, ( 11008, 28, 45.6000, 70, 0.05 )
, ( 11008, 34, 14.0000, 90, 0.05 )
, ( 11008, 71, 21.5000, 21, 0 )
GO
INSERT dbo.[Order Details]
  (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES
( 11009, 24, 4.5000, 12, 0 )
, ( 11009, 36, 19.0000, 18, 0.25 )
, ( 11009, 60, 34.0000, 9, 0 )
, ( 11010, 7, 30.0000, 20, 0 )
, ( 11010, 24, 4.5000, 10, 0 )
, ( 11011, 58, 13.2500, 40, 0.05 )
, ( 11011, 71, 21.5000, 20, 0 )
, ( 11012, 19, 9.2000, 50, 0.05 )
, ( 11012, 60, 34.0000, 36, 0.05 )
, ( 11012, 71, 21.5000, 60, 0.05 )
, ( 11013, 23, 9.0000, 10, 0 )
, ( 11013, 42, 14.0000, 4, 0 )
, ( 11013, 45, 9.5000, 20, 0 )
, ( 11013, 68, 12.5000, 2, 0 )
, ( 11014, 41, 9.6500, 28, 0.1 )
, ( 11015, 30, 25.8900, 15, 0 )
, ( 11015, 77, 13.0000, 18, 0 )
, ( 11016, 31, 12.5000, 15, 0 )
, ( 11016, 36, 19.0000, 16, 0 )
, ( 11017, 3, 10.0000, 25, 0 )
, ( 11017, 59, 55.0000, 110, 0 )
, ( 11017, 70, 15.0000, 30, 0 )
, ( 11018, 12, 38.0000, 20, 0 )
, ( 11018, 18, 62.5000, 10, 0 )
, ( 11018, 56, 38.0000, 5, 0 )
, ( 11019, 46, 12.0000, 3, 0 )
, ( 11019, 49, 20.0000, 2, 0 )
, ( 11020, 10, 31.0000, 24, 0.15 )
, ( 11021, 2, 19.0000, 11, 0.25 )
, ( 11021, 20, 81.0000, 15, 0 )
, ( 11021, 26, 31.2300, 63, 0 )
, ( 11021, 51, 53.0000, 44, 0.25 )
, ( 11021, 72, 34.8000, 35, 0 )
, ( 11022, 19, 9.2000, 35, 0 )
, ( 11022, 69, 36.0000, 30, 0 )
, ( 11023, 7, 30.0000, 4, 0 )
, ( 11023, 43, 46.0000, 30, 0 )
, ( 11024, 26, 31.2300, 12, 0 )
, ( 11024, 33, 2.5000, 30, 0 )
, ( 11024, 65, 21.0500, 21, 0 )
, ( 11024, 71, 21.5000, 50, 0 )
, ( 11025, 1, 18.0000, 10, 0.1 )
, ( 11025, 13, 6.0000, 20, 0.1 )
, ( 11026, 18, 62.5000, 8, 0 )
, ( 11026, 51, 53.0000, 10, 0 )
, ( 11027, 24, 4.5000, 30, 0.25 )
, ( 11027, 62, 49.3000, 21, 0.25 )
, ( 11028, 55, 24.0000, 35, 0 )
, ( 11028, 59, 55.0000, 24, 0 )
, ( 11029, 56, 38.0000, 20, 0 )
, ( 11029, 63, 43.9000, 12, 0 )
, ( 11030, 2, 19.0000, 100, 0.25 )
, ( 11030, 5, 21.3500, 70, 0 )
, ( 11030, 29, 123.7900, 60, 0.25 )
, ( 11030, 59, 55.0000, 100, 0.25 )
, ( 11031, 1, 18.0000, 45, 0 )
, ( 11031, 13, 6.0000, 80, 0 )
, ( 11031, 24, 4.5000, 21, 0 )
, ( 11031, 64, 33.2500, 20, 0 )
, ( 11031, 71, 21.5000, 16, 0 )
, ( 11032, 36, 19.0000, 35, 0 )
, ( 11032, 38, 263.5000, 25, 0 )
, ( 11032, 59, 55.0000, 30, 0 )
, ( 11033, 53, 32.8000, 70, 0.1 )
, ( 11033, 69, 36.0000, 36, 0.1 )
, ( 11034, 21, 10.0000, 15, 0.1 )
, ( 11034, 44, 19.4500, 12, 0 )
, ( 11034, 61, 28.5000, 6, 0 )
, ( 11035, 1, 18.0000, 10, 0 )
, ( 11035, 35, 18.0000, 60, 0 )
, ( 11035, 42, 14.0000, 30, 0 )
, ( 11035, 54, 7.4500, 10, 0 )
, ( 11036, 13, 6.0000, 7, 0 )
, ( 11036, 59, 55.0000, 30, 0 )
, ( 11037, 70, 15.0000, 4, 0 )
, ( 11038, 40, 18.4000, 5, 0.2 )
, ( 11038, 52, 7.0000, 2, 0 )
, ( 11038, 71, 21.5000, 30, 0 )
, ( 11039, 28, 45.6000, 20, 0 )
, ( 11039, 35, 18.0000, 24, 0 )
, ( 11039, 49, 20.0000, 60, 0 )
, ( 11039, 57, 19.5000, 28, 0 )
, ( 11040, 21, 10.0000, 20, 0 )
, ( 11041, 2, 19.0000, 30, 0.2 )
, ( 11041, 63, 43.9000, 30, 0 )
, ( 11042, 44, 19.4500, 15, 0 )
, ( 11042, 61, 28.5000, 4, 0 )
, ( 11043, 11, 21.0000, 10, 0 )
, ( 11044, 62, 49.3000, 12, 0 )
, ( 11045, 33, 2.5000, 15, 0 )
, ( 11045, 51, 53.0000, 24, 0 )
, ( 11046, 12, 38.0000, 20, 0.05 )
, ( 11046, 32, 32.0000, 15, 0.05 )
, ( 11046, 35, 18.0000, 18, 0.05 )
, ( 11047, 1, 18.0000, 25, 0.25 )
, ( 11047, 5, 21.3500, 30, 0.25 )
, ( 11048, 68, 12.5000, 42, 0 )
, ( 11049, 2, 19.0000, 10, 0.2 )
, ( 11049, 12, 38.0000, 4, 0.2 )
, ( 11050, 76, 18.0000, 50, 0.1 )
, ( 11051, 24, 4.5000, 10, 0.2 )
, ( 11052, 43, 46.0000, 30, 0.2 )
, ( 11052, 61, 28.5000, 10, 0.2 )
, ( 11053, 18, 62.5000, 35, 0.2 )
, ( 11053, 32, 32.0000, 20, 0 )
, ( 11053, 64, 33.2500, 25, 0.2 )
, ( 11054, 33, 2.5000, 10, 0 )
, ( 11054, 67, 14.0000, 20, 0 )
, ( 11055, 24, 4.5000, 15, 0 )
, ( 11055, 25, 14.0000, 15, 0 )
, ( 11055, 51, 53.0000, 20, 0 )
, ( 11055, 57, 19.5000, 20, 0 )
, ( 11056, 7, 30.0000, 40, 0 )
, ( 11056, 55, 24.0000, 35, 0 )
, ( 11056, 60, 34.0000, 50, 0 )
, ( 11057, 70, 15.0000, 3, 0 )
, ( 11058, 21, 10.0000, 3, 0 )
, ( 11058, 60, 34.0000, 21, 0 )
, ( 11058, 61, 28.5000, 4, 0 )
, ( 11059, 13, 6.0000, 30, 0 )
, ( 11059, 17, 39.0000, 12, 0 )
, ( 11059, 60, 34.0000, 35, 0 )
, ( 11060, 60, 34.0000, 4, 0 )
, ( 11060, 77, 13.0000, 10, 0 )
, ( 11061, 60, 34.0000, 15, 0 )
, ( 11062, 53, 32.8000, 10, 0.2 )
, ( 11062, 70, 15.0000, 12, 0.2 )
, ( 11063, 34, 14.0000, 30, 0 )
, ( 11063, 40, 18.4000, 40, 0.1 )
, ( 11063, 41, 9.6500, 30, 0.1 )
, ( 11064, 17, 39.0000, 77, 0.1 )
, ( 11064, 41, 9.6500, 12, 0 )
, ( 11064, 53, 32.8000, 25, 0.1 )
, ( 11064, 55, 24.0000, 4, 0.1 )
, ( 11064, 68, 12.5000, 55, 0 )
, ( 11065, 30, 25.8900, 4, 0.25 )
, ( 11065, 54, 7.4500, 20, 0.25 )
, ( 11066, 16, 17.4500, 3, 0 )
, ( 11066, 19, 9.2000, 42, 0 )
, ( 11066, 34, 14.0000, 35, 0 )
, ( 11067, 41, 9.6500, 9, 0 )
, ( 11068, 28, 45.6000, 8, 0.15 )
, ( 11068, 43, 46.0000, 36, 0.15 )
, ( 11068, 77, 13.0000, 28, 0.15 )
, ( 11069, 39, 18.0000, 20, 0 )
, ( 11070, 1, 18.0000, 40, 0.15 )
, ( 11070, 2, 19.0000, 20, 0.15 )
, ( 11070, 16, 17.4500, 30, 0.15 )
, ( 11070, 31, 12.5000, 20, 0 )
, ( 11071, 7, 30.0000, 15, 0.05 )
, ( 11071, 13, 6.0000, 10, 0.05 )
, ( 11072, 2, 19.0000, 8, 0 )
, ( 11072, 41, 9.6500, 40, 0 )
, ( 11072, 50, 16.2500, 22, 0 )
, ( 11072, 64, 33.2500, 130, 0 )
, ( 11073, 11, 21.0000, 10, 0 )
, ( 11073, 24, 4.5000, 20, 0 )
, ( 11074, 16, 17.4500, 14, 0.05 )
, ( 11075, 2, 19.0000, 10, 0.15 )
, ( 11075, 46, 12.0000, 30, 0.15 )
, ( 11075, 76, 18.0000, 2, 0.15 )
, ( 11076, 6, 25.0000, 20, 0.25 )
, ( 11076, 14, 23.2500, 20, 0.25 )
, ( 11076, 19, 9.2000, 10, 0.25 )
, ( 11077, 2, 19.0000, 24, 0.2 )
, ( 11077, 3, 10.0000, 4, 0 )
, ( 11077, 4, 22.0000, 1, 0 )
, ( 11077, 6, 25.0000, 1, 0.02 )
, ( 11077, 7, 30.0000, 1, 0.05 )
, ( 11077, 8, 40.0000, 2, 0.1 )
, ( 11077, 10, 31.0000, 1, 0 )
, ( 11077, 12, 38.0000, 2, 0.05 )
, ( 11077, 13, 6.0000, 4, 0 )
, ( 11077, 14, 23.2500, 1, 0.03 )
, ( 11077, 16, 17.4500, 2, 0.03 )
, ( 11077, 20, 81.0000, 1, 0.04 )
, ( 11077, 23, 9.0000, 2, 0 )
, ( 11077, 32, 32.0000, 1, 0 )
, ( 11077, 39, 18.0000, 2, 0.05 )
, ( 11077, 41, 9.6500, 3, 0 )
, ( 11077, 46, 12.0000, 3, 0.02 )
, ( 11077, 52, 7.0000, 2, 0 )
, ( 11077, 55, 24.0000, 2, 0 )
, ( 11077, 60, 34.0000, 2, 0.06 )
, ( 11077, 64, 33.2500, 2, 0.03 )
, ( 11077, 66, 17.0000, 1, 0 )
, ( 11077, 73, 15.0000, 2, 0.01 )
, ( 11077, 75, 7.7500, 4, 0 )
, ( 11077, 77, 13.0000, 2, 0 )
GO
 USE master
 GO
