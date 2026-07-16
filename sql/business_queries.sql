/*

Project : Stock Market Analytics Pipeline
Business-oriented SQL queries to analyze stock performance,
volatility, returns, and trading activity.

*/


/*

Find the top 10 highest-performing companies based on
cumulative return.
insight-Identifies the top-performing stocks based on cumulative
return over the selected period.
*/

SELECT
    company,
    ROUND(MAX(cumulative_return)::numeric,2) AS total_return
FROM stock_data
GROUP BY company
ORDER BY total_return DESC
LIMIT 10;





/*

Find the top 10 most volatile companies.
Shows the companies with the highest price fluctuations,
helping identify high-risk stocks.
*/

SELECT
    company,
    ROUND(AVG(volatility_30d)::numeric,4) AS avg_volatility
FROM stock_data
GROUP BY company
ORDER BY avg_volatility DESC
LIMIT 10;




/*

Find the company with the highest average daily return.
Identifies the company that consistently delivered the
highest average daily return during the selected period.

*/

SELECT
    company,
    ROUND(AVG(daily_return)::numeric,4) AS avg_daily_return
FROM stock_data
WHERE daily_return IS NOT NULL
GROUP BY company
ORDER BY avg_daily_return DESC
LIMIT 1;




/*

Find the highest single-day gain.
Shows the company and date with the maximum one-day
stock price increase.

*/

SELECT
    company,
    date,
    ROUND(daily_return::numeric,4) AS daily_return
FROM stock_data
WHERE daily_return IS NOT NULL
ORDER BY daily_return DESC
LIMIT 1;




/*

Find the highest single-day loss.
Identifies the largest one-day decline in stock price,
helping analyze major market drops.

*/

SELECT
    company,
    date,
    ROUND(daily_return::numeric,4) AS daily_return
FROM stock_data
WHERE daily_return IS NOT NULL
ORDER BY daily_return ASC
LIMIT 1;


/*


Find the average trading volume for each company.


Compares the average trading activity of companies and
helps identify the most actively traded stocks.

*/

SELECT
    company,
    ROUND(AVG(volume)::numeric,0) AS average_volume
FROM stock_data
GROUP BY company
ORDER BY average_volume DESC;




/*

Find the highest stock price ever recorded.
Shows the company and date when the highest stock price
was recorded in the dataset.
*/

SELECT
    company,
    date,
    high
FROM stock_data
ORDER BY high DESC
LIMIT 1;





/*

Find the lowest stock price ever recorded.
Shows the company and date when the lowest stock price
was recorded in the dataset.

*/

SELECT
    company,
    date,
    low
FROM stock_data
ORDER BY low ASC
LIMIT 1;

