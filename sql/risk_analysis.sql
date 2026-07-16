/*

Analyze stock risk, volatility, drawdown,
and abnormal price movements.


*/

/*

Calculate the standard deviation of daily returns
for each company.

*/

SELECT
    company,
    ROUND(STDDEV(daily_return)::numeric,4) AS volatility
FROM stock_data
WHERE daily_return IS NOT NULL
GROUP BY company
ORDER BY volatility DESC;

/*
Business Insight:

Higher standard deviation indicates greater
price volatility and investment risk.
*/

/*

Calculate the maximum drawdown for each company.

*/

WITH drawdown AS (

SELECT
    company,
    date,
    close,

    MAX(close) OVER(
        PARTITION BY company
        ORDER BY date
    ) AS running_peak

FROM stock_data

)

SELECT

company,

ROUND(
MIN(((close-running_peak)/running_peak)*100)::numeric,
2
) AS max_drawdown_percent

FROM drawdown

GROUP BY company

ORDER BY max_drawdown_percent;
/*
Business Insight:

Maximum drawdown measures the largest decline
from a historical peak, helping investors
understand downside risk.
*/

/*

Rank companies using a risk-adjusted return ratio.

*/

SELECT

company,

ROUND(
(AVG(daily_return)/STDDEV(daily_return))::numeric,
4
) AS risk_adjusted_return

FROM stock_data

WHERE daily_return IS NOT NULL

GROUP BY company

ORDER BY risk_adjusted_return DESC;

/*
Business Insight:

Identifies companies generating better returns
relative to their risk.
*/

/*

Find days with abnormal price movement
(greater than 5%).

*/

SELECT

company,
date,
ROUND(daily_return::numeric,4) AS daily_return

FROM stock_data

WHERE ABS(daily_return) > 0.05

ORDER BY ABS(daily_return) DESC;

/*
Business Insight:

Highlights unusually large daily price changes
that may be linked to important market events.
*/