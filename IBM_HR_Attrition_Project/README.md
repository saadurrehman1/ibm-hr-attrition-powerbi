# IBM HR Attrition Analysis — Power BI Project

This project explores the IBM HR Employee Attrition dataset using SQL for EDA and Power BI for visualization.

## Project Overview

- **Goal:** Analyze employee attrition patterns and identify key factors influencing churn.
- **Tools:** SQLite (SQL), Power BI Desktop
- **Dataset:** [IBM HR Analytics Employee Attrition](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset)

## Repository Structure

IBM_HR_Attrition_Project/
 ├── hr_attrition_eda.sql       # SQL EDA queries
 ├── EDA_Results/               # Exported CSVs of EDA results
 ├── HR_Attrition.pbix          # Final Power BI file
 ├── screenshots/               # Dashboard page screenshots
 ├── README.md                  # Project description

## Key Steps

1. **EDA:** Ran descriptive queries to explore attrition by department, overtime, income, tenure, age, and more.
2. **SQL:** Wrote clean joins, group-bys, and aggregations to generate insights.
3. **Dashboard:** Built an interactive Power BI dashboard with:
   - Overview KPIs (attrition rate, average income)
   - Demographic breakdowns
   - Overtime and tenure impact visuals
   - Income and age distributions by attrition status

## Screenshots

### Overview Page
![Overview](screenshots/IBM_HR_ATTRITION_DASHBOARD_OVERVIEW.JPG)

### Demographics & Tenure
![Demographics](screenshots/DemographicInsights.JPG)


## Notes

- The `.pbix` file is included for transparency — open in **Power BI Desktop** to explore.
- If you’d like to test the SQL yourself, see `hr_attrition_eda.sql` and `/EDA_Results/`.


**Created by Saad Ur Rehman**
