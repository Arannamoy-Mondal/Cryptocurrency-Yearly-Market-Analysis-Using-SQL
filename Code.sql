create database CryptoDemo;
use CryptoDemo;

-- Blockchain type table start

create table BlockChain_type(
  type varchar(200),
  constraint BlockChain_type_pk primary key (type)
);



insert into BlockChain_type (type) values ('Public'),
                                          ('Private'),
                                          ('Hybrid'),
                                          ('Consortium');


-- Blockchain type table end


-- Consensus_algorithm_type table start

create table Consensus_algorithm_type(
    type varchar(200),
    constraint Consensus_type_pk primary key (type)
);

insert into Consensus_algorithm_type (type) values ('PoW'),('PoS'),('PoC'),('PoB');
insert into Consensus_algorithm_type (type) values ('PoH');
insert into Consensus_algorithm_type (type) values ('PoH+PoS+BFT');


# Consensus_algorithm_type table end


# BlockChainNetwork_type table start
create table BlockChainNetwork_type(
    type varchar(200),
    constraint BlockChainNetwork_type_pk primary key (type)
);

insert into BlockChainNetwork_type (type) values ('Layer-1'),('Layer-2'),('Layer-3');

# BlockChainNetwork_type table end


# AllCrypto table start

create table AllCrypto(
  crypto_id int auto_increment,
  name varchar(100) not null,
  symbol varchar(10) not null unique ,
  max_price decimal(65,10) not null, -- max limit  decimal(30,30)
  min_price decimal(65,10) not null,
  max_total_market_cap decimal(50,10) not null,
  min_total_market_cap decimal(50,10) not null ,
  total_supply decimal(30,30) not null,
  circulating_supply decimal(30,30) not null ,
  blockchain_type varchar(200) not null ,
  consensus_algorithm varchar(200) not null ,
  blockchain_network_type varchar(200) not null ,
  founded year not null ,
  added_time_in_db timestamp not null,
  constraint AllCrypto_pk primary key (crypto_id),
  constraint AllCrypto_blockchain_type_fk foreign key (blockchain_type) references BlockChain_type(type) on delete CASCADE ,
  constraint AllCrypto_consensus_type_fk foreign key (consensus_algorithm) references Consensus_algorithm_type(type) on delete CASCADE ,
  constraint AllCrypto_blockchain_network_type_fk foreign key (blockchain_network_type) references BlockChainNetwork_type(type) on delete CASCADE
);



alter table AllCrypto modify column max_total_market_cap varchar(200) not null; -- only for mysql
alter table AllCrypto modify column min_total_market_cap varchar(200) not null; -- only for mysql
# alter table AllCrypto add column symbol varchar(10) not null unique;
alter table AllCrypto modify column total_supply varchar(200) not null;
alter table AllCrypto modify column circulating_supply varchar(200) not null ;
alter table AllCrypto modify column max_price float;
alter table AllCrypto modify column min_price float;
alter table AllCrypto add column current_market_cap float not null ;

alter table AllCrypto drop column current_market_cap;
# AllCrypto table start

select * from AllCrypto;

insert into AllCrypto (name, max_price, min_price,
                       max_total_market_cap, min_total_market_cap, total_supply,
                       circulating_supply, blockchain_type, consensus_algorithm,
                       blockchain_network_type, founded, added_time_in_db,symbol)
values ('Bitcoin',108000,0.05816,'$1.3T','$0.5M',
       '21 M','19.5 M','Public','PoW','Layer-1',2008,
       curdate(),'BTC');


insert into AllCrypto (name, symbol, max_price, min_price, max_total_market_cap, min_total_market_cap, total_supply,
                       circulating_supply, blockchain_type, consensus_algorithm, blockchain_network_type, founded,
                       added_time_in_db) values
 ('Ethereum',
  'ETH',4864.11,
  0.43,
  '$525B (Nov 10, 2021)','$1.5B (Oct 29, 2015)',
  'Infinity','120M','Public','PoS',
  'Layer-1',2015,curdate());



create table CurrentMarketCap(
  symbol varchar(10),
  total_value float,
  constraint CurrrentMarketCap_fk foreign key (symbol) references AllCrypto(symbol),
  constraint CurrrentMarketCap_PK primary key (symbol)
);


alter table CurrentMarketCap rename CurrentMarketCapOfCrypto;
drop table CurrentMarketCapOfCrypto;

create table MarketDominance(
  year year,
  symbol varchar(10),
  total_value float,
  dominance decimal(30,5),
  check ( dominance<=100 ),
  constraint MarketDominance_fk foreign key (symbol) references AllCrypto(symbol),
  constraint MarketDominance_pk primary key (symbol,year),
  constraint MarketDominance_year_fk foreign key (year) references TotalUserDistribution(year)
);


# insert into MarketDominance (year, symbol, total_value,dominance)
# values (2009,'BTC',0.00001,100),
#        (2013,'BTC',1.2,80),
#        (2013,'LTC',0.15,10),
#        (2013,'XRP',0.05,3.3),
#        (2017,'BTC',320,53),
#        (2017,'ETH',70,11.7);

select year,symbol,concat(total_value,' billion') as market_cap,concat(dominance,' %') as market_dominance
from MarketDominance;





drop table MarketDominance;

