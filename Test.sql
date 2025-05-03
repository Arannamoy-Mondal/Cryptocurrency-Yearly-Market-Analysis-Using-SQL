-- Copyright 2025 Arannamoy Mondal
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
    
-- ACCEPTED COUNTRY DATA START
INSERT INTO ACCEPTED_COUNTRY (COUNTRY_CODE, RESTRICTIONS, CRYPTO_ATMS, ACCEPTED_YEAR)
VALUES
('USA',  'Legal (regulated as property/commodity, FinCEN oversight)', 27000, 2013),
('CAN',  'Legal (regulated under AML/CFT laws, taxed as capital gains)', 2500, 2014),
('SLV',  'Bitcoin is legal tender (mandatory acceptance, IMF restrictions)', 200, 2021),
('DEU',  'Legal (tax-free after 1-year holding, MiCA compliance)', 500, 2013),
('JPN',  'Legal (regulated as payment method, strict AML rules)', 1000, 2017),
('AUS',  'Legal (regulated, taxed as property, AML/CTF compliance)', 400, 2017),
('CHE',  'Legal (crypto-friendly, FINMA oversight)', 150, 2014),
('GBR',  'Legal (regulated, taxed as assets, FCA authorization)', 300, 2014),
('SGP',  'Legal (regulated under Payment Services Act)', 200, 2019),
('KOR',  'Legal (regulated, strict KYC/AML compliance)', 100, 2017),
('BTN',  'Legal (state-managed Bitcoin mining for reserves)', 0, 2020),
('CZE',  'Legal (exploring reserve, MiCA compliance)', 50, 2025);
-- ACCEPTED COUNTRY DATA END


-- BANNED COUNTRY DATA START
INSERT INTO BANNED_COUNTRY (COUNTRY_CODE, RESTRICTIONS, CRYPTO_ATMS, BANNED_YEAR)
VALUES
('CHN', 'Banned (exchanges, trading, mining; financial stability, capital flight)', 10, 2021),
('DZA',  'Banned (ownership, transactions; money laundering, terrorism financing)', 0, 2018),
('BGD',  'Banned (fines, imprisonment; financial stability, illicit activities)', 5, 2017),
('NPL',  'Banned (trading, use; fraud, financial stability)', 0, 2021),
('AFG',  'Banned (Taliban rule; financial instability, Islamic law)', 0, 2022),
('EGY',  'Banned (haram under Islamic law; money laundering, volatility)', 2, 2018),
('IRQ', 'Banned (financial crime, consumer protection; patchy enforcement)', 1, 2017),
('MAR',  'Banned (financial crime, instability; possible legalization 2025)', 3, 2017),
('QAT', 'Banned (QFCRA prohibits all crypto activities)', 0, 2018),
('TUN',  'Banned (limited data; financial stability concerns)', 0, 2018);
-- BANNED COUNTRY DATA END

