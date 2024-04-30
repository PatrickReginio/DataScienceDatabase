--///ACCESS CONTROL (DCL)///
--//Admin Role//
USE DataScienceDatabase;
CREATE ROLE DataScienceDatabaseAdmin;

--CREATE users for specific roles.
USE master;
CREATE LOGIN datascienceadminpatrick WITH PASSWORD = 'datascienceadminpatrickpassword';
USE DataScienceDatabase;
CREATE USER datascienceadmin FOR LOGIN datascienceadminpatrick;

--GRANT permissions to specific roles.
USE DataScienceDatabase;
GRANT CREATE PROCEDURE, CREATE TABLE, EXECUTE, SELECT, INSERT, UPDATE, DELETE TO DatabaseAdmin;

EXEC sp_addrolemember 'DataScienceDatabaseAdmin', 'datascienceadmin';


--//User Role//
USE DataScienceDatabase;
CREATE ROLE DataScienceUser;

--CREATE users for specific roles.
USE master;
CREATE LOGIN datascienceuserjesse WITH PASSWORD = 'datascienceuserjessepassword'
USE DataScienceDatabase;
CREATE USER datascienceuser#1 FOR LOGIN datascienceuserjesse;

USE master;
CREATE LOGIN datascienceusercece WITH PASSWORD = 'datascienceusercecepassword'
USE DataScienceDatabase;
CREATE USER datascienceuser#2 FOR LOGIN datascienceusercece;

--GRANT permissions to specific roles.
USE DataScienceDatabase;
GRANT SELECT, INSERT, UPDATE ON DimCustomer TO DataScienceUser;
GRANT SELECT, INSERT, UPDATE ON DimDate TO DataScienceUser;
GRANT SELECT, INSERT, UPDATE ON DimProdut TO DataScienceUser;
GRANT SELECT, INSERT, UPDATE ON DimTerritory TO DataScienceUser;
GRANT SELECT, INSERT, UPDATE ON SCHEMA:: SalesSchema TO DataScienceUser;

EXEC sp_addrolemember 'DataScienceUser', 'datascienceuser#1';
EXEC sp_addrolemember 'DataScienceUser', 'datascienceuser#2';

--//Viewer Role//
USE DataScienceDatabase
CREATE ROLE DataScienceViewer

--CREATE users for specific roles.
USE master;
CREATE LOGIN datascienceviewernick WITH PASSWORD = 'datascienceviewernickpassword'
USE DataScienceDatabase;
CREATE USER datascienceviewer#1 FOR LOGIN datascienceviewernick;

USE master;
CREATE LOGIN datascienceviewerschmidt WITH PASSWORD = 'datascienceviewerschmidtpassword'
USE DataScienceDatabase;
CREATE USER datascienceviewer#2 FOR LOGIN datascienceviewerschmidt;

USE master;
CREATE LOGIN datascienceviewerwinston WITH PASSWORD = 'datascienceviewerwinstonpassword'
USE DataScienceDatabase;
CREATE USER datascienceviewer#3 FOR LOGIN datascienceviewerwinston;

--GRANT permissions to specific roles.
GRANT SELECT ON DimCustomer TO DataScienceViewer;
GRANT SELECT ON DimDate TO DataScienceViewer;
GRANT SELECT ON DimProdut TO DataScienceViewer;
GRANT SELECT ON DimTerritory TO DataScienceViewer;
GRANT SELECT ON SCHEMA:: SalesSchema TO DataScienceViewer;

EXEC sp_addrolemember 'DataScienceViewer', 'datascienceviewer#1';
EXEC sp_addrolemember 'DataScienceViewer', 'datascienceviewer#2';
EXEC sp_addrolemember 'DataScienceViewer', 'datascienceviewer#3';