create table AcceptedCountry(
  country_id int auto_increment,
  symbol varchar(10),
  country_name varchar(200),
  restrictions varchar(200),
  crypto_atms int not null,
  constraint AcceptedCountry_fk foreign key (symbol) references AllCrypto(symbol),
  constraint AcceptedCountry_pk primary key (country_id)
);

insert into AcceptedCountry (symbol, country_name, restrictions, crypto_atms)
values ('BTC','United States','Legal (regulated as property/commodity)',27000),
('ETH','United States','Legal (regulated as property/commodity)',27000),
('LTC','United States','Legal (regulated as property/commodity)',27000),
('BCH','United States','Legal (regulated as property/commodity)',27000),
('XLM','United States','Legal (regulated as property/commodity)',27000),
('USDT','United States','Legal (regulated as property/commodity)',27000),
('DOGE','United States','Legal (regulated as property/commodity)',27000),
('BTC','Canada','Legal (regulated under securities laws)',2500),
('ETH','Canada','Legal (regulated under securities laws)',2500),
('LTC','Canada','Legal (regulated under securities laws)',2500),
('BTC','El Salvador','Bitcoin is legal tender (since 2021)',200),
('BTC','Germany','Legal (Legal (tax-free after 1-year holding))',500),
('ETH','Germany','Legal (Legal (tax-free after 1-year holding))',500)
;

select *
from AcceptedCountry;

drop table AcceptedCountry;



create table TotalUserDistribution(
    year year,
    asia_user decimal(30,5),
    north_america_user decimal(30,5),
    america_user decimal(30,5), -- Nort America + South America
    africa_user decimal(30,5),
    europe_user decimal(30,5),
    oceania_user decimal(30,5),
    total_user_in_word decimal(30,5),
    total_market_cap decimal(30,5),
    constraint TotalUserDistribution_pk_rule primary key (year)
);


alter table TotalUserDistribution change total_user_in_word total_user decimal(30,5);

INSERT INTO TotalUserDistribution (year, asia_user, north_america_user, america_user, africa_user, europe_user, oceania_user, total_user,total_market_cap) VALUES
(2009, 0.001, 0.002, 0.003, 0.0001, 0.001, 0.0001, 0.004,0.00001),
(2010, 0.005, 0.005, 0.010, 0.0005, 0.003, 0.0005, 0.020,0.0003),
(2011, 0.020, 0.010, 0.030, 0.001, 0.010, 0.001, 0.070,0.04),
(2012, 0.050, 0.030, 0.080, 0.002, 0.020, 0.002, 0.150,0.13),
(2013, 0.200, 0.100, 0.300, 0.010, 0.080, 0.010, 0.500,1.5),
(2014, 0.500, 0.300, 0.800, 0.020, 0.200, 0.020, 1.500,5),
(2015, 1.000, 0.500, 1.500, 0.050, 0.400, 0.050, 3.000,7),
(2016, 3.000, 1.500, 4.500, 0.100, 2.500, 0.100, 8.000,17),
(2017, 10.000, 5.000, 15.000, 0.500, 5.000, 0.300, 30.500,600),
(2018, 15.000, 8.000, 23.000, 1.000, 7.000, 0.500, 50.000,120),
(2019, 25.000, 12.000, 37.000, 2.000, 10.000, 0.800, 80.000,250),
(2020, 50.000, 20.000, 70.000, 5.000, 15.000, 1.000, 150.000,1000),
(2021, 100.000, 30.000, 130.000, 10.000, 20.000, 1.500, 300.000,2900),
(2022, 150.000, 40.000, 180.000, 20.000, 25.000, 2.000, 420.000,1000),
(2023, 200.000, 50.000, 230.000, 30.000, 28.000, 3.000, 580.000,1750),
(2024, 263.000, 57.000, 186.600, 38.000, 31.000, 5.000, 833.700,3800),
(2025, 265.100, 65.700, 186.600, 53.900, 35.000, 5.000, 926.750,2970);




# INSERT INTO TotalUserDistribution (year, total_user_in_word, total_user)
# VALUES
#     (2008, '1 Thousand', 1000),
#     (2009, '10 Thousand', 10000),
#     (2010, '100 Thousand', 100000),
#     (2011, '500 Thousand', 500000),
#     (2012, '1 Million', 1000000),
#     (2013, '3 Million', 3000000),
#     (2014, '5 Million', 5000000),
#     (2015, '10 Million', 10000000),
#     (2016, '20 Million', 20000000),
#     (2017, '30 Million', 30000000),
#     (2018, '35 Million', 35000000),
#     (2019, '45 Million', 45000000),
#     (2020, '101 Million', 101000000),
#     (2021, '295 Million', 295000000),
#     (2022, '425 Million', 425000000),
#     (2023, '580 Million', 580000000),
#     (2024, '620 Million', 620000000),
#     (2025, '660 Million', 660000000);

# drop table TotalUserDistribution;


select year,
       concat(total_market_cap,' billion'),
       concat(asia_user,' million'),
       concat(north_america_user,' million'),
       concat(america_user-north_america_user,' million') as south_america_user,
       concat(america_user,' million'),
       concat(africa_user,' million'),
       concat(europe_user,' million'),
       concat(oceania_user,' million'),
       concat(TotalUserDistribution.total_user,' million')
from TotalUserDistribution;

