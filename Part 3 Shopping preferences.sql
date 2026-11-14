-- SQL File 3: Shopping preferences
SELECT TOP 10*
FROM dbo.consumer_shopping_behavior_survey;

-- 21. Where do respondents shop most: online, in-store or an equal mix?
SELECT	
		Preferred_Platform,
		COUNT(Preferred_Platform) AS Numb_of_respondents
FROM consumer_shopping_behavior_survey
GROUP BY Preferred_Platform
ORDER BY COUNT(Preferred_Platform) Desc;

-- 22. What is the most common online-shopping frequency?
SELECT	
		Online_Shopping_Frequency,
		COUNT(Online_Shopping_Frequency) AS Numb_of_respondents
FROM consumer_shopping_behavior_survey
GROUP BY Online_Shopping_Frequency
ORDER BY COUNT(Online_Shopping_Frequency) Desc;

-- 23. What is the most popular shopping platform?
SELECT	
		Shop_Most_Where,
		COUNT(Shop_Most_Where) AS Numb_of_respondents
FROM consumer_shopping_behavior_survey
GROUP BY Shop_Most_Where
ORDER BY COUNT(Shop_Most_Where) Desc;

-- 24. Which device is used most frequently for shopping?
SELECT	
		Primary_Device,
		COUNT(Primary_Device) AS Numb_of_respondents
FROM consumer_shopping_behavior_survey
GROUP BY Primary_Device
ORDER BY COUNT(Primary_Device) Desc;

-- 25. What is the most popular spending category?
SELECT	
		Top_Spending_Category,
		COUNT(Top_Spending_Category) AS Numb_of_respondents
FROM consumer_shopping_behavior_survey
GROUP BY Top_Spending_Category
ORDER BY COUNT(Top_Spending_Category) Desc;

-- 26. What is the most common payment method?
SELECT	
		Shop_Most_Where,
		COUNT(Shop_Most_Where) AS Numb_of_respondents
FROM consumer_shopping_behavior_survey
GROUP BY Shop_Most_Where
ORDER BY COUNT(Shop_Most_Where) Desc;

-- 27. How many respondents use BNPL:
--     - Regularly
--     - Occasionally
--     - Never
SELECT	
		Online_Shopping_Frequency,
		COUNT(Online_Shopping_Frequency) AS Numb_of_respondents
FROM consumer_shopping_behavior_survey
GROUP BY Online_Shopping_Frequency
ORDER BY COUNT(Online_Shopping_Frequency) Desc;

-- 28. What percentage of respondents prefer online, offline or both?
SELECT
    Best_Shopping_Mode,
    COUNT(*) AS Total_Respondents,
    CAST(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()
        AS DECIMAL(5,2)
    ) AS Percentage_Per_Shopping_Mode
FROM consumer_shopping_behavior_survey
WHERE Best_Shopping_Mode IS NOT NULL
GROUP BY Best_Shopping_Mode
ORDER BY Percentage_Per_Shopping_Mode DESC;

-- 29. What is the most popular shopping platform in each gender group?
SELECT
		Preferred_Platform,
		Gender,
		COUNT(*) AS Total_Respondents
FROM consumer_shopping_behavior_survey
GROUP BY Preferred_Platform, Gender
ORDER BY COUNT(*) DESC; 

-- 30. What is the most popular spending category within each income range?
SELECT
		Monthly_Income_Range,
		Top_Spending_Category,
		COUNT(*) AS Total_Respondents
FROM consumer_shopping_behavior_survey
GROUP BY Monthly_Income_Range, Top_Spending_Category
ORDER BY COUNT(*) DESC; 