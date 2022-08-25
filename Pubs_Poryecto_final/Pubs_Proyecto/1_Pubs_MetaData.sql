USE tempdb
GO

-- Si la base de datos existe, eliminarla. Si no existe no hacer nada.
IF EXISTS(SELECT name FROM sys.databases WHERE name='PUBSMETADATA')
BEGIN
	DROP DATABASE PUBSDMETADATA
END
GO

-- Crear la base de datos para almacenar los metadatos
CREATE DATABASE PUBSMETADATA
GO

-- Utilizar la base de datos
USE PUBSMETADATA
GO

-- Especifica el comportamiento de los operadores igual(=) y no igual (<>)
-- cuando se utilizan con valores NULL.
-- https://docs.microsoft.com/en-us/sql/t-sql/statements/set-ansi-nulls-transact-sql?view=sql-server-ver15
-- Expresión		SET ANSI_NULLS ON		SET ANSI_NULL OFF
-- NULL = NULL		UNKNOWN					TRUE
-- 1 = NULL			UNKNOWN					FALSE
-- NULL <> NULL		UNKNOWN					FALSE
SET ANSI_NULLS ON
GO

-- Hace que SQL siga las normas ISO con respecto a la delimitación de identificadores
-- que utilizan las comillas.
-- https://docs.microsoft.com/en-us/sql/t-sql/statements/set-quoted-identifier-transact-sql?view=sql-server-ver15
SET QUOTED_IDENTIFIER OFF
GO

-- Tabla que almacena los metadatos de las ejecuciones ETL
CREATE TABLE dbo.ETLExecution (
	id INT IDENTITY(1, 1) NOT NULL,
	userName NVARCHAR(50) NULL,
	machineName NVARCHAR(50) NULL,
	packageName NVARCHAR(50) NULL,
	etlLoad DATETIME NULL,
	etlCountRows BIGINT NULL,
	etlCountNewRegister BIGINT NULL,
	etlCountModifiedRegister BIGINT NULL
)
GO


-- Insertando registros en la tabla dbo.ETLExecution
INSERT INTO dbo.ETLExecution(userName, machineName, packageName, etlLoad)
VALUES (?, ?, ?, GETDATE())