select T2.year,
       concat(T2.total_user,' million') as total_user,
       concat((((T2.total_user-T1.total_user)*100)/T1.total_user),'%') as user_growth,
       concat(T2.total_market_cap,' billion') as market_cap,
       concat((((T2.total_market_cap-T1.total_market_cap)*100)/T1.total_user),'%') as market_growth
from TotalUserDistribution as T1 join TotalUserDistribution as T2
where timediff(T2.year,T1.year)=1;
;


create table HedgeFundHFTAFM( # table for corporate organization who used cryto as a alternative asset
#   id int auto_increment,
    company_name varchar(200) not null ,
    country_name varchar(200) not null ,
    company_type enum('High-Frequency Trading (HFT) Firms','Asset Management Firms','Crypto Funds'),
    total_managed_asset varchar(200) not null ,
    constraint HedgeFundHFTAFM_pk primary key (company_name)
);

drop table HedgeFundHFTAFM;

insert into HedgeFundHFTAFM(company_name, country_name,company_type,total_managed_asset)
values ('BlackRock Inc',' United States','Asset Management Firms','Over $10 trillion AUM as of 2025')
,('Vanguard Group',' United States','Asset Management Firms','$9.3 trillion AUM as of 2025'),
 ('Fidelity Investments',' United States','Asset Management Firms','$4.5 trillion AUM as of 2025'),
('Grayscale Investments',' United States','Crypto Funds','$17.5 billion AUM in crypto funds (Grayscale Bitcoin Trust) as of 2024'),
 ('Hudson River Trading',' United States','High-Frequency Trading (HFT) Firms','5% of U.S. stock market volume'),
 ('Citadel Securities',' United States','High-Frequency Trading (HFT) Firms','25% of U.S. equity volume'),
 ('Polychain Capital','United States','Crypto Funds','$3 billion AUM in crypto funds'),
 ('Pantera Capital','United States','Crypto Funds','$3.5 billion AUM in crypto funds'),
 ('Alameda Research','Hong Kong','Crypto Funds', '$14.6 billion as of mid-2022');

select * from HedgeFundHFTAFM;

 create table EFTAsTransactionByAMF(
    id int auto_increment,
    etf_company varchar(200) not null,
    etf_crpto_symbol varchar(10) not null,
    etf_total_cap varchar(200),
    etf_name varchar(500),
    constraint  EFTAsTransactionByAMF_pk primary key (id),
    constraint EFTAsTransactionByAMF_crypto_fk foreign key (etf_crpto_symbol) references AllCrypto(symbol),
    constraint EFTAsTransactionByAMF_company_fk foreign key (etf_company) references HedgeFundHFTAFM(company_name)
);

select * from EFTAsTransactionByAMF;

insert into EFTAsTransactionByAMF (etf_company, etf_crpto_symbol, etf_total_cap, etf_name) values
('BlackRock Inc','BTC','$47.97 billion','iShares Bitcoin Trust ETF (IBIT)'),
('Vanguard Group','');

drop table EFTAsTransactionByAMF;

# delete
# from AllCrypto
# where symbol='ETH';


insert into Consensus_algorithm_type (type) values

('PoSA'),
('PoH+PoS'),
('Ripple Protocol'),
('Ouroboros PoS'),
('AuxPoW'),
('Snowman PoS'),
('PoS (Oracle)'),
('Governance'),
('Tendermint BFT'),
('RandomX PoW'),
('Pure PoS'),
('SCP'),
('PoRep/PoSt'),
('DPoS'),
('Nightshade PoS'),
('Liquid PoS'),
('Threshold Relay'),
('Hashgraph aBFT'),
('Lachesis aBFT'),
('PoS (ETH)'),
('N/A'),
('NPoS'),
('PoA');


insert into BlockChainNetwork_type (type) values ('Layer-1 (ETH)'),('Multi-Chain');
select * from BlockChainNetwork_type;

select *
from AllCrypto;

INSERT INTO AllCrypto (
  name, symbol, max_price, min_price, max_total_market_cap, min_total_market_cap,
  total_supply, circulating_supply, blockchain_type, consensus_algorithm,
  blockchain_network_type, founded, added_time_in_db
) VALUES
-- 1-10: Major Layer-1 Blockchains
('Bitcoin', 'BTC', 69000.00, 0.06, '$1.3T (Nov 10, 2021)', '$0.5M (Jul 18, 2010)', '21M', '19.5M', 'Public', 'PoW', 'Layer-1', 2009, CURDATE()),
('Ethereum', 'ETH', 4864.11, 0.43, '$525B (Nov 10, 2021)', '$1.5B (Oct 29, 2015)', 'Infinity', '120M', 'Public', 'PoS', 'Layer-1', 2015, CURDATE()),
('Binance Coin', 'BNB', 690.00, 0.10, '$120B (May 10, 2021)', '$3M (Jul 25, 2017)', '200M', '157M', 'Public', 'PoSA', 'Layer-1', 2017, CURDATE()),
('Solana', 'SOL', 260.00, 0.50, '$80B (Nov 6, 2021)', '$20M (Mar 16, 2020)', '511M', '400M', 'Public', 'PoH+PoS', 'Layer-1', 2020, CURDATE()),
('XRP', 'XRP', 3.84, 0.002, '$150B (Jan 4, 2018)', '$1.3M (Aug 1, 2013)', '100B', '54B', 'Public', 'Ripple Protocol', 'Layer-1', 2013, CURDATE()),
('Cardano', 'ADA', 3.10, 0.017, '$94B (Sep 2, 2021)', '$6M (Oct 1, 2017)', '45B', '35B', 'Public', 'Ouroboros PoS', 'Layer-1', 2017, CURDATE()),
('Dogecoin', 'DOGE', 0.74, 0.00008, '$88B (May 8, 2021)', '$3M (Dec 6, 2013)', 'Infinity', '142B', 'Public', 'AuxPoW', 'Layer-1', 2013, CURDATE()),
('Avalanche', 'AVAX', 146.00, 2.80, '$50B (Nov 21, 2021)', '$40M (Sep 21, 2020)', '720M', '400M', 'Public', 'Snowman PoS', 'Layer-1', 2020, CURDATE()),
('Polkadot', 'DOT', 55.00, 2.70, '$54B (Nov 4, 2021)', '$300M (May 26, 2020)', '1.2B', '1.1B', 'Public', 'NPoS', 'Layer-1', 2020, CURDATE()),
('Polygon', 'MATIC', 2.92, 0.003, '$20B (Dec 27, 2021)', '$1M (Oct 30, 2017)', '10B', '9.3B', 'Public', 'PoS', 'Layer-2', 2017, CURDATE()),

