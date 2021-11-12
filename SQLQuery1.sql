

IF OBJECT_ID('Data') IS NOT NULL DROP TABLE Data

CREATE TABLE Data
(DEMO_IND NVARCHAR(200),
Indicator NVARCHAR(200),
[LOCATION] NVARCHAR(200),
Country NVARCHAR(200),
[TIME] NVARCHAR(200),
[Value] FLOAT,
[Flag Codes] NVARCHAR(200),
Flags NVARCHAR(200)
)

BULK INSERT Data
FROM 'C:\Users\alexa\datasets\data.csv'
WITH ( FORMAT='CSV');

SELECT * FROM Data

CREATE VIEW GDP_Excel_Input AS

SELECT a.*, b.GDP_Per_Capita FROM

	(SELECT Country, [Time] AS Year_No, [Value] AS GDP_Value FROM Data
	WHERE Indicator = 'GDP (current US$)' ) a

	LEFT JOIN
	(SELECT Country, [Time] AS Year_No, [Value] AS GDP_Per_Capita FROM Data
	WHERE Indicator = 'GDP per capita (current US$)' ) b
	ON a.Country = b.Country AND a.Year_No = b.Year_No

SELECT * FROM GDP_Excel_Input

CREATE PROCEDURE GDP_Excel_Input_Monthly AS

IF OBJECT_ID('Data') IS NOT NULL DROP TABLE Data

CREATE TABLE Data
(DEMO_IND NVARCHAR(200),
Indicator NVARCHAR(200),
[LOCATION] NVARCHAR(200),
Country NVARCHAR(200),
[TIME] NVARCHAR(200),
[Value] FLOAT,
[Flag Codes] NVARCHAR(200),
Flags NVARCHAR(200)
)


BULK INSERT Data
FROM 'C:\Users\alexa\datasets\data.csv'
WITH ( FORMAT='CSV');


EXEC GDP_Excel_Input_Monthly



