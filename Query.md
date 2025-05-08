<ol>
<li>

`Write a query to display the cryptocurrencies whose transaction fees are greater than or equal to 1 USD and show them in ascending order.`

```sql
SELECT * FROM CRYPTO_CURRENCY_PERFORMANCE_METRICS WHERE CRYPTO_CURRENCY_PERFORMANCE_METRICS.AVERAGE_TRX_FEE>=1 ORDER BY AVERAGE_TRX_FEE ASC;
```
</li>
<li>

`Write a query to display the all time maximum price, all time minimum price, the date of the maximum price, the date of the minimum price, and the maximum return of any currency.`

```sql
 WITH TMP AS (
    SELECT 
        SYMBOL,
        MAX_PRICE,
        MIN_PRICE,
        MAX_PRICE_DATE,
        MIN_PRICE_DATE,
        (MAX_PRICE - MIN_PRICE) * 100 / NULLIF(MIN_PRICE, 0) AS MAX_RETURN  -- Added NULLIF to avoid division by zero
    FROM CRYPTO
)
SELECT * 
FROM TMP 
WHERE SYMBOL = 'BTC';
```

</li>

<li>


`Write a query to display the brokerages have their headquarters in the countries where cryptocurrency is accepted and legal.`

```sql
SELECT 
    BROKERAGE.NAME,
    BROKERAGE.HEADQUARTER,
    COUNTRY.CRYPTO_STATUS
FROM 
    BROKERAGE 
JOIN 
    COUNTRY 
ON 
   BROKERAGE.HEADQUARTER LIKE '%' + COUNTRY.COUNTRY_NAME
   -- BROKERAGE.HEADQUARTER LIKE '%' + COUNTRY.COUNTRY_NAME + '%'
WHERE 
    COUNTRY.CRYPTO_STATUS = 'ACCEPTED';
	select * from COUNTRY
	Select * from BROKERAGE
```

</li>

<li>

`Write a query to display the yearly growth in the number of crypto users increased or decreased,  the market cap growth increased or decreased, and  the percentage growth of users and market cap increased or decreased.`

```sql
SELECT 
    T2.year,
    CAST(T2.TOTAL_USER_IN_WORD AS VARCHAR) + ' million' AS total_user,
    CAST(((T2.TOTAL_USER_IN_WORD - T1.TOTAL_USER_IN_WORD) * 100.0 / T1.TOTAL_USER_IN_WORD) AS VARCHAR) + '%' AS user_growth,
    CAST(T2.total_market_cap AS VARCHAR) + ' billion' AS market_cap,
    CAST(((T2.total_market_cap - T1.total_market_cap) * 100.0 / T1.TOTAL_USER_IN_WORD) AS VARCHAR) + '%' AS market_growth
FROM 
    Total_User_Distribution T1
JOIN 
    Total_User_Distribution T2 ON T2.year = T1.year + 1
```
</li>

<li>

`Write a query to display the intersection of crypto table and market dominance table.`

```sql
--INTERSECTION
SELECT SYMBOL 
FROM CRYPTO
INTERSECT
SELECT SYMBOL 
FROM MARKET_DOMINANCE 
WHERE YEAR = 2025;
```

</li>

<li>

`Write a query to display the total number of currencies for each consensus algorithm.`

```sql
--GROUP BY
select CONSENSUS_ALGORITHM_TYPE,count(CONSENSUS_ALGORITHM_TYPE) from CRYPTO group by CONSENSUS_ALGORITHM_TYPE;
```

</li>

<li>

`Write a query to display the total number of currencies for each specific consensus algorithm. User said the consensus algorithm name. Like as: PoS,PoW, AuxPoW, PoC.`

```sql
--HAVING
select CONSENSUS_ALGORITHM_TYPE,count(CONSENSUS_ALGORITHM_TYPE) from CRYPTO group by CONSENSUS_ALGORITHM_TYPE
                                                                            having CONSENSUS_ALGORITHM_TYPE='PoW'
or CONSENSUS_ALGORITHM_TYPE='PoS' or CONSENSUS_ALGORITHM_TYPE='AuxPoW';	
```

</li>

<li>

`Write a query to display (Combine the list of cryptocurrency symbols from countries where cryptocurrencies are accepted(ACCEPTED_COUNTRYWISE_MOST_USED_CRYPTO) and those from banned countries (USER_AMOUNT_IN_BANNED_COUNTRY) for the year 2024.`

```sql
--UNION
SELECT CRYPTO_SYMBOL AS SYMBOL
FROM ACCEPTED_COUNTRYWISE_MOST_USED_CRYPTO
WHERE YEAR = 2024
UNION
SELECT AFFECTED_CRYPTO AS SYMBOL
FROM CONTROVERSY
WHERE YEAR = 2024 AND AFFECTED_CRYPTO IS NOT NULL;
```

</li>

<li>

`Write a query to display and increase the average transaction fee (AVERAGE_TRX_FEE) by 10% for those cryptocurrencies whose average transaction fee (AVERAGE_TRX_FEE) is greater than or equal to 1`

```sql
UPDATE CRYPTO_CURRENCY_PERFORMANCE_METRICS
SET AVERAGE_TRX_FEE = AVERAGE_TRX_FEE * 1.10
WHERE AVERAGE_TRX_FEE > 1;
SELECT * FROM CRYPTO_CURRENCY_PERFORMANCE_METRICS
```
</li>

<li>


`Write a query to display the cryptocurrency symbols, names, and their maximum prices, along with a price tier classification. The price tier should categorize the maximum price as 'High Price' (greater than 10,000), 'Medium Price' (between 100 and 10,000), and 'Low Price' (less than 100). Sort the results in descending order of maximum price.`

```sql
--CASE
SELECT 
    SYMBOL,
    NAME,
    MAX_PRICE,
    CASE 
        WHEN MAX_PRICE > 10000 THEN 'High Price'
        WHEN MAX_PRICE BETWEEN 100 AND 10000 THEN 'Medium Price'
        ELSE 'Low Price'
    END AS PRICE_TIER
FROM CRYPTO
ORDER BY MAX_PRICE DESC;
```

</li>

</ol>