-- 11-20: Additional Top Cryptos
('Litecoin', 'LTC', 412.00, 1.11, '$25B (May 10, 2021)', '$5M (Oct 13, 2011)', '84M', '73M', 'Public', 'PoW', 'Layer-1', 2011, CURDATE()),
('Chainlink', 'LINK', 52.70, 0.11, '$22B (May 10, 2021)', '$3M (Sep 19, 2017)', '1B', '550M', 'Hybrid', 'PoS (Oracle)', 'Layer-1', 2017, CURDATE()),
('Uniswap', 'UNI', 44.97, 0.48, '$22B (May 3, 2021)', '$50M (Sep 16, 2020)', '1B', '760M', 'Public', 'Governance', 'Layer-1 (ETH)', 2020, CURDATE()),
('Bitcoin Cash', 'BCH', 4355.00, 75.00, '$70B (Dec 20, 2017)', '$1B (Aug 1, 2017)', '21M', '19.4M', 'Public', 'PoW', 'Layer-1', 2017, CURDATE()),
('Cosmos', 'ATOM', 44.70, 1.13, '$9B (Sep 20, 2021)', '$100M (Mar 14, 2019)', 'Infinite', '350M', 'Public', 'Tendermint BFT', 'Layer-1', 2019, CURDATE()),
('Monero', 'XMR', 542.00, 0.21, '$5B (May 7, 2021)', '$1.8M (May 21, 2014)', '18.4M', '18.2M', 'Public', 'RandomX PoW', 'Layer-1', 2014, CURDATE()),
('Algorand', 'ALGO', 3.56, 0.10, '$10B (Jun 20, 2019)', '$200M (Jun 20, 2019)', '10B', '7.5B', 'Public', 'Pure PoS', 'Layer-1', 2019, CURDATE()),
('Stellar', 'XLM', 0.93, 0.002, '$25B (Jan 3, 2018)', '$1M (Aug 1, 2014)', '50B', '28B', 'Public', 'SCP', 'Layer-1', 2014, CURDATE()),
('VeChain', 'VET', 0.28, 0.001, '$4B (Apr 15, 2021)', '$10M (Aug 18, 2017)', '86.7B', '72.5B', 'Public', 'PoA', 'Layer-1', 2017, CURDATE()),
('Filecoin', 'FIL', 236.00, 1.83, '$12B (Apr 1, 2021)', '$400M (Oct 15, 2020)', '2B', '400M', 'Public', 'PoRep/PoSt', 'Layer-1', 2020, CURDATE()),

-- 21-30: Emerging & Niche Projects
('TRON', 'TRX', 0.30, 0.001, '$16B (Jan 5, 2018)', '$70M (Sep 13, 2017)', '100B', '92B', 'Public', 'DPoS', 'Layer-1', 2017, CURDATE()),
('Ethereum Classic', 'ETC', 176.00, 0.50, '$21B (Jul 20, 2018)', '$140M (Jul 24, 2016)', '210.7M', '140M', 'Public', 'PoW', 'Layer-1', 2016, CURDATE()),
('NEAR Protocol', 'NEAR', 20.44, 0.53, '$12B (Jan 16, 2022)', '$850M (Oct 13, 2020)', '1B', '850M', 'Public', 'Nightshade PoS', 'Layer-1', 2020, CURDATE()),
('Tezos', 'XTZ', 9.12, 0.31, '$7B (Oct 4, 2021)', '$950M (Jul 1, 2018)', 'Infinite', '950M', 'Public', 'Liquid PoS', 'Layer-1', 2018, CURDATE()),
('Internet Computer', 'ICP', 700.00, 3.09, '$45B (May 10, 2021)', '$450M (May 10, 2021)', '469M', '450M', 'Public', 'Threshold Relay', 'Layer-1', 2021, CURDATE()),
('Hedera', 'HBAR', 0.57, 0.009, '$6B (Sep 15, 2021)', '$33M (Sep 16, 2019)', '50B', '33B', 'Public', 'Hashgraph aBFT', 'Layer-1', 2019, CURDATE()),
('Fantom', 'FTM', 3.48, 0.001, '$4B (Oct 28, 2021)', '$2.8B (Dec 27, 2019)', '3.175B', '2.8B', 'Public', 'Lachesis aBFT', 'Layer-1', 2019, CURDATE()),
('The Sandbox', 'SAND', 8.44, 0.028, '$6B (Nov 25, 2021)', '$2.3B (Aug 14, 2020)', '3B', '2.3B', 'Public', 'PoS (ETH)', 'Layer-2', 2020, CURDATE()),
('Decentraland', 'MANA', 5.90, 0.007, '$4B (Nov 25, 2021)', '$1.9B (Sep 20, 2017)', '2.2B', '1.9B', 'Public', 'PoS (ETH)', 'Layer-2', 2017, CURDATE()),
('Axie Infinity', 'AXS', 165.00, 0.12, '$10B (Nov 6, 2021)', '$120M (Nov 6, 2020)', '270M', '120M', 'Public', 'PoS (ETH)', 'Layer-2', 2020, CURDATE()),

