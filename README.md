Customer Churn Analysis — Telecom Industry

Show Image
Show Image
Show Image
Show Image

Project overview

An end-to-end churn analysis project for a telecom company with 7,032 customers. The goal was to identify which customer segments have the highest churn risk, quantify the revenue impact, and surface actionable retention recommendations.

Key result: 26.6% overall churn rate representing ~$1.67M in annualized revenue at risk, concentrated in month-to-month contract holders in their first 12 months.


Tools used

ToolPurposeMySQL 8.0Data cleaning, column standardization, analysis queriesPython (pandas, matplotlib, seaborn)Exploratory data analysis, 8 chartsPower BI3-page interactive dashboardJupyter NotebookEDA documentation and findings


Dataset


Source: Telecom customer data (7,032 rows · 32 columns)
Key columns: tenure_months, Contract, payment_method, monthly_charges, CLTV, churn_label, churn_reason
Target variable: churn_label (Yes / No) · churn_value (1 / 0)
Churn rate: 26.6% (1,869 churned out of 7,032)



Project structure

customer-churn-analysis/
│
├── churnanalysis.ipynb       ← Python EDA notebook (8 charts + findings)
├── churnsql.sql              ← MySQL cleaning + analysis queries
├── churn_clean.csv           ← Cleaned dataset (exported from MySQL)
├── README.md                 ← This file
│
└── charts/
    ├── chart1_churn_overview.png
    ├── chart2_contract.png
    ├── chart3_tenure.png
    ├── chart4_payment.png
    ├── chart5_monthly_charges.png
    ├── chart6_churn_reasons.png
    ├── chart7_segments.png
    └── chart8_revenue.png


Workflow

Raw CSV → MySQL (cleaning + column rename) → churn_clean table
    → Python EDA (8 charts + insights)
    → Power BI (3-page dashboard)
    → Business recommendations


SQL — what was done

Data cleaning steps:


Renamed columns with special characters and spaces to snake_case
Checked for nulls and blank values across all 32 columns
Filled blank churn_reason values with 'No Churn' for retained customers
Verified zero duplicates using COUNT(*) vs COUNT(DISTINCT customer_id)
Created churn_clean as a working copy of the raw table


Analysis queries written:


Overall churn rate
Churn by contract type
Churn by tenure bucket (lifecycle stage analysis)
Revenue at risk by contract type (monthly + annualized)
Churn by payment method
Senior citizen × contract type cross-tab
Churn reason breakdown (with window function for % share)
CLTV segment vs churn rate



Python EDA — 8 charts

ChartTypeKey finding1. Churn overviewDonut26.6% overall churn rate2. Churn by contractHorizontal barMonth-to-month = 42.7% vs Two-year = 2.8%3. Churn by tenureVertical barFirst-year customers churn at 47.7%4. Churn by payment methodHorizontal barElectronic check = 45.3% vs auto-pay = 15–16%5. Monthly charges distributionHistogramChurned customers skew toward higher monthly plans6. Churn reasonsHorizontal barAttitude of support person is #1 reason (192 customers)7. High-risk segments3-panel barSenior citizens (41.7%), fiber optic (41.9%), low CLTV8. Revenue impactBar + scatter$1.67M annual risk; churned cluster = low tenure + high charges


Key findings

1 — Contract type is the #1 churn driver

Month-to-month customers churn at 42.7% vs 2.8% for two-year contracts — a 15× difference. This is the single strongest predictor in the dataset.

2 — First-year customers are the highest-risk group

Churn rate is 47.7% in the first 12 months, dropping to 20.4% after 24 months and 9.5% after 48 months. The problem is early engagement, not the product itself.

3 — Service quality drives more churn than competitor gaps

Attitude of support person is the #1 individual churn reason (192 customers) — ahead of every competitor-related reason. Combined service issues account for ~35% of all churn.

4 — Electronic check users churn at ~3× the rate of auto-pay customers

45.3% vs 15–16%. A simple auto-pay enrollment nudge at month 3 could meaningfully reduce this.

5 — Senior citizens and fiber optic customers are disproportionately high-risk

Senior citizens churn at 41.7% vs 23.7% for non-seniors. Fiber optic customers churn at 41.9%, well above the 26.6% average — paying premium prices and leaving anyway signals a value perception problem.


Business recommendations

PriorityRecommendationTarget segmentEst. impactHighOffer discount to switch to annual contract in first 6 monthsMonth-to-month, tenure < 6 months$260K+ saved/yearHighStructured 90-day onboarding programAll new customersReduces 47.7% → target lowerHighSupport quality scoring + targeted trainingAll customersAddresses #1 churn reasonMediumAuto-pay enrollment nudge at month 3 with bill creditElectronic check usersReduces 45.3% → ~16%MediumDedicated senior support tier + simplified plansSenior citizensReduces 41.7% churn rate


Power BI dashboard

3-page interactive dashboard built in Power BI Desktop:


Page 1 — Executive overview: 4 KPI cards, donut chart, churn by contract, churn by tenure
Page 2 — Segment deep dive: payment method, senior citizen, internet service, contract × internet matrix, churn reasons
Page 3 — Revenue impact: 4 KPI cards, revenue by contract, revenue by payment method, top churned customers table, scatter chart



How to run this project

SQL:


Open MySQL Workbench
Create a database: CREATE DATABASE churndb;
Import the raw CSV using Table Data Import Wizard
Run churnsql.sql top to bottom


Python:


Install dependencies: pip install pandas matplotlib seaborn pymysql
Open churnanalysis.ipynb in Jupyter Notebook
Update the MySQL password in Cell 2
Run all cells top to bottom



About

Rohan — Data Analyst with 2 years of MIS analytics experience.

Skills: SQL · Python · Power BI · Excel · Data Cleaning · EDA · Dashboard Design

Show Image


This project is part of my data analytics portfolio. Dataset used for educational and portfolio purposes.
