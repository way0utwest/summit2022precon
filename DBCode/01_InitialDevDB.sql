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
/****** Object:  Table [dbo].[flyway_schema_history]    Script Date: 22/08/2022 20:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[flyway_schema_history](
	[installed_rank] [int] NOT NULL,
	[version] [nvarchar](50) NULL,
	[description] [nvarchar](200) NULL,
	[type] [nvarchar](20) NOT NULL,
	[script] [nvarchar](1000) NOT NULL,
	[checksum] [int] NULL,
	[installed_by] [nvarchar](100) NOT NULL,
	[installed_on] [datetime] NOT NULL,
	[execution_time] [int] NOT NULL,
	[success] [bit] NOT NULL,
 CONSTRAINT [flyway_schema_history_pk] PRIMARY KEY CLUSTERED 
(
	[installed_rank] ASC
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
/****** Object:  Index [flyway_schema_history_s_idx]    Script Date: 22/08/2022 20:39:11 ******/
CREATE NONCLUSTERED INDEX [flyway_schema_history_s_idx] ON [dbo].[flyway_schema_history]
(
	[success] ASC
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
ALTER TABLE [dbo].[flyway_schema_history] ADD  DEFAULT (getdate()) FOR [installed_on]
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
ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [CK_Discount] CHECK  (([Discount]>=(0) AND [Discount]<=(1)))
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [CK_Discount]
GO
ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [CK_Quantity] CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [CK_Quantity]
GO
ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [CK_UnitPrice] CHECK  (([UnitPrice]>=(0)))
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [CK_UnitPrice]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [CK_Products_UnitPrice] CHECK  (([UnitPrice]>=(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_Products_UnitPrice]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [CK_ReorderLevel] CHECK  (([ReorderLevel]>=(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_ReorderLevel]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [CK_UnitsInStock] CHECK  (([UnitsInStock]>=(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_UnitsInStock]
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

CREATE PROCEDURE [dbo].[Ten Most Expensive Products]
AS
SET ROWCOUNT 10;
SELECT Products.ProductName AS TenMostExpensiveProducts,
       Products.UnitPrice
FROM Products
ORDER BY Products.UnitPrice DESC;
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
( N'�LAND ISLANDS', N'AX', NULL ), 
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
( N'SAINT BARTH�LEMY', N'BL', NULL ), 
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
( N'C�TE D''IVOIRE', N'CI', NULL ), 
( N'COOK ISLANDS', N'CK', NULL ), 
( N'CHILE', N'CL', NULL ), 
( N'CAMEROON', N'CM', NULL ), 
( N'CHINA', N'CN', NULL ), 
( N'COLOMBIA', N'CO', NULL ), 
( N'COSTA RICA', N'CR', NULL ), 
( N'CUBA', N'CU', NULL ), 
( N'CAPE VERDE', N'CV', NULL ), 
( N'CURA�AO', N'CW', NULL ), 
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
( N'R�UNION', N'RE', NULL ), 
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