-- 31-40: Stablecoins & Meme Coins
('Tether', 'USDT', 1.00, 0.96, '$83B (Feb 10, 2023)', '$1M (Feb 25, 2015)', 'Infinite', '83B', 'Hybrid', 'N/A', 'Multi-Chain', 2014, CURDATE()),
('USD Coin', 'USDC', 1.00, 0.97, '$56B (Jun 15, 2022)', '$25M (Sep 26, 2018)', 'Infinite', '56B', 'Hybrid', 'N/A', 'Multi-Chain', 2018, CURDATE()),
('Shiba Inu', 'SHIB', 0.000088, 0.000000000056, '$41B (Oct 28, 2021)', '$3M (Aug 1, 2020)', '1Q', '549T', 'Public', 'PoS (ETH)', 'Layer-1 (ETH)', 2020, CURDATE()),
('Dai', 'DAI', 1.01, 0.95, '$10B (Dec 18, 2021)', '$1M (Dec 18, 2017)', 'Infinite', '10B', 'Public', 'PoS (ETH)', 'Layer-2', 2017, CURDATE()),
('Cronos', 'CRO', 0.97, 0.03, '$6B (Nov 25, 2021)', '$300M (Dec 8, 2018)', '30B', '25B', 'Public', 'PoS', 'Layer-1', 2018, CURDATE()),
('Kusama', 'KSM', 623.00, 0.88, '$6B (May 15, 2021)', '$300M (Oct 1, 2019)', '10M', '8.5M', 'Public', 'NPoS', 'Layer-1', 2019, CURDATE()),
('Zcash', 'ZEC', 319.00, 0.88, '$3B (Oct 29, 2016)', '$1M (Oct 28, 2016)', '21M', '16M', 'Public', 'PoW', 'Layer-1', 2016, CURDATE()),
('Chiliz', 'CHZ', 0.89, 0.004, '$2B (Mar 13, 2021)', '$10M (Feb 28, 2019)', '8.88B', '6B', 'Public', 'PoA', 'Layer-1', 2019, CURDATE()),
('Helium', 'HNT', 55.22, 0.11, '$4B (Nov 12, 2021)', '$100M (Jul 30, 2019)', '223M', '160M', 'Public', 'PoC', 'Layer-1', 2019, CURDATE()),
('Theta Network', 'THETA', 15.90, 0.04, '$16B (Apr 16, 2021)', '$120M (Jan 1, 2019)', '1B', '1B', 'Public', 'PoS', 'Layer-1', 2019, CURDATE());

;

# drop table AllCrypto;

create table Brokerage(
    name varchar(200),
    hq varchar(200),
    established_year year,
    own_crypto_currency varchar(10),
    founder_name varchar(200),
    constraint Brokerage_pk primary key (name),
    constraint Brokerage_fk foreign key (own_crypto_currency) references AllCrypto(symbol) on delete cascade
);

alter table Brokerage drop constraint Brokerage_fk;

INSERT INTO Brokerage (name, hq, established_year, own_crypto_currency, founder_name) VALUES
('Coinbase', 'San Francisco, CA, USA', 2012, NULL, 'Brian Armstrong'),
('Robinhood', 'Menlo Park, CA, USA', 2013, NULL, 'Vlad Tenev, Baiju Bhatt'),
('Binance', 'George Town, Cayman Islands', 2017, 'BNB', 'Changpeng Zhao'),
('Kraken', 'San Francisco, CA, USA', 2011, NULL, 'Jesse Powell'),
('Crypto.com', 'Singapore', 2016, 'CRO', 'Kris Marszalek'),
('Bitget', 'Victoria, Seychelles', 2018, 'BGB', 'Sandra Lou'),
('BitMart', 'New York, NY, USA', 2017, 'BMX', 'Sheldon Xia'),
('Gemini', 'New York, NY, USA', 2014, NULL, 'Cameron Winklevoss, Tyler Winklevoss'),
('Bitfinex', 'Hong Kong', 2012, 'LEO', 'Giancarlo Devasini'),
('Bitstamp', 'Luxembourg City, Luxembourg', 2011, NULL, 'Nejc Kodrič, Damijan Merlak'),
('KuCoin', 'Victoria, Seychelles', 2017, 'KCS', 'Johnny Lyu'),
('OKX', 'Victoria, Seychelles', 2017, 'OKB', 'Star Xu'),
('Bybit', 'Dubai, UAE', 2018, 'BIT', 'Ben Zhou'),
('Gate.io', 'George Town, Cayman Islands', 2013, 'GT', 'Lin Han'),
('Uphold', 'New York, NY, USA', 2015, NULL, 'J.P. Thieriot'),
('eToro', 'Tel Aviv, Israel', 2007, NULL, 'Yoni Assia'),
('AvaTrade', 'Dublin, Ireland', 2006, NULL, 'Emanuel Kronitz'),
('Capital.com', 'Limassol, Cyprus', 2016, NULL, 'Viktor Prokopenya'),
('Interactive Brokers', 'Greenwich, CT, USA', 1977, NULL, 'Thomas Peterffy'),
('Tastytrade', 'Chicago, IL, USA', 2017, NULL, 'Tom Sosnoff');

