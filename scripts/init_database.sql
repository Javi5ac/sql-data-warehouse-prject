/*
===================================================================
Create Database and Schemas
===================================================================
Script Purpouse:
	This script creates a new dataset named "DataWarehouse" after checking if it already exists.
	If it exists, it would be dropped and recreated. Additionally, the script sets up three schemas
	within the database "bronze", "silver" and "gold".

WARNING:
	Running this script will drop the entire 'DataWarehouse' database if it exists.
	Alldata will be permanently deleted. Proceed with caution and ensure you have
	proper bakups before running this script. 
*/

USE master;
GO

-- Drop and recreate 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse
END

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
Go

-- Create Schemas 
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
