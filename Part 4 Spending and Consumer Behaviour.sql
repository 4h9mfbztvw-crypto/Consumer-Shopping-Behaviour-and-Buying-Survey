-- SQL File 4: Spending and Consumer Behaviour
	SELECT *
	FROM consumer_shopping_behavior_survey

-- 31. How many respondents belong to each non-essential spending range?
SELECT 
		Count (*) AS Total_of_Respondents,
		Avg_Monthly_Spend_NonEssentials
FROM consumer_shopping_behavior_survey
GROUP BY Avg_Monthly_Spend_NonEssentials
ORDER BY Count (*) DESC;

-- 32. Which income range contains the most respondents who spend $500+?
SELECT
		Monthly_Income_Range,
		Count(*) AS Total_of_Respondents
FROM consumer_shopping_behavior_survey
WHERE Avg_Monthly_Spend_NonEssentials = '$500+'
GROUP BY Monthly_Income_Range 
ORDER BY Count(*) DESC;
-- 33. What is the average impulse-purchase score?
SELECT AVG(Impulse_Purchase_Frequency) AS AVG_Impulse_Purchase
FROM consumer_shopping_behavior_survey;

-- 34. Which shopping-list group has the highest average impulse-purchase score?
SELECT
    Makes_Shopping_List,
    AVG(Impulse_Purchase_Frequency) AS AVG_Impulse_Purchase
FROM consumer_shopping_behavior_survey
WHERE Makes_Shopping_List IS NOT NULL
  AND Impulse_Purchase_Frequency IS NOT NULL
GROUP BY Makes_Shopping_List
ORDER BY AVG_Impulse_Purchase DESC;

-- 35. Compare average impulse-purchase scores between BNPL users and non-users.
SELECT
    Uses_BNPL_Installments,
    AVG(Impulse_Purchase_Frequency) AS AVG_Impulse_Purchase
FROM consumer_shopping_behavior_survey
WHERE Uses_BNPL_Installments IS NOT NULL
  AND Impulse_Purchase_Frequency IS NOT NULL
  GROUP BY Uses_BNPL_Installments
ORDER BY AVG_Impulse_Purchase DESC;

-- 36. What is the average discount-importance score for each income range?
SELECT
    Monthly_Income_Range,
    AVG(Discount_Importance_Score) AS AVG_Discount_Importance_Score
FROM consumer_shopping_behavior_survey
WHERE	Discount_Importance_Score IS NOT NULL
		AND Monthly_Income_Range IS NOT NULL
GROUP BY Monthly_Income_Range
ORDER BY AVG(Discount_Importance_Score) DESC;

-- 37. Do respondents who compare prices frequently place more importance on discounts?
SELECT
    Price_Comparison_Frequency,
    AVG(Discount_Importance_Score) AS AVG_Discount_Importance_Score
FROM consumer_shopping_behavior_survey
WHERE	Discount_Importance_Score IS NOT NULL
		AND Price_Comparison_Frequency IS NOT NULL
GROUP BY Price_Comparison_Frequency 
ORDER BY AVG(Discount_Importance_Score) DESC;

-- 38. Which spending category has the highest average impulse-purchase score?
SELECT
    Top_Spending_Category,
    AVG(Impulse_Purchase_Frequency) AS AVGImpulse_Purchase_Frequency
FROM consumer_shopping_behavior_survey
WHERE	Top_Spending_Category IS NOT NULL
		AND Impulse_Purchase_Frequency IS NOT NULL
GROUP BY Top_Spending_Category 
ORDER BY AVG(Impulse_Purchase_Frequency) DESC;

-- 39. Compare return frequency across the different spending ranges.
SELECT
    Avg_Monthly_Spend_NonEssentials,
    Return_Frequency,
    COUNT(*) AS Total_Respondents
FROM consumer_shopping_behavior_survey
WHERE Avg_Monthly_Spend_NonEssentials IS NOT NULL
  AND Return_Frequency IS NOT NULL
GROUP BY
    Avg_Monthly_Spend_NonEssentials,
    Return_Frequency
ORDER BY
    Avg_Monthly_Spend_NonEssentials,
    Total_Respondents DESC;
-- 40. Which payment method is most common among respondents who spend $300-500 or $500+?
SELECT TOP 1
    Preferred_Payment_Method,
    COUNT(*) AS Total_Respondents
FROM consumer_shopping_behavior_survey
WHERE Avg_Monthly_Spend_NonEssentials IN ('$300-500', '$500+')
  AND Preferred_Payment_Method IS NOT NULL
GROUP BY Preferred_Payment_Method
ORDER BY Total_Respondents DESC;