insert into Brokerage (name, hq, established_year, own_crypto_currency, founder_name)
values ('Mt. Gox','Shibuya, Tokyo, Japan',2010,null,'Jed McCaleb');

INSERT INTO Brokerage (name, hq, established_year, own_crypto_currency) VALUES
('WazirX', 'Mumbai, India', 2018, 'WRX'),
('NiceHash', 'Ljubljana, Slovenia', 2014, NULL),
('FTX', 'Nassau, Bahamas', 2019, 'FTT')
;
drop table Brokerage;

# delete from Brokerage where name='Coinbase';

select * from Brokerage order by name asc;

create table Top_Brokerage(
    year year,
    brokerage_name varchar(200),
    total_market_cap decimal(30,5),
    market_share decimal(30,5),
    total_user decimal(30,5),
    constraint Top_Brokerage_pk primary key (brokerage_name,year),
    constraint Top_Brokerage_Fk foreign key (brokerage_name) references Brokerage(name) on delete cascade ,
    constraint Top_Brokerage_Fk_2 foreign key (year) references TotalUserDistribution(year) on delete cascade
);



INSERT INTO Top_Brokerage (year, brokerage_name, total_market_cap, market_share, total_user) VALUES
(2011, 'Mt. Gox', 0.00000, 70.00000, 0.01000),
(2012, 'Mt. Gox', 0.00000, 80.00000, 0.05000),
(2012, 'Bitstamp', 0.00000, 10.00000, 0.01000),
(2013, 'Mt. Gox', 0.00000, 60.00000, 0.10000),
(2013, 'Bitstamp', 0.00000, 15.00000, 0.02000),
(2013, 'Coinbase', 0.00000, 5.00000, 0.10000),
(2014, 'Bitstamp', 0.00000, 20.00000, 0.20000),
(2014, 'Coinbase', 0.00000, 10.00000, 0.50000),
(2014, 'Kraken', 0.00000, 5.00000, 0.10000),
(2014, 'Bitfinex', 0.00000, 5.00000, 0.05000),
(2015, 'Coinbase', 0.40000, 15.00000, 1.00000),
(2015, 'Bitstamp', 0.00000, 10.00000, 0.30000),
(2015, 'Kraken', 0.00000, 5.00000, 0.20000),
(2015, 'Bitfinex', 0.00000, 5.00000, 0.10000),
(2016, 'Coinbase', 1.00000, 20.00000, 2.00000),
(2016, 'Bitfinex', 0.00000, 15.00000, 0.50000),
(2016, 'Kraken', 0.00000, 5.00000, 0.30000),
(2016, 'Bitstamp', 0.00000, 5.00000, 0.20000),
(2017, 'Coinbase', 1.60000, 25.00000, 10.00000),
(2017, 'Binance', 0.00000, 20.00000, 5.00000),
(2017, 'Bitfinex', 0.00000, 10.00000, 1.00000),
(2017, 'Kraken', 0.00000, 5.00000, 0.50000),
(2017, 'Bitstamp', 0.00000, 5.00000, 0.30000),
(2018, 'Coinbase', 8.00000, 20.00000, 13.00000),
(2018, 'Binance', 0.00000, 30.00000, 10.00000),
(2018, 'Robinhood', 7.00000, 5.00000, 15.00000),
(2018, 'Kraken', 0.00000, 5.00000, 1.00000),
(2018, 'Bitfinex', 0.00000, 5.00000, 0.50000),
(2019, 'Coinbase', 8.00000, 20.00000, 15.00000),
(2019, 'Binance', 0.00000, 35.00000, 15.00000),
(2019, 'Robinhood', 8.00000, 5.00000, 18.00000),
(2019, 'Kraken', 0.00000, 5.00000, 2.00000),
(2019, 'Gemini', 0.00000, 3.00000, 0.50000),
(2020, 'Coinbase', 8.00000, 20.00000, 35.00000),
(2020, 'Binance', 0.00000, 35.00000, 20.00000),
(2020, 'Robinhood', 11.00000, 5.00000, 20.00000),
(2020, 'Kraken', 0.00000, 5.00000, 3.00000),
(2020, 'Gemini', 0.00000, 3.00000, 1.00000),
(2021, 'Coinbase', 60.00000, 15.00000, 73.00000),
(2021, 'Robinhood', 30.00000, 5.00000, 23.00000),
(2021, 'Binance', 0.00000, 34.70000, 30.00000),
(2021, 'Kraken', 0.00000, 5.00000, 6.00000),
(2021, 'Gemini', 0.00000, 3.00000, 2.00000),
(2022, 'Coinbase', 20.00000, 10.00000, 108.00000),
(2022, 'Robinhood', 10.00000, 3.00000, 24.00000),
(2022, 'Binance', 0.00000, 35.00000, 35.00000),
(2022, 'Kraken', 0.00000, 5.00000, 8.00000),
(2022, 'Crypto.com', 0.00000, 10.00000, 10.00000),
(2023, 'Coinbase', 35.00000, 10.00000, 110.00000),
(2023, 'Robinhood', 12.00000, 3.00000, 25.00000),
(2023, 'Binance', 0.00000, 34.70000, 40.00000),
(2023, 'Kraken', 0.00000, 5.00000, 9.00000),
(2023, 'Crypto.com', 0.00000, 11.20000, 12.00000),
(2024, 'Coinbase', 50.00000, 10.00000, 112.00000),
(2024, 'Robinhood', 15.00000, 3.00000, 25.60000),
(2024, 'Binance', 0.00000, 34.70000, 45.00000),
(2024, 'Crypto.com', 0.00000, 11.20000, 15.00000),
(2024, 'Kraken', 0.00000, 5.00000, 10.00000),
(2025, 'Coinbase', 71.20000, 10.00000, 115.00000),
(2025, 'Robinhood', 20.00000, 3.00000, 26.00000),
(2025, 'Binance', 0.00000, 34.70000, 50.00000),
(2025, 'Crypto.com', 0.00000, 11.20000, 15.00000),
(2025, 'Kraken', 0.00000, 5.00000, 10.00000);

