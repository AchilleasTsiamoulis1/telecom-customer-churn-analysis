# Telecom Customer Churn Analysis

## Project Overview

This project analyzes customer churn for a telecommunications company using the Maven Analytics Telecom Customer Churn dataset. The goal is to identify patterns associated with customer attrition, understand the main reasons customers leave and provide actionable business recommendations.

The project follows an end-to-end data analysis workflow, including data cleaning, SQL analysis, exploratory data analysis in Python and an interactive Power BI dashboard.

Dataset Source: https://mavenanalytics.io/data-playground/telecom-customer-churn

## Business Objectives

- Measure the overall customer churn rate.
- Identify customer segments with higher churn rates.
- Analyze the relationship between churn, contract type, tenure and internet service.
- Investigate the main reasons customers leave the company.
- Translate the findings into actionable business recommendations.

## Tools & Technologies

- **Microsoft Excel** — Data cleaning and preparation
- **MySQL Workbench** — SQL queries and data analysis
- **Python** — Exploratory Data Analysis using Pandas and data visualization
- **Power BI** — Interactive dashboard and KPI reporting
- **Git & GitHub** — Project version control and documentation

## Project Workflow

### 1. Data Cleaning — Excel

The dataset was inspected and prepared for analysis.

Key tasks included:
- Checking missing values and duplicate customer IDs.
- Reviewing column values and data consistency.
- Creating additional analytical groups, including age groups, tenure groups, and monthly charge groups.
- Converting 120 negative monthly charge values into blanks because they were invalid for the analysis.
- Creating 2 new excel files including category classification and blanks handling.

The cleaned dataset contained **7,043 customer records**.

### 2. SQL Analysis — MySQL

SQL was used to analyze churn rates across different customer segments.

Key techniques included:
- `GROUP BY` and aggregate functions.
- `CASE` statements for conditional calculations.
- Common Table Expressions (CTEs).
- Filtering and sorting results.
- Segment analysis using multiple customer attributes.

The analysis focused on contract type, tenure, internet service, offers, payment methods and combinations of customer characteristics.

### 3. Exploratory Data Analysis — Python

Python and Pandas were used to explore the dataset, compare customer groups, and investigate churn patterns.

Key tasks included:
- Analyzing customer status and churn rates.
- Comparing average monthly charges, tenure and revenue across customer statuses.
- Investigating churn across contract types and internet services.
- Identifying high-risk customer segments.
- Analyzing churn categories and specific churn reasons.

### 4. Interactive Dashboard — Power BI

An interactive dashboard was developed to present the main findings in a concise and accessible format.

**Key Performance Indicators (KPIs):**
- Total Customers
- Churned Customers
- Stayed Customers
- Churn Rate

**Visualizations:**
- Churn Rate by Contract Type
- Churn Rate by Tenure Group
- Churn Rate by Internet Type

**Interactive Filters:**
- Contract Type
- Internet Type
- Age Group

The dashboard allows users to explore churn patterns across different customer segments.

## Key Findings

### Overall Customer Churn

- Total customers: **7,043**
- Churned customers: **1,869**
- Customers who stayed: **4,720**
- New customers: **454**
- Overall churn rate: **26.54%**

Approximately one in four customers in the dataset had churned.

### Churn by Contract Type

| Contract Type | Churn Rate |
|---|---:|
| Month-to-Month | 45.84% |
| One Year | 10.71% |
| Two Year | 2.55% |

Month-to-month customers had a substantially higher churn rate than customers with longer-term contracts. This suggests that contract commitment is strongly associated with customer retention in this dataset.

### Churn by Tenure

| Tenure Group | Churn Rate |
|---|---:|
| 0–6 months | 53.33% |
| 7–12 months | 35.34% |
| 13–24 months | 28.71% |
| 25–36 months | 21.63% |
| 37–48 months | 19.03% |
| 49–60 months | 14.42% |
| 61+ months | 6.61% |

Churn was highest among customers with shorter tenure and generally declined as tenure increased. This highlights the importance of customer onboarding and early retention efforts.

### Churn by Internet Type

| Internet Type | Churn Rate |
|---|---:|
| Fiber Optic | 40.72% |
| Cable | 25.66% |
| DSL | 18.58% |

Fiber Optic customers had the highest churn rate among the internet service categories. Further investigation would be needed to determine whether this is associated with pricing, service quality, customer expectations or other factors.

### High-Risk Customer Segment

One of the highest-risk segments identified was:

- Contract: Month-to-Month
- Internet Type: Fiber Optic
- Offer: Offer E
- Customers in segment: 304
- Churn rate: **77.63%**

This segment had a notably high churn rate and could be prioritized for further investigation and targeted retention strategies.

### Reasons for Customer Churn

The analysis of churn categories identified the following distribution among the 1,869 churned customers:

| Churn Category | Customers | Share of Churned Customers |
|---|---:|---:|
| Competitor | 841 | 45.00% |
| Dissatisfaction | 321 | 17.17% |
| Attitude | 314 | 16.80% |
| Price | 211 | 11.29% |
| Other | 182 | 9.74% |

**Competition was the most frequently reported churn category**, accounting for 45% of churned customers.

The most frequently reported specific reasons included:

- Competitor had better devices: **16.75%**
- Competitor made better offer: **16.64%**
- Attitude of support person: **11.77%**
- Don't know: **6.96%**
- Competitor offered more data: **6.26%**

Within the Attitude category, 70.06% of customers cited the attitude of the support person. Within the Competitor category, better devices and better offers accounted for 37.22% and 36.98% of the category, respectively.

These findings suggest that competitive offerings and customer service experience deserve particular attention.

## Business Recommendations

Based on the analysis, the following actions could help improve customer retention:

1. **Strengthen early retention efforts:** Customers with short tenure have significantly higher churn rates. Improve onboarding, follow-up communication and early customer support.
2. **Review month-to-month contracts:** Investigate retention incentives and longer-term contract options that provide clear value to customers.
3. **Evaluate competitive offerings:** Review device options, service packages and promotional offers to understand where competitors may provide a stronger value proposition.
4. **Improve customer support:** Provide additional staff training and monitor customer satisfaction to address concerns about support interactions.
5. **Investigate Fiber Optic churn:** Explore potential issues related to pricing, reliability, service expectations and the specific needs of this customer segment.
6. **Review pricing and service value:** Examine customer feedback about high prices and additional service charges.

These recommendations are based on observed patterns and reported churn reasons. Further investigation would be required to establish causality and evaluate the effectiveness of specific retention actions.

## Limitations

- The analysis identifies associations and patterns but does not establish causal relationships.
- Reported churn reasons reflect the reasons recorded in the dataset and may not capture every factor influencing customer decisions.
- The high churn rate in a customer segment does not, by itself, explain why those customers leave.
- The analysis is based on the available dataset and may not represent all telecommunications customers.

## Conclusion

This project demonstrates an end-to-end data analysis workflow, from data preparation and SQL querying to Python-based exploration and Power BI visualization.

The analysis identified several important churn patterns: month-to-month customers and customers with shorter tenure had higher churn rates, while competition was the most frequently reported reason for customer departure.

The project also demonstrates how data analysis can support business decision-making by identifying customer segments and areas that may benefit from further investigation.

## Author

**Achilleas Tsiamoulis**

GitHub: [AchilleasTsiamoulis1](https://github.com/AchilleasTsiamoulis1)
