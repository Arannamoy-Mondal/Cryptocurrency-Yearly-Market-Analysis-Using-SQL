## 🚀  Cryptocurrency Market Analysis Using SQL

## License

> This project is licensed under the Apache License 2.0.  
> See the [LICENSE](./LICENSE) file for more details.

## 📚 Description: This project focuses on analyzing the cryptocurrency market using SQL. It covers various aspects like global adoption, blockchain type (like as: Public, Private, Hybrid, Consortium), blockchain network type (like as: Layer-1, Layer-2), consensus algorithm type (like as: PoS, PoW, PoC etc.), every year market cap, market dominance, transaction speeds, brokerage holdings, yearly returns, exchange traded fund, brokerage market dominance,controversy.

## 🛠️ Features
- Global Crypto Adoption Analysis
- Blockchain Type, Network Type, Consensus Algorithm Type
- Crypto Dominance Metrics
- Country-wise Crypto ATM Distribution
- Average Transaction Cost and Speed Analysis
- Yearly Returns Tracking
- Founding Year Analysis and Market Capitalization Study
- Exchange Traded Fund (ETF's).
- Brokerages’ Holdings Overview and Controversy


# Table Description:

## 1. BLOCKCHAIN_ACCESS_TYPE
**Description:** Stores types of blockchain access (public/private)  
**Attributes:**  
- `TYPE` (VARCHAR(200) **PK** NOT NULL  
- `DESCRIPTION` (TEXT) NOT NULL  
**Normalization:** 3NF  
**Cardinality:** 1:N with CRYPTO  
**Real-Time Usage:** Regulatory compliance categorization

## 2. BLOCKCHAIN_TOKEN_TYPE
**Description:** Defines token types (utility/security)  
**Attributes:**  
- `TYPE` (VARCHAR(200) **PK** NOT NULL  
- `DESCRIPTION` (TEXT) NOT NULL  
**Normalization:** 3NF  
**Cardinality:** 1:N with CRYPTO  
**Real-Time Usage:** Token classification for taxation
RIBUTION
**Description:** Global user distribution by region  
**Attributes:**  
- `YEAR` (INT) **PK**  
- Regional user counts (7 columns)  
- `TOTAL_USER_IN_WORD` (DECIMAL(38,15))  
- `TOTAL_MARKET_CAP` (DECIMAL(38,15))  
**Normalization:** 2NF  
**Cardinality:** 1:N with MARKET_DOMINANCE  
**Real-Time Usage:** Regional adoption tracking

## 9. MARKET_DOMINANCE
**Description:** Annual market share tracking  
**Attributes:**  
- `YEAR` (INT) **PK**  
- `SYMBOL` (VARCHAR(10)) **PK** FK  
- Price extremes (4 columns)  
- `TOTAL_MARKET_CAP_OF_THIS_CURRENCY` (DECIMAL(38,10))  
- `DOMINANCE` (FLOAT) CHECK(<=100)  
- Transaction/user metrics (3 columns)  
**Normalization:** 3NF  
**Cardinality:** N:1 with CRYPTO  
**Real-Time Usage:** Market share analysis

## 10. COUNTRY
**Description:** National crypto regulations  
**Attributes:**  
- `COUNTRY_CODE` (VARCHAR(50)) **PK**  
- `COUNTRY_NAME` (VARCHAR(200))  
- `CRYPTO_STATUS` (VARCHAR(20)) CHECK  
- Socioeconomic metrics (3 columns)  
**Normalization:** 3NF  
**Cardinality:** 1:N with 3 related tables  
**Real-Time Usage:** Regulatory compliance mapping

## 11. ACCEPTED_COUNTRY
**Description:** Crypto-friendly nations  
**Attributes:**  
- `COUNTRY_CODE` (VARCHAR(50)) **PK** FK  
- `RESTRICTIONS` (VARCHAR(200))  
- `CRYPTO_ATMS` (INT) NOT NULL  
- `ACCEPTED_YEAR` (INT)  
**Normalization:** 3NF  
**Cardinality:** 1:1 with COUNTRY  
**Real-Time Usage:** ATM deployment planning

## 12. BANNED_COUNTRY
**Description:** Crypto-restricted nations  
**Attributes:**  
- `COUNTRY_CODE` (VARCHAR(50)) **PK** FK  
- `RESTRICTIONS` (VARCHAR(200))  
- `CRYPTO_ATMS` (INT) NOT NULL  
- `BANNED_YEAR` (INT)  
**Normalization:** 3NF  
**Cardinality:** 1:1 with COUNTRY  
**Real-Time Usage:** Regulatory risk assessment

## 13. USER_AMOUNT_IN_BANNED_COUNTRY
**Description:** Illicit usage tracking  
**Attributes:**  
- `YEAR` (INT) **PK**  
- `COUNTRY_CODE` (VARCHAR(50)) **PK** FK  
- `USER_AMOUNT` (DECIMAL(38,20))  
**Normalization:** 3NF  
**Cardinality:** N:1 with COUNTRY  
**Real-Time Usage:** Compliance monitoring

## 14. ACCEPTED_COUNTRYWISE_MOST_USED_CRYPTO
**Description:** Regional crypto popularity  
**Attributes:**  
- `YEAR` (INT) **PK**  
- `COUNTRY_CODE` (VARCHAR(50)) **PK** FK  
- `CRYPTO_SYMBOL` (VARCHAR(10)) **PK** FK  
- `USER_PERCENTAGE` (DECIMAL(10,5)) CHECK(<=100)  
**Normalization:** 3NF  
**Cardinality:** N:1 with COUNTRY/CRYPTO  
**Real-Time Usage:** Regional marketing strategies

## 15. BLOCK_REWARD_EMISSION_TYPE
**Description:** Reward distribution models  
**Attributes:**  
- `TYPE` (VARCHAR(50)) **PK**  
**Normalization:** 3NF  
**Cardinality:** 1:N with REWARD_DETAILS  
**Real-Time Usage:** Supply schedule analysis

## 16. REWARD_DETAILS
**Description:** Mining reward specifics  
**Attributes:**  
- `SYMBOL` (VARCHAR(10)) **PK** FK  
- `EMISSION_TYPE` (VARCHAR(50)) FK  
- Emission metrics (4 columns)  
**Normalization:** 3NF  
**Cardinality:** 1:1 with CRYPTO  
**Real-Time Usage:** Miner incentive tracking

## 17. BLOCK_REWARD_EMISSION
**Description:** Historical reward changes  
**Attributes:**  
- `SYMBOL` (VARCHAR(10)) **PK** FK  
- `YEAR` (INT) **PK**  
- `DATE` (DATE)  
- Market/hash metrics (4 columns)  
**Normalization:** 3NF  
**Cardinality:** N:1 with CRYPTO  
**Real-Time Usage:** Halving event analysis

## 18. HFT_AMF_FIRMS
**Description:** Trading firms data  
**Attributes:**  
- `COMPANY_NAME` (VARCHAR(200)) **PK**  
- `HEAD_QUARTER` (VARCHAR(200))  
- `ESTABLISHED_YEAR` (INT)  
- `WORK_TYPE` (VARCHAR(500))  
- `FAMOUS_FOR` (VARCHAR(500))  
**Normalization:** 3NF  
**Cardinality:** 1:N with CRYPTO_ETF  
**Real-Time Usage:** Market influence tracking

## 19. ETF_INVESTMENT_TYPE
**Description:** ETF classification  
**Attributes:**  
- `TYPE` (VARCHAR(200)) **PK**  
- `DESCRIPTION` (TEXT)  
**Normalization:** 3NF  
**Cardinality:** 1:N with CRYPTO_ETF  
**Real-Time Usage:** ETF risk categorization

## 20. CRYPTO_ETF
**Description:** ETF details  
**Attributes:**  
- `ETF_NAME` (VARCHAR(300))  
- `ETF_CODE` (VARCHAR(200)) **PK**  
- `COMPANY_NAME` (VARCHAR(200)) FK  
- `LAUNCH_DATE` (DATE)  
- `YEAR` (INT)  
- `TOTAL_AUM_UNDER_ETF` (DECIMAL(38,20))  
- `CRYPTO_SYMBOL` (VARCHAR(10)) **PK** FK  
- `ETF_INVESTMENT_TYPE` (VARCHAR(200)) FK  
- `EXPENSE_RATIO` (DECIMAL(10,5)) CHECK(<100)  
**Normalization:** 3NF  
**Cardinality:** N:1 with 3 related tables  
**Real-Time Usage:** ETF performance comparison

## 21. BROKERAGE
**Description:** Exchange platforms  
**Attributes:**  
- `NAME` (VARCHAR(200)) **PK**  
- `HEADQUARTER` (VARCHAR(200))  
- `ESTABLISHED_YEAR` (INT)  
- `OWN_CRYPTO_CURRENCY` (VARCHAR(10))  
- `FOUNDER_NAME` (VARCHAR(200))  
**Normalization:** 3NF  
**Cardinality:** 1:N with 2 related tables  
**Real-Time Usage:** Exchange reliability assessment

## 22. TOP_BROKERAGE
**Description:** Leading exchanges  
**Attributes:**  
- `YEAR` (INT) **PK**  
- `BROKERAGE_NAME` (VARCHAR(200)) **PK** FK  
- Market metrics (3 columns)  
**Normalization:** 3NF  
**Cardinality:** N:1 with BROKERAGE  
**Real-Time Usage:** Market leadership tracking

## 23. CONTROVERSY
**Description:** Brokerage incidents  
**Attributes:**  
- `YEAR` (INT)  
- `BROKERAGE_NAME` (VARCHAR(200)) FK  
- `CONTROVERSY_DETAIL` (VARCHAR(400))  
- `AFFECTED_CRYPTO` (VARCHAR(10)) FK  
- `AFFECTED_AMOUNT_IN_BILLION` (DECIMAL(38,10))  
**Normalization:** 2NF (Recommended PK: YEAR+BROKERAGE_NAME)  
**Cardinality:** N:1 with BROKERAGE  
**Real-Time Usage:** Risk management database
## 3. CONSENSUS_ALGORITHM_TYPE
**Description:** Stores consensus mechanisms (PoW/PoS)  
**Attributes:**  
- `TYPE` (VARCHAR(200) **PK** NOT NULL  
- `DESCRIPTION` (TEXT) NOT NULL  
**Normalization:** 3NF  
**Cardinality:**  
- 1:N with CRYPTO  
- 1:N with HASH_ALGO_NAME  
**Real-Time Usage:** Energy efficiency analysis

## 4. BLOCKCHAIN_NETWORK_TYPE
**Description:** Network types (mainnet/testnet)  
**Attributes:**  
- `TYPE` (VARCHAR(200) **PK** NOT NULL  
- `DESCRIPTION` (TEXT) NOT NULL  
- `EXAMPLES` (TEXT) NOT NULL  
- `KEY_FEATURES` (TEXT) NOT NULL  
**Normalization:** 3NF  
**Cardinality:** 1:N with CRYPTO  
**Real-Time Usage:** Network capability comparison

## 5. HASH_ALGO_NAME
**Description:** Hash algorithms and hardware specs  
**Attributes:**  
- `NAME` (VARCHAR(200) **PK** NOT NULL  
- `CONSENSUS_ALGORITHM_TYPE` (VARCHAR(200) **PK** NOT NULL  
- `DESCRIPTION` (VARCHAR(MAX) NOT NULL  
- `HARDWARE_TYPE` (VARCHAR(200) NOT NULL  
- `PROS` (VARCHAR(MAX) NOT NULL  
- `CONS` (VARCHAR(MAX) NOT NULL  
- `ENERGY_EFFICIENCY` (VARCHAR(10) CHECK('HIGH','LOW','MODERATE')  
**Normalization:** 3NF  
**Cardinality:** N:1 with CONSENSUS_ALGORITHM_TYPE  
**Real-Time Usage:** Mining hardware optimization

## 6. CRYPTO
**Description:** Core cryptocurrency details  
**Attributes:**  
- `NAME` (VARCHAR(200)) NOT NULL  
- `SYMBOL` (VARCHAR(10)) **PK** NOT NULL  
- `MAX_PRICE` (DECIMAL(38,15)) NOT NULL  
- `MIN_PRICE` (DECIMAL(38,15)) NOT NULL  
- `MAX_PRICE_DATE` (DATE)  
- `MIN_PRICE_DATE` (DATE)  
- `TOTAL_SUPPLY` (DECIMAL(38,15)) NOT NULL  
- `CIRCULATING_SUPPLY` (DECIMAL(38,15)) NOT NULL  
- `BLOCKCHAIN_ACCESS_TYPE` (VARCHAR(200)) FK NOT NULL  
- `CONSENSUS_ALGORITHM_TYPE` (VARCHAR(200)) FK NOT NULL  
- `BLOCKCHAIN_NETWORK_TYPE` (VARCHAR(200)) FK NOT NULL  
- `BLOCKCHAIN_TOKEN_TYPE` (VARCHAR(200)) FK NOT NULL  
- `HASH_ALGO_NAME` (VARCHAR(200)) FK  
- `HASH_ALGO_CONSENSUS_TYPE` (VARCHAR(200)) FK  
- `FOUNDER` (VARCHAR(200)) NOT NULL  
- `INITIAL_RELEASE_YEAR` (INT) NOT NULL  
- `OFFICIAL_WEBSITE` (VARCHAR(100)) NOT NULL  
- `DESCRIPTION_FOR_MAJOR_CHANGES` (VARCHAR(MAX)) NOT NULL  
**Normalization:** 3NF  
**Cardinality:**  
- 1:N with 7 related tables  
- N:1 with 4 lookup tables  
**Real-Time Usage:** Central reference for all crypto analysis

## 7. CRYPTO_CURRENCY_PERFORMANCE_METRICS
**Description:** Performance and energy metrics  
**Attributes:**  
- `SYMBOL` (VARCHAR(10)) **PK** FK  
- `TRANSACTION_PER_SECOND` (DECIMAL(38,15))  
- `AVERAGE_TRX_FEE` (DECIMAL(38,15))  
- `ELECTRICITY_COST_PER_BLOCK` (DECIMAL(38,15))  
- `HEAT_IMMERSION_PER_TX` (DECIMAL(38,2))  
- `HASH_RATE_PER_UNIT` (VARCHAR(50))  
- `TOTAL_USERS` (DECIMAL(38,0))  
**Normalization:** 3NF  
**Cardinality:** 1:1 with CRYPTO  
**Real-Time Usage:** Environmental impact assessment

## 8. TOTAL_USER_DISTRIBUTION
**Description:** Global user distribution by region  
**Attributes:**  
- `YEAR` (INT) **PK**  
- Regional user counts (7 columns)  
- `TOTAL_USER_IN_WORD` (DECIMAL(38,15))  
- `TOTAL_MARKET_CAP` (DECIMAL(38,15))  
**Normalization:** 2NF  
**Cardinality:** 1:N with MARKET_DOMINANCE  
**Real-Time Usage:** Regional adoption tracking

## 9. MARKET_DOMINANCE
**Description:** Annual market share tracking  
**Attributes:**  
- `YEAR` (INT) **PK**  
- `SYMBOL` (VARCHAR(10)) **PK** FK  
- Price extremes (4 columns)  
- `TOTAL_MARKET_CAP_OF_THIS_CURRENCY` (DECIMAL(38,10))  
- `DOMINANCE` (FLOAT) CHECK(<=100)  
- Transaction/user metrics (3 columns)  
**Normalization:** 3NF  
**Cardinality:** N:1 with CRYPTO  
**Real-Time Usage:** Market share analysis

## 10. COUNTRY
**Description:** National crypto regulations  
**Attributes:**  
- `COUNTRY_CODE` (VARCHAR(50)) **PK**  
- `COUNTRY_NAME` (VARCHAR(200))  
- `CRYPTO_STATUS` (VARCHAR(20)) CHECK  
- Socioeconomic metrics (3 columns)  
**Normalization:** 3NF  
**Cardinality:** 1:N with 3 related tables  
**Real-Time Usage:** Regulatory compliance mapping

## 11. ACCEPTED_COUNTRY
**Description:** Crypto-friendly nations  
**Attributes:**  
- `COUNTRY_CODE` (VARCHAR(50)) **PK** FK  
- `RESTRICTIONS` (VARCHAR(200))  
- `CRYPTO_ATMS` (INT) NOT NULL  
- `ACCEPTED_YEAR` (INT)  
**Normalization:** 3NF  
**Cardinality:** 1:1 with COUNTRY  
**Real-Time Usage:** ATM deployment planning

## 12. BANNED_COUNTRY
**Description:** Crypto-restricted nations  
**Attributes:**  
- `COUNTRY_CODE` (VARCHAR(50)) **PK** FK  
- `RESTRICTIONS` (VARCHAR(200))  
- `CRYPTO_ATMS` (INT) NOT NULL  
- `BANNED_YEAR` (INT)  
**Normalization:** 3NF  
**Cardinality:** 1:1 with COUNTRY  
**Real-Time Usage:** Regulatory risk assessment

## 13. USER_AMOUNT_IN_BANNED_COUNTRY
**Description:** Illicit usage tracking  
**Attributes:**  
- `YEAR` (INT) **PK**  
- `COUNTRY_CODE` (VARCHAR(50)) **PK** FK  
- `USER_AMOUNT` (DECIMAL(38,20))  
**Normalization:** 3NF  
**Cardinality:** N:1 with COUNTRY  
**Real-Time Usage:** Compliance monitoring

## 14. ACCEPTED_COUNTRYWISE_MOST_USED_CRYPTO
**Description:** Regional crypto popularity  
**Attributes:**  
- `YEAR` (INT) **PK**  
- `COUNTRY_CODE` (VARCHAR(50)) **PK** FK  
- `CRYPTO_SYMBOL` (VARCHAR(10)) **PK** FK  
- `USER_PERCENTAGE` (DECIMAL(10,5)) CHECK(<=100)  
**Normalization:** 3NF  
**Cardinality:** N:1 with COUNTRY/CRYPTO  
**Real-Time Usage:** Regional marketing strategies

## 15. BLOCK_REWARD_EMISSION_TYPE
**Description:** Reward distribution models  
**Attributes:**  
- `TYPE` (VARCHAR(50)) **PK**  
**Normalization:** 3NF  
**Cardinality:** 1:N with REWARD_DETAILS  
**Real-Time Usage:** Supply schedule analysis

## 16. REWARD_DETAILS
**Description:** Mining reward specifics  
**Attributes:**  
- `SYMBOL` (VARCHAR(10)) **PK** FK  
- `EMISSION_TYPE` (VARCHAR(50)) FK  
- Emission metrics (4 columns)  
**Normalization:** 3NF  
**Cardinality:** 1:1 with CRYPTO  
**Real-Time Usage:** Miner incentive tracking

## 17. BLOCK_REWARD_EMISSION
**Description:** Historical reward changes  
**Attributes:**  
- `SYMBOL` (VARCHAR(10)) **PK** FK  
- `YEAR` (INT) **PK**  
- `DATE` (DATE)  
- Market/hash metrics (4 columns)  
**Normalization:** 3NF  
**Cardinality:** N:1 with CRYPTO  
**Real-Time Usage:** Halving event analysis

## 18. HFT_AMF_FIRMS
**Description:** Trading firms data  
**Attributes:**  
- `COMPANY_NAME` (VARCHAR(200)) **PK**  
- `HEAD_QUARTER` (VARCHAR(200))  
- `ESTABLISHED_YEAR` (INT)  
- `WORK_TYPE` (VARCHAR(500))  
- `FAMOUS_FOR` (VARCHAR(500))  
**Normalization:** 3NF  
**Cardinality:** 1:N with CRYPTO_ETF  
**Real-Time Usage:** Market influence tracking

## 19. ETF_INVESTMENT_TYPE
**Description:** ETF classification  
**Attributes:**  
- `TYPE` (VARCHAR(200)) **PK**  
- `DESCRIPTION` (TEXT)  
**Normalization:** 3NF  
**Cardinality:** 1:N with CRYPTO_ETF  
**Real-Time Usage:** ETF risk categorization

## 20. CRYPTO_ETF
**Description:** ETF details  
**Attributes:**  
- `ETF_NAME` (VARCHAR(300))  
- `ETF_CODE` (VARCHAR(200)) **PK**  
- `COMPANY_NAME` (VARCHAR(200)) FK  
- `LAUNCH_DATE` (DATE)  
- `YEAR` (INT)  
- `TOTAL_AUM_UNDER_ETF` (DECIMAL(38,20))  
- `CRYPTO_SYMBOL` (VARCHAR(10)) **PK** FK  
- `ETF_INVESTMENT_TYPE` (VARCHAR(200)) FK  
- `EXPENSE_RATIO` (DECIMAL(10,5)) CHECK(<100)  
**Normalization:** 3NF  
**Cardinality:** N:1 with 3 related tables  
**Real-Time Usage:** ETF performance comparison

## 21. BROKERAGE
**Description:** Exchange platforms  
**Attributes:**  
- `NAME` (VARCHAR(200)) **PK**  
- `HEADQUARTER` (VARCHAR(200))  
- `ESTABLISHED_YEAR` (INT)  
- `OWN_CRYPTO_CURRENCY` (VARCHAR(10))  
- `FOUNDER_NAME` (VARCHAR(200))  
**Normalization:** 3NF  
**Cardinality:** 1:N with 2 related tables  
**Real-Time Usage:** Exchange reliability assessment

## 22. TOP_BROKERAGE
**Description:** Leading exchanges  
**Attributes:**  
- `YEAR` (INT) **PK**  
- `BROKERAGE_NAME` (VARCHAR(200)) **PK** FK  
- Market metrics (3 columns)  
**Normalization:** 3NF  
**Cardinality:** N:1 with BROKERAGE  
**Real-Time Usage:** Market leadership tracking

## 23. CONTROVERSY
**Description:** Brokerage incidents  
**Attributes:**  
- `YEAR` (INT)  
- `BROKERAGE_NAME` (VARCHAR(200)) FK  
- `CONTROVERSY_DETAIL` (VARCHAR(400))  
- `AFFECTED_CRYPTO` (VARCHAR(10)) FK  
- `AFFECTED_AMOUNT_IN_BILLION` (DECIMAL(38,10))  
**Normalization:** 2NF (Recommended PK: YEAR+BROKERAGE_NAME)  
**Cardinality:** N:1 with BROKERAGE  
**Real-Time Usage:** Risk management database

## ⚠️ Caution
> **Note:**  
> The data used in this project was collected from various public sources for educational and analytical purposes only.  
> It may not be 100% accurate, up-to-date, or suitable for financial decision-making.  
> Please verify information independently before using it in real-world applications.
> **We are not responsible or liable for any financial loss, damages, or consequences** arising from the use of this data, including but not limited to scams, misinterpretations, or inappropriate real-world applications.
> Users are strongly advised to independently verify any information before relying on it for financial, commercial, or personal decision-making.


## Schema Diagram:
<img src="CRYPTO_MARKET_ANALYSIS_PROJECT_DATABASE8.png">

## Sample Query:

<ol>

<li>

```sql
# Sort top 10 Cryptocurrency by ascending order depend on max price
select *
from AllCrypto order by max_price asc limit 10;
```



</li>

<li>

```sql
# # Sort top 10 Cryptocurrency by ascending order depend on max price except the 3 lowest max price
select * from AllCrypto order by max_price asc limit 10 offset 2;
```
</li>

<li>

```sql
# Query for only PoS currencies
select * from AllCrypto where consensus_algorithm='PoS'
```

</li>

<li>

```sql
# Market Growth And User Growth Of Every Year From 2009 To 2025

select T2.year,
       concat(T2.total_user,' million') as total_user,
       concat((((T2.total_user-T1.total_user)*100)/T1.total_user),'%') as user_growth,
       concat(T2.total_market_cap,' billion') as market_cap,
       concat((((T2.total_market_cap-T1.total_market_cap)*100)/T1.total_user),'%') as market_growth
from TotalUserDistribution as T1 join TotalUserDistribution as T2
where timediff(T2.year,T1.year)=1;
;
```

</li>

<li>

```sql
# query for only these currency which consensus algo is 'PoS'
select MarketDominance.year,MarketDominance.symbol,concat(MarketDominance.total_value,' billion'),concat(MarketDominance.dominance,'%') from MarketDominance join AllCrypto  where MarketDominance.symbol=AllCrypto.symbol
and AllCrypto.consensus_algorithm='PoS';
```

</li>


<li>

```sql
# query for only these currency which consensus algo is 'Layer-1'
select MarketDominance.year,MarketDominance.symbol,concat(MarketDominance.total_value,' billion'),concat(MarketDominance.dominance,'%') from MarketDominance join AllCrypto  where MarketDominance.symbol=AllCrypto.symbol
and AllCrypto.blockchain_network_type='Layer-1';
```

</li>

<li>

```sql

# which country has highest atm booth for 'AuxPoW' consensus algorithm.
select AcceptedCountry.country_name from AcceptedCountry join AllCrypto where AcceptedCountry.symbol=AllCrypto.symbol and AllCrypto.consensus_algorithm='AuxPoW';
```

</li>

<li>

```sql
# market growth of PoS (Ethereum), PoS from 2015 to 2016
with  tmp as (select MarketDominance.year,MarketDominance.symbol,MarketDominance.total_value
              ,MarketDominance.dominance
              from MarketDominance join AllCrypto where AllCrypto.consensus_algorithm like '%PoS%' and AllCrypto.symbol=MarketDominance.symbol)
select tmp1.year,tmp1.symbol,concat(((tmp1.total_value-tmp2.total_value)*100/tmp2.total_value),'%') as market_growth,concat(tmp1.dominance,'%') as market_dominance from tmp as tmp1 join tmp as tmp2 where  timediff(tmp1.year,tmp2.year)=1 and tmp1.year>=2015 and tmp1.year<=2016
and tmp2.year>=2015 and tmp2.year<=2016 order by tmp1.dominance desc ;
```


<img src="./SS/C4.png">
</li>

<li>

```sql
# controversies occur due to hacked
select * from Controversy where controversy_detail like '%hack%';
```

<img src="./SS/c5.png">

</li>



<li>

```sql
# query for those company who have not launch etf yet 

with tmp as (select * from HedgeFundHFTAFM as giant left join EFTAsTransactionByAMF EATBA on giant.company_name = EATBA.etf_company)
select tmp.company_name,tmp.country_name,tmp.company_type from tmp where tmp.etf_name is null;
```

<img src="./SS/C6.png">

</li>


<li>

```sql
# query for those broker who has no controversies

with tmp as (select * from Brokerage as br left join Controversy C on br.name = C.brokerage_name)
select tmp.name from tmp where tmp.affected_crypto is null;
```

<img src="./SS/C7.png">
</li>


<li>


```sql
# if a broker get 1 reward for 1 controversy which broker got 1s place
with tmp as (select brokerage_name,count(brokerage_name) as reward from Controversy group by brokerage_name)
select * from tmp order by reward desc limit 1;
```

<img src="./SS/c8.png">
</li>

<li>

```sql
# QUERY FOR THIS BROKERAGE WHOSE HEADQUARTER IN THIS KIND OF COUNTRY WHERE CRYPTO IS ACCEPTED
SELECT BROKERAGE.NAME,BROKERAGE.HEADQUARTER,COUNTRY.CRYPTO_STATUS FROM BROKERAGE JOIN COUNTRY WHERE COUNTRY.CRYPTO_STATUS='ACCEPTED' AND BROKERAGE.HEADQUARTER LIKE
                                                                                                     CONCAT('%',COUNTRY.COUNTRY_NAME,'%');
```

```
Output:
AvaTrade,"Dublin, Ireland",ACCEPTED
Binance,"George Town, Cayman Islands",ACCEPTED
Bitfinex,Hong Kong,ACCEPTED
Bitget,"Victoria, Seychelles",ACCEPTED
Bitstamp,"Luxembourg City, Luxembourg",ACCEPTED
Capital.com,"Limassol, Cyprus",ACCEPTED
Crypto.com,Singapore,ACCEPTED
eToro,"Tel Aviv, Israel",ACCEPTED
FTX,"Nassau, Bahamas",ACCEPTED
Gate.io,"George Town, Cayman Islands",ACCEPTED
KuCoin,"Victoria, Seychelles",ACCEPTED
Mt. Gox,"Shibuya, Tokyo, Japan",ACCEPTED
NiceHash,"Ljubljana, Slovenia",ACCEPTED
OKX,"Victoria, Seychelles",ACCEPTED

```       
</li>

<ol>


## Relationship:

>> BLOCKCHAIN_ACCESS_TYPE	CRYPTO	1:N

>> BLOCKCHAIN_TOKEN_TYPE	CRYPTO	1:N

>> CONSENSUS_ALGORITHM_TYPE	CRYPTO	1:N

>> BLOCKCHAIN_NETWORK_TYPE	CRYPTO	1:N

>> HASH_ALGO_NAME	CRYPTO	1:N

>> CRYPTO	CRYPTO_CURRENCY_PERFORMANCE_METRICS	1:1

>> TOTAL_USER_DISTRIBUTION	MARKET_DOMINANCE	1:N

>> CRYPTO	MARKET_DOMINANCE	1:N



```
Many-to-One:
CRYPTO → BLOCKCHAIN_ACCESS_TYPE

CRYPTO → BLOCKCHAIN_TOKEN_TYPE

CRYPTO → CONSENSUS_ALGORITHM_TYPE

CRYPTO → BLOCKCHAIN_NETWORK_TYPE

CRYPTO → HASH_ALGO_NAME (assuming NAME is unique)

HASH_ALGO_NAME → CONSENSUS_ALGORITHM_TYPE

MARKET_DOMINANCE → CRYPTO

MARKET_DOMINANCE → TOTAL_USER_DISTRIBUTION

USER_AMOUNT_IN_BANNED_COUNTRY → COUNTRY

ACCEPTED_COUNTRYWISE_MOST_USED_CRYPTO → COUNTRY

ACCEPTED_COUNTRYWISE_MOST_USED_CRYPTO → CRYPTO

REWARD_DETAILS → BLOCK_REWARD_EMISSION_TYPE

BLOCK_REWARD_EMISSION → CRYPTO

CRYPTO_ETF → HFT_AMF_FIRMS

CRYPTO_ETF → CRYPTO

CRYPTO_ETF → ETF_INVESTMENT_TYPE

TOP_BROKERAGE → BROKERAGE

TOP_BROKERAGE → TOTAL_USER_DISTRIBUTION

CONTROVERSY → BROKERAGE

CONTROVERSY → CRYPTO

BROKERAGE → CRYPTO (if FK were active)

One-to-One:
CRYPTO → CRYPTO_CURRENCY_PERFORMANCE_METRICS

CRYPTO → REWARD_DETAILS

COUNTRY → ACCEPTED_COUNTRY

COUNTRY → BANNED_COUNTRY

```