-- ACCEPTED_COUNTRYWISE_MOST_USED_CRYPTO DATA END
INSERT INTO ACCEPTED_COUNTRYWISE_MOST_USED_CRYPTO (YEAR, COUNTRY_CODE, CRYPTO_SYMBOL, USER_PERCENTAGE)
VALUES
-- United States (USA): 2013-2024
(2013, 'USA', 'BTC', 95.00000), -- BTC dominates early
(2013, 'USA', 'XRP', 4.00000),
(2014, 'USA', 'BTC', 90.00000),
(2014, 'USA', 'XRP', 5.00000),
(2014, 'USA', 'USDT', 4.00000), -- USDT launched 2014
(2015, 'USA', 'BTC', 80.00000),
(2015, 'USA', 'ETH', 10.00000), -- ETH launched 2015
(2015, 'USA', 'USDT', 5.00000),
(2015, 'USA', 'XRP', 4.00000),
(2017, 'USA', 'BTC', 60.00000), -- ICO boom, altcoins grow
(2017, 'USA', 'ETH', 20.00000),
(2017, 'USA', 'USDT', 10.00000),
(2017, 'USA', 'DOGE', 3.00000), -- DOGE launched 2013, gains traction
(2017, 'USA', 'XRP', 3.00000),
(2017, 'USA', 'BNB', 2.00000), -- BNB, ADA launched 2017
(2017, 'USA', 'ADA', 2.00000),
(2020, 'USA', 'BTC', 50.00000), -- DeFi, NFTs boost altcoins
(2020, 'USA', 'ETH', 20.00000),
(2020, 'USA', 'USDT', 10.00000),
(2020, 'USA', 'DOGE', 8.00000),
(2020, 'USA', 'SOL', 3.00000), -- SOL, DOT launched 2020
(2020, 'USA', 'ADA', 2.00000),
(2020, 'USA', 'DOT', 2.00000),
(2020, 'USA', 'XRP', 2.00000),
(2020, 'USA', 'BNB', 2.00000),
(2024, 'USA', 'BTC', 50.00000), -- Matches previous 2024 estimate
(2024, 'USA', 'ETH', 20.00000),
(2024, 'USA', 'USDT', 10.00000),
(2024, 'USA', 'DOGE', 8.00000),
(2024, 'USA', 'SOL', 5.00000),
(2024, 'USA', 'ADA', 2.00000),
(2024, 'USA', 'DOT', 2.00000),
(2024, 'USA', 'XRP', 1.50000),
(2024, 'USA', 'BNB', 1.00000),
-- El Salvador (SLV): 2021-2024 (BTC legal tender)
(2021, 'SLV', 'BTC', 90.00000),
(2021, 'SLV', 'ETH', 5.00000),
(2021, 'SLV', 'USDT', 2.00000),
(2021, 'SLV', 'DOGE', 1.00000),
(2021, 'SLV', 'SOL', 0.50000),
(2021, 'SLV', 'ADA', 0.50000),
(2021, 'SLV', 'DOT', 0.50000),
(2021, 'SLV', 'XRP', 0.50000),
(2021, 'SLV', 'BNB', 0.50000),
(2024, 'SLV', 'BTC', 85.00000),
(2024, 'SLV', 'ETH', 5.00000),
(2024, 'SLV', 'USDT', 3.00000),
(2024, 'SLV', 'DOGE', 1.00000),
(2024, 'SLV', 'SOL', 1.00000),
(2024, 'SLV', 'ADA', 1.00000),
(2024, 'SLV', 'DOT', 1.00000),
(2024, 'SLV', 'XRP', 1.00000),
(2024, 'SLV', 'BNB', 1.00000),
-- Singapore (SGP): 2019-2024 (DeFi, trading hub)
(2019, 'SGP', 'BTC', 60.00000),
(2019, 'SGP', 'ETH', 20.00000),
(2019, 'SGP', 'USDT', 10.00000),
(2019, 'SGP', 'DOGE', 3.00000),
(2019, 'SGP', 'XRP', 3.00000),
(2019, 'SGP', 'BNB', 2.00000),
(2019, 'SGP', 'ADA', 2.00000),
(2020, 'SGP', 'BTC', 45.00000),
(2020, 'SGP', 'ETH', 25.00000),
(2020, 'SGP', 'USDT', 15.00000),
(2020, 'SGP', 'DOGE', 3.00000),
(2020, 'SGP', 'SOL', 3.00000),
(2020, 'SGP', 'ADA', 3.00000),
(2020, 'SGP', 'DOT', 3.00000),
(2020, 'SGP', 'XRP', 2.00000),
(2020, 'SGP', 'BNB', 2.00000),
(2024, 'SGP', 'BTC', 35.00000), -- Matches previous 2024 estimate
(2024, 'SGP', 'ETH', 25.00000),
(2024, 'SGP', 'USDT', 20.00000),
(2024, 'SGP', 'DOGE', 3.00000),
(2024, 'SGP', 'SOL', 7.00000),
(2024, 'SGP', 'ADA', 5.00000),
(2024, 'SGP', 'DOT', 5.00000),
(2024, 'SGP', 'XRP', 3.00000),
(2024, 'SGP', 'BNB', 3.00000);

-- USER_AMOUNT_IN_BANNED_COUNTRY DATA START

