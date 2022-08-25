USE tempdb
GO

IF EXISTS(SELECT name FROM SYS.databases WHERE name='PUBSLOAD')
BEGIN
	DROP DATABASE PUBSLOAD
END
GO

CREATE DATABASE PUBSLOAD
GO

USE PUBSLOAD
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Titles(
	title_id VARCHAR(6) NOT NULL,
	Title VARCHAR(80) NOT NULL,
	[type] VARCHAR(12) NOT NULL,
	pub_id CHAR(4) NOT NULL,
	price MONEY NULL,
	advance MONEY NULL,
	royalty INT NULL,
	ytd_sales INT NULL,
	notes VARCHAR(200),
	pubdate DATETIME NOT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)
GO

CREATE TABLE dbo.Author(
	au_id VARCHAR(11) NOT NULL,
	au_lname VARCHAR(40) NOT NULL,
	au_fname VARCHAR(20) NOT NULL,
	phone CHAR(12) NOT NULL,
	[address] VARCHAR(40) NULL,
	city VARCHAR(20) NULL,
	[state] CHAR(2) NULL,
	zip CHAR(5) NULL,
	[contract] BIT NOT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)
GO

CREATE TABLE dbo.discounts(
	discounttype VARCHAR(40) NOT NULL,
	stor_id CHAR(4) NULL,
	lowqty SMALLINT NULL,
	highqty SMALLINT NULL,
	discount DECIMAL(4,2) NOT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)
GO

CREATE TABLE dbo.employee(
	emp_id CHAR(9) NOT NULL,
	fname VARCHAR(20) NOT NULL,
	minit CHAR(1) NULL,
	lname VARCHAR(30) NOT NULL,
	job_id SMALLINT NOT NULL,
	job_lvl TINYINT NULL,
	pub_id CHAR(4) NOT NULL,
	hire_date DATETIME NOT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)
GO

CREATE TABLE dbo.jobs(
	job_id SMALLINT NOT NULL,
	job_desc VARCHAR(50) NOT NULL,
	min_lvl TINYINT NOT NULL,
	max_lvl TINYINT NOT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)
GO

CREATE TABLE dbo.pub_info(
	pub_id CHAR(4) NOT NULL,
	logo IMAGE NULL,
	pr_info TEXT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)
GO

CREATE TABLE dbo.publishers(
	pub_id CHAR(4) NOT NULL,
	pub_name VARCHAR(40) NULL,
	city VARCHAR(20) NULL,
	[state] CHAR(2) NULL,
	country VARCHAR(30) NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)
GO

CREATE TABLE dbo.roysched(
	title_id VARCHAR(6) NOT NULL,
	lorange INT NULL,
	hirange INT NULL,
	royalty INT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)
GO

CREATE TABLE dbo.sales(
	stor_id CHAR(4) NOT NULL,
	ord_num VARCHAR(20) NOT NULL,
	ord_date DATETIME NOT NULL,
	qty SMALLINT NOT NULL,
	payterms VARCHAR(12) NOT NULL,
	title_id VARCHAR(6) NOT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)
GO

CREATE TABLE dbo.stores(
	stor_id CHAR(4) NOT NULL,
	stor_name VARCHAR(40) NULL,
	stor_address VARCHAR(40) NULL,
	city VARCHAR(20) NULL,
	[state] CHAR(2) NULL,
	zip CHAR(5) NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)
GO

CREATE TABLE titleauthor(
	au_id VARCHAR(11) NOT NULL,
	title_id VARCHAR(6) NOT NULL,
	au_ord TINYINT NULL,
	royaltyper INT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)
GO

SELECT * FROM dbo.Author
GO

SELECT * FROM dbo.discounts
GO

SELECT * FROM dbo.employee
GO

SELECT * FROM dbo.jobs
GO

SELECT * FROM dbo.pub_info
GO

SELECT * FROM dbo.pub_info
GO

SELECT * FROM dbo.publishers
GO

SELECT * FROM dbo.roysched
GO

SELECT * FROM dbo.sales
GO

SELECT * FROM dbo.stores
GO

SELECT * FROM dbo.titleauthor
GO

SELECT * FROM dbo.Titles
GO

--Llamada de la tabla ETLExecution desde la base de datos PUBSMETADATA a PUBSLOAD
SELECT * FROM PUBSMETADATA.dbo.ETLExecution
GO

-- Seleccionar el último id de ETLExecution
SELECT TOP(1) id
FROM dbo.ETLExecution
WHERE packageName = ?
ORDER BY id DESC

-- Actualizar el total de filas insertadas en ETLExecution
UPDATE dbo.ETLExecution
SET etlCountRows = ?
WHERE id = ?