/*

Project : Stock Market Analytics Pipeline

SQL Window Functions for ranking, previous/next values,
running averages, and rolling calculations.


*/


/*

Rank companies based on cumulative return.

*/

SELECT
    company,
    ROUND(MAX(cumulative_return)::numeric,2) AS total_return,
    RANK() OVER(
        ORDER BY MAX(cumulative_return) DESC
    ) AS company_rank
FROM stock_data
GROUP BY company;

/*
Business Insight:

Ranks companies according to their overall cumulative
return, helping identify the best-performing stocks.
*/


/*


Find the previous day's closing price using LAG().

*/

SELECT
    company,
    date,
    close,
    LAG(close) OVER(
        PARTITION BY company
        ORDER BY date
    ) AS previous_close
FROM stock_data;

/*
Business Insight:

Compares today's closing price with the previous trading
day, helping analyze daily price movement.
*/


/*

Find the next day's closing price using LEAD().

*/

SELECT
    company,
    date,
    close,
    LEAD(close) OVER(
        PARTITION BY company
        ORDER BY date
    ) AS next_close
FROM stock_data;

/*
Business Insight:

Displays the next trading day's closing price, useful
for time-series analysis and trend comparison.
*/


/*

Calculate the running average of closing price.

*/

SELECT
    company,
    date,
    close,
    ROUND(
        AVG(close) OVER(
            PARTITION BY company
            ORDER BY date
        )::numeric,
        2
    ) AS running_avg_close
FROM stock_data;

/*
Business Insight:

Shows how the average closing price changes over time
for each company.
*/


/*

Calculate the rolling average of trading volume.

*/

SELECT
    company,
    date,
    volume,
    ROUND(
        AVG(volume) OVER(
            PARTITION BY company
            ORDER BY date
            ROWS BETWEEN 9 PRECEDING AND CURRENT ROW
        )::numeric,
        0
    ) AS rolling_avg_volume
FROM stock_data;

/*
Business Insight:

Calculates the 10-day rolling average of trading volume,
helping identify unusual spikes or drops in trading activity.
*/