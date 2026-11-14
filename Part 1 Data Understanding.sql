SELECT TOP 10 *
FROM dbo.consumer_shopping_behavior_survey;

-- Part 1: Data Understanding 

-- How many survey responses are in the dataset?
SELECT 
		COUNT(Response_ID) AS ResponsesCount
FROM consumer_shopping_behavior_survey;

-- What is the earliest and latest response date?
SELECT 
		MAX (Timestamp) AS Latest_Response,
		MIN (Timestamp) AS Earliest_Response
FROM consumer_shopping_behavior_survey;

-- How many unique countries are represented?
SELECT
		DISTINCT COUNT (country_region) AS Unique_Countries
FROM consumer_shopping_behavior_survey;

-- Which columns contain missing values?
SELECT
    SUM(CASE WHEN Age IS NULL OR TRIM(Age) = '' THEN 1 ELSE 0 END) AS Missing_Age,
    SUM(CASE WHEN Gender IS NULL OR TRIM(Gender) = '' THEN 1 ELSE 0 END) AS Missing_Gender,
    SUM(CASE WHEN Occupation_Status IS NULL OR TRIM(Occupation_Status) = '' THEN 1 ELSE 0 END) AS Missing_Occupation,
    SUM(CASE WHEN Country_Region IS NULL OR TRIM(Country_Region) = '' THEN 1 ELSE 0 END) AS Missing_Country,
    SUM(CASE WHEN Monthly_Income_Range IS NULL OR TRIM(Monthly_Income_Range) = '' THEN 1 ELSE 0 END) AS Missing_Income
FROM consumer_shopping_behavior_survey;

-- How many duplicate Response_ID values exist?
SELECT 
		Response_ID,
		COUNT(*) AS Occurence_count
FROM 
	consumer_shopping_behavior_survey
GROUP BY
	Response_ID
HAVING
	COUNT(*) > 1;
