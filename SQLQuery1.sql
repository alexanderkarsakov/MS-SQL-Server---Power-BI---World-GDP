

IF OBJECT_ID('Raw_Data_GDP') IS NOT NULL DROP TABLE Raw_Data_GDP

CREATE TABLE Raw_Data_GDP
(DEMO_IND NVARCHAR(200),
Indicator NVARCHAR(200),
[LOCATION] NVARCHAR(200),
Country NVARCHAR(200),
[TIME] NVARCHAR(200),
[Value] FLOAT,
[Flag Codes] NVARCHAR(200),
Flags NVARCHAR(200)
)


BULK INSERT Raw_Data_GDP
FROM 'C:\Users\alexa\datasets\gdp_raw_data.csv'
WITH ( FORMAT='CSV');


SELECT * FROM Raw_Data_GDP



CREATE VIEW GDP_Excel_Input AS

SELECT a.*, b.GDP_Per_Capita FROM

	(SELECT Country, [Time] AS Year_No, [Value] AS GDP_Value FROM Raw_Data_GDP
	WHERE Indicator = 'GDP (current US$)' ) a

	LEFT JOIN
	(SELECT Country, [Time] AS Year_No, [Value] AS GDP_Per_Capita FROM Raw_Data_GDP
	WHERE Indicator = 'GDP per capita (current US$)' ) b
	ON a.Country = b.Country AND a.Year_No = b.Year_No

SELECT * FROM GDP_Excel_Input


CREATE PROCEDURE GDP_Excel_Input_Monthly AS

IF OBJECT_ID('Raw_Data_GDP') IS NOT NULL DROP TABLE Raw_Data_GDP

CREATE TABLE Raw_Data_GDP
(DEMO_IND NVARCHAR(200),
Indicator NVARCHAR(200),
[LOCATION] NVARCHAR(200),
Country NVARCHAR(200),
[TIME] NVARCHAR(200),
[Value] FLOAT,
[Flag Codes] NVARCHAR(200),
Flags NVARCHAR(200)
)


BULK INSERT Raw_Data_GDP
FROM 'C:\Users\alexa\datasets\gdp_raw_data.csv'
WITH ( FORMAT='CSV');


EXEC GDP_Excel_Input_Monthly



