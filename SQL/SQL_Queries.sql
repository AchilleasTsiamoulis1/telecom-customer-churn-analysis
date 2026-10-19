-- Total Customers 
SELECT COUNT(*)
FROM telecom_churn;

-- Customer Status
SELECT COUNT(`Customer Status`), `Customer Status`
FROM telecom_churn
GROUP BY `Customer Status`;

-- Overall Churn Rate
SELECT (COUNT(CASE WHEN `Customer Status` = 'Churned' THEN 1 END) * 100.0) / COUNT(*) AS churn_rate_percentage
FROM telecom_churn;

SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE 
			WHEN `Customer Status` = 'Churned' THEN 1 
			ELSE 0 
		END) AS churned_customers,
    ROUND(
        SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) / COUNT(*) * 100,
        2
    ) AS churn_rate
FROM telecom_churn;

-- Which Contract type has the highest churn rate?
SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE 
			WHEN `Customer Status` = 'Churned' THEN 1 
			ELSE 0 
		END) AS churned_customers,
    ROUND(
        SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) / COUNT(*) * 100,
        2
    ) AS churn_rate
FROM telecom_churn
GROUP BY Contract;

-- Tenure
SELECT 
	(CASE 
		WHEN `Tenure in Months` BETWEEN 0 AND 6 THEN '0-6'
		WHEN `Tenure in Months` BETWEEN 7 AND 12 THEN '7-12'
		WHEN `Tenure in Months` BETWEEN 13 AND 24 THEN '13-24'
		WHEN `Tenure in Months` BETWEEN 25 AND 36 THEN '25-36'
		WHEN `Tenure in Months` BETWEEN 37 AND 48 THEN '37-48'
		WHEN `Tenure in Months` BETWEEN 49 AND 60 THEN '49-60'
		ELSE '61+'
	END) AS Tenure_in_Groups, 
	COUNT(*) AS total_customers, 
    SUM(CASE 
			WHEN `Customer Status` = 'Churned' THEN 1
			ELSE 0
		END) AS churned,
    ROUND(
        SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) / COUNT(*) * 100,
        2
    ) AS churn_rate
FROM telecom_churn
GROUP BY Tenure_in_Groups;

-- Same using the new column
SELECT `Tenure in Groups`,
	COUNT(*) AS total_customers,
    SUM(CASE 
			WHEN `Customer Status` = 'Churned' THEN 1
			ELSE 0
		END) AS churned,
    ROUND(
        SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) / COUNT(*) * 100,
        2
    ) AS churn_rate
FROM telecom_churn
GROUP BY `Tenure in Groups`;
    
-- Which Internet Type has the highest churn rate?
SELECT `Internet Type`, 
	COUNT(*) AS customers, 
    SUM(CASE 
			WHEN `Customer Status` = 'Churned' THEN 1 
			ELSE 0 
		END) AS churned, 
    ROUND(
		SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) / COUNT(*) * 100, 
		2) AS churn_rate 
FROM telecom_churn
WHERE `Internet Type` IS NOT NULL AND `Internet Type` <> ''
GROUP BY `Internet Type`;

-- Churn Rate by Offer
SELECT Offer,
	COUNT(*) AS Total_customers,
    SUM(CASE 
			WHEN `Customer Status` = 'Churned' THEN 1 
			ELSE 0 
		END) AS churned,
        ROUND(
		SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) / COUNT(*) * 100, 
		2) AS churn_rate 
FROM telecom_churn
GROUP BY Offer;

-- Monthly Charge Groups
SELECT (CASE
			WHEN `Monthly Charge` < 30 THEN 'Under $30'
			WHEN `Monthly Charge` BETWEEN 30 AND 49.99 THEN '$30-49.99'
			WHEN `Monthly Charge` BETWEEN 50 AND 69.99 THEN '$50-69.99'
			WHEN `Monthly Charge` BETWEEN 70 AND 89.99 THEN '$70-89.99'
			ELSE '$90+'
		END) AS Monthly_Charge,
        COUNT(*) AS Total_Customers,
        SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) AS churned,
		ROUND(
			SUM(CASE 
					WHEN `Customer Status` = 'Churned' THEN 1 
					ELSE 0 
				END) / COUNT(*) * 100, 
		2) AS churn_rate 
FROM telecom_churn
GROUP BY Monthly_Charge;

