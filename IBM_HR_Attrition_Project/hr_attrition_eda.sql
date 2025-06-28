-- =======================================
-- IBM HR Attrition EDA 
-- =======================================

-- Basic row count
SELECT COUNT(*) AS Total_Employees FROM HR;

-- Attrition breakdown
SELECT Attrition, COUNT(*) AS Count
FROM HR
GROUP BY Attrition;

-- Average Age, Income, and Tenure by Attrition
SELECT Attrition,
       ROUND(AVG(Age), 1) AS Avg_Age,
       ROUND(AVG(MonthlyIncome), 2) AS Avg_Income,
       ROUND(AVG(YearsAtCompany), 1) AS Avg_YearsAtCompany
FROM HR
GROUP BY Attrition;

-- Attrition by Department
SELECT Department, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY Department, Attrition
ORDER BY Department, Attrition;

-- Attrition by Job Role
SELECT JobRole, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY JobRole, Attrition
ORDER BY JobRole, Attrition;

-- Attrition by Gender
SELECT Gender, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY Gender, Attrition;

-- Attrition by Marital Status
SELECT MaritalStatus, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY MaritalStatus, Attrition;

-- Does OverTime impact Attrition?
SELECT OverTime, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY OverTime, Attrition;

-- Impact of Business Travel
SELECT BusinessTravel, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY BusinessTravel, Attrition;

-- Average Distance From Home by Attrition
SELECT Attrition, ROUND(AVG(DistanceFromHome), 2) AS Avg_Distance
FROM HR
GROUP BY Attrition;

-- Job Satisfaction vs Attrition
SELECT JobSatisfaction, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY JobSatisfaction, Attrition
ORDER BY JobSatisfaction, Attrition;

-- Relationship Satisfaction vs Attrition
SELECT RelationshipSatisfaction, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY RelationshipSatisfaction, Attrition
ORDER BY RelationshipSatisfaction, Attrition;

-- Years Since Last Promotion
SELECT Attrition, ROUND(AVG(YearsSinceLastPromotion), 2) AS Avg_YearsSinceLastPromotion
FROM HR
GROUP BY Attrition;

-- Performance Rating by Attrition
SELECT PerformanceRating, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY PerformanceRating, Attrition
ORDER BY PerformanceRating, Attrition;

-- Work Life Balance vs Attrition
SELECT WorkLifeBalance, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY WorkLifeBalance, Attrition
ORDER BY WorkLifeBalance, Attrition;