INSERT INTO USER_AMOUNT_IN_BANNED_COUNTRY (YEAR, COUNTRY_CODE, USER_AMOUNT) VALUES
-- China (Banned 2021)
('2008', 'CHN', 0.00100000000000000000), -- Pre-Bitcoin era
('2009', 'CHN', 0.00500000000000000000),
('2010', 'CHN', 0.02000000000000000000),
('2011', 'CHN', 0.10000000000000000000), -- Early mining adoption
('2012', 'CHN', 0.30000000000000000000),
('2013', 'CHN', 0.80000000000000000000), -- BTC price surge
('2014', 'CHN', 1.50000000000000000000),
('2015', 'CHN', 2.20000000000000000000),
('2016', 'CHN', 3.00000000000000000000), -- Mining dominance
('2017', 'CHN', 3.80000000000000000000),
('2018', 'CHN', 4.50000000000000000000), -- Pre-ban peak
('2019', 'CHN', 5.00000000000000000000),
('2020', 'CHN', 5.50000000000000000000), -- Ban announced
('2021', 'CHN', 1.20000000000000000000), -- Post-ban crash
('2022', 'CHN', 0.60000000000000000000), -- Underground mining
('2023', 'CHN', 0.30000000000000000000),
('2024', 'CHN', 0.15000000000000000000), -- Continued crackdown

-- Algeria (Banned 2018)
('2008', 'DZA', 0.00010000000000000000),
('2009', 'DZA', 0.00050000000000000000),
('2010', 'DZA', 0.00200000000000000000),
('2011', 'DZA', 0.01000000000000000000),
('2012', 'DZA', 0.03000000000000000000),
('2013', 'DZA', 0.06000000000000000000),
('2014', 'DZA', 0.10000000000000000000),
('2015', 'DZA', 0.15000000000000000000),
('2016', 'DZA', 0.20000000000000000000),
('2017', 'DZA', 0.25000000000000000000), -- Peak pre-ban
('2018', 'DZA', 0.10000000000000000000), -- Ban enforced
('2019', 'DZA', 0.05000000000000000000),
('2020', 'DZA', 0.03000000000000000000),
('2021', 'DZA', 0.02000000000000000000),
('2022', 'DZA', 0.01500000000000000000),
('2023', 'DZA', 0.01000000000000000000),
('2024', 'DZA', 0.00800000000000000000), -- Residual usage

-- Bangladesh (Banned 2017)
('2008', 'BGD', 0.00001000000000000000),
('2009', 'BGD', 0.00005000000000000000),
('2010', 'BGD', 0.00020000000000000000),
('2011', 'BGD', 0.00100000000000000000),
('2012', 'BGD', 0.00500000000000000000),
('2013', 'BGD', 0.02000000000000000000),
('2014', 'BGD', 0.08000000000000000000),
('2015', 'BGD', 0.30000000000000000000), -- Remittance use cases
('2016', 'BGD', 0.70000000000000000000),
('2017', 'BGD', 1.20000000000000000000), -- Ban year peak
('2018', 'BGD', 0.50000000000000000000), -- Post-ban drop
('2019', 'BGD', 0.30000000000000000000),
('2020', 'BGD', 0.20000000000000000000),
('2021', 'BGD', 0.15000000000000000000),
('2022', 'BGD', 0.10000000000000000000),
('2023', 'BGD', 0.08000000000000000000),
('2024', 'BGD', 0.06000000000000000000),

-- Nepal (Banned 2021)
('2008', 'NPL', 0.00000100000000000000),
-- ...
('2020', 'NPL', 0.20000000000000000000), -- Pre-ban growth
('2021', 'NPL', 0.05000000000000000000), -- Ban enforced
('2022', 'NPL', 0.03000000000000000000),
('2023', 'NPL', 0.02000000000000000000),
('2024', 'NPL', 0.01500000000000000000),

-- Egypt (Banned 2018)
('2008', 'EGY', 0.00001000000000000000),
-- ...
('2017', 'EGY', 0.60000000000000000000), -- Peak pre-ban
('2018', 'EGY', 0.25000000000000000000), -- Islamic law ban
('2019', 'EGY', 0.15000000000000000000),
('2024', 'EGY', 0.05000000000000000000),

-- Iraq (Banned 2017)
('2008', 'IRQ', 0.00000100000000000000),
-- ...
('2016', 'IRQ', 0.30000000000000000000),
('2017', 'IRQ', 0.10000000000000000000), -- Ban enforced
('2024', 'IRQ', 0.05000000000000000000),

-- Morocco (Banned 2017)
('2008', 'MAR', 0.00010000000000000000),
-- ...
('2016', 'MAR', 0.50000000000000000000),
('2017', 'MAR', 0.20000000000000000000), -- Ban enforced
('2024', 'MAR', 0.30000000000000000000), -- Anticipation of legalization