-- Same using the new column
SELECT `Montlhy Charge Group`,
	COUNT(*) AS Total_Customers,
        SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) AS churned,
		ROUND(
			SUM(CASE 
					WHEN `Customer Status` = 'Churned' THEN 1 
					ELSE 0 
				END) / COUNT(*) * 100, 
		2) AS churn_rate 
FROM telecom_churn
GROUP BY `Montlhy Charge Group`;

-- Monthly Charge with Contract
SELECT `Montlhy Charge Group`,
	`Contract`,
    COUNT(*) AS Total_Customers,
    SUM(CASE 
			WHEN `Customer Status` = 'Churned' THEN 1 
			ELSE 0 
		END) AS churned,
	ROUND(
		SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) / COUNT(*) * 100, 
	2) AS churn_rate 
FROM telecom_churn
GROUP BY `Montlhy Charge Group`, `Contract`
ORDER BY `Montlhy Charge Group` ASC, `Contract` ASC;

-- High-risk segment (Offer E, Fiber Optic, Month-to-Month)
SELECT COUNT(*) AS Total_Customers,
	SUM(CASE 
			WHEN `Customer Status` = 'Churned' THEN 1 
			ELSE 0 
		END) AS churned,
	ROUND(
		SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) / COUNT(*) * 100, 
	2) AS churn_rate
FROM telecom_churn
WHERE `Offer` = 'Offer E' AND `Internet Type` = 'Fiber Optic' AND `Contract` = 'Month-to-Month';

-- Churn by Payment Method
SELECT `Payment Method`,
	COUNT(*) AS total_customers,
    SUM(CASE 
			WHEN `Customer Status` = 'Churned' THEN 1 
			ELSE 0 
		END) AS churned,
	ROUND(
		SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) / COUNT(*) * 100, 
	2) AS churn_rate
FROM telecom_churn
GROUP BY `Payment Method`;

-- Churn by Age Group
SELECT (CASE
			WHEN Age < 30 THEN 'Under 30' 
            WHEN Age BETWEEN 30 AND 44 THEN '30-44'
            WHEN Age BETWEEN 45 AND 59 THEN '45-59'
            ELSE '60+'
		END) AS Age_Group,
        COUNT(*) AS Total_customers,
        SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) AS churned,
		ROUND(
			SUM(CASE 
					WHEN `Customer Status` = 'Churned' THEN 1 
					ELSE 0 
				END) / COUNT(*) * 100, 
		2) AS churn_rate
FROM telecom_churn
GROUP BY Age_Group;

-- Same using the new column
SELECT `Age Group`,
        COUNT(*) AS Total_customers,
        SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) AS churned,
		ROUND(
			SUM(CASE 
					WHEN `Customer Status` = 'Churned' THEN 1 
					ELSE 0 
				END) / COUNT(*) * 100, 
		2) AS churn_rate
FROM telecom_churn
GROUP BY `Age Group`;


-- High-risk segments per Offer
SELECT `Offer`,
	`Internet Type`,
    COUNT(*) AS Total_Customers,
    SUM(CASE 
			WHEN `Customer Status` = 'Churned' THEN 1 
			ELSE 0 
		END) AS churned,
	ROUND(
		SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) / COUNT(*) * 100, 
	2) AS churn_rate
FROM telecom_churn
WHERE TRIM(`Internet Type`) <> ''
GROUP BY `Offer`, `Internet Type`
ORDER BY `Offer` ASC, `Internet Type` ASC;

-- Customer Status distribution
SELECT `Contract`,
	`Customer Status`,
    COUNT(*) AS Total_Customers
FROM telecom_churn
GROUP BY `Contract`, `Customer Status`
ORDER BY `Contract` ASC;

-- Churn Rate per Tenure Group and Contract
SELECT (CASE 
		WHEN `Tenure in Months` BETWEEN 0 AND 6 THEN '0-6'
		WHEN `Tenure in Months` BETWEEN 7 AND 12 THEN '7-12'
		WHEN `Tenure in Months` BETWEEN 13 AND 24 THEN '13-24'
		WHEN `Tenure in Months` BETWEEN 25 AND 36 THEN '25-36'
		WHEN `Tenure in Months` BETWEEN 37 AND 48 THEN '37-48'
		WHEN `Tenure in Months` BETWEEN 49 AND 60 THEN '49-60'
		ELSE '61+'
	END) AS Tenure_in_Groups,
	`Contract`,
    COUNT(*) AS Total_customers,
    SUM(CASE 
			WHEN `Customer Status` = 'Churned' THEN 1 
			ELSE 0 
		END) AS churned,
	ROUND(
		SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) / COUNT(*) * 100, 
	2) AS churn_rate
