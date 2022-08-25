USE tempdb

CREATE DATABASE PUBSSTAGE
GO
USE PUBSSTAGE
GO

IF EXISTS(SELECT name FROM sys.tables WHERE name = 'StageAuthor')
BEGIN
	DROP TABLE dbo.StageAuthor
END


--1. Tabla para stage de Author
CREATE TABLE dbo.StageAuthor (
	AuthorId VARCHAR(11) NOT NULL,
	LastName VARCHAR(40) NOT NULL,
	FirstName VARCHAR(40) NOT NULL,
	Phone CHAR(12) NOT NULL,
	[Address] VARCHAR(40) NULL,
	City VARCHAR(20) NULL,
	[State] CHAR(2) NULL,
	Zip CHAR(5) NULL,
	[Contract] BIT NOT NULL,
	ETLLoad DATETIME NOT NULL,
	ETLExecution INT NOT NULL,
)


IF EXISTS(SELECT name FROM sys.tables WHERE name = 'StageDiscount')
BEGIN
	DROP TABLE dbo.StageDiscount
END


--2. Tabla para stage de Discount
CREATE TABLE dbo.StageDiscount (
	DiscountType VARCHAR(40) NOT NULL,
	StoreId CHAR(4) NULL,
	Lowqty SMALLINT NULL,
	Highqty SMALLINT NULL,
	Discount DECIMAL(4,2) NOT NULL,
	ETLLoad DATETIME NOT NULL,
	ETLExecution INT NOT NULL,
)


IF EXISTS(SELECT name FROM sys.tables WHERE name = 'StageEmployee')
BEGIN
	DROP TABLE dbo.StageEmployee
END


--3. Tabla para stage de Employee
CREATE TABLE dbo.StageEmployee (
	EmployeeId CHAR(9) NOT NULL,
	FirstName VARCHAR(20) NOT NULL,
	Minit CHAR(1) null,
	LastName VARCHAR(30) NOT NULL,
	JobId SMALLINT NULL,
	JobLevel TINYINT NULL,
	PubId CHAR(4) NOT NULL,
	HireDate datetime NOT NULL,
	ETLLoad DATETIME NOT NULL,
	ETLExecution INT NOT NULL
)


IF EXISTS(SELECT name FROM sys.tables WHERE name = 'StageJob')
BEGIN
	DROP TABLE dbo.StageJob
END


--4. Tabla para stage de Jobs
CREATE TABLE dbo.StageJob(
	JobId SMALLINT NOT NULL,
	JobDescent VARCHAR(50) NOT NULL,
	MinimunLevel TINYINT NOT NULL,
	MaximunLevel TINYINT NOT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)


IF EXISTS(SELECT name FROM sys.tables WHERE name = 'StagePubsInfo')
BEGIN
	DROP TABLE dbo.StagePubsInfo
END


--5. Tabla para stage de PubsInfo
CREATE TABLE dbo.StagePubsInfo(
	PubId CHAR(4) NOT NULL,
	Logo IMAGE NULL,
	PresentationInfo TEXT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)


IF EXISTS(SELECT name FROM sys.tables WHERE name = 'StagePublisher')
BEGIN
	DROP TABLE dbo.StagePublisher
END


--6. Tabla para stage Publisher
CREATE TABLE dbo.StagePublisher(
	PubId CHAR(4) NOT NULL,
	PubName VARCHAR(40) NULL,
	City VARCHAR(20) NULL,
	[State] CHAR(2) NULL,
	Country VARCHAR(30) NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)


IF EXISTS(SELECT name FROM sys.tables WHERE name = 'StageRoysched')
BEGIN
	DROP TABLE dbo.StageRoysched
END


--7. Tabla para stage de Roysched
CREATE TABLE dbo.StageRoysched(
	TitleId VARCHAR(6) NOT NULL,
	LowRange INT NULL,
	HighRange INT NULL,
	Royalty INT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)


IF EXISTS(SELECT name FROM sys.tables WHERE name = 'StageSale')
BEGIN
	DROP TABLE dbo.StageSale
END


--8. Tabla para stage de Sale
CREATE TABLE dbo.StageSale(
	StoreId CHAR(4) NOT NULL,
	OrderNumber VARCHAR(20) NOT NULL,
	OrderDate DATETIME NOT NULL,
	Quantity SMALLINT NOT NULL,
	PayTerms VARCHAR(12) NOT NULL,
	TitleId VARCHAR(6) NOT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)


IF EXISTS(SELECT name FROM sys.tables WHERE name = 'StageStore')
BEGIN
	DROP TABLE dbo.StageStore
END


--9. Tabla para stage de Store
CREATE TABLE dbo.StageStore(
	StoreId CHAR(4) NOT NULL,
	StoreName VARCHAR(40) NULL,
	StoreAddress VARCHAR(40) NULL,
	City VARCHAR(20) NULL,
	[State] CHAR(2) NULL,
	Zip CHAR(5) NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)



IF EXISTS(SELECT name FROM sys.tables WHERE name = 'StageTitle')
BEGIN
	DROP TABLE dbo.StageTitle
END

--10. Tabla para stage de Titles
CREATE TABLE dbo.StageTitle(
	TitleId VARCHAR(6) NOT NULL,
	Title VARCHAR(80) NOT NULL,
	[Type] VARCHAR(12) NOT NULL,
	PubId CHAR(4) NOT NULL,
	Price MONEY NULL,
	Advance MONEY NULL,
	Royalty INT NULL,
	YtdSales INT NULL,
	Notes VARCHAR(200),
	PubDate DATETIME NOT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)


IF EXISTS(SELECT name FROM sys.tables WHERE name = 'StageTitlesAuthor')
BEGIN
	DROP TABLE dbo.StageTitlesAuthor
END


--11. Tabla para stage de TitleAuthor
CREATE TABLE dbo.StageTitlesAuthor(
	AutorId VARCHAR(11) NOT NULL,
	TittleId VARCHAR(6) NOT NULL,
	AutorOrder TINYINT NULL,
	RoyalTyper INT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)

use PUBSSTAGE

select * from StageDiscount