-- Qatar (Banned 2018)
('2008', 'QAT', 0.00000100000000000000),
-- ...
('2017', 'QAT', 0.08000000000000000000),
('2018', 'QAT', 0.01000000000000000000), -- Strict ban
('2024', 'QAT', 0.00200000000000000000),

-- Tunisia (Banned 2018)
('2008', 'TUN', 0.00000100000000000000),
-- ...
('2017', 'TUN', 0.10000000000000000000),
('2018', 'TUN', 0.04000000000000000000), -- Post-ban
('2024', 'TUN', 0.02000000000000000000),

-- Afghanistan (Banned 2022)
('2008', 'AFG', 0.00000010000000000000),
-- ...
('2021', 'AFG', 0.03000000000000000000), -- Pre-Taliban peak
('2022', 'AFG', 0.00500000000000000000), -- Taliban ban
('2023', 'AFG', 0.00200000000000000000),
('2024', 'AFG', 0.00100000000000000000);

-- USER_AMOUNT_IN_BANNED_COUNTRY DATA END




-- ACCEPTED_COUNTRYWISE_MOST_USED_CRYPTO DATA END    
-- Accepted Countries
INSERT INTO COUNTRY (COUNTRY_CODE, COUNTRY_NAME, CRYPTO_STATUS, EDUCATION_PERCENTAGE, UNEMPLOYMENT_RATE, GDP) VALUES
('USA', 'United States', 'ACCEPTED', 99.0, 3.63, 27720.0000000000),
('DEU', 'Germany', 'ACCEPTED', 99.0, 7.62, 4530.0000000000),
('GBR', 'United Kingdom', 'ACCEPTED', 99.0, 4.06, 3380.0000000000),
('JPN', 'Japan', 'ACCEPTED', 99.0, 2.60, 4200.0000000000),
('CAN', 'Canada', 'ACCEPTED', 99.0, 5.37, 2230.0000000000),
('CHE', 'Switzerland', 'ACCEPTED', 99.0, 4.05, 824.0000000000),
('SGP', 'Singapore', 'ACCEPTED', 97.0, 3.47, 466.0000000000),
('AUS', 'Australia', 'ACCEPTED', 99.0, 3.67, 1700.0000000000),
('KOR', 'South Korea', 'ACCEPTED', 99.0, 3.50, 1670.0000000000),
('PRT', 'Portugal', 'ACCEPTED', 95.0, 6.49, 289.0000000000),
('SLV', 'El Salvador', 'ACCEPTED', 86.0, 6.50, 32.4000000000),  -- Added missing data
('CZE', 'Czech Republic', 'ACCEPTED', 95.0, 2.20, 290.0000000000);  -- Added missing data


select count(*) from COUNTRY;
delete from BANNED_COUNTRY;
-- Restricted Countries
INSERT INTO COUNTRY (COUNTRY_CODE, COUNTRY_NAME, CRYPTO_STATUS, EDUCATION_PERCENTAGE, UNEMPLOYMENT_RATE, GDP) VALUES
('CHN', 'China', 'RESTRICTED', 96.0, 5.50, 17790.0000000000),
('NGA', 'Nigeria', 'RESTRICTED', 62.0, 9.80, 477.0000000000),
('BGD', 'Bangladesh', 'RESTRICTED', 74.0, 5.06, 460.0000000000),
('DZA', 'Algeria', 'RESTRICTED', 81.0, 11.81, 206.0000000000),
('EGY', 'Egypt', 'RESTRICTED', 71.0, 7.31, 387.0000000000),
('MAR', 'Morocco', 'RESTRICTED', 73.0, 11.50, 143.0000000000),
('BOL', 'Bolivia', 'RESTRICTED', 92.0, 4.80, 41.0000000000),
('NPL', 'Nepal', 'RESTRICTED', 67.0, 4.40, 40.0000000000),
('PAK', 'Pakistan', 'RESTRICTED', 59.0, 5.50, 341.0000000000),
('IRQ', 'Iraq', 'RESTRICTED', 50.0, 15.53, 264.0000000000),
('TUN', 'Tunisia', 'RESTRICTED', 79.0, 15.20, 46.5000000000),  -- Added missing data
('QAT', 'Qatar', 'RESTRICTED', 97.0, 0.10, 220.0000000000),    -- Added missing data
('AFG', 'Afghanistan', 'RESTRICTED', 43.0, 13.30, 14.6000000000); -- Added missing data
