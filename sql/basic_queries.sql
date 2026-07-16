/*
basic analysis 
stock market analytics pipeline
basic sql queries to understand the stock market dataset.
*/




-- 1.Find the total number of records.
--insight - it gives the total count of the record.--


SELECT COUNT(*) AS total_records
FROM stock_data;






--2.Find total number of companies.--
-- it identifies the no. of unique companies available in the dataset. It helps measure dataset coverage and confirms whether--
--all intended companies were successfully loaded.--
SELECT COUNT(DISTINCT company) AS total_companies
FROM stock_data;

 


/*

Find the available date range.
This query determines the time period covered by the
dataset.

insight- Understanding the available date range is important for
trend analysis, yearly comparisons, forecasting, and
dashboard filtering.
*/

SELECT
    MIN(date) AS start_date,
    MAX(date) AS end_date
FROM stock_data;




/*

Find average closing price of each company.
insight-This query compares the average closing price of all
companies over the selected period.

It helps identify companies whose stocks generally trade
at higher price levels and provides a quick comparison of
overall stock price trends.
*/

SELECT
    company,
    ROUND(AVG(close)::numeric, 2) AS average_close_price
FROM stock_data
GROUP BY company
ORDER BY average_close_price DESC;



/*


Find the highest trading volume.
insight-This query identifies the trading day with the highest
market activity.

Extremely high trading volume often indicates important
events such as earnings announcements, major news,
market volatility, or increased investor participation.
*/

SELECT
    company,
    date,
    volume
FROM stock_data
ORDER BY volume DESC
LIMIT 1;
