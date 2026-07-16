/*

Project : Stock Market Analytics Pipeline
Analyze stock relationships and validate data quality.

*/
/*

Calculate the correlation between two companies'
daily returns.

*/

SELECT
    CORR(a.daily_return, b.daily_return) AS correlation
FROM stock_data a
JOIN stock_data b
ON a.date = b.date
WHERE a.company = 'AAPL'
AND b.company = 'MSFT'
AND a.daily_return IS NOT NULL
AND b.daily_return IS NOT NULL;

/*
Business Insight:

Measures how closely Apple and Microsoft move
together in terms of daily returns.
*/
/*

Analyze overnight price gaps.

*/

SELECT

company,
date,
open,

LAG(close) OVER(
PARTITION BY company
ORDER BY date
) AS previous_close,

ROUND(
(open-LAG(close) OVER(
PARTITION BY company
ORDER BY date
))::numeric,
2
) AS overnight_gap

FROM stock_data;

/*
Business Insight:

Shows the difference between today's opening
price and yesterday's closing price.
*/
/*

Find the best performing month.

*/

SELECT
    EXTRACT(MONTH FROM date::DATE) AS month,
    ROUND(AVG(daily_return)::numeric, 4) AS average_return
FROM stock_data
WHERE daily_return IS NOT NULL
GROUP BY month
ORDER BY average_return DESC;
/*
Business Insight:

Identifies which month historically delivered
the highest average returns.
*/
/*

Check data quality.

*/

SELECT

COUNT(*) AS total_rows,

COUNT(DISTINCT company) AS companies,

COUNT(*)-COUNT(date) AS missing_dates,

COUNT(*)-COUNT(close) AS missing_close_prices,

COUNT(*)-
COUNT(DISTINCT(company,date))
AS duplicate_records

FROM stock_data;

/*
Business Insight:

Validates dataset quality by identifying
missing values and duplicate records.
*/
