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
  symbol varchar(10),
  total_value float,
  check ( total_value<=100 ),
  constraint MarketDominance_fk foreign key (symbol) references AllCrypto(symbol),
  constraint MarketDominance_pk primary key (symbol)
);

select *
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



