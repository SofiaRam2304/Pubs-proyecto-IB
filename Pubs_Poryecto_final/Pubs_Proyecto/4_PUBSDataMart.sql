CREATE DATABASE PUBSDATAMART
go

USE PUBSDATAMART


--1. Tabla de dimension de Author

IF EXISTS(SELECT name FROM sys.tables WHERE name = 'dbo.DimTitlesAuthorsInfo')
BEGIN
	DROP TABLE dbo.DimTitlesAuthorsInfo
END

CREATE TABLE dbo.DimTitlesAuthorsInfo (
	TitleAuthorInfoKey INT IDENTITY(1,1) 
	CONSTRAINT PK_AuthorKey_DimAuthor PRIMARY KEY CLUSTERED,
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

--2. Tabla para Dimension de Discount

IF EXISTS(SELECT name FROM sys.tables WHERE name = 'dbo.DimStoresDiscounts')
BEGIN
	DROP TABLE dbo.DimStoresDiscounts
END

CREATE TABLE dbo.DimStoresDiscounts (
	DiscountKey INT IDENTITY(1,1) 
	CONSTRAINT PK_DiscountKey_DimDiscount PRIMARY KEY CLUSTERED,
	DiscountType VARCHAR(40) NOT NULL,
	StoreId CHAR(4) NULL,
	Lowqty SMALLINT NULL,
	Highqty SMALLINT NULL,
	Discount DECIMAL(4,2) NOT NULL,
	ETLLoad DATETIME NOT NULL,
	ETLExecution INT NOT NULL,
)

--3. Tabla para Dimension de dbo.DimPublisherEmployeeJobs

IF EXISTS(SELECT name FROM sys.tables WHERE name = 'dbo.DimPublisherEmployeeJobs')
BEGIN
	DROP TABLE dbo.DimPublisherEmployeeJobs
END

CREATE TABLE dbo.DimPublisherEmployeeJobs(
	JobKey INT IDENTITY(1,1) 
	CONSTRAINT PK_JobKey_DimJob PRIMARY KEY CLUSTERED,
	JobId SMALLINT NOT NULL,
	JobDescent VARCHAR(50) NOT NULL,
	MinimunLevel TINYINT NOT NULL,
	MaximunLevel TINYINT NOT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)

--4. Tabla para Dimension de dbo.DimPublisherEmployee

IF EXISTS(SELECT name FROM sys.tables WHERE name = 'dbo.DimPublisherEmployee')
BEGIN
	DROP TABLE dbo.DimPublisherEmployee
END

CREATE TABLE dbo.DimPublisherEmployee (
	EmployeeKey INT IDENTITY(1,1) 
	CONSTRAINT PK_EmployeeKey_DimEmployee PRIMARY KEY CLUSTERED,
	JobKey INT,
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
	CONSTRAINT FK_JobKey_DimEmployee
	FOREIGN KEY (JobKey) REFERENCES dbo.DimPublisherEmployeeJobs(JobKey)
)

--5. Tabla para Dimension de DimPublisherInfo

IF EXISTS(SELECT name FROM sys.tables WHERE name = 'dbo.DimPublisherInfo')
BEGIN
	DROP TABLE dbo.DimPublisherInfo
END

CREATE TABLE dbo.DimPublisherInfo(
	PubInfoKey INT IDENTITY(1,1) 
	CONSTRAINT PK_PubInfoKey_DimPubInfo PRIMARY KEY CLUSTERED,
	PubId CHAR(4) NOT NULL,
	Logo IMAGE NULL,
	PresentationInfo TEXT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)

--6. Tabla para Dimension dbo.DimPublisher

IF EXISTS(SELECT name FROM sys.tables WHERE name = 'dbo.DimPublisher')
BEGIN
	DROP TABLE dbo.DimPublisher
END

CREATE TABLE dbo.DimPublisher(
	PublisherKey INT IDENTITY(1,1) 
	CONSTRAINT PK_Publisher_DimPublisher PRIMARY KEY CLUSTERED,
	EmployeeKey INT,
	PubInfoKey INT,
	PubId CHAR(4) NOT NULL,
	PubName VARCHAR(40) NULL,
	City VARCHAR(20) NULL,
	[State] CHAR(2) NULL,
	Country VARCHAR(30) NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
	CONSTRAINT FK_EmployeeKey_DimEmployee
	FOREIGN KEY (EmployeeKey) REFERENCES dbo.DimPublisherEmployee(EmployeeKey),
	CONSTRAINT FK_PubInfoKey_DimEmployee
	FOREIGN KEY (PubInfoKey) REFERENCES dbo.DimPublisherInfo(PubInfoKey)
)

--7. Tabla para Dimension de dbo.DimStore

IF EXISTS(SELECT name FROM sys.tables WHERE name = 'dbo.DimStore')
BEGIN
	DROP TABLE dbo.DimStore
END

CREATE TABLE dbo.DimStore(
	StoreKey INT IDENTITY(1,1) 
	CONSTRAINT PK_Store_DimStore PRIMARY KEY CLUSTERED,
	DiscountKey INT,
	StoreId CHAR(4) NOT NULL,
	StoreName VARCHAR(40) NULL,
	StoreAddress VARCHAR(40) NULL,
	City VARCHAR(20) NULL,
	[State] CHAR(2) NULL,
	Zip CHAR(5) NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
	CONSTRAINT FK_StoreKey_DimStore
	FOREIGN KEY (DiscountKey) REFERENCES dbo.DimStoresDiscounts(DiscountKey)
)

--8. Tabla para Dimension de Roysched

IF EXISTS(SELECT name FROM sys.tables WHERE name = 'dbo.DimRoysched')
BEGIN
	DROP TABLE dbo.DimRoysched
END

CREATE TABLE dbo.DimRoysched(
	RoySchedKey INT IDENTITY(1,1) 
	CONSTRAINT PK_RoyShed_DimRoyShed PRIMARY KEY CLUSTERED,
	TitleId VARCHAR(6) NOT NULL,
	LowRange INT NULL,
	HighRange INT NULL,
	Royalty INT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)

--9. Tabla para Dimension de TitleAuthor

IF EXISTS(SELECT name FROM sys.tables WHERE name = 'dbo.DimTitlesAuthor')
BEGIN
	DROP TABLE dbo.DimTitlesAuthor
END

CREATE TABLE dbo.DimTitlesAuthor(
	TitlesAuthorKey INT IDENTITY(1,1) 
	CONSTRAINT PK_Title_DimTitle PRIMARY KEY CLUSTERED,
	TitleAuthorInfoKey INT,
	AutorId VARCHAR(11) NOT NULL,
	TittleId VARCHAR(6) NOT NULL,
	AutorOrder TINYINT NULL,
	RoyalTyper INT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
	CONSTRAINT FK_TitleAuthorInfoKey_DimTitlesAuthor
	FOREIGN KEY (TitleAuthorInfoKey) REFERENCES dbo.DimTitlesAuthorsInfo(TitleAuthorInfoKey)
)

--10. Tabla para Dimension de Titles

IF EXISTS(SELECT name FROM sys.tables WHERE name = 'dbo.DimTitle')
BEGIN
	DROP TABLE dbo.DimTitle
END

CREATE TABLE dbo.DimTitle(
	TitleKey INT IDENTITY(1,1) 
	CONSTRAINT PK_TitleKey_DimTitle PRIMARY KEY CLUSTERED,
	TitlesAuthorKey INT,
	RoySchedKey INT,
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
	CONSTRAINT FK_TitlesAuthorKey_DimTitle
	FOREIGN KEY (TitlesAuthorKey) REFERENCES dbo.DimTitlesAuthor(TitlesAuthorKey),
	CONSTRAINT FK_RoySchedKey_DimTitle
	FOREIGN KEY (RoySchedKey) REFERENCES dbo.DimRoysched(RoySchedKey)
)
go

--11 Tabla para DimTime
IF EXISTS(SELECT name FROM sys.tables WHERE name = 'dbo.DimTime')
BEGIN
	DROP TABLE dbo.DimTime
END

CREATE TABLE dbo.DimTime (
	[idTime] INT IDENTITY(1,1)
	CONSTRAINT PK_idTime_DimTime PRIMARY KEY CLUSTERED,
	[Date] DATETIME NOT NULL,
	[Year] INT NOT NULL,
	[Quarter] INT NOT NULL,
	[Month] INT NOT NULL,
	[Week] INT NOT NULL,
	[DayOfYear] INT NOT NULL,
	[DayOfMonth] INT NOT NULL,
	[DayOfWeek] INT NOT NULL,
	[IsWeekend] INT NULL,
	[IsHoliday] INT NULL,
	[Comments] VARCHAR(50) NULL,
	[CalendarWeek] INT NOT NULL,
	[CalendarWorkingWeek] INT NOT NULL,
	[LeapYear] INT NOT NULL,
	ETLLoad DATETIME,
	ETLExecution INT
)
GO

--12. Tabla para Fact de Sale

IF EXISTS(SELECT name FROM sys.tables WHERE name = 'dbo.FactSale')
BEGIN
	DROP TABLE dbo.FactSale
END

CREATE TABLE dbo.FactSale(
	salesKey INT IDENTITY(1,1),
	TitleKey INT,
	StoreKey INT,
	PublisherKey INT,
	[idTime] INT,
	StoreId CHAR(4) NOT NULL,
	OrderNumber VARCHAR(20) NOT NULL,
	OrderDate DATETIME NOT NULL,
	Quantity SMALLINT NOT NULL,
	PayTerms VARCHAR(12) NOT NULL,
	TitleId VARCHAR(6) NOT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
	CONSTRAINT FK_TitlesKey_FactSales
	FOREIGN KEY (TitleKey) REFERENCES dbo.DimTitle(TitleKey),
	CONSTRAINT FK_StoreKey_DimTitle
	FOREIGN KEY (StoreKey) REFERENCES dbo.DimStore(StoreKey),
	CONSTRAINT FK_PublisherKey_DimTitle
	FOREIGN KEY (PublisherKey) REFERENCES dbo.DimPublisher(PublisherKey),
	CONSTRAINT FK_IdTime_DimTitle
	FOREIGN KEY ([idTime]) REFERENCES dbo.DimTime([idTime]),
)

 --Consulta que obtiene el origen de los datos
--SELECT	DISTINCT(OrderDate),
--		YEAR(OrderDate) AS [Year],
--		DATEPART(QUARTER, OrderDate) AS [Quarter],
--		DATEPART(MONTH, OrderDate) AS [Month],
--		DATEPART(WEEK, OrderDate) AS [Week],
--		DATEPART(DAYOFYEAR, OrderDate) AS [DayOfYear],
--		DATEPART(DAY, OrderDate) AS [DateOfMonth],
--		DATEPART(WEEKDAY, OrderDate - 1) AS [DayOfWeek],
--		IIF ((DATEPART(WEEKDAY, OrderDate - 1) = 6 OR DATEPART(WEEKDAY, OrderDate - 1) = 7), 1, 0) AS [IsWeekend],
--		-- Completar los días feriado (Holidays) feriados de Estados Unidos
--		IIF ((DATEPART(MONTH, OrderDate) = 1 AND DATEPART(DAY, OrderDate) = 1) OR 
--		     (DATEPART(MONTH, OrderDate) = 12 AND DATEPART(DAY, OrderDate) = 25), 1, 0) AS [IsHoliday],
--		'1 -> (V) / 0 -> (F)' AS [Comments],
--		DATEPART(WEEK, OrderDate) AS [CalendarWeek],
--		DATEPART(WEEK, OrderDate) AS [CalendarWorkingWeek],
--		IIF (DATEPART(DAYOFYEAR, OrderDate) = 366, 1, 0) AS [LeapYear]
--FROM [NORTHWND].dbo.Orders

UPDATE dbo.DimPublisher
SET  PubName = ?,
	City = ?,
	[State] = ?,
	Country = ?
WHERE PubId = ?

use PUBSMETADATA

UPDATE dbo.ETLExecution
SET etlCountRows = ?
	[etlCountNewRegister] = ?
	[etlCountModifiedRegister] = ?
WHERE id = ?