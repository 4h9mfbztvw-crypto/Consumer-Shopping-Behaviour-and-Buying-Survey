SELECT TOP 10*
FROM dbo.consumer_shopping_behavior_survey;

--Q1.Create a cleaned age column using TRY_CAST().

SELECT
    Age,
    TRY_CAST(TRIM(Age) AS INT) AS Cleaned_Age
FROM consumer_shopping_behavior_survey;

--Q2.How many valid and invalid age values are there?

SELECT
    SUM(
        CASE 
            WHEN TRY_CAST(TRIM(Age) AS INT) IS NOT NULL 
            THEN 1 
            ELSE 0 
        END
    ) AS Valid_Ages,

    SUM(
        CASE 
            WHEN TRY_CAST(TRIM(Age) AS INT) IS NULL 
            THEN 1 
            ELSE 0 
        END
    ) AS Invalid_Ages
FROM consumer_shopping_behavior_survey;

--Q3. What is the average valid age of respondents?
WITH Cleaned_Data AS (
	SELECT TRY_CAST(TRIM(Age) AS INT) AS Cleaned_Age
	FROM consumer_shopping_behavior_survey
)
SELECT 
		AVG(Cleaned_Age) AS AVG_AGE
FROM Cleaned_Data;

--Q4. What are the youngest and oldest valid ages?
WITH Cleaned_Data AS (
	SELECT TRY_CAST(TRIM(Age) AS INT) AS Cleaned_Age
	FROM consumer_shopping_behavior_survey
)
SELECT 
		MIN(Cleaned_Age) AS MIN_AGE
FROM Cleaned_Data;

--Q4. How many respondents belong to each gender?
SELECT	Gender,
		COUNT(Response_ID) AS Total_Responses_by_Gender
FROM consumer_shopping_behavior_survey
GROUP BY Gender
ORDER BY COUNT(Response_ID) desc;

--Q5. How many respondents belong to each occupation status?
SELECT	Occupation_Status,
		COUNT(Response_ID) AS Total_Responses_by_Occupation
FROM consumer_shopping_behavior_survey
GROUP BY Occupation_Status
ORDER BY COUNT(Response_ID) desc;

--Q6. Which five countries have the most respondents?
SELECT	TOP 5 Country_Region,
		COUNT(Response_ID) AS Total_Responses_by_Country
FROM consumer_shopping_behavior_survey
GROUP BY Country_Region
ORDER BY COUNT(Response_ID) desc;

--Q7. How many respondents are from each monthly income range?
SELECT	Monthly_Income_Range,
		COUNT(Response_ID) AS Total_Responses_by_MnthIncomeRange
FROM consumer_shopping_behavior_survey
GROUP BY Monthly_Income_Range
ORDER BY COUNT(Response_ID) desc;

--Q8. Display respondents who are students and under 25 years old.
SELECT *
FROM consumer_shopping_behavior_survey
WHERE TRY_CAST(TRIM(Age) AS INT) < 25;

--Q9. Display employed respondents with an income of $3,000–6,000 or $6,000+.
SELECT *
FROM consumer_shopping_behavior_survey
WHERE Occupation_Status IN ('Employed full-time', 'Employed part-time')
  AND (
        Monthly_Income_Range = '$3,000-6,000'
        OR Monthly_Income_Range = '$6,000+'
      );

--Q9.  Create the following age groups
WITH Cleaned_Data AS (
    SELECT *,
        TRY_CAST(TRIM(Age) AS INT) AS Cleaned_Age
    FROM consumer_shopping_behavior_survey
)
SELECT
    Age,
    Cleaned_Age,
    CASE
        WHEN Cleaned_Age < 20 THEN 'Under 20'
        WHEN Cleaned_Age BETWEEN 20 AND 29 THEN '20-29'
        WHEN Cleaned_Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Cleaned_Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Cleaned_Age >= 50 THEN '50+'
        ELSE 'Invalid / Missing'
    END AS Age_Group
FROM Cleaned_Data;

--Q10. How many respondents belong to each group

WITH Cleaned_Data AS (
    SELECT
        Response_ID,
        TRY_CAST(TRIM(Age) AS INT) AS Cleaned_Age
    FROM consumer_shopping_behavior_survey
),
Age_Groups AS (
    SELECT
        Response_ID,
        CASE
            WHEN Cleaned_Age < 20 THEN 'Under 20'
            WHEN Cleaned_Age BETWEEN 20 AND 29 THEN '20-29'
            WHEN Cleaned_Age BETWEEN 30 AND 39 THEN '30-39'
            WHEN Cleaned_Age BETWEEN 40 AND 49 THEN '40-49'
            WHEN Cleaned_Age >= 50 THEN '50+'
            ELSE 'Invalid / Missing'
        END AS Age_Group
    FROM Cleaned_Data
)
SELECT
    Age_Group,
    COUNT(*) AS Total_Responses
FROM Age_Groups
GROUP BY Age_Group;