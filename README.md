# Customer Churn Analysis — Telecom Industry

[![Python](https://img.shields.io/badge/Python-3.10-blue?logo=python)](./churnanalysis(1).ipynb)

[![MySQL](https://img.shields.io/badge/MySQL-8.0-orange?logo=mysql)](./churnsql.sql)

[![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow?logo=powerbi)](./Customer_Churn_Dashboard.pbix)

![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

## Project overview

An end-to-end churn analysis project for a telecom company with 7,032 customers. The goal was to identify which customer segments have the highest churn risk, quantify the revenue impact, and surface actionable retention recommendations.

**Key result:** 26.6% overall churn rate representing **~$1.67M in annualized revenue at risk**, concentrated in month-to-month contract holders in their first 12 months.

---

## Tools used

| Tool | Purpose |
|---|---|
| MySQL 8.0 | Data cleaning, column standardization, analysis queries |
| Python (pandas, matplotlib, seaborn) | Exploratory data analysis, 8 charts |
| Power BI | 3-page interactive dashboard |
| Jupyter Notebook | EDA documentation and findings |

---

## Dataset

- **Source:** Telecom customer data (7,032 rows · 32 columns)
- **Key columns:** `tenure_months`, `Contract`, `payment_method`, `monthly_charges`, `CLTV`, `churn_label`, `churn_reason`
- **Target variable:** `churn_label` (Yes / No) · `churn_value` (1 / 0)
- **Churn rate:** 26.6% (1,869 churned out of 7,032)

---

## Project structure

```
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
```

---

## Workflow

```
Raw CSV → MySQL (cleaning + column rename) → churn_clean table
    → Python EDA (8 charts + insights)
    → Power BI (3-page dashboard)
    → Business recommendations
```

---

## SQL — what was done

**Data cleaning steps:**
- Renamed columns with special characters and spaces to snake_case
- Checked for nulls and blank values across all 32 columns
- Filled blank `churn_reason` values with `'No Churn'` for retained customers
- Verified zero duplicates using COUNT(*) vs COUNT(DISTINCT customer_id)
- Created `churn_clean` as a working copy of the raw table

**Analysis queries written:**
1. Overall churn rate
2. Churn by contract type
3. Churn by tenure bucket (lifecycle stage analysis)
4. Revenue at risk by contract type (monthly + annualized)
5. Churn by payment method
6. Senior citizen × contract type cross-tab
7. Churn reason breakdown (with window function for % share)
8. CLTV segment vs churn rate

---

## Python EDA — 8 charts

| Chart | Type | Key finding |
|---|---|---|
| 1. Churn overview | Donut | 26.6% overall churn rate |
| 2. Churn by contract | Horizontal bar | Month-to-month = 42.7% vs Two-year = 2.8% |
| 3. Churn by tenure | Vertical bar | First-year customers churn at 47.7% |
| 4. Churn by payment method | Horizontal bar | Electronic check = 45.3% vs auto-pay = 15–16% |
| 5. Monthly charges distribution | Histogram | Churned customers skew toward higher monthly plans |
| 6. Churn reasons | Horizontal bar | Attitude of support person is #1 reason (192 customers) |
| 7. High-risk segments | 3-panel bar | Senior citizens (41.7%), fiber optic (41.9%), low CLTV |
| 8. Revenue impact | Bar + scatter | $1.67M annual risk; churned cluster = low tenure + high charges |

---

## Key findings

### 1 — Contract type is the #1 churn driver
Month-to-month customers churn at **42.7%** vs **2.8%** for two-year contracts — a **15× difference**. This is the single strongest predictor in the dataset.

### 2 — First-year customers are the highest-risk group
Churn rate is **47.7%** in the first 12 months, dropping to **20.4%** after 24 months and **9.5%** after 48 months. The problem is early engagement, not the product itself.

### 3 — Service quality drives more churn than competitor gaps
**Attitude of support person** is the #1 individual churn reason (192 customers) — ahead of every competitor-related reason. Combined service issues account for ~35% of all churn.

### 4 — Electronic check users churn at ~3× the rate of auto-pay customers
45.3% vs 15–16%. A simple auto-pay enrollment nudge at month 3 could meaningfully reduce this.

### 5 — Senior citizens and fiber optic customers are disproportionately high-risk
Senior citizens churn at **41.7%** vs 23.7% for non-seniors. Fiber optic customers churn at **41.9%**, well above the 26.6% average — paying premium prices and leaving anyway signals a value perception problem.

---

## Business recommendations

| Priority | Recommendation | Target segment | Est. impact |
|---|---|---|---|
| High | Offer discount to switch to annual contract in first 6 months | Month-to-month, tenure < 6 months | $260K+ saved/year |
| High | Structured 90-day onboarding program | All new customers | Reduces 47.7% → target lower |
| High | Support quality scoring + targeted training | All customers | Addresses #1 churn reason |
| Medium | Auto-pay enrollment nudge at month 3 with bill credit | Electronic check users | Reduces 45.3% → ~16% |
| Medium | Dedicated senior support tier + simplified plans | Senior citizens | Reduces 41.7% churn rate |

---

## Power BI dashboard

3-page interactive dashboard built in Power BI Desktop:

- **Page 1 — Executive overview:** 4 KPI cards, donut chart, churn by contract, churn by tenure
- **Page 2 — Segment deep dive:** payment method, senior citizen, internet service, contract × internet matrix, churn reasons
- **Page 3 — Revenue impact:** 4 KPI cards, revenue by contract, revenue by payment method, top churned customers table, scatter chart

---

## How to run this project

**SQL:**
1. Open MySQL Workbench
2. Create a database: `CREATE DATABASE churndb;`
3. Import the raw CSV using Table Data Import Wizard
4. Run `churnsql.sql` top to bottom

**Python:**
1. Install dependencies: `pip install pandas matplotlib seaborn pymysql`
2. Open `churnanalysis.ipynb` in Jupyter Notebook
3. Update the MySQL password in Cell 2
4. Run all cells top to bottom

---

## About

**Rohan** — Data Analyst with 2 years of MIS analytics experience.  
Skills: SQL · Python · Power BI · Excel · Data Cleaning · EDA · Dashboard Design

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin)](https://www.linkedin.com/in/rohan-chavan-4b2a0540b)

---

*This project is part of my data analytics portfolio. Dataset used for educational and portfolio purposes.*
