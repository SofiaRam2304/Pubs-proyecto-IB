Use PUBSLOAD


--#1 Conversion Data Flow Employee
SELECT 
        Emp_id,
        CAST([fname] AS VARCHAR(20)) AS FirstName,
        CAST([minit] AS CHAR(1)) AS Minit,
        CAST([lname] AS VARCHAR(30)) AS LastName,
        CAST([job_id] AS SMALLINT) AS JobId,
        CAST([job_lvl] AS TINYINT) AS JobLevel,
        CAST([pub_id] AS CHAR(4)) AS PubId,
        CAST([hire_date] AS DATETIME) AS HireDate
FROM PUBSLOAD.dbo.Employee
WHERE ETLExecution = 8

--#2 Conversion Data Flow Job
/*
CREATE TABLE dbo.StageJob(
	JobId SMALLINT NOT NULL,
	JobDescent VARCHAR(50) NOT NULL,
	MinimunLevel TINYINT NOT NULL,
	MaximunLevel TINYINT NOT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)
*/

SELECT 
        job_id,
        CAST([job_desc] AS VARCHAR(50)) AS JobDescent,
        CAST([min_lvl] AS TINYINT) AS MinimunLevel,
        CAST([max_lvl] AS TINYINT) AS MaximunLevel,
FROM PUBSLOAD.dbo.jobs
WHERE ETLExecution = ?

--#3 Conversion Data Flow Author
/*
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
*/

SELECT 
        au_id,
        CAST([au_lname] AS VARCHAR(40)) AS LastName,
		CAST([au_fname] AS VARCHAR(20)) AS FirstName,
        CAST([phone] AS CHAR(12)) AS Phone,
        CAST([address] AS VARCHAR(40)) AS [Address],
		CAST([city] AS VARCHAR(20)) AS City,
		CAST([state] AS CHAR(2)) AS [State],
		CAST([zip] AS CHAR(5)) AS Zip,
		CAST([contract] AS BIT) AS [Contract]
FROM PUBSLOAD.dbo.Author
WHERE ETLExecution = ?

--#4 Conversion Data Flow Discount
/*
CREATE TABLE dbo.StageDiscount (
	DiscountType VARCHAR(40) NOT NULL,
	StoreId CHAR(4) NULL,
	Lowqty SMALLINT NULL,
	Highqty SMALLINT NULL,
	Discount DECIMAL(4,2) NOT NULL,
	ETLLoad DATETIME NOT NULL,
	ETLExecution INT NOT NULL,
)
*/

SELECT 
        CAST([discounttype] AS VARCHAR(40)) AS DiscountType,
		CAST([stor_id] AS CHAR(4)) AS StoreId,
        CAST([lowqty] AS SMALLINT) AS Lowqty,
        CAST([highqty] AS SMALLINT) AS Highqty,
		CAST([discount] AS DECIMAL(4,2)) AS Discount
FROM PUBSLOAD.dbo.discounts
WHERE ETLExecution = ?

--#5 Conversion Data Flow PubsInfo
/*
CREATE TABLE dbo.StagePubsInfo(
	PubId CHAR(4) NOT NULL,
	Logo IMAGE NULL,
	PresentationInfo TEXT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)
*/

SELECT 
        CAST([pub_id] AS CHAR(4)) AS PubId,
		CAST([logo] AS IMAGE) AS Logo,
        CAST([pr_info] AS TEXT) AS PresentationInfo
FROM PUBSLOAD.dbo.pub_info
WHERE ETLExecution = ?

--#6 Conversion Data Flow Publisher
/*
CREATE TABLE dbo.StagePublisher(
	PubId CHAR(4) NOT NULL,
	PubName VARCHAR(40) NULL,
	City VARCHAR(20) NULL,
	[State] CHAR(2) NULL,
	Country VARCHAR(30) NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)
*/

SELECT 
        CAST([pub_id] AS CHAR(4)) AS PubId,
		CAST([pub_name] AS VARCHAR(40)) AS PubName,
        CAST([city] AS VARCHAR(20)) AS City,
		CAST([state] AS CHAR(2)) AS [State],
		CAST([country] AS VARCHAR(30)) AS Country
FROM PUBSLOAD.dbo.publishers
WHERE ETLExecution = ?

--#7 Conversion Data Flow Roysched
/*
CREATE TABLE dbo.StageRoysched(
	TitleId VARCHAR(6) NOT NULL,
	LowRange INT NULL,
	HighRange INT NULL,
	Royalty INT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)
*/

SELECT 
        CAST([title_id] AS CHAR(6)) AS TitleId,
		CAST([lorange] AS INT) AS LowRange,
        CAST([hirange] AS INT) AS HighRange,
		CAST([royalty] AS INT) AS Royalty
FROM PUBSLOAD.dbo.roysched
WHERE ETLExecution = ?

--#8 Conversion Data Flow StageTitleAuthor
/*
CREATE TABLE dbo.StageTitlesAuthor(
	AutorId VARCHAR(11) NOT NULL,
	TittleId VARCHAR(6) NOT NULL,
	AutorOrder TINYINT NULL,
	RoyalTyper INT NULL,
	EtlLoad DATETIME NOT NULL,
	EtlExecution INT NOT NULL
)
*/

SELECT 
        CAST([au_id] AS VARCHAR(11)) AS AutorId,
		CAST([title_id] AS VARCHAR(6)) AS TittleId,
        CAST([au_ord] AS TINYINT) AS AutorOrder,
		CAST([royaltyper] AS INT) AS RoyalTyper
FROM PUBSLOAD.dbo.titleauthor
WHERE ETLExecution = ?

--#9 Conversion Data Flow Sale
/*
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
*/

SELECT 
        CAST([stor_id] AS CHAR(4)) AS StoreId,
		CAST([ord_num] AS VARCHAR(20)) AS OrderNumber,
        CAST([ord_date] AS DATETIME) AS OrderDate,
		CAST([qty] AS SMALLINT) AS Quantity,
		CAST([payterms] AS VARCHAR(12)) AS PayTerms,
		CAST([title_id] AS VARCHAR(6)) AS TitleId
FROM PUBSLOAD.dbo.sales
WHERE ETLExecution = ?

--#10 Conversion Data Flow Store
/*
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
*/

SELECT 
        CAST([stor_id] AS CHAR(4)) AS StoreId,
		CAST([stor_name] AS VARCHAR(40)) AS StoreName,
        CAST([stor_address] AS VARCHAR(40)) AS StoreAddress,
		CAST([city] AS VARCHAR(20)) AS City,
		CAST([state] AS CHAR(2)) AS [State],
		CAST([zip] AS VARCHAR(5)) AS Zip
FROM PUBSLOAD.dbo.stores
WHERE ETLExecution = ?

--#11 Conversion Data Flow Title
/*
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
*/

SELECT 
        CAST([title_id] AS CHAR(6)) AS TitleId,
		CAST([Title] AS VARCHAR(80)) AS Title,
        CAST([type] AS VARCHAR(12)) AS [Type],
		CAST([pub_id] AS CHAR(4)) AS PubId,
		CAST([price] AS MONEY) AS Price,
		CAST([advance] AS MONEY) AS Advance,
		CAST([royalty] AS INT) AS Royalty,
		CAST([ytd_sales] AS INT) AS YtdSales,
		CAST([notes] AS VARCHAR(200)) AS Notes,
		CAST([pubdate] AS DATETIME) AS PubDate
FROM PUBSLOAD.dbo.Titles
WHERE ETLExecution = ?