FROM telecom_churn
GROUP BY Tenure_in_Groups, `Contract`
ORDER BY churn_rate DESC;

-- Top 5 high-risk combinations
SELECT `Contract`,
	`Internet Type`,
    COUNT(*) AS Total_Customers,
    SUM(CASE 
			WHEN `Customer Status` = 'Churned' THEN 1 
			ELSE 0 
		END) AS churned,
	ROUND(
		SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) / COUNT(*) * 100, 
	2) AS churn_rate
FROM telecom_churn
WHERE TRIM(`Internet Type`) <> ''
GROUP BY `Contract`, `Internet Type`
ORDER BY churn_rate DESC
LIMIT 5;

-- Automatically detects high-risk customer segments
SELECT `Contract`,
	`Internet Type`,
	`Offer`,
    COUNT(*) AS Total_Customers,
    SUM(CASE 
			WHEN `Customer Status` = 'Churned' THEN 1 
			ELSE 0 
		END) AS churned,
	ROUND(
		SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) / COUNT(*) * 100, 
	2) AS churn_rate
FROM telecom_churn
WHERE TRIM(`Internet Type`) <> ''
GROUP BY `Contract`, `Internet Type`, `Offer`
ORDER BY churn_rate DESC
LIMIT 5;

-- 100% seems like a huge number, but in practice it means almost nothing because it’s based on a single customer.
-- That’s why we don’t look solely at the churn rate

-- With HAVING
SELECT `Contract`,
	`Internet Type`,
	`Offer`,
    COUNT(*) AS Total_Customers,
    SUM(CASE 
			WHEN `Customer Status` = 'Churned' THEN 1 
			ELSE 0 
		END) AS churned,
	ROUND(
		SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) / COUNT(*) * 100, 
	2) AS churn_rate
FROM telecom_churn
WHERE TRIM(`Internet Type`) <> ''
GROUP BY `Contract`, `Internet Type`, `Offer`
HAVING COUNT(*) >= 100
ORDER BY churn_rate DESC
LIMIT 5;

-- The Offer E + Fiber Optic + Month-to-Month plan isn’t just the one with the highest rate.
-- It has: 304 customers → 236 churned → 77.63%, so it is simultaneously:
-- 1) a fairly large segment,
-- 2) an extremely high observed churn rate,
-- 3) and clearly higher than the other large combinations.
-- We also see that all of the Top 5 are Month-to-Month. This further reinforces our finding regarding the Contract.

-- WITH/CTE
WITH Top_5_high_risk_customer_segments AS (
	SELECT `Contract`,
	`Internet Type`,
	`Offer`,
    COUNT(*) AS Total_Customers,
    SUM(CASE 
			WHEN `Customer Status` = 'Churned' THEN 1 
			ELSE 0 
		END) AS churned,
	ROUND(
		SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) / COUNT(*) * 100, 
	2) AS churn_rate
	FROM telecom_churn
	WHERE TRIM(`Internet Type`) <> ''
	GROUP BY `Contract`, `Internet Type`, `Offer`
	HAVING COUNT(*) >= 100
	ORDER BY churn_rate DESC
	LIMIT 5
)
SELECT * 
FROM Top_5_high_risk_customer_segments;

-- Of the total 1,869 churned customers, what percentage does each high-risk segment represent?
WITH Top_5_high_risk_customer_segments AS (
	SELECT `Contract`,
	`Internet Type`,
	`Offer`,
    COUNT(*) AS Total_Customers,
    SUM(CASE 
			WHEN `Customer Status` = 'Churned' THEN 1 
			ELSE 0 
		END) AS churned,
	ROUND(
		SUM(CASE 
				WHEN `Customer Status` = 'Churned' THEN 1 
				ELSE 0 
			END) / COUNT(*) * 100, 
	2) AS churn_rate
	FROM telecom_churn
	WHERE TRIM(`Internet Type`) <> ''
	GROUP BY `Contract`, `Internet Type`, `Offer`
	HAVING COUNT(*) >= 100
	ORDER BY churn_rate DESC
	LIMIT 5
), 
Total_Churned AS (
    SELECT COUNT(*) AS total_churned
    FROM telecom_churn
    WHERE `Customer Status` = 'Churned'
)
SELECT `Contract`,
    `Internet Type`,
    `Offer`,
    churned,
    ROUND(churned / total_churned * 100, 2) AS result
