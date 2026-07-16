/*

Advanced SQL queries using Common Table Expressions (CTEs)
to analyze yearly and monthly stock performance.


*/
/*

Find the top gainer for each year.

*/

WITH yearly_return AS (

    SELECT
        EXTRACT(YEAR FROM date::date) AS year,
        company,
        ROUND(MAX(cumulative_return)::numeric,2) AS total_return
    FROM stock_data
    GROUP BY year, company

),

ranked AS (

    SELECT *,
           RANK() OVER(
               PARTITION BY year
               ORDER BY total_return DESC
           ) AS rank_no
    FROM yearly_return

)

SELECT
    year,
    company,
    total_return
FROM ranked
WHERE rank_no = 1
ORDER BY year;

/*
Business Insight:

Identifies the best-performing company in each year
based on cumulative return.
*/

/*

Find the top loser for each year.

*/

WITH yearly_return AS (

    SELECT
        EXTRACT(YEAR FROM date::date) AS year,
        company,
        ROUND(MAX(cumulative_return)::numeric,2) AS total_return
    FROM stock_data
    GROUP BY year, company

),

ranked AS (

    SELECT *,
           RANK() OVER(
               PARTITION BY year
               ORDER BY total_return ASC
           ) AS rank_no
    FROM yearly_return

)

SELECT
    year,
    company,
    total_return
FROM ranked
WHERE rank_no = 1
ORDER BY year;

/*
Business Insight:

Shows the weakest-performing stock each year.
*/

/*

Calculate the monthly average daily return.

*/

SELECT

    EXTRACT(YEAR FROM date::date) AS year,
    EXTRACT(MONTH FROM date::date) AS month,

    ROUND(
        AVG(daily_return)::numeric,
        4
    ) AS average_return

FROM stock_data

WHERE daily_return IS NOT NULL

GROUP BY year, month

ORDER BY year, month;

/*
Business Insight:

Shows monthly market performance trends over time.
*/

/*

Find stocks trading above their 30-day moving average.

*/

SELECT

    company,
    date,
    close,
    ma30

FROM stock_data

WHERE close > ma30

ORDER BY company, date;

/*
Business Insight:

Stocks trading above MA30 often indicate an
upward price trend.
*/

/*

Find days where volume was above the 10-day average.

*/

SELECT

    company,
    date,
    volume,
    volume_ma10

FROM stock_data

WHERE volume > volume_ma10

ORDER BY company, date;

/*
Business Insight:

Highlights unusually high trading activity,
which may indicate significant market events.
*/