# drop table Top_Brokerage;

select * from Top_Brokerage order by year asc;


create table Controversy(
    year year,
    id int auto_increment,
    brokerage_name varchar(200),
    controversy_detail varchar(400),
    affected_crypto varchar(10),
    constraint Controversy_pk primary key (id),
    constraint Controversy_fk foreign key (brokerage_name) references Brokerage(name),
    constraint Controversy_fk2 foreign key (affected_crypto) references AllCrypto(symbol)
);


INSERT INTO Controversy (year,brokerage_name,affected_crypto, controversy_detail) VALUES
(2015, 'Bitstamp','BTC' ,'Hacked, lost ~19,000 BTC ($5M). Suspended operations for days due to phishing attack targeting employees.'),
(2017, 'NiceHash','BTC' ,'Hacked, lost 4,700 BTC ($64M) from hot wallet; repaid users by 2020.'),
(2018, 'KuCoin','BTC', 'Hacked, lost $150M in crypto. Recovered most funds but raised security concerns.'),
(2021, 'Robinhood', 'DOGE','Restricted crypto/stock trades (e.g., Dogecoin, GameStop) due to clearinghouse issues, sparking manipulation claims.'),
(2022, 'Coinbase', 'ETH','Super Bowl ad QR code crashed site, overwhelming servers with traffic.'),
(2022, 'FTX', 'SOL','Collapsed after $8B fraud; Alameda misused customer funds, triggering $6B withdrawals.'),
(2023, 'Coinbase','BTC', 'SEC sued for unregistered securities exchange, targeting tokens like ADA, SOL.'),
(2023, 'Binance', 'BNB','SEC sued for unregistered exchange, offering BNB, BUSD as securities.'),
(2023, 'Kraken','BTC', 'SEC alleged unregistered exchange operations, targeting staking services.'),
(2023, 'Bybit','BTC', 'India FIU fined $1.06M for PMLA violations; Bybit paid and registered in 2025.'),
(2023, 'Bybit', 'SOL','FTX sued Bybit for $1B over prioritized withdrawals; settled for $228M in 2024.'),
(2023, 'FTX','SOL', 'SBF convicted of fraud, conspiracy; sentenced to 25 years for $8B theft.'),
(2024, 'Crypto.com','BTC', 'Sued SEC after Wells notice, challenging jurisdiction over token sales.'),
(2024, 'eToro','BTC', 'Settled with SEC, ceased most U.S. crypto trading for unregistered broker violations.'),
(2024, 'Interactive Brokers', 'BTC','$48M loss from NYSE glitch affecting trades, exposing platform vulnerabilities.'),
(2024, 'WazirX','ETH', 'Hacked, lost $234.9M to Lazarus Group via multisig wallet; halted trading.'),
(2024, 'WazirX','ETH', 'User poll for 55% fund access sparked backlash as unfair socialized loss.'),
(2025, 'Bybit','ETH', 'Hacked, lost $1.5B ETH to Lazarus Group via Safe{Wallet} flaw; reserves replenished.'),
(2025, 'Bybit','SOL', 'Airdrop delays for $PAWS, $NOT, $MAJOR tokens caused user complaints.'),
(2025, 'FTX','BTC', 'Repaid $16B to creditors using 2022 prices, angering Bitcoin/Solana holders.'),
(2025, 'WazirX','BTC', 'Regulatory scrutiny; Delhi HC sought RBI probe after $234.9M hack.'),
(2025, 'NiceHash', 'ETH','Users reported ETH transfer delays to WazirX and high BTC withdrawal fees.');