FROM Top_5_high_risk_customer_segments
CROSS JOIN Total_Churned;
-- Essentially, I’m not looking for “how much churn this segment has,” but rather “what percentage of all 1,869 churned customers comes from this segment.”
-- Segment churn rate → how likely a customer in this segment is to churn.
-- Share of all churned customers → how significant this segment is within the total number of churned customers.
-- The M2M + Fiber + Offer E segment has the highest churn rate (77.63%), so it is the “most at-risk” segment in terms of the likelihood of churn.
-- However, the M2M + Fiber + None segment is even more significant in terms of absolute business impact:
-- 	641 churned customers = 34.30% of all churned customers.
-- In other words:
-- This specific segment does not have the highest churn rate, but on its own it accounts for approximately 1 in 3 churned customers.
-- 236 + 641 + 71 + 111 + 54 = 1,113 churned customers
-- That is, approximately 59.5% of all churned customers.
-- Therefore, we can say:
-- The 5 highest-risk customer segments, each with at least 100 customers, account for approximately 60% of all churned customers. All 5 include month-to-month contracts, and most involve fiber-optic customers.


-- 1) Overall KPIs
-- Total Customers → 7,043
-- Churned → 1,869
-- Churn Rate → 26.54%
-- 2. Main drivers / patterns
-- Month-to-Month → 45.84%
-- 0–6 months → 53.33%
-- Fiber Optic → 40.72%
-- Offer E → 52.92%
-- 60+ → 35.41%
-- Bank Withdrawal → 34.00%
-- 3. High-risk segments
-- M2M + Fiber + Offer E → 77.63%
-- M2M + Fiber + None → 59.74%
-- The Top 5 segments → around 59.5% of all the churned customers

-- Average values
SELECT ROUND(AVG(`Monthly Charge`), 2) AS AVG_Monthly_Charge, 
	ROUND(AVG(`Total Charges`), 2) AS AVG_Total_Charge, 
    ROUND(AVG(`Total Revenue`), 2) AS AVG_Total_Revenue, 
    ROUND(AVG(`Tenure in Months`), 2) AS AVG_Tenure_in_Months, 
    ROUND(AVG(`Avg Monthly Long Distance Charges`), 2) AS AVG_Monthly_Long_Distance_Charges,
    `Customer Status`
FROM telecom_churn
WHERE `Customer Status` = 'Churned' OR `Customer Status` = 'Stayed'
GROUP BY `Customer Status`;
-- "Churned customers have a higher average monthly charge than stayed customers ($72.97 vs $61.38), while also having substantially shorter average tenure (18.0 vs 41.0 months)."

-- Average Monthly Charge per Customer Status and Contract
SELECT ROUND(AVG(`Monthly Charge`), 2) AS AVG_Monthly_Charge, 
	`Customer Status`,
    `Contract`
FROM telecom_churn
WHERE `Customer Status` = 'Churned' OR `Customer Status` = 'Stayed'
GROUP BY `Customer Status`, `Contract`;
-- "Across all contract types, churned customers have higher average monthly charges than stayed customers, with the largest differences observed among One Year and Two Year contracts."

-- How much Revenue "is lost" from Churned customers
SELECT 
    ROUND(SUM(CASE 
            WHEN `Customer Status` = 'Churned' THEN `Total Revenue` 
            ELSE 0 
        END), 2) AS Churned_Revenue,

    ROUND(SUM(CASE 
            WHEN `Customer Status` = 'Stayed' THEN `Total Revenue` 
            ELSE 0 
        END), 2) AS Stayed_Revenue,

    ROUND(
        SUM(CASE 
                WHEN `Customer Status` = 'Churned' THEN `Total Revenue` 
                ELSE 0 
            END)
        /
        (
            SUM(CASE 
                    WHEN `Customer Status` = 'Churned' THEN `Total Revenue` 
                    ELSE 0 
                END)
            +
            SUM(CASE 
                    WHEN `Customer Status` = 'Stayed' THEN `Total Revenue` 
                    ELSE 0 
                END)
        ) * 100,
        2
    ) AS Churned_Revenue_Share
FROM telecom_churn;

-- Churned customers account for 26.54% of customers but only 17.28% of the observed revenue generated by Churned and Stayed customers.


-- ############################## Python EDA issue ##################################
SELECT
    COUNT(`Monthly Charge`) AS non_null_count,
    AVG(`Monthly Charge`) AS avg_monthly_charge,
    MIN(`Monthly Charge`) AS min_monthly_charge,
    MAX(`Monthly Charge`) AS max_monthly_charge
FROM telecom_churn;
-- Here the 120 values are still recognized. Also here we have 99.95 max value instead of 118.75


SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN `Monthly Charge` < 0 THEN 1 ELSE 0 END) AS negative_charges,
    SUM(CASE WHEN `Monthly Charge` IS NULL THEN 1 ELSE 0 END) AS null_charges,
    MIN(`Monthly Charge`) AS min_charge,
    MAX(`Monthly Charge`) AS max_charge
FROM telecom_churn;
-- Same here. Now we go to Python again

SELECT
    `Customer ID`,
    `Monthly Charge`
FROM telecom_churn
WHERE `Customer ID` IN (
    '7569-NMZYQ',
    '8984-HPEMB',
    '5734-EJKXG',
    '5989-AXPUC',
    '8199-ZLLSA',
    '9924-JPRMC',
    '2889-FPWRM',
    '3810-DVDQQ',
    '9739-JLPQJ',
    '2302-ANTDP'
);
-- We check the exact values Python gave us to see what is the data. The 118.75 is shown

-- We have to check what is the data type
DESCRIBE telecom_churn;
-- Monthly Charge is TEXT

SELECT
    COUNT(*) AS total_rows,
    AVG(CAST(`Monthly Charge` AS DECIMAL(10,2))) AS avg_monthly_charge,
    MIN(CAST(`Monthly Charge` AS DECIMAL(10,2))) AS min_charge,
    MAX(CAST(`Monthly Charge` AS DECIMAL(10,2))) AS max_charge
FROM telecom_churn;
-- Temporary conversion

-- We check if there are non-numeric values
SELECT `Monthly Charge`
FROM telecom_churn
WHERE `Monthly Charge` IS NOT NULL
  AND TRIM(`Monthly Charge`) NOT REGEXP '^[0-9]+(\\.[0-9]+)?$';
-- There are a lot. Also found that the values are separated with comma instead of dot because we changed them for the excel analysis. Excel wants comma to recognize a number, MYSQL wants dot

-- Check how many values contain ,
SELECT
    SUM(CASE WHEN TRIM(`Monthly Charge`) = '' THEN 1 ELSE 0 END) AS blank_values,
    SUM(CASE WHEN `Monthly Charge` LIKE '%,%' THEN 1 ELSE 0 END) AS comma_values,
    SUM(CASE WHEN `Monthly Charge` LIKE '%.%' THEN 1 ELSE 0 END) AS dot_values
FROM telecom_churn;

-- Temporary change comma to dot 
SELECT
    COUNT(
        CAST(
            REPLACE(NULLIF(TRIM(`Monthly Charge`), ''), ',', '.')
            AS DECIMAL(10,2)
        )
    ) AS non_null_count,

    AVG(
        CAST(
            REPLACE(NULLIF(TRIM(`Monthly Charge`), ''), ',', '.')
            AS DECIMAL(10,2)
        )
    ) AS avg_monthly_charge,

    MIN(
        CAST(
            REPLACE(NULLIF(TRIM(`Monthly Charge`), ''), ',', '.')
            AS DECIMAL(10,2)
        )
    ) AS min_charge,

    MAX(
        CAST(
            REPLACE(NULLIF(TRIM(`Monthly Charge`), ''), ',', '.')
            AS DECIMAL(10,2)
        )
    ) AS max_charge
FROM telecom_churn;

SELECT
    `Customer Status`,
    ROUND(
        AVG(
            CAST(
                REPLACE(NULLIF(TRIM(`Monthly Charge`), ''), ',', '.')
                AS DECIMAL(10,2)
            )
        ),
        2
    ) AS avg_monthly_charge
FROM telecom_churn
GROUP BY `Customer Status`;
-- Now the values are the same as Python

SELECT
    `Customer Status`,
    Contract,
    ROUND(
        AVG(
            CAST(
                REPLACE(
                    NULLIF(TRIM(`Monthly Charge`), ''),
                    ',',
                    '.'
                ) AS DECIMAL(10,2)
            )
        ),
        2
    ) AS avg_monthly_charge
FROM telecom_churn
GROUP BY `Customer Status`, Contract
ORDER BY `Customer Status`, Contract;
-- The values are the same too