drop table Controversy;

select name,own_crypto_currency from
             Brokerage order by name asc ;


INSERT INTO MarketDominance (year, symbol, total_value, dominance) VALUES
(2009, 'BTC', 0.00001, 100.00),
(2010, 'BTC', 0.001, 100.00),
(2011, 'BTC', 0.01, 100.00),
(2012, 'BTC', 0.1, 95.00),
(2013, 'BTC', 1.2, 80.00),
(2013, 'DOGE', 0.001, 0.07),
(2014, 'BTC', 4.0, 80.00),
(2014, 'DOGE', 0.02, 0.40),
(2014, 'USDT', 0.01, 0.20),
(2014, 'XMR', 0.01, 0.20),
(2015, 'BTC', 5.0, 71.43),
(2015, 'ETH', 0.7, 10.00),
(2015, 'DOGE', 0.02, 0.29),
(2015, 'USDT', 0.02, 0.29),
(2015, 'XMR', 0.01, 0.14),
(2016, 'BTC', 12.0, 70.59),
(2016, 'ETH', 1.5, 8.82),
(2016, 'DOGE', 0.03, 0.18),
(2016, 'USDT', 0.05, 0.29),
(2016, 'XMR', 0.1, 0.59),
(2017, 'BTC', 320.0, 53.33),
(2017, 'ETH', 70.0, 11.67),
(2017, 'DOGE', 0.2, 0.03),
(2017, 'USDT', 1.0, 0.17),
(2017, 'XMR', 2.0, 0.33),
(2018, 'BTC', 70.0, 53.85),
(2018, 'ETH', 15.0, 11.54),
(2018, 'DOGE', 0.2, 0.15),
(2018, 'USDT', 2.0, 1.54),
(2018, 'XMR', 1.0, 0.77),
(2019, 'BTC', 130.0, 54.17),
(2019, 'ETH', 20.0, 8.33),
(2019, 'DOGE', 0.3, 0.13),
(2019, 'USDT', 4.0, 1.67),
(2019, 'XMR', 1.5, 0.63),
(2020, 'BTC', 500.0, 65.79),
(2020, 'ETH', 80.0, 10.53),
(2020, 'DOGE', 0.5, 0.07),
(2020, 'USDT', 15.0, 1.97),
(2020, 'XMR', 2.5, 0.33),
(2020, 'SOL', 0.1, 0.01),
(2020, 'DOT', 3.0, 0.39),
(2021, 'BTC', 1300.0, 59.09),
(2021, 'ETH', 400.0, 18.18),
(2021, 'DOGE', 50.0, 2.27),
(2021, 'USDT', 60.0, 2.73),
(2021, 'XMR', 5.0, 0.23),
(2021, 'SOL', 70.0, 3.18),
(2021, 'DOT', 30.0, 1.36),
(2022, 'BTC', 400.0, 50.00),
(2022, 'ETH', 150.0, 18.75),
(2022, 'DOGE', 10.0, 1.25),
(2022, 'USDT', 65.0, 8.13),
(2022, 'XMR', 2.0, 0.25),
(2022, 'SOL', 15.0, 1.88),
(2022, 'DOT', 5.0, 0.63),
(2023, 'BTC', 1000.0, 58.82),
(2023, 'ETH', 250.0, 14.71),
(2023, 'DOGE', 15.0, 0.88),
(2023, 'USDT', 90.0, 5.29),
(2023, 'XMR', 3.0, 0.18),
(2023, 'SOL', 50.0, 2.94),
(2023, 'DOT', 7.0, 0.41),
(2024, 'BTC', 1880.0, 63.30),
(2024, 'ETH', 217.0, 7.31),
(2024, 'DOGE', 25.0, 0.84),
(2024, 'USDT', 100.0, 3.37),
(2024, 'XMR', 4.0, 0.13),
(2024, 'SOL', 90.0, 3.03),
(2024, 'DOT', 10.0, 0.34);


# sample query
# Sort top 10 Cryptocurrency by ascending order depend on max price
select *
from AllCrypto order by max_price asc limit 10;

# # Sort top 10 Cryptocurrency by ascending order depend on max price except the 3 lowest max price
select * from AllCrypto order by max_price asc limit 10 offset 2;

# Query for only PoS currencies
select * from AllCrypto where consensus_algorithm='PoS';

# Market Growth And User Growth Of Every Year From 2009 To 2025

select T2.year,
       concat(T2.total_user,' million') as total_user,
       concat((((T2.total_user-T1.total_user)*100)/T1.total_user),'%') as user_growth,
       concat(T2.total_market_cap,' billion') as market_cap,
       concat((((T2.total_market_cap-T1.total_market_cap)*100)/T1.total_user),'%') as market_growth
from TotalUserDistribution as T1 join TotalUserDistribution as T2
where timediff(T2.year,T1.year)=1;
;


# query for only these currency which consensus algo is 'Layer-1'
select MarketDominance.year,MarketDominance.symbol,concat(MarketDominance.total_value,' billion'),concat(MarketDominance.dominance,'%') from MarketDominance join AllCrypto  where MarketDominance.symbol=AllCrypto.symbol
and AllCrypto.blockchain_network_type='Layer-1';


select *
from AllCrypto where symbol='DOGE';

