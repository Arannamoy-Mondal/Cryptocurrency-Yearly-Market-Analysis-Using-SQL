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

CREATE DATABASE CRYPTO_MARKET_ANALYSIS_PROJECT_DATABASE;


USE CRYPTO_MARKET_ANALYSIS_PROJECT_DATABASE;
# DROP DATABASE CRYPTO_MARKET_ANALYSIS_PROJECT_DATABASE;

SHOW VARIABLES LIKE 'datadir';


CREATE TABLE BLOCKCHAIN_ACCESS_TYPE(
    TYPE VARCHAR(200) PRIMARY KEY NOT NULL ,
    DESCRIPTION TEXT NOT NULL
);


# TEST 1
INSERT INTO BLOCKCHAIN_ACCESS_TYPE VALUES ('PUBLIC','Open to everyone; decentralized, permissionless, and transparent.');
DELETE  FROM BLOCKCHAIN_ACCESS_TYPE;
SELECT * FROM BLOCKCHAIN_ACCESS_TYPE;
# DROP TABLE BLOCKCHAIN_ACCESS_TYPE;


CREATE TABLE BLOCKCHAIN_TOKEN_TYPE(
    TYPE VARCHAR(200) PRIMARY KEY NOT NULL ,
    DESCRIPTION TEXT NOT NULL
);

# TEST
INSERT INTO BLOCKCHAIN_TOKEN_TYPE VALUES ('Native Coin','Primary currency of a blockchain');
DELETE FROM BLOCKCHAIN_TOKEN_TYPE;
SELECT * FROM BLOCKCHAIN_TOKEN_TYPE;
# DROP TABLE BLOCKCHAIN_TOKEN_TYPE;

CREATE TABLE CONSENSUS_ALGORITHM_TYPE(
    TYPE VARCHAR(200) PRIMARY KEY NOT NULL ,
    DESCRIPTION TEXT NOT NULL
);


# DELETE FROM CONSENSUS_ALGORITHM_TYPE;
# DROP TABLE CONSENSUS_ALGORITHM_TYPE;

CREATE TABLE BLOCKCHAIN_NETWORK_TYPE(
    TYPE VARCHAR(200) PRIMARY KEY NOT NULL ,
    DESCRIPTION TEXT NOT NULL,
    EXAMPLES TEXT NOT NULL ,
    KEY_FEATURES TEXT NOT NULL
);

# INSERT INTO BLOCKCHAIN_NETWORK_TYPE VALUES ('LAYER-1','Base blockchain');
# DROP TABLE BLOCKCHAIN_NETWORK_TYPE;

CREATE TABLE HASH_ALGO_NAME(
    NAME VARCHAR(200) NOT NULL ,
    CONSENSUS_ALGORITHM_TYPE VARCHAR(200) NOT NULL ,
    DESCRIPTION TEXT NOT NULL ,
    HARDWARE_TYPE TEXT NOT NULL ,
    PROS TEXT NOT NULL ,
    CONS TEXT NOT NULL ,
    ENERGY_EFFICIENCY ENUM ('HIGH','LOW','MODERATE') NOT NULL,
    CONSTRAINT FOREIGN KEY (CONSENSUS_ALGORITHM_TYPE) REFERENCES CONSENSUS_ALGORITHM_TYPE(TYPE),
    CONSTRAINT HASH_ALGO_NAME_PK PRIMARY KEY (NAME,CONSENSUS_ALGORITHM_TYPE)
);

# DROP TABLE HASH_ALGO_NAME;
# DELETE FROM HASH_ALGO_NAME;


CREATE TABLE CRYPTO(
    NAME VARCHAR(200) NOT NULL ,
    SYMBOL VARCHAR(10),
    MAX_PRICE DECIMAL(65,15) NOT NULL ,
    MAX_PRICE_DATE DATE,
    MIN_PRICE DECIMAL(65,15) NOT NULL ,
    MIN_PRICE_DATE DATE,
    TOTAL_SUPPLY DECIMAL(65,15) NOT NULL ,

    CIRCULATING_SUPPLY DECIMAL(65,15) NOT NULL ,

    BLOCKCHAIN_ACCESS_TYPE VARCHAR(200) NOT NULL ,
#     ------------------------
    CONSENSUS_ALGORITHM_TYPE VARCHAR(200) NOT NULL ,
#     ----------------------------
    BLOCKCHAIN_NETWORK_TYPE VARCHAR(200) NOT NULL ,

    BLOCKCHAIN_TOKEN_TYPE VARCHAR(200) NOT NULL,
#    ------------------------------
    HASH_ALGO_NAME VARCHAR(200),

#   --------------------------------

    FOUNDER VARCHAR(200) NOT NULL ,
    INITIAL_RELEASE_YEAR YEAR NOT NULL,
    OFFICIAL_WEBSITE VARCHAR(100) NOT NULL ,
    DESCRIPTION_FOR_MAJOR_CHANGES_LIKE_AS_MERGE TEXT NOT NULL ,

    CONSTRAINT CRYPTO_TABLE_PK PRIMARY KEY (SYMBOL),

    CONSTRAINT CRYPTO_TABLE_FK_BLOCKCHAIN_TYPE_FK1 FOREIGN KEY (BLOCKCHAIN_ACCESS_TYPE) REFERENCES BLOCKCHAIN_ACCESS_TYPE(TYPE) ON DELETE RESTRICT,

    CONSTRAINT CRYPTO_TABLE_FK_CONSENSUS_ALGO_FK1 FOREIGN KEY (CONSENSUS_ALGORITHM_TYPE) REFERENCES CONSENSUS_ALGORITHM_TYPE(TYPE) ON DELETE RESTRICT,

    CONSTRAINT CRYPTO_TABLE_FK_BLOCKCHAIN_NETWORK_TYPE_FK1 FOREIGN KEY (BLOCKCHAIN_NETWORK_TYPE) REFERENCES BLOCKCHAIN_NETWORK_TYPE(TYPE) ON DELETE RESTRICT,

    CONSTRAINT CRYPTO_TABLE_FK_BLOCKCHAIN_TOKEN_TYPE_FK1 FOREIGN KEY (BLOCKCHAIN_TOKEN_TYPE) REFERENCES BLOCKCHAIN_TOKEN_TYPE(TYPE) ON DELETE RESTRICT,

    CONSTRAINT CRYPTO_TABLE_FK_HASH_ALGO_NAME_FK1 FOREIGN KEY (HASH_ALGO_NAME) REFERENCES HASH_ALGO_NAME(NAME) ON DELETE RESTRICT
);

ALTER TABLE CRYPTO MODIFY COLUMN TOTAL_SUPPLY DECIMAL(65,15);
# NAME, SYMBOL, CURRENT_MARKET_CAP, MAX_PRICE, MAX_PRICE_DATE, MIN_PRICE, MIN_PRICE_DATE,
#     TOTAL_SUPPLY, CIRCULATING_SUPPLY, BLOCKCHAIN_ACCESS_TYPE, CONSENSUS_ALGORITHM_TYPE,
#     BLOCKCHAIN_NETWORK_TYPE, BLOCKCHAIN_TOKEN_TYPE, HASH_ALGO_NAME,
#     FOUNDER, INITIAL_RELEASE_YEAR, OFFICIAL_WEBSITE, DESCRIPTION_FOR_MAJOR_CHANGES_LIKE_AS_MERGE
# DROP TABLE CRYPTO;

# SELECT COUNT(*) FROM CRYPTO;


CREATE TABLE CRYPTO_CURRENCY_PERFORMANCE_METRICS(
    SYMBOL VARCHAR(10),
    TRANSACTION_PER_SECOND DECIMAL(65,15),
    AVERAGE_TRX_FEE DECIMAL(65,15),
    ELECTRICITY_COST_PER_BLOCK DECIMAL(65,15), # USD PER BLOCK
    HEAT_IMMERSION_PER_TX DECIMAL(65,2), # JOULE
    HASH_RATE_PER_UNIT VARCHAR(50),
    TOTAL_USERS DECIMAL(65,0),
    CONSTRAINT CRYPTO_CURRENCY_PERFORMANCE_METRICS_PK PRIMARY KEY (SYMBOL),
    CONSTRAINT CRYPTO_CURRENCY_PERFORMANCE_METRICS_FK FOREIGN KEY (SYMBOL) REFERENCES CRYPTO(SYMBOL)
);

# DROP TABLE CRYPTO_CURRENCY_PERFORMANCE_METRICS;


CREATE TABLE TOTAL_USER_DISTRIBUTION(
    YEAR YEAR,
    ASIA_USER DECIMAL(65,15),
    NORTH_AMERICA_USER DECIMAL(65,15),
    AMERICA_USER DECIMAL(65,15), -- NORT AMERICA + SOUTH AMERICA
    AFRICA_USER DECIMAL(65,15),
    EUROPE_USER DECIMAL(65,15),
    OCEANIA_USER DECIMAL(65,15),
    TOTAL_USER_IN_WORD DECIMAL(65,15),
    TOTAL_MARKET_CAP DECIMAL(65,15),
    CONSTRAINT TOTALUSERDISTRIBUTION_PK_RULE PRIMARY KEY (YEAR)
);

# DROP TABLE TOTAL_USER_DISTRIBUTION;

CREATE TABLE MARKET_DOMINANCE(
  YEAR YEAR,
  SYMBOL VARCHAR(10),
  MAX_PRICE DECIMAL(65,15),
  MIN_PRICE DECIMAL(65,30),
  MAX_PRICE_DATE DATE,
  MIN_PRICE_DATE DATE,
  TOTAL_MARKET_CAP_OF_THIS_CURRENCY DECIMAL(65,10),
  DOMINANCE FLOAT,
  TOTAL_TRANSACTION DECIMAL(65,10), # IN MILLION
  TOTAL_USER DECIMAL(65,10), # IN MILLION
  TOTAL_WALLET_COUNT DECIMAL(65,10), # IN MILLION
  CHECK ( DOMINANCE<=100 ),
  CONSTRAINT MARKET_DOMINANCE_SYSMBOL_FK1 FOREIGN KEY (SYMBOL) REFERENCES CRYPTO(SYMBOL),
  CONSTRAINT MARKET_DOMINANCE_PK PRIMARY KEY (SYMBOL,YEAR),
  CONSTRAINT MARKETDOMINANCE_YEAR_FK1 FOREIGN KEY (YEAR) REFERENCES TOTAL_USER_DISTRIBUTION(YEAR)
);



DROP TABLE MARKET_DOMINANCE;


CREATE TABLE COUNTRY(
    COUNTRY_CODE VARCHAR(50),
    COUNTRY_NAME VARCHAR(200),
    CRYPTO_STATUS ENUM ('ACCEPTED','RESTRICTED','BANNED'),
    EDUCATION_PERCENTAGE FLOAT,
    UNEMPLOYMENT_RATE FLOAT,
    GDP DECIMAL(65,10) # IN BILLION
);
ALTER TABLE COUNTRY ADD CONSTRAINT COUNTRY_PK PRIMARY KEY (COUNTRY_CODE);

DELETE FROM COUNTRY;

CREATE TABLE ACCEPTED_COUNTRY(
  COUNTRY_CODE VARCHAR(50),
  RESTRICTIONS VARCHAR(200),
  CRYPTO_ATMS INT NOT NULL,
  ACCEPTED_YEAR YEAR,
  CONSTRAINT ACCEPTED_COUNTRY_PK PRIMARY KEY (COUNTRY_CODE),
  CONSTRAINT ACCEPTED_COUNTRY_FK FOREIGN KEY (COUNTRY_CODE) REFERENCES COUNTRY(COUNTRY_CODE)
);

# DROP TABLE ACCEPTED_COUNTRY,BANNED_COUNTRY,USER_AMOUNT_IN_BANNED_COUNTRY,ACCEPTED_COUNTRYWISE_MOST_USED_CRYPTO;

CREATE TABLE BANNED_COUNTRY(
  COUNTRY_CODE VARCHAR(50),
  RESTRICTIONS VARCHAR(200),
  CRYPTO_ATMS INT NOT NULL,
  BANNED_YEAR YEAR,
  CONSTRAINT BANNED_COUNTRY_PK PRIMARY KEY (COUNTRY_CODE),
  CONSTRAINT BANNED_COUNTRY_FK FOREIGN KEY (COUNTRY_CODE) REFERENCES COUNTRY(COUNTRY_CODE)
);

CREATE TABLE USER_AMOUNT_IN_BANNED_COUNTRY(
    YEAR YEAR,
    COUNTRY_CODE VARCHAR(50), # ACCORDING TO PASSPORT COUNTRY CODE
    USER_AMOUNT DECIMAL(65,20), # MILLION
    CONSTRAINT USER_AMOUNT_IN_BANNED_COUNTRY_PK PRIMARY KEY (YEAR,COUNTRY_CODE),
    CONSTRAINT USER_AMOUNT_IN_BANNED_COUNTRY_FK_1 FOREIGN KEY (COUNTRY_CODE) REFERENCES COUNTRY(COUNTRY_CODE)
);

# DROP TABLE USER_AMOUNT_IN_BANNED_COUNTRY;

CREATE TABLE ACCEPTED_COUNTRYWISE_MOST_USED_CRYPTO(
    YEAR YEAR,
    COUNTRY_CODE VARCHAR(50),
    CRYPTO_SYMBOL VARCHAR(10),
    USER_PERCENTAGE DECIMAL(10,5),
    CHECK ( USER_PERCENTAGE<=100 ),
    CONSTRAINT ACCEPTED_COUNTRYWISE_MOST_USED_CRYPTO_PK PRIMARY KEY (YEAR,COUNTRY_CODE,CRYPTO_SYMBOL),
    CONSTRAINT ACCEPTED_COUNTRYWISE_MOST_USED_CRYPTO_FK_1 FOREIGN KEY (COUNTRY_CODE) REFERENCES COUNTRY(COUNTRY_CODE),
    CONSTRAINT ACCEPTED_COUNTRYWISE_MOST_USED_CRYPTO_FK_2 FOREIGN KEY (CRYPTO_SYMBOL) REFERENCES CRYPTO(SYMBOL)
);

# DROP TABLE ACCEPTED_COUNTRYWISE_MOST_USED_CRYPTO;

CREATE TABLE BLOCK_REWARD_EMISSION_TYPE(
    TYPE VARCHAR(50) PRIMARY KEY
);
INSERT INTO BLOCK_REWARD_EMISSION_TYPE (TYPE) VALUES ('HALVING'),('TAIL EMISSION'),('LINEAR EMISSION');

CREATE TABLE REWARD_DETAILS(
  SYMBOL VARCHAR(10),
  EMISSION_TYPE VARCHAR(50), # HALVING, TAIL EMISSION, LINEAR EMISSION
  EMISSION_TIME DECIMAL(65,0), # HALVING HOUR, TAIL EMISSION TIME, LINEAR EMISSION TIME
  STARTING_TIME_BLOCK_REWARD DECIMAL(65,5),
  CURRENT_BLOCK_REWARD DECIMAL(65,5),
  BLOCK_REWARD_TIME DECIMAL(65,30), # MINUTE
  CONSTRAINT REWARD_TYPE_PK PRIMARY KEY(SYMBOL),
  CONSTRAINT REWARD_TYPE_FK_1 FOREIGN KEY(SYMBOL) REFERENCES CRYPTO(SYMBOL),
  CONSTRAINT REWARD_TYPE_FK_2 FOREIGN KEY (EMISSION_TYPE) REFERENCES BLOCK_REWARD_EMISSION_TYPE(TYPE)
);


CREATE TABLE BLOCK_REWARD_EMISSION( # BASICALLY WORKS ON HALVING PERIOD BLOCK TIME, HASH RATE
    SYMBOL VARCHAR(10),
    YEAR YEAR,
    DATE DATE,
    BLOCK_REWARD DECIMAL(65,10),
    HALVING_YEAR_MARKET_PRICE DECIMAL(65,20),
    HALVING_YEAR_MARKET_CAP DECIMAL(65,20), # MILLION
    NETWORK_HASH_RATE DECIMAL(65,0),# EXAHASH
    CONSTRAINT HALVING_PERIOD_PK PRIMARY KEY (SYMBOL,YEAR),
    CONSTRAINT HALVING_PERIOD_FK_1 FOREIGN KEY (SYMBOL) REFERENCES CRYPTO(SYMBOL)
);

CREATE TABLE HFT_AMF_FIRMS( # HFT FIRMS AND ASSET MANAGEMENT FINANCIAL FIRMS
    COMPANY_NAME VARCHAR(200),
    HEAD_QUARTER VARCHAR(200),
    ESTABLISHED_YEAR YEAR,
    WORK_TYPE VARCHAR(500),
    FAMOUS_FOR VARCHAR(500),
    CONSTRAINT HFT_ASM_FIRMS PRIMARY KEY (COMPANY_NAME,HEAD_QUARTER,ESTABLISHED_YEAR)
);
# DROP TABLE HFT_AMF_FIRMS;

CREATE TABLE ETF_INVESTMENT_TYPE(
    TYPE VARCHAR(200) PRIMARY KEY,
    DESCRIPTION TEXT
);
INSERT INTO ETF_INVESTMENT_TYPE (TYPE, DESCRIPTION) VALUES
('SPOT', 'An investment type where the ETF holds the underlying cryptocurrency directly, tracking the spot price of the crypto asset itself. It provides direct exposure to the asset, without any time-based contracts or derivatives.'),

('FUTURES', 'An investment type where the ETF invests in cryptocurrency futures contracts, which are agreements to buy or sell the cryptocurrency at a future date at a predetermined price. It tracks the future price of the crypto asset and may involve roll costs.'),

('SPOT (Converted)', 'An investment type where the ETF holds the underlying cryptocurrency directly, but the asset is converted to a security or trust structure (such as a trust or a fund). This provides exposure to the spot price, but typically through a structured vehicle like Grayscale Bitcoin Trust.');

# DROP TABLE ETF_INVESTMENT_TYPE;

CREATE TABLE CRYPTO_ETF(
    ETF_NAME VARCHAR(300),
    ETF_CODE VARCHAR(200),
    COMPANY_NAME VARCHAR(200),
    LAUNCH_DATE DATE,
    YEAR YEAR,
    TOTAL_AUM_UNDER_ETF DECIMAL(65,20), # IN BILLION USD
    CRYPTO_SYMBOL VARCHAR(10),
    ETF_INVESTMENT_TYPE VARCHAR(200),
    EXPENSE_RATIO DECIMAL(10,5),
    CHECK ( EXPENSE_RATIO <100),
    CONSTRAINT CRYPTO_ETF_FK_1 FOREIGN KEY (COMPANY_NAME) REFERENCES HFT_AMF_FIRMS(COMPANY_NAME),
    CONSTRAINT CRYPTO_ETF_FK_2 FOREIGN KEY (CRYPTO_SYMBOL) REFERENCES CRYPTO(SYMBOL),
    CONSTRAINT CRYPTO_ETF_PK PRIMARY KEY (ETF_CODE,CRYPTO_SYMBOL),
    CONSTRAINT CRYPTO_ETF_FK_3 FOREIGN KEY (ETF_INVESTMENT_TYPE) REFERENCES ETF_INVESTMENT_TYPE(TYPE)
);

# DROP TABLE CRYPTO_ETF;

# DROP TABLE BLOCK_REWARD_EMISSION;


CREATE TABLE BROKERAGE(
    NAME VARCHAR(200),
    HEADQUARTER VARCHAR(200),
    ESTABLISHED_YEAR YEAR,
    OWN_CRYPTO_CURRENCY VARCHAR(10),
    FOUNDER_NAME VARCHAR(200),
    CONSTRAINT BROKERAGE_PK PRIMARY KEY (NAME)
#     CONSTRAINT BROKERAGE_FK FOREIGN KEY (OWN_CRYPTO_CURRENCY) REFERENCES CRYPTO(SYMBOL) ON DELETE CASCADE
);

# ALTER TABLE BROKERAGE DROP CONSTRAINT BROKERAGE_FK;

CREATE TABLE TOP_BROKERAGE(
    YEAR YEAR,
    BROKERAGE_NAME VARCHAR(200),
    TOTAL_MARKET_CAP DECIMAL(30,5),
    MARKET_SHARE DECIMAL(30,5),
    TOTAL_USER DECIMAL(30,5),
    CONSTRAINT TOP_BROKERAGE_PK PRIMARY KEY (BROKERAGE_NAME,YEAR),
    CONSTRAINT TOP_BROKERAGE_FK FOREIGN KEY (BROKERAGE_NAME) REFERENCES BROKERAGE(NAME) ON DELETE CASCADE ,
    CONSTRAINT TOP_BROKERAGE_FK_2 FOREIGN KEY (YEAR) REFERENCES TOTAL_USER_DISTRIBUTION(YEAR) ON DELETE CASCADE
);

CREATE TABLE CONTROVERSY(
    YEAR YEAR,
    ID INT AUTO_INCREMENT,
    BROKERAGE_NAME VARCHAR(200),
    CONTROVERSY_DETAIL VARCHAR(400),
    AFFECTED_CRYPTO VARCHAR(10),
    AFFECTED_AMOUNT_IN_BILLION DECIMAL(65,10),
    CONSTRAINT CONTROVERSY_PK PRIMARY KEY (ID),
    CONSTRAINT CONTROVERSY_FK FOREIGN KEY (BROKERAGE_NAME) REFERENCES BROKERAGE(NAME),
    CONSTRAINT CONTROVERSY_FK2 FOREIGN KEY (AFFECTED_CRYPTO) REFERENCES CRYPTO(SYMBOL)
);

SELECT * FROM CRYPTO WHERE SYMBOL='btc';

SELECT * FROM BLOCK_REWARD_EMISSION;
# INSERT DATA

# BLOCKCHAIN_ACCESS_TYPE DATA

INSERT INTO BLOCKCHAIN_ACCESS_TYPE (
    TYPE,
    DESCRIPTION
) VALUES
('Public',
 'A blockchain where anyone can join, participate, and validate transactions. It is fully permissionless, meaning there are no restrictions on who can participate in the consensus process. Examples include Bitcoin and Ethereum, where anyone can become a miner or validator. Public blockchains are open for all but can face scalability and transaction speed issues.'),
('Private',
 'A blockchain where access is restricted to a specific group of participants, typically controlled by a single organization or consortium. Only authorized participants can join and validate transactions, making it more centralized and secure. Often used for enterprise solutions to handle sensitive data. Examples include Hyperledger and Corda. Private blockchains offer better control but lack the decentralization of public chains.'),
('Hybrid',
 'A blockchain that combines elements of both public and private blockchains, allowing some data to be public and other data to remain private. This allows for greater flexibility in terms of transparency and control. For example, sensitive data can be kept private while transaction validation can be made public. Hybrid blockchains offer a balance of transparency, security, and control.'),
('Consortium',
 'A blockchain where the network is governed by a group of organizations rather than a single entity. It combines aspects of both private and public blockchains, where only authorized entities can participate as validators. It’s often used in business collaborations to maintain privacy while allowing transparency among the members of the consortium. Examples include Quorum and Ripple. Consortium blockchains provide more decentralized control compared to private blockchains but are still permissioned and restricted to a group of trusted participants.');




# BLOCKCHAIN_TOKEN_TYPE DATA

INSERT INTO BLOCKCHAIN_TOKEN_TYPE (
    TYPE,
    DESCRIPTION
) VALUES
('Stablecoin', 'A cryptocurrency pegged to a stable asset, such as a fiat currency, to reduce volatility. Examples include USDT (Tether), USDC (USD Coin), and DAI.'),
('Native Coin', 'The primary cryptocurrency used within its respective blockchain network to pay for transaction fees and services. Examples include Bitcoin (BTC) for Bitcoin, Ether (ETH) for Ethereum, and XRP for Ripple (XRP Ledger).'),
('Utility Token', 'A type of token that is used within a blockchain ecosystem to access specific features or services. Examples include Binance Coin (BNB), which can be used to pay for transaction fees on Binance.'),
('Security Token', 'A token that represents an ownership stake or investment in an asset, typically regulated by government agencies. These tokens comply with securities laws. Examples include tZERO and tokenized real estate assets.'),
('Governance Token', 'A token that grants its holder the right to participate in the decision-making process of a decentralized network or project. Examples include Uniswap (UNI) and Compound (COMP).'),
('Non-Fungible Token (NFT)', 'A unique, indivisible token that represents ownership of a specific item or asset, such as digital art or collectibles. Examples include CryptoPunks, Bored Ape Yacht Club (BAYC), and Decentraland.');

INSERT INTO BLOCKCHAIN_TOKEN_TYPE (TYPE, DESCRIPTION)
VALUES ('MEME TOKEN','Meme tokens are cryptocurrencies driven by internet culture, humor, and community hype, often lacking fundamental utility. They gain traction through social media (e.g., Reddit, Twitter) and viral trends.');
# CONSENSUS_ALGORITHM_TYPE DATA
    -- Insert new consensus algorithms with descriptions
INSERT INTO CONSENSUS_ALGORITHM_TYPE (TYPE, DESCRIPTION) VALUES
('PoW', 'Proof of Work: Miners solve cryptographic puzzles to validate transactions. Used by Bitcoin (BTC), Litecoin (LTC), and Dogecoin (DOGE).'),
('PoS', 'Proof of Stake: Validators stake coins to secure the network. Used by Ethereum (ETH), Avalanche (AVAX), and Cardano (ADA) via Ouroboros.'),
('PoC', 'Proof of Capacity: Validators allocate disk space to participate. Used by Chia (XCH) and Burstcoin (BURST).'),
('PoB', 'Proof of Burn: Coins are "burned" (sent to unspendable addresses) to gain mining rights. Rarely used; seen in Slimcoin (SLM).'),
('PoH', 'Proof of History: Cryptographic clock for ordering transactions. Part of Solana’s (SOL) hybrid consensus.'),
('PoH+PoS+BFT', 'Hybrid consensus combining Proof of History, Proof of Stake, and Byzantine Fault Tolerance. Used by Solana (SOL) for scalability and security.'),
('PoSA', 'Proof of Staked Authority: Hybrid of PoS and Proof of Authority, where validators stake tokens and are pre-approved. Used by BNB Chain (BNB).'),
('PoH+PoS', 'Combination of Proof of History (timestamping) and Proof of Stake. Used by Solana (SOL) for high-speed validation.'),
('Ripple Protocol', 'Ripple Protocol Consensus Algorithm (RPCA): Trusted validators iteratively agree on transactions. Used by XRP Ledger (XRP).'),
('Ouroboros PoS', 'Peer-reviewed PoS protocol with epochs and stake pools. Used by Cardano (ADA).'),
('AuxPoW', 'Auxiliary Proof of Work: Allows merging mining with a parent chain (e.g., Dogecoin (DOGE) mining with Bitcoin).'),
('Snowman PoS', 'Avalanche Consensus variant optimized for linear blockchains. Used by Avalanche (AVAX) C-Chain.'),
('PoS (Oracle)', 'Proof of Stake with oracle governance. Used by Chainlink (LINK) for decentralized oracle consensus.'),
('Governance', 'On-chain governance for protocol upgrades (not strictly consensus). Used by MakerDAO (MKR) and others.'),
('Tendermint BFT', 'Byzantine Fault Tolerant consensus with instant finality. Used by Cosmos (ATOM) and Terra Classic (LUNC).'),
('RandomX PoW', 'ASIC-resistant Proof of Work algorithm. Used by Monero (XMR).'),
('Pure PoS', 'Permissionless PoS with cryptographic randomness. Used by Algorand (ALGO).'),
('SCP', 'Stellar Consensus Protocol: Federated Byzantine Agreement. Used by Stellar (XLM).'),
('PoRep/PoSt', 'Proof of Replication/Proof of Spacetime: Storage validation, not blockchain consensus. Used by Filecoin (FIL).'),
('DPoS', 'Delegated Proof of Stake: Token holders elect block producers. Used by TRON (TRX) and EOS (EOS).'),
('Nightshade PoS', 'Sharded PoS consensus for parallel transaction processing. Used by NEAR Protocol (NEAR).'),
('Liquid PoS', 'Liquid staking with delegated validation. Used by Liquidchain (XLC) and derivatives.'),
('Threshold Relay', 'Random leader election via verifiable delay functions. Used by Internet Computer (ICP).'),
('Hashgraph aBFT', 'Asynchronous Byzantine Fault Tolerant gossip protocol. Used by Hedera (HBAR).'),
('Lachesis aBFT', 'DAG-based aBFT consensus for Fantom (FTM).'),
('PoS (ETH)', 'Ethereum’s Proof of Stake (Gasper consensus). Used by Ethereum (ETH) post-Merge.'),
('N/A', 'No consensus mechanism (e.g., stablecoins, wrapped tokens, or non-blockchain systems).'),
('NPoS', 'Nominated Proof of Stake: Token holders nominate validators. Used by Polkadot (DOT).'),
('PoA', 'Proof of Authority: Pre-approved validators with identity stakes. Used by VeChain (VET).');


# BLOCKCHAIN_NETWORK_TYPE
    INSERT INTO BLOCKCHAIN_NETWORK_TYPE (TYPE, DESCRIPTION, EXAMPLES, KEY_FEATURES) VALUES
('Layer-0',
 'Protocols enabling cross-chain interoperability and multi-chain infrastructure.',
 'Cosmos (ATOM), Polkadot (DOT), Avalanche Subnets',
 'Inter-blockchain Communication (IBC), shared security, parachains.'),

('Layer-1',
 'Base blockchain networks with native consensus and security.',
 'Bitcoin (BTC), Ethereum (ETH), Solana (SOL), Cardano (ADA)',
 'Proof of Work (PoW), Proof of Stake (PoS), smart contracts.'),

('Layer-2',
 'Scalability solutions built atop Layer-1 blockchains.',
 'Optimism (OP), Arbitrum (ARB), Polygon zkEVM, Lightning Network (Bitcoin)',
 'Rollups (ZK/Optimistic), state channels, inherits L1 security.'),

('Sidechain',
 'Independent blockchains connected to a Layer-1 via two-way bridges.',
 'Polygon PoS, Gnosis Chain (xDAI), Ronin (AXS)',
 'Custom consensus (e.g., PoA), faster transactions, separate security model.'),

('Appchain',
 'Application-specific blockchains tailored for a single dApp.',
 'dYdX Chain (Cosmos), Injective (INJ), Osmosis (OSMO)',
 'High customization, dedicated throughput, often built on Layer-0.'),

('Hybrid Network',
 'Combines features of multiple layers or consensus models.',
 'Polygon (PoS + zkEVM), Avalanche (L1 + Subnets)',
 'Balances decentralization, scalability, and flexibility.'),

('Modular Blockchain',
 'Separates execution, consensus, and data availability layers.',
 'Celestia (TIA), EigenLayer, Fuel Network',
 'Specialized layers (e.g., rollup-focused data availability).'),

('Private/Permissioned',
 'Restricted access networks for enterprise use cases.',
 'Hyperledger Fabric, R3 Corda, Quorum',
 'Centralized governance, high throughput, privacy features.');



# HASH_ALGO_NAME TABLE DATA
INSERT INTO HASH_ALGO_NAME (NAME, CONSENSUS_ALGORITHM_TYPE, DESCRIPTION, HARDWARE_TYPE, PROS, CONS, ENERGY_EFFICIENCY) VALUES
('SHA-256', 'PoW', 'Secure Hash Algorithm 256-bit, developed by the NSA, produces a 256-bit hash. Used for Bitcoin mining and transaction verification, ensuring data integrity through deterministic output.', 'ASIC, GPU', 'High security, widely adopted, resistant to collisions, standardized by NIST.', 'High computational power required, ASIC dominance centralizes mining, vulnerable to length extension attacks.', 'LOW'),
('Scrypt', 'PoW', 'A memory-intensive hash function designed to reduce ASIC advantage, used for mining Litecoin and Dogecoin. Produces a hash through iterative computations.', 'ASIC, GPU, CPU', 'Memory-hard, reduces ASIC dominance, supports CPU/GPU mining, faster than SHA-256.', 'Still vulnerable to ASIC mining, less secure than SHA-256 against certain attacks.', 'MODERATE'),
('X11', 'PoW', 'A chained hashing algorithm using 11 different hash functions, developed for Dash. Energy-efficient and designed to deter ASIC development.', 'GPU, CPU', '30% less power than Scrypt, runs cooler, complex design resists ASICs, high security.', 'Limited adoption, complex implementation, some ASIC development possible.', 'MODERATE'),
('Ethash', 'PoW', 'Memory-hard algorithm used by Ethereum Classic, designed to be ASIC-resistant and GPU-friendly. Relies on a large DAG (Directed Acyclic Graph) for mining.', 'GPU', 'ASIC-resistant, supports GPU mining, high memory requirements enhance security.', 'High memory usage, complex setup, Ethereum’s move to PoS reduced adoption.', 'LOW'),
('Equihash', 'PoW', 'A memory-hard algorithm based on the Birthday Problem, used by Zcash. Designed to favor CPU/GPU mining and resist ASICs.', 'GPU, CPU', 'ASIC-resistant, supports standard hardware, high security for privacy coins.', 'Memory-intensive, limited adoption, some ASIC development occurred.', 'MODERATE'),
('CryptoNight', 'PoW', 'A memory-hard algorithm designed for CPU mining, used by Monero in early versions. Aims to democratize mining by favoring standard PCs.', 'CPU, GPU', 'CPU-friendly, promotes decentralization, resistant to ASICs.', 'Slower performance, limited scalability, Monero moved to RandomX.', 'HIGH'),
('Keccak-256', 'PoW', 'A cryptographic hash function from the SHA-3 family, used by Ethereum for transaction hashing. Produces a 256-bit hash with high security.', 'GPU, CPU', 'High security, collision-resistant, versatile for non-mining uses.', 'Not optimized for mining, limited PoW use post-Ethereum Merge.', 'MODERATE'),
('X15', 'PoW', 'A chained algorithm using 15 hash functions, designed for energy efficiency and resistance to cryptographic attacks. Used by smaller coins like BitSend.', 'GPU, CPU', 'Enhanced security through multiple hashes, energy-efficient, resists specialized hardware.', 'Very limited adoption, complex implementation.', 'MODERATE'),
('Blake2', 'PoW', 'A cryptographic hash function faster than MD5 and SHA-1, used by some smaller PoW coins. Optimized for speed and security.', 'GPU, CPU', 'High speed, secure, immune to length extension attacks.', 'Less tested in large-scale PoW, limited cryptocurrency use.', 'HIGH'),
('Lyra2RE', 'PoW', 'A memory-hard algorithm used by Vertcoin, designed to be ASIC-resistant and support GPU mining.', 'GPU', 'ASIC-resistant, supports decentralized mining, energy-efficient.', 'Limited adoption, less secure than SHA-256 for large networks.', 'MODERATE'),
('Groestl', 'PoW', 'A cryptographic hash function from the SHA-3 competition, used by Groestlcoin. Focuses on security and efficiency.', 'GPU, CPU', 'High security, efficient on standard hardware, ASIC-resistant.', 'Limited adoption, less community support.', 'MODERATE'),
('Quark', 'PoW', 'A lightweight algorithm using multiple hash functions, designed for CPU mining and energy efficiency. Used by QuarkChain.', 'CPU', 'Energy-efficient, CPU-friendly, promotes decentralization.', 'Low adoption, less secure for high-value networks.', 'HIGH'),
('SHA-1', 'PoW', 'A 160-bit hash function, predecessor to SHA-2, used by some early or niche PoW coins. Less secure but computationally lighter.', 'GPU, CPU', 'Lightweight, fast computation, suitable for low-power devices.', 'Significant cryptographic weaknesses, not secure for modern use.', 'HIGH'),
('MD5', 'PoW', 'A 128-bit hash function used by some obscure PoW coins. Fast but cryptographically broken.', 'GPU, CPU', 'Very fast, low resource usage.', 'Highly vulnerable to collisions, unsuitable for secure applications.', 'HIGH'),
('RIPEMD-160', 'PoW', 'A 160-bit hash function from the RIPEMD family, used in some hybrid PoW/PoS coins. Balances security and efficiency.', 'GPU, CPU', 'Secure for smaller networks, efficient on standard hardware.', 'Less secure than SHA-256, limited adoption.', 'MODERATE');

INSERT INTO HASH_ALGO_NAME (NAME, CONSENSUS_ALGORITHM_TYPE, DESCRIPTION, HARDWARE_TYPE, PROS, CONS, ENERGY_EFFICIENCY) VALUES
('RandomX', 'PoW', 'A Proof-of-Work algorithm designed for Monero, optimized for general-purpose CPUs and GPUs. Uses random code execution and memory-hard techniques via a virtual machine, producing a 256-bit hash with Blake2b. Aims to resist ASICs and promote decentralized mining.', 'CPU, GPU', 'ASIC-resistant, efficient on consumer hardware, promotes decentralization, audited for security.', 'Complex implementation, requires 64-bit CPU and large cache, slower in light mode for verification.', 'HIGH'),
('SHA-256', 'PoS', 'Secure Hash Algorithm 256-bit, used in Solana’s Proof of History for sequential hashing to timestamp transactions. Generates a 256-bit hash, ensuring data integrity and order in a high-throughput PoS blockchain.', 'CPU', 'High security, widely adopted, efficient for non-mining tasks, supports Solana’s 50,000 TPS.', 'Not ASIC-resistant in PoW contexts, limited to timestamping in PoS, computationally intensive for sequential tasks.', 'MODERATE');

INSERT INTO HASH_ALGO_NAME VALUES ('N/A', 'PoS',
                                   'No specific hash algorithm, used for non-PoW or non-standard consensus mechanisms.'
                                  ,'N/A','N/A','N/A','HIGH');


# CRYPTO DATA START


INSERT INTO CRYPTO (
    NAME, SYMBOL, MAX_PRICE, MAX_PRICE_DATE, MIN_PRICE, MIN_PRICE_DATE,
    TOTAL_SUPPLY, CIRCULATING_SUPPLY, BLOCKCHAIN_ACCESS_TYPE, CONSENSUS_ALGORITHM_TYPE,
    BLOCKCHAIN_NETWORK_TYPE, BLOCKCHAIN_TOKEN_TYPE, HASH_ALGO_NAME,
    FOUNDER, INITIAL_RELEASE_YEAR, OFFICIAL_WEBSITE, DESCRIPTION_FOR_MAJOR_CHANGES_LIKE_AS_MERGE
) VALUES
-- 1. Bitcoin
('Bitcoin', 'BTC', 180000.000000000000000, '2025-03-31', 0.048650000000000, '2010-07-14', 21000000.000000000000000, 19500000.000000000000000, 'Public', 'PoW', 'Layer-1', 'Native Coin', 'SHA-256', 'Satoshi Nakamoto', 2009, 'https://bitcoin.org', 'Taproot upgrade (2021), ETF approvals (2024)'),
-- 2. Ethereum
('Ethereum', 'ETH', 6000.000000000000000, '2025-12-31', 0.432979000000000, '2015-10-20', NULL, 120000000.000000000000000, 'Public', 'PoS', 'Layer-1', 'Native Coin', 'Keccak-256', 'Vitalik Buterin', 2015, 'https://ethereum.org', 'The Merge to PoS (2022), Dencun upgrade (2024)'),
-- 3. Tether
('Tether', 'USDT', 1.320000000000000, '2018-07-24', 0.572521000000000, '2015-03-02', NULL, 83000000000.000000000000000, 'Hybrid', 'N/A', 'Layer-1', 'Stablecoin', 'N/A', 'Brock Pierce', 2014, 'https://tether.to', 'Reserve attestation changes (2022), multi-chain expansion'),
-- 4. XRP
('XRP', 'XRP', 3.400000000000000, '2018-01-07', 0.002686000000000, '2014-05-22', 100000000000.000000000000000, 54000000000.000000000000000, 'Public', 'Ripple Protocol', 'Layer-1', 'Native Coin', 'N/A', 'Chris Larsen', 2013, 'https://ripple.com', 'SEC lawsuit resolution (2023)'),
-- 5. Binance Coin
('Binance Coin', 'BNB', 717.480000000000000, '2024-06-06', 0.096109000000000, '2017-08-02', 200000000.000000000000000, 157000000.000000000000000, 'Public', 'PoSA', 'Layer-1', 'Utility Token', 'N/A', 'Changpeng Zhao', 2017, 'https://bnbchain.org', 'BNB Chain rebrand (2022)'),
-- 6. USD Coin
('USD Coin', 'USDC', 1.170000000000000, '2019-05-08', 0.877647000000000, '2023-03-11', NULL, 56000000000.000000000000000, 'Hybrid', 'N/A', 'Layer-1', 'Stablecoin', 'N/A', 'Circle', 2018, 'https://circle.com', 'CCTP cross-chain protocol (2023)'),
-- 7. Solana
('Solana', 'SOL', 259.960000000000000, '2021-11-06', 0.500801000000000, '2020-05-11', 511000000.000000000000000, 400000000.000000000000000, 'Public', 'PoH+PoS', 'Layer-1', 'Native Coin', 'SHA-256', 'Anatoly Yakovenko', 2020, 'https://solana.com', 'Network outages (2022-2023), Firedancer upgrade (2024)'),
-- 8. Cardano
('Cardano', 'ADA', 3.090000000000000, '2021-09-02', 0.019252000000000, '2020-03-13', 45000000000.000000000000000, 35000000000.000000000000000, 'Public', 'Ouroboros PoS', 'Layer-1', 'Native Coin', 'N/A', 'Charles Hoskinson', 2017, 'https://cardano.org', 'Alonzo hard fork (2021), Chang upgrade (2024)'),
-- 9. Dogecoin
('Dogecoin', 'DOGE', 0.731578000000000, '2021-05-08', 0.000086900000000, '2015-05-06', NULL, 142000000000.000000000000000, 'Public', 'AuxPoW', 'Layer-1', 'Native Coin', 'Scrypt', 'Billy Markus', 2013, 'https://dogecoin.com', 'Merge mining with Litecoin, Elon Musk endorsements'),
-- 10. TRON
('TRON', 'TRX', 0.231673000000000, '2018-01-05', 0.001804000000000, '2017-11-12', 100000000000.000000000000000, 92000000000.000000000000000, 'Public', 'DPoS', 'Layer-1', 'Native Coin', 'N/A', 'Justin Sun', 2017, 'https://tron.network', 'USDD stablecoin launch (2022)'),
-- 11. Avalanche
('Avalanche', 'AVAX', 144.960000000000000, '2021-11-21', 2.800000000000000, '2020-12-31', 720000000.000000000000000, 400000000.000000000000000, 'Public', 'Snowman PoS', 'Layer-1', 'Native Coin', 'N/A', 'Emin Gün Sirer', 2020, 'https://avax.network', 'Apricot upgrade (2021), Subnet expansion'),
-- 12. Shiba Inu
('Shiba Inu', 'SHIB', 0.000086160000000, '2021-10-28', 0.000000000081000, '2020-09-01', 1000000000000000.000000000000000, 549000000000000.000000000000000, 'Public', 'PoS (ETH)', 'Layer-2', 'Meme Token', 'Keccak-256', 'Ryoshi', 2020, 'https://shibatoken.com', 'Shibarium launch (2023)'),
-- 13. Polkadot
('Polkadot', 'DOT', 54.980000000000000, '2021-11-04', 2.700000000000000, '2020-08-20', 1200000000.000000000000000, 1100000000.000000000000000, 'Public', 'NPoS', 'Layer-0', 'Native Coin', 'N/A', 'Gavin Wood', 2020, 'https://polkadot.network', 'Parachain launches (2021)'),
-- 14. Chainlink
('Chainlink', 'LINK', 52.700000000000000, '2021-05-10', 0.148183000000000, '2017-11-29', 1000000000.000000000000000, 550000000.000000000000000, 'Hybrid', 'PoS (Oracle)', 'Layer-1', 'Utility Token', 'Keccak-256', 'Sergey Nazarov', 2017, 'https://chain.link', 'CCIP launch (2023)'),
-- 15. Bitcoin Cash
('Bitcoin Cash', 'BCH', 3785.820000000000000, '2017-12-20', 76.930000000000000, '2018-12-16', 21000000.000000000000000, 19400000.000000000000000, 'Public', 'PoW', 'Layer-1', 'Native Coin', 'SHA-256', 'Roger Ver', 2017, 'https://bitcoincash.org', 'Hard fork from Bitcoin (2017)'),
-- 16. Dai
('Dai', 'DAI', 1.220000000000000, '2020-03-13', 0.903243000000000, '2018-03-31', NULL, 10000000000.000000000000000, 'Public', 'PoS (ETH)', 'Layer-2', 'Stablecoin', 'Keccak-256', 'MakerDAO', 2017, 'https://makerdao.com', 'Multi-Chain DAI (2023)'),
-- 17. Litecoin
('Litecoin', 'LTC', 410.260000000000000, '2021-05-10', 1.150000000000000, '2015-01-14', 84000000.000000000000000, 73000000.000000000000000, 'Public', 'PoW', 'Layer-1', 'Native Coin', 'Scrypt', 'Charlie Lee', 2011, 'https://litecoin.org', 'MimbleWimble upgrade (2022)'),
-- 18. NEAR Protocol
('NEAR Protocol', 'NEAR', 20.440000000000000, '2022-01-16', 0.526762000000000, '2020-11-04', 1000000000.000000000000000, 850000000.000000000000000, 'Public', 'Nightshade PoS', 'Layer-1', 'Native Coin', 'N/A', 'Illia Polosukhin', 2020, 'https://near.org', 'Sharding Phase 1 (2023)'),
-- 19. Polygon
('Polygon', 'MATIC', 2.920000000000000, '2021-12-27', 0.003143000000000, '2019-05-10', 10000000000.000000000000000, 9300000000.000000000000000, 'Public', 'PoS', 'Layer-2', 'Utility Token', 'Keccak-256', 'Sandeep Nailwal', 2017, 'https://polygon.technology', 'zkEVM launch (2023)'),
-- 20. Internet Computer
('Internet Computer', 'ICP', 700.650000000000000, '2021-05-10', 2.870000000000000, '2023-09-22', 469000000.000000000000000, 450000000.000000000000000, 'Public', 'Threshold Relay', 'Layer-1', 'Native Coin', 'N/A', 'Dominic Williams', 2021, 'https://internetcomputer.org', 'Bitcoin integration (2023)'),
-- 21. Fetch.ai
('Fetch.ai', 'FET', 3.330000000000000, '2024-03-31', 0.008300000000000, '2019-03-02', 1152997575.000000000000000, 1040000000.000000000000000, 'Public', 'PoS', 'Layer-1', 'Utility Token', 'N/A', 'Humayun Sheikh', 2019, 'https://fetch.ai', 'AI agent ecosystem expansion (2024)'),
-- 22. Stellar
('Stellar', 'XLM', 0.875563000000000, '2018-01-03', 0.000476000000000, '2014-11-18', 50000000000.000000000000000, 28000000000.000000000000000, 'Public', 'SCP', 'Layer-1', 'Native Coin', 'N/A', 'Jed McCaleb', 2014, 'https://stellar.org', 'Protocol 19 upgrade (2023)'),
-- 23. Ethereum Classic
('Ethereum Classic', 'ETC', 167.090000000000000, '2021-05-06', 0.615038000000000, '2016-07-25', 210700000.000000000000000, 140000000.000000000000000, 'Public', 'PoW', 'Layer-1', 'Native Coin', 'Ethash', 'Ethereum Foundation', 2016, 'https://ethereumclassic.org', 'Thanos upgrade (2020)'),
-- 24. Cosmos
('Cosmos', 'ATOM', 44.450000000000000, '2022-01-17', 1.160000000000000, '2020-03-13', NULL, 350000000.000000000000000, 'Public', 'Tendermint BFT', 'Layer-0', 'Native Coin', 'N/A', 'Jae Kwon', 2019, 'https://cosmos.network', 'Interchain Security (2023)'),
-- 25. Filecoin
('Filecoin', 'FIL', 236.840000000000000, '2021-04-01', 2.640000000000000, '2022-12-16', 2000000000.000000000000000, 400000000.000000000000000, 'Public', 'PoRep/PoSt', 'Layer-1', 'Utility Token', 'N/A', 'Juan Benet', 2017, 'https://filecoin.io', 'FVM launch (2023)'),
-- 26. Arbitrum
('Arbitrum', 'ARB', 2.750000000000000, '2023-03-23', 0.360000000000000, '2023-09-11', 10000000000.000000000000000, 2000000000.000000000000000, 'Public', 'PoS', 'Layer-2', 'Governance Token', 'Keccak-256', 'Offchain Labs', 2023, 'https://arbitrum.io', 'Mainnet launch (2023)'),
-- 27. Cronos
('Cronos', 'CRO', 0.965407000000000, '2021-11-24', 0.012119000000000, '2019-02-08', 30000000000.000000000000000, 25000000000.000000000000000, 'Public', 'PoS', 'Layer-1', 'Utility Token', 'N/A', 'Kris Marszalek', 2018, 'https://cronos.org', 'Cronos Chain launch (2021)'),
-- 28. Hedera
('Hedera', 'HBAR', 0.569229000000000, '2021-09-15', 0.009861000000000, '2020-01-02', 50000000000.000000000000000, 33000000000.000000000000000, 'Public', 'Hashgraph aBFT', 'Layer-1', 'Native Coin', 'N/A', 'Leemon Baird', 2019, 'https://hedera.com', 'Consensus Service 2.0 (2023)'),
-- 29. Fantom
('Fantom', 'FTM', 3.460000000000000, '2021-10-28', 0.001902000000000, '2020-03-13', 3175000000.000000000000000, 2800000000.000000000000000, 'Public', 'Lachesis aBFT', 'Layer-1', 'Native Coin', 'N/A', 'Dr. Ahn Byung Ik', 2019, 'https://fantom.foundation', 'Gas monetization (2023)'),
-- 30. The Graph
('The Graph', 'GRT', 0.667000000000000, '2021-04-16', 0.021000000000000, '2020-12-17', 10788004317.000000000000000, 8000000000.000000000000000, 'Public', 'PoS', 'Layer-2', 'Utility Token', 'Keccak-256', 'Yaniv Tal', 2020, 'https://thegraph.com', 'Decentralized indexing (2023)'),
-- 31. Algorand
('Algorand', 'ALGO', 3.560000000000000, '2019-06-20', 0.087513000000000, '2023-09-11', 10000000000.000000000000000, 7500000000.000000000000000, 'Public', 'Pure PoS', 'Layer-1', 'Native Coin', 'N/A', 'Silvio Micali', 2019, 'https://algorand.com', 'State proofs (2022)'),
-- 32. VeChain
('VeChain', 'VET', 0.280991000000000, '2021-04-17', 0.001678000000000, '2020-03-13', 86700000000.000000000000000, 72500000000.000000000000000, 'Public', 'PoA', 'Layer-1', 'Utility Token', 'N/A', 'Sunny Lu', 2017, 'https://vechain.org', 'VeChainThor 2.0 (2022)'),
-- 33. Tezos
('Tezos', 'XTZ', 9.120000000000000, '2021-10-04', 0.350476000000000, '2018-12-07', NULL, 950000000.000000000000000, 'Public', 'Liquid PoS', 'Layer-1', 'Native Coin', 'N/A', 'Arthur Breitman', 2018, 'https://tezos.com', 'Mumbai upgrade (2023)'),
-- 34. The Sandbox
('The Sandbox', 'SAND', 8.400000000000000, '2021-11-25', 0.028972000000000, '2020-11-04', 3000000000.000000000000000, 2300000000.000000000000000, 'Public', 'PoS (ETH)', 'Layer-2', 'Utility Token', 'Keccak-256', 'Arthur Madrid', 2020, 'https://sandbox.game', 'LAND staking (2023)'),
-- 35. Decentraland
('Decentraland', 'MANA', 5.850000000000000, '2021-11-25', 0.009317000000000, '2017-10-31', 2200000000.000000000000000, 1900000000.000000000000000, 'Public', 'PoS (ETH)', 'Layer-2', 'Utility Token', 'Keccak-256', 'Ari Meilich', 2017, 'https://decentraland.org', 'DAO governance overhaul (2022)'),
-- 36. Axie Infinity
('Axie Infinity', 'AXS', 164.900000000000000, '2021-11-06', 0.123718000000000, '2020-11-06', 270000000.000000000000000, 120000000.000000000000000, 'Public', 'PoS', 'Sidechain', 'Governance Token', 'Keccak-256', 'Trung Nguyen', 2020, 'https://axieinfinity.com', 'Ronin Bridge relaunch (2023)'),
-- 37. Aave
('Aave', 'AAVE', 661.690000000000000, '2021-05-18', 26.020000000000000, '2020-11-05', 16000000.000000000000000, 14000000.000000000000000, 'Public', 'PoS (ETH)', 'Layer-2', 'Governance Token', 'Keccak-256', 'Stani Kulechov', 2017, 'https://aave.com', 'V3 protocol (2022)'),
-- 38. Monero
('Monero', 'XMR', 542.330000000000000, '2018-01-09', 0.216177000000000, '2015-01-14', 18400000.000000000000000, 18200000.000000000000000, 'Public', 'RandomX PoW', 'Layer-1', 'Native Coin', 'RandomX', 'Ricardo Spagni', 2014, 'https://getmonero.org', 'Tail emission activation (2022)'),
-- 39. Kusama
('Kusama', 'KSM', 621.710000000000000, '2021-05-18', 0.876743000000000, '2020-01-14', 10000000.000000000000000, 8500000.000000000000000, 'Public', 'NPoS', 'Layer-0', 'Native Coin', 'N/A', 'Gavin Wood', 2019, 'https://kusama.network', 'Parachain auctions (2021)'),
-- 40. Zcash
('Zcash', 'ZEC', 5941.800000000000000, '2016-10-29', 18.940000000000000, '2020-03-13', 21000000.000000000000000, 16000000.000000000000000, 'Public', 'PoW', 'Layer-1', 'Native Coin', 'Equihash', 'Zooko Wilcox', 2016, 'https://z.cash', 'Halo 2 upgrade (2022)'),
-- 41. Chiliz
('Chiliz', 'CHZ', 0.878633000000000, '2021-03-13', 0.004001000000000, '2019-09-28', 8888888888.000000000000000, 6000000000.000000000000000, 'Public', 'PoA', 'Layer-1', 'Utility Token', 'N/A', 'Alexandre Dreyfus', 2019, 'https://chiliz.com', 'Socios.com expansion (2023)'),
-- 42. Helium
('Helium', 'HNT', 54.880000000000000, '2021-11-12', 0.113248000000000, '2020-04-18', 223000000.000000000000000, 160000000.000000000000000, 'Public', 'PoC', 'Layer-1', 'Native Coin', 'N/A', 'Amir Haleem', 2019, 'https://helium.com', 'Solana migration (2023)'),
-- 43. Optimism
('Optimism', 'OP', 4.850000000000000, '2022-05-31', 0.400000000000000, '2022-12-07', 4294967296.000000000000000, 1000000000.000000000000000, 'Public', 'PoS', 'Layer-2', 'Governance Token', 'Keccak-256', 'Optimism Foundation', 2022, 'https://optimism.io', 'Bedrock upgrade (2023)'),
-- 44. Maker
('Maker', 'MKR', 4095.000000000000000, '2021-05-03', 97.960000000000000, '2017-01-29', 1005577.000000000000000, 950000.000000000000000, 'Public', 'PoS (ETH)', 'Layer-2', 'Governance Token', 'Keccak-256', 'Rune Christensen', 2017, 'https://makerdao.com', 'Endgame plan (2024)'),
-- 45. Injective
('Injective', 'INJ', 44.950000000000000, '2024-03-14', 0.657000000000000, '2020-11-04', 100000000.000000000000000, 85000000.000000000000000, 'Public', 'Tendermint BFT', 'Appchain', 'Native Coin', 'N/A', 'Eric Chen', 2020, 'https://injective.com', 'Cosmos SDK integration'),
-- 46. Immutable X
('Immutable X', 'IMX', 3.760000000000000, '2021-11-26', 0.110000000000000, '2021-06-11', 2000000000.000000000000000, 1500000000.000000000000000, 'Public', 'PoS', 'Layer-2', 'Utility Token', 'Keccak-256', 'James Ferguson', 2021, 'https://immutable.com', 'Immutable zkEVM launch (2024)'),
-- 47. Aptos
('Aptos', 'APT', 20.250000000000000, '2023-01-26', 3.080000000000000, '2022-12-07', 1000000000.000000000000000, 400000000.000000000000000, 'Public', 'PoS', 'Layer-1', 'Native Coin', 'N/A', 'Mo Shaikh', 2022, 'https://aptoslabs.com', 'Mainnet launch (2022)'),
-- 48. Sei
('Sei', 'SEI', 0.880000000000000, '2023-08-15', 0.095000000000000, '2023-09-11', 10000000000.000000000000000, 3000000000.000000000000000, 'Public', 'Tendermint BFT', 'Layer-1', 'Native Coin', 'N/A', 'Jayendra Jog', 2023, 'https://sei.network', 'Mainnet launch (2023)'),
-- 49. Lido DAO
('Lido DAO', 'LDO', 3.330000000000000, '2021-11-16', 0.404000000000000, '2020-12-17', 1000000000.000000000000000, 900000000.000000000000000, 'Public', 'PoS (ETH)', 'Layer-2', 'Governance Token', 'Keccak-256', 'Konstantin Lomashuk', 2020, 'https://lido.fi', 'Liquid staking expansion (2023)'),
-- 50. Ondo
('Ondo', 'ONDO', 3.330000000000000, '2024-03-31', 0.810000000000000, '2024-01-18', 10000000000.000000000000000, 2000000000.000000000000000, 'Public', 'PoS', 'Layer-2', 'Utility Token', 'Keccak-256', 'Nathan Allman', 2024, 'https://ondo.finance', 'RWA tokenization launch (2024)');

# CRYPTO DATA END


# CRYPTO_PERFORMANCE_METRICS_START
INSERT INTO CRYPTO_CURRENCY_PERFORMANCE_METRICS (SYMBOL, TRANSACTION_PER_SECOND,
                                                 AVERAGE_TRX_FEE
                                                , ELECTRICITY_COST_PER_BLOCK, HEAT_IMMERSION_PER_TX,
                                                 HASH_RATE_PER_UNIT,
                                                 TOTAL_USERS) VALUES
('BTC', 7.00, 2.5000,
 1449.000000, 5216.400000, '2.31E+09', 1000000),
('ETH', 15.00, 1.2000, 0.005000, 0.018000, 'N/A', 500000),
('USDT', 15.00, 1.2000, 0.005000, 0.018000, 'N/A', 10000000),
('XRP', 1500.00, 0.0004, 0.000100, 0.000360, 'N/A', 2000000),
('BNB', 100.00, 0.1000, 0.010000, 0.036000, 'N/A', 5000000),
('USDC', 15.00, 1.2000, 0.005000, 0.018000, 'N/A', 8000000),
('SOL', 2000.00, 0.0003, 0.001000, 0.003600, 'N/A', 1500000),
('ADA', 250.00, 0.0500, 0.000500, 0.001800, 'N/A', 1000000),
('DOGE', 7.00, 0.5000, 100.000000, 360.000000, '1.67E+06', 500000),
('TRX', 2000.00, 0.0010, 0.001000, 0.003600, 'N/A', 1200000),
('AVAX', 4500.00, 0.0200, 0.001000, 0.003600, 'N/A', 800000),
('SHIB', 15.00, 1.2000, 0.005000, 0.018000, 'N/A', 1000000),
('DOT', 1000.00, 0.0100, 0.001000, 0.003600, 'N/A', 700000),
('LINK', 15.00, 1.2000, 0.005000, 0.018000, 'N/A', 600000),
('BCH', 7.00, 0.0500, 200.000000, 720.000000, '1.43E+07', 300000),
('DAI', 15.00, 1.2000, 0.005000, 0.018000, 'N/A', 500000),
('LTC', 7.00, 0.0400, 50.000000, 180.000000, '4.29E+06', 400000),
('NEAR', 4000.00, 0.0010, 0.001000, 0.003600, 'N/A', 600000),
('MATIC', 65.00, 0.0200, 0.005000, 0.018000, 'N/A', 800000),
('ICP', 11000.00, 0.0001, 0.001000, 0.003600, 'N/A', 500000),
('FET', 1000.00, 0.0100, 0.001000, 0.003600, 'N/A', 400000),
('XLM', 1000.00, 0.0000, 0.000100, 0.000360, 'N/A', 1000000),
('ETC', 7.00, 0.1000, 150.000000, 540.000000, '6.43E+06', 200000),
('ATOM', 10000.00, 0.0100, 0.001000, 0.003600, 'N/A', 500000),
('FIL', 3000.00, 0.0100, 0.001000, 0.003600, 'N/A', 400000),
('ARB', 40.00, 0.0500, 0.005000, 0.018000, 'N/A', 600000),
('CRO', 300.00, 0.0100, 0.001000, 0.003600, 'N/A', 500000),
('HBAR', 10000.00, 0.0001, 0.000100, 0.000360, 'N/A', 400000),
('FTM', 300.00, 0.0010, 0.001000, 0.003600, 'N/A', 500000),
('GRT', 15.00, 1.2000, 0.005000, 0.018000, 'N/A', 400000),
('ALGO', 6000.00, 0.0010, 0.000500, 0.001800, 'N/A', 500000),
('VET', 10000.00, 0.0100, 0.001000, 0.003600, 'N/A', 400000),
('XTZ', 40.00, 0.0100, 0.001000, 0.003600, 'N/A', 300000),
('SAND', 15.00, 1.2000, 0.005000, 0.018000, 'N/A', 400000),
('MANA', 15.00, 1.2000, 0.005000, 0.018000, 'N/A', 300000),
('AXS', 15.00, 1.2000, 0.005000, 0.018000, 'N/A', 500000),
('AAVE', 15.00, 1.2000, 0.005000, 0.018000, 'N/A', 400000),
('XMR', 7.00, 0.0500, 80.000000, 288.000000, '1.07E+06', 200000),
('KSM', 1000.00, 0.0100, 0.001000, 0.003600, 'N/A', 200000),
('ZEC', 7.00, 0.0500, 100.000000, 360.000000, '1.43E+06', 200000),
('CHZ', 100.00, 0.0100, 0.001000, 0.003600, 'N/A', 300000),
('HNT', 2000.00, 0.0010, 0.001000, 0.003600, 'N/A', 300000),
('OP', 40.00, 0.0500, 0.005000, 0.018000, 'N/A', 400000),
('MKR', 15.00, 1.2000, 0.005000, 0.018000, 'N/A', 300000),
('INJ', 10000.00, 0.0100, 0.001000, 0.003600, 'N/A', 300000),
('IMX', 9000.00, 0.0100, 0.005000, 0.018000, 'N/A', 300000),
('APT', 10000.00, 0.0100, 0.001000, 0.003600, 'N/A', 200000),
('SEI', 12000.00, 0.0100, 0.001000, 0.003600, 'N/A', 200000),
('LDO', 15.00, 1.2000, 0.005000, 0.018000, 'N/A', 300000),
('ONDO', 15.00, 1.2000, 0.005000, 0.018000, 'N/A', 200000);

# CRYPTO_PERFORMANCE_METRICS_START

# TOTAL_USER_DISTRIBUTION DATA START
INSERT INTO TOTAL_USER_DISTRIBUTION (YEAR, ASIA_USER, NORTH_AMERICA_USER, AMERICA_USER, AFRICA_USER, EUROPE_USER, OCEANIA_USER, TOTAL_USER_IN_WORD,TOTAL_MARKET_CAP) VALUES
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
# TOTAL_USER_DISTRIBUTION DATA END

# MARKET_DOMINANCE DATA START
INSERT INTO MARKET_DOMINANCE (YEAR, SYMBOL, MAX_PRICE, MIN_PRICE, MAX_PRICE_DATE, MIN_PRICE_DATE, TOTAL_MARKET_CAP_OF_THIS_CURRENCY, DOMINANCE)
VALUES
-- 2009: Only BTC
(2009, 'BTC', 0.100000000000000, 0.000100000000000000000000000000000,
 '2009-10-05', '2009-01-03', 100000.0000000000, 100.00)


/*
INSERT INTO MARKET_DOMINANCE (YEAR, SYMBOL, MAX_PRICE, MIN_PRICE, MAX_PRICE_DATE, MIN_PRICE_DATE, TOTAL_MARKET_CAP_OF_THIS_CURRENCY, DOMINANCE)
VALUES
-- 2010: Only BTC
(2010, 'BTC', 0.500000000000000, 0.100000000000000000000000000000, '2010-07-17', '2010-01-01', 1000000.0000000000, 100.00),
# (2010, 'ETH', NULL, NULL, NULL, NULL, NULL, NULL),
# (2010, 'USDT', NULL, NULL, NULL, NULL, NULL, NULL),
-- ... (47 more NULL records for 2010, similar to 2009)

-- 2011: BTC, LTC, NMC
(2011, 'BTC', 31.900000000000000, 0.300000000000000000000000000000, '2011-06-08', '2011-01-01', 50000000.0000000000, 98.04),
(2011, 'LTC', 0.050000000000000, 0.010000000000000000000000000000, '2011-10-07', '2011-10-07', 500000.0000000000, 0.98),
# (2011, 'NMC', 1.000000000000000, 0.100000000000000000000000000000, '2011-04-28', '2011-04-28', 250000.0000000000, 0.49),
# (2011, 'ETH', NULL, NULL, NULL, NULL, NULL, NULL),
# (2011, 'USDT', NULL, NULL, NULL, NULL, NULL, NULL),
# ... (46 more NULL records for 2011)

-- 2012: BTC, LTC, NMC, PPC
(2012, 'BTC', 13.700000000000000, 4.200000000000000000000000000000, '2012-04-01', '2012-06-01', 100000000.0000000000, 95.24),
(2012, 'LTC', 0.100000000000000, 0.020000000000000000000000000000, '2012-12-31', '2012-01-01', 2000000.0000000000, 1.90),
# (2012, 'NMC', 2.500000000000000, 0.500000000000000000000000000000, '2012-01-01', '2012-12-31', 1000000.0000000000, 0.95),
# (2012, 'PPC', 0.500000000000000, 0.100000000000000000000000000000, '2012-08-19', '2012-08-19', 500000.0000000000, 0.48),
# (2012, 'ETH', NULL, NULL, NULL, NULL, NULL, NULL),
-- ... (45 more NULL records for 2012)

-- 2013: BTC, XRP, LTC, PPC, NMC
(2013, 'BTC', 1157.000000000000000, 13.300000000000000000000000000000, '2013-12-04', '2013-01-01', 14000000000.0000000000, 93.33),
(2013, 'XRP', 0.060000000000000, 0.005800000000000000000000000000, '2013-12-31', '2013-01-01', 2000000000.0000000000, 1.33),
(2013, 'LTC', 31.500000000000000, 1.400000000000000000000000000000, '2013-11-28', '2013-01-01', 1000000000.0000000000, 0.67),
# (2013, 'PPC', 7.000000000000000, 0.400000000000000000000000000000, '2013-11-01', '2013-01-01', 500000000.0000000000, 0.33),
# (2013, 'NMC', 5.000000000000000, 0.500000000000000000000000000000, '2013-11-01', '2013-01-01', 300000000.0000000000, 0.20),
# (2013, 'ETH', NULL, NULL, NULL, NULL, NULL, NULL),
# (2013, 'USDT', NULL, NULL, NULL, NULL, NULL, NULL),
-- ... (43 more NULL records for 2013)

-- 2014: BTC, XRP, LTC, PPC, NMC, DOGE
(2014, 'BTC', 1000.000000000000000, 300.000000000000000000000000000000, '2014-01-01', '2014-12-31', 5130000000.0000000000, 85.50),
(2014, 'XRP', 0.024000000000000, 0.002800000000000000000000000000, '2014-12-31', '2014-01-01', 346220000.0000000000, 5.77),
(2014, 'LTC', 24.000000000000000, 2.000000000000000000000000000000, '2014-01-01', '2014-12-31', 122630000.0000000000, 2.04),
# (2014, 'PPC', 5.000000000000000, 0.500000000000000000000000000000, '2014-01-01', '2014-12-31', 16260000.0000000000, 0.27),
# (2014, 'NMC', 3.000000000000000, 0.300000000000000000000000000000, '2014-01-01', '2014-12-31', 10000000.0000000000, 0.17),
(2014, 'DOGE', 0.000400000000000, 0.000100000000000000000000000000000, '2014-01-01', '2014-12-31', 5000000.0000000000, 0.08);
# (2014, 'ETH', NULL, NULL, NULL, NULL, NULL, NULL),
-- ... (42 more NULL records for 2014)

-- 2015: BTC, ETH, XRP, LTC, DASH
INSERT INTO MARKET_DOMINANCE (YEAR, SYMBOL, MAX_PRICE, MIN_PRICE, MAX_PRICE_DATE, MIN_PRICE_DATE, TOTAL_MARKET_CAP_OF_THIS_CURRENCY, DOMINANCE)
VALUES
(2015, 'BTC', 500.000000000000000, 200.000000000000000000000000000000, '2015-01-01', '2015-12-31', 7000000000.0000000000, 87.50),
(2015, 'ETH', 1.300000000000000, 0.400000000000000000000000000000, '2015-08-07', '2015-12-31', 65980000.0000000000, 0.82),
(2015, 'XRP', 0.014000000000000, 0.003800000000000000000000000000, '2015-12-31', '2015-01-01', 100000000.0000000000, 1.25),
(2015, 'LTC', 8.000000000000000, 1.200000000000000000000000000000, '2015-07-09', '2015-01-01', 150000000.0000000000, 1.88),
# (2015, 'DASH', 4.000000000000000, 0.500000000000000000000000000000, '2015-12-31', '2015-01-01', 50000000.0000000000, 0.63),
(2015, 'DOGE', 0.000200000000000, 0.000100000000000000000000000000000, '2015-01-01', '2015-12-31', 10000000.0000000000, 0.13),
# (2015, 'USDT', NULL, NULL, NULL, NULL, NULL, NULL),
-- ... (42 more NULL records for 2015)
# SELECT * FROM CRYPTO WHERE SYMBOL='DASH';
-- 2016: BTC, ETH, XRP, LTC, DASH, XMR
(2016, 'BTC', 900.000000000000000, 350.000000000000000000000000000000, '2016-12-31', '2016-01-01', 14000000000.0000000000, 87.50),
(2016, 'ETH', 21.500000000000000, 1.000000000000000000000000000000, '2016-06-16', '2016-01-01', 7200000000.0000000000, 45.00),
(2016, 'XRP', 0.008900000000000, 0.004400000000000000000000000000, '2016-12-31', '2016-01-01', 1960000000.0000000000, 12.25),
(2016, 'LTC', 6.000000000000000, 3.000000000000000000000000000000, '2016-06-16', '2016-01-01', 200000000.0000000000, 1.25),
# (2016, 'DASH', 14.000000000000000, 1.500000000000000000000000000000, '2016-12-31', '2016-01-01', 100000000.0000000000, 0.63),
(2016, 'XMR', 2.500000000000000, 0.500000000000000000000000000000, '2016-12-31', '2016-01-01', 50000000.0000000000, 0.31),
# (2016, 'USDT', NULL, NULL, NULL, NULL, NULL, NULL),
-- ... (41 more NULL records for 2016)

-- 2017: BTC, ETH, XRP, BCH, LTC, DASH, XMR, ETC
(2017, 'BTC', 19666.000000000000000, 775.000000000000000000000000000000, '2017-12-07', '2017-01-01', 300000000000.0000000000, 60.00),
(2017, 'ETH', 826.000000000000000, 8.000000000000000000000000000000, '2017-12-12', '2017-01-01', 80000000000.0000000000, 16.00),
(2017, 'XRP', 3.840000000000000, 0.006100000000000000000000000000, '2017-12-31', '2017-01-01', 150000000000.0000000000, 30.00),
(2017, 'BCH', 4340.000000000000000, 300.000000000000000000000000000000, '2017-12-20', '2017-08-01', 50000000000.0000000000, 10.00),
(2017, 'LTC', 366.000000000000000, 4.000000000000000000000000000000, '2017-12-12', '2017-01-01', 20000000000.0000000000, 4.00),
# (2017, 'DASH', 1540.000000000000000, 15.000000000000000000000000000000, '2017-12-20', '2017-01-01', 10000000000.0000000000, 2.00),
(2017, 'XMR', 480.000000000000000, 2.500000000000000000000000000000, '2017-12-31', '2017-01-01', 5000000000.0000000000, 1.00),
(2017, 'ETC', 44.000000000000000, 1.000000000000000000000000000000, '2017-12-31', '2017-01-01', 4000000000.0000000000, 0.80),
(2017, 'USDT', 1.210000000000000, 0.870000000000000000000000000000, '2017-12-31', '2017-01-01', 2000000000.0000000000, 0.40);
# (2017, 'BNB', NULL, NULL, NULL, NULL, NULL, NULL),
-- ... (39 more NULL records for 2017)

-- 2018: BTC, ETH, XRP, USDT, BCH, LTC, BNB, ADA, XLM
INSERT INTO MARKET_DOMINANCE (YEAR, SYMBOL, MAX_PRICE, MIN_PRICE, MAX_PRICE_DATE, MIN_PRICE_DATE, TOTAL_MARKET_CAP_OF_THIS_CURRENCY, DOMINANCE)
VALUES
(2018, 'BTC', 17200.000000000000000, 3200.000000000000000000000000000000, '2018-01-07', '2018-12-15', 125000000000.0000000000, 51.02),
(2018, 'ETH', 1417.000000000000000, 83.000000000000000000000000000000, '2018-01-13', '2018-12-07', 19800000000.0000000000, 8.08),
(2018, 'XRP', 3.380000000000000, 0.290000000000000000000000000000, '2018-01-07', '2018-12-31', 20000000000.0000000000, 8.16),
(2018, 'USDT', 1.210000000000000, 0.870000000000000000000000000000, '2018-01-01', '2018-12-31', 2800000000.0000000000, 1.14),
(2018, 'BCH', 4000.000000000000000, 75.000000000000000000000000000000, '2018-01-01', '2018-12-15', 14500000000.0000000000, 5.92),
(2018, 'LTC', 255.000000000000000, 22.000000000000000000000000000000, '2018-01-07', '2018-12-15', 6000000000.0000000000, 2.45),
(2018, 'BNB', 24.000000000000000, 4.000000000000000000000000000000, '2018-01-07', '2018-12-15', 5000000000.0000000000, 2.04),
(2018, 'ADA', 1.330000000000000, 0.030000000000000000000000000000, '2018-01-04', '2018-12-31', 4000000000.0000000000, 1.63),
(2018, 'XLM', 0.910000000000000, 0.070000000000000000000000000000, '2018-01-03', '2018-12-31', 3000000000.0000000000, 1.22),
(2018, 'TRX', 0.300000000000000, 0.010000000000000000000000000000, '2018-01-05', '2018-12-31', 2000000000.0000000000, 0.82),
# (2018, 'SOL', NULL, NULL, NULL, NULL, NULL, NULL),
-- ... (39 more NULL records for 2018)

-- 2019: BTC, ETH, XRP, USDT, BCH, LTC, BNB, ADA, XLM, TRX
(2019, 'BTC', 13880.000000000000000, 3400.000000000000000000000000000000, '2019-06-26', '2019-01-01', 250000000000.0000000000, 62.50),
(2019, 'ETH', 360.000000000000000, 103.000000000000000000000000000000, '2019-06-26', '2019-01-01', 35000000000.0000000000, 8.75),
(2019, 'XRP', 0.580000000000000, 0.170000000000000000000000000000, '2019-06-22', '2019-12-31', 20000000000.0000000000, 5.00),
(2019, 'USDT', 1.050000000000000, 0.950000000000000000000000000000, '2019-06-01', '2019-01-01', 4000000000.0000000000, 1.00),
(2019, 'BCH', 520.000000000000000, 100.000000000000000000000000000000, '2019-06-26', '2019-01-01', 9000000000.0000000000, 2.25),
(2019, 'LTC', 146.000000000000000, 30.000000000000000000000000000000, '2019-06-22', '2019-01-01', 6000000000.0000000000, 1.50),
(2019, 'BNB', 39.000000000000000, 6.000000000000000000000000000000, '2019-06-22', '2019-01-01', 5000000000.0000000000, 1.25),
(2019, 'ADA', 0.100000000000000, 0.030000000000000000000000000000, '2019-06-26', '2019-01-01', 3000000000.0000000000, 0.75),
(2019, 'XLM', 0.150000000000000, 0.050000000000000000000000000000, '2019-06-26', '2019-12-31', 2000000000.0000000000, 0.50),
(2019, 'TRX', 0.040000000000000, 0.010000000000000000000000000000, '2019-06-26', '2019-01-01', 1500000000.0000000000, 0.38),
# (2019, 'SOL', NULL, NULL, NULL, NULL, NULL, NULL),
-- ... (39 more NULL records for 2019)

-- 2020: BTC, ETH, XRP, USDT, BNB, LTC, BCH, ADA, XLM, LINK
(2020, 'BTC', 29000.000000000000000, 3800.000000000000000000000000000000, '2020-12-31', '2020-03-12', 500000000000.0000000000, 62.50),
(2020, 'ETH', 750.000000000000000, 120.000000000000000000000000000000, '2020-12-31', '2020-03-12', 80000000000.0000000000, 10.00),
(2020, 'XRP', 0.790000000000000, 0.110000000000000000000000000000, '2020-11-24', '2020-03-12', 30000000000.0000000000, 3.75),
(2020, 'USDT', 1.010000000000000, 0.970000000000000000000000000000, '2020-12-31', '2020-01-01', 20000000000.0000000000, 2.50),
(2020, 'BNB', 38.000000000000000, 6.000000000000000000000000000000, '2020-12-31', '2020-03-12', 6000000000.0000000000, 0.75),
(2020, 'LTC', 130.000000000000000, 25.000000000000000000000000000000, '2020-12-31', '2020-03-12', 5000000000.0000000000, 0.63),
(2020, 'BCH', 450.000000000000000, 150.000000000000000000000000000000, '2020-12-31', '2020-03-12', 4000000000.0000000000, 0.50),
(2020, 'ADA', 0.190000000000000, 0.030000000000000000000000000000, '2020-12-31', '2020-03-12', 3000000000.0000000000, 0.38),
(2020, 'XLM', 0.200000000000000, 0.050000000000000000000000000000, '2020-11-24', '2020-03-12', 2000000000.0000000000, 0.25),
(2020, 'LINK', 14.000000000000000, 1.500000000000000000000000000000, '2020-08-01', '2020-03-12', 1500000000.0000000000, 0.19),
# (2020, 'SOL', NULL, NULL, NULL, NULL, NULL, NULL),
-- ... (39 more NULL records for 2020)
-- 2021: BTC, ETH, XRP, USDT, BNB, ADA, SOL, DOGE, DOT, LINK
(2021, 'BTC', 69000.000000000000000, 29000.000000000000000000000000000000, '2021-11-10', '2021-01-01', 1200000000000.0000000000, 48.00),
(2021, 'ETH', 4878.000000000000000, 730.000000000000000000000000000000, '2021-11-10', '2021-01-01', 500000000000.0000000000, 20.00),
(2021, 'XRP', 1.960000000000000, 0.170000000000000000000000000000, '2021-04-14', '2021-01-01', 90000000000.0000000000, 3.60),
(2021, 'USDT', 1.010000000000000, 0.990000000000000000000000000000, '2021-12-31', '2021-01-01', 80000000000.0000000000, 3.20),
(2021, 'BNB', 690.000000000000000, 37.000000000000000000000000000000, '2021-05-10', '2021-01-01', 100000000000.0000000000, 4.00),
(2021, 'ADA', 3.100000000000000, 0.180000000000000000000000000000, '2021-09-02', '2021-01-01', 80000000000.0000000000, 3.20),
(2021, 'SOL', 260.000000000000000, 1.500000000000000000000000000000, '2021-11-06', '2021-01-01', 70000000000.0000000000, 2.80),
(2021, 'DOGE', 0.740000000000000, 0.008000000000000000000000000000, '2021-05-08', '2021-01-01', 60000000000.0000000000, 2.40),
(2021, 'DOT', 55.000000000000000, 4.000000000000000000000000000000, '2021-11-04', '2021-01-01', 50000000000.0000000000, 2.00),
(2021, 'LINK', 53.000000000000000, 13.000000000000000000000000000000, '2021-05-02', '2021-01-01', 40000000000.0000000000, 1.60),
(2021, 'USDC', 1.010000000000000, 0.990000000000000000000000000000, '2021-12-31', '2021-01-01', 30000000000.0000000000, 1.20),
(2021, 'LTC', 413.000000000000000, 112.000000000000000000000000000000, '2021-05-10', '2021-01-01', 20000000000.0000000000, 0.80),
-- ... (38 more records for 2021, including MATIC, AVAX, etc.)

-- 2022: BTC, ETH, USDT, BNB, XRP, ADA, SOL, DOGE, DOT, DAI
(2022, 'BTC', 48000.000000000000000, 16000.000000000000000000000000000000, '2022-01-01', '2022-11-09', 400000000000.0000000000, 33.33),
(2022, 'ETH', 4000.000000000000000, 900.000000000000000000000000000000, '2022-01-01', '2022-11-09', 150000000000.0000000000, 12.50),
(2022, 'USDT', 1.010000000000000, 0.990000000000000000000000000000, '2022-01-01', '2022-12-31', 70000000000.0000000000, 5.83),
(2022, 'BNB', 530.000000000000000, 220.000000000000000000000000000000, '2022-01-01', '2022-11-09', 80000000000.0000000000, 6.67),
(2022, 'XRP', 0.910000000000000, 0.300000000000000000000000000000, '2022-01-01', '2022-11-09', 40000000000.0000000000, 3.33),
(2022, 'ADA', 1.360000000000000, 0.240000000000000000000000000000, '2022-01-01', '2022-11-09', 30000000000.0000000000, 2.50),
(2022, 'SOL', 180.000000000000000, 8.000000000000000000000000000000, '2022-01-01', '2022-11-09', 25000000000.0000000000, 2.08),
(2022, 'DOGE', 0.190000000000000, 0.060000000000000000000000000000, '2022-01-01', '2022-11-09', 20000000000.0000000000, 1.67),
(2022, 'DOT', 30.000000000000000, 4.000000000000000000000000000000, '2022-01-01', '2022-11-09', 15000000000.0000000000, 1.25),
(2022, 'DAI', 1.010000000000000, 0.990000000000000000000000000000, '2022-12-31', '2022-01-01', 10000000000.0000000000, 0.83),
(2022, 'MATIC', 2.680000000000000, 0.320000000000000000000000000000, '2022-01-01', '2022-11-09', 9000000000.0000000000, 0.75),
-- ... (39 more records for 2022)

-- 2023: BTC, ETH, USDT, BNB, XRP, SOL, ADA, DOGE, TRX, LINK
(2023, 'BTC', 45000.000000000000000, 16000.000000000000000000000000000000, '2023-12-31', '2023-01-01', 800000000000.0000000000, 44.44),
(2023, 'ETH', 2400.000000000000000, 1200.000000000000000000000000000000, '2023-12-31', '2023-01-01', 250000000000.0000000000, 13.89),
(2023, 'USDT', 1.010000000000000, 0.990000000000000000000000000000, '2023-12-31', '2023-01-01', 90000000000.0000000000, 5.00),
(2023, 'BNB', 320.000000000000000, 200.000000000000000000000000000000, '2023-12-31', '2023-01-01', 50000000000.0000000000, 2.78),
(2023, 'XRP', 0.850000000000000, 0.350000000000000000000000000000, '2023-07-13', '2023-01-01', 45000000000.0000000000, 2.50),
(2023, 'SOL', 125.000000000000000, 10.000000000000000000000000000000, '2023-12-31', '2023-01-01', 40000000000.0000000000, 2.22),
(2023, 'ADA', 0.620000000000000, 0.240000000000000000000000000000, '2023-12-31', '2023-01-01', 30000000000.0000000000, 1.67),
(2023, 'DOGE', 0.100000000000000, 0.060000000000000000000000000000, '2023-12-31', '2023-01-01', 20000000000.0000000000, 1.11),
(2023, 'TRX', 0.120000000000000, 0.050000000000000000000000000000, '2023-12-31', '2023-01-01', 15000000000.0000000000, 0.83),
(2023, 'LINK', 20.000000000000000, 5.000000000000000000000000000000, '2023-12-31', '2023-01-01', 10000000000.0000000000, 0.56),
(2023, 'MATIC', 1.000000000000000, 0.500000000000000000000000000000, '2023-12-31', '2023-01-01', 9000000000.0000000000, 0.50),
-- ... (39 more records for 2023)

-- 2024: BTC, ETH, USDT, BNB, XRP, SOL, ADA, DOGE, TRX, AVAX
(2024, 'BTC', 97000.000000000000000, 45000.000000000000000000000000000000, '2024-12-31', '2024-01-01', 1600000000000.0000000000, 64.00),
(2024, 'ETH', 4000.000000000000000, 2400.000000000000000000000000000000, '2024-12-31', '2024-01-01', 300000000000.0000000000, 12.00),
(2024, 'USDT', 1.010000000000000, 0.990000000000000000000000000000, '2024-12-31', '2024-01-01', 120000000000.0000000000, 4.80),
(2024, 'BNB', 700.000000000000000, 320.000000000000000000000000000000, '2024-12-31', '2024-01-01', 100000000000.0000000000, 4.00),
(2024, 'XRP', 2.770000000000000, 0.500000000000000000000000000000, '2024-12-31', '2024-01-01', 100000000000.0000000000, 4.00),
(2024, 'SOL', 200.000000000000000, 80.000000000000000000000000000000, '2024-12-31', '2024-01-01', 80000000000.0000000000, 3.20),
(2024, 'ADA', 0.800000000000000, 0.300000000000000000000000000000, '2024-12-31', '2024-01-01', 40000000000.0000000000, 1.60),
(2024, 'DOGE', 0.200000000000000, 0.080000000000000000000000000000, '2024-12-31', '2024-01-01', 30000000000.0000000000, 1.20),
(2024, 'TRX', 0.150000000000000, 0.080000000000000000000000000000, '2024-12-31', '2024-01-01', 20000000000.0000000000, 0.80),
(2024, 'AVAX', 50.000000000000000, 20.000000000000000000000000000000, '2024-12-31', '2024-01-01', 15000000000.0000000000, 0.60),
(2024, 'SHIB', 0.000030000000000, 0.000010000000000000000000000000000, '2024-12-31', '2024-01-01', 10000000000.0000000000, 0.40),
-- ... (39 more records for 2024)

-- 2025: BTC, ETH, USDT, XRP, BNB, SOL, ADA, DOGE, TRX, AVAX, SHIB, DOT, LINK, BCH, DAI, LTC, NEAR, MATIC, ICP, FET
(2025, 'BTC', 97973.340000000000000, 60000.000000000000000000000000000000, '2025-02-05', '2025-01-01', 1940000000000.0000000000, 55.43),
(2025, 'ETH', 2800.000000000000000, 2000.000000000000000000000000000000, '2025-02-05', '2025-01-01', 327400000000.0000000000, 9.35),
(2025, 'USDT', 1.010000000000000, 0.990000000000000000000000000000, '2025-01-01', '2025-01-01', 140400000000.0000000000, 4.01),
(2025, 'XRP', 2.500000000000000, 1.500000000000000000000000000000, '2025-02-05', '2025-01-01', 144200000000.0000000000, 4.12),
(2025, 'BNB', 600.000000000000000, 400.000000000000000000000000000000, '2025-02-05', '2025-01-01', 81900000000.0000000000, 2.34),
(2025, 'USDC', 1.010000000000000, 0.990000000000000000000000000000, '2025-01-01', '2025-01-01', 55000000000.0000000000, 1.57),
(2025, 'SOL', 200.000000000000000, 100.000000000000000000000000000000, '2025-02-05', '2025-01-01', 90000000000.0000000000, 2.57),
(2025, 'ADA', 0.746200000000000, 0.500000000000000000000000000000, '2025-02-05', '2025-01-01', 26200000000.0000000000, 0.75),
(2025, 'DOGE', 0.263400000000000, 0.200000000000000000000000000000, '2025-02-05', '2025-01-01', 38900000000.0000000000, 1.11),
(2025, 'TRX', 0.223300000000000, 0.100000000000000000000000000000, '2025-02-05', '2025-01-01', 19200000000.0000000000, 0.55),
(2025, 'AVAX', 100.000000000000000, 50.000000000000000000000000000000, '2025-02-05', '2025-01-01', 45000000000.0000000000, 1.29),
(2025, 'SHIB', 0.000050000000000, 0.000010000000000000000000000000000, '2025-02-05', '2025-01-01', 40000000000.0000000000, 1.14),
(2025, 'DOT', 50.000000000000000, 20.000000000000000000000000000000, '2025-02-05', '2025-01-01', 35000000000.0000000000, 1.00),
(2025, 'LINK', 40.000000000000000, 15.000000000000000000000000000000, '2025-02-05', '2025-01-01', 30000000000.0000000000, 0.86),
(2025, 'BCH', 500.000000000000000, 200.000000000000000000000000000000, '2025-02-05', '2025-01-01', 25000000000.0000000000, 0.71),
(2025, 'DAI', 1.010000000000000, 0.990000000000000000000000000000, '2025-01-01', '2025-01-01', 20000000000.0000000000, 0.57),
(2025, 'LTC', 200.000000000000000, 80.000000000000000000000000000000, '2025-02-05', '2025-01-01', 18000000000.0000000000, 0.51),
(2025, 'NEAR', 10.000000000000000, 5.000000000000000000000000000000, '2025-02-05', '2025-01-01', 17000000000.0000000000, 0.49),
(2025, 'MATIC', 2.000000000000000, 1.000000000000000000000000000000, '2025-02-05', '2025-01-01', 16000000000.0000000000, 0.46),
(2025, 'ICP', 20.000000000000000, 10.000000000000000000000000000000, '2025-02-05', '2025-01-01', 15000000000.0000000000, 0.43),
(2025, 'FET', 3.000000000000000, 1.500000000000000000000000000000, '2025-02-05', '2025-01-01', 14000000000.0000000000, 0.40),
(2025, 'XLM', 0.500000000000000, 0.200000000000000000000000000000, '2025-02-05', '2025-01-01', 13000000000.0000000000, 0.37),
(2025, 'ETC', 50.000000000000000, 20.000000000000000000000000000000, '2025-02-05', '2025-01-01', 12000000000.0000000000, 0.34),
(2025, 'ATOM', 15.000000000000000, 7.000000000000000000000000000000, '2025-02-05', '2025-01-01', 11000000000.0000000000, 0.31),
(2025, 'FIL', 10.000000000000000, 5.000000000000000000000000000000, '2025-02-05', '2025-01-01', 10000000000.0000000000, 0.29),
(2025, 'ARB', 2.000000000000000, 1.000000000000000000000000000000, '2025-02-05', '2025-01-01', 9500000000.0000000000, 0.27),
(2025, 'CRO', 0.200000000000000, 0.100000000000000000000000000000, '2025-02-05', '2025-01-01', 9000000000.0000000000, 0.26),
(2025, 'HBAR', 0.300000000000000, 0.150000000000000000000000000000, '2025-02-05', '2025-01-01', 8500000000.0000000000, 0.24),
(2025, 'FTM', 1.500000000000000, 0.700000000000000000000000000000, '2025-02-05', '2025-01-01', 8000000000.0000000000, 0.23),
(2025, 'GRT', 0.500000000000000, 0.200000000000000000000000000000, '2025-02-05', '2025-01-01', 7500000000.0000000000, 0.21),
(2025, 'ALGO', 0.300000000000000, 0.150000000000000000000000000000, '2025-02-05', '2025-01-01', 7000000000.0000000000, 0.20),
(2025, 'VET', 0.100000000000000, 0.050000000000000000000000000000, '2025-02-05', '2025-01-01', 6500000000.0000000000, 0.19),
(2025, 'XTZ', 2.000000000000000, 1.000000000000000000000000000000, '2025-02-05', '2025-01-01', 6000000000.0000000000, 0.17),
(2025, 'SAND', 1.000000000000000, 0.500000000000000000000000000000, '2025-02-05', '2025-01-01', 5500000000.0000000000, 0.16),
(2025, 'MANA', 1.000000000000000, 0.500000000000000000000000000000, '2025-02-05', '2025-01-01', 5000000000.0000000000, 0.14),
(2025, 'AXS', 10.000000000000000, 5.000000000000000000000000000000, '2025-02-05', '2025-01-01', 4500000000.0000000000, 0.13),
(2025, 'AAVE', 200.000000000000000, 100.000000000000000000000000000000, '2025-02-05', '2025-01-01', 4000000000.0000000000, 0.11),
(2025, 'XMR', 300.000000000000000, 150.000000000000000000000000000000, '2025-02-05', '2025-01-01', 3500000000.0000000000, 0.10),
(2025, 'KSM', 50.000000000000000, 20.000000000000000000000000000000, '2025-02-05', '2025-01-01', 3000000000.0000000000, 0.09),
(2025, 'ZEC', 100.000000000000000, 50.000000000000000000000000000000, '2025-02-05', '2025-01-01', 2500000000.0000000000, 0.07),
(2025, 'CHZ', 0.200000000000000, 0.100000000000000000000000000000, '2025-02-05', '2025-01-01', 2000000000.0000000000, 0.06),
(2025, 'HNT', 10.000000000000000, 5.000000000000000000000000000000, '2025-02-05', '2025-01-01', 1800000000.0000000000, 0.05),
(2025, 'OP', 3.000000000000000, 1.500000000000000000000000000000, '2025-02-05', '2025-01-01', 1600000000.0000000000, 0.05),
(2025, 'MKR', 2000.000000000000000, 1000.000000000000000000000000000000, '2025-02-05', '2025-01-01', 1400000000.0000000000, 0.04),
(2025, 'INJ', 50.000000000000000, 20.000000000000000000000000000000, '2025-02-05', '2025-01-01', 1200000000.0000000000, 0.03),
(2025, 'IMX', 3.000000000000000, 1.500000000000000000000000000000, '2025-02-05', '2025-01-01', 1000000000.0000000000, 0.03),
(2025, 'APT', 20.000000000000000, 10.000000000000000000000000000000, '2025-02-05', '2025-01-01', 900000000.0000000000, 0.03),
(2025, 'SEI', 1.000000000000000, 0.500000000000000000000000000000, '2025-02-05', '2025-01-01', 800000000.0000000000, 0.02),
(2025, 'LDO', 2.000000000000000, 1.000000000000000000000000000000, '2025-02-05', '2025-01-01', 700000000.0000000000, 0.02),
(2025, 'ONDO', 1.000000000000000, 0.500000000000000000000000000000, '2025-02-05', '2025-01-01', 600000000.0000000000, 0.02);*/

-- 2009: Bitcoin Genesis Block
INSERT INTO MARKET_DOMINANCE VALUES
(2009,'BTC',0.100000000000000,0.000100000000000000000000000000000,'2009-10-05','2009-01-03',
100000,100.00,0.0001,0.0001,0.0001);

-- 2010: Early Mining Era
INSERT INTO MARKET_DOMINANCE VALUES
(2010,'BTC',0.500000000000000,0.100000000000000000000000000000,'2010-07-17','2010-01-01',
1000000,100.00,0.012,0.005,0.008);

-- 2011: First Altcoin (Litecoin)
INSERT INTO MARKET_DOMINANCE VALUES
(2011,'BTC',31.900000000000000,0.300000000000000000000000000000,'2011-06-08','2011-01-01',
50000000,98.04,2.5,0.3,0.36),
(2011,'LTC',0.050000000000000,0.010000000000000000000000000000,'2011-10-07','2011-10-07',
500000,0.98,0.01,0.005,0.006);

-- 2012: Market Infrastructure Development
INSERT INTO MARKET_DOMINANCE VALUES
(2012,'BTC',13.700000000000000,4.200000000000000000000000000000,'2012-04-01','2012-06-01',
100000000,95.24,5.2,1.1,1.32),
(2012,'LTC',0.100000000000000,0.020000000000000000000000000000,'2012-12-31','2012-01-01',
2000000,1.90,0.15,0.08,0.096);

-- 2013: First Retail Boom
INSERT INTO MARKET_DOMINANCE VALUES
(2013,'BTC',1157.000000000000000,13.300000000000000000000000000000,'2013-12-04','2013-01-01',
14000000000,93.33,12.8,3.5,4.2),
(2013,'XRP',0.060000000000000,0.005800000000000000000000000000,'2013-12-31','2013-01-01',
2000000000,1.33,1.2,0.4,0.48),
(2013,'LTC',31.500000000000000,1.400000000000000000000000000000,'2013-11-28','2013-01-01',
1000000000,0.67,0.8,0.25,0.3);

-- 2014: Post-MtGox Recovery
INSERT INTO MARKET_DOMINANCE VALUES
(2014,'BTC',1000.000000000000000,300.000000000000000000000000000000,'2014-01-01','2014-12-31',
5130000000,85.50,18.3,4.8,5.76),
(2014,'XRP',0.024000000000000,0.002800000000000000000000000000,'2014-12-31','2014-01-01',
346220000,5.77,2.1,0.7,0.84),
(2014,'LTC',24.000000000000000,2.000000000000000000000000000000,'2014-01-01','2014-12-31',
122630000,2.04,1.1,0.3,0.36),
(2014,'DOGE',0.000400000000000,0.000100000000000000000000000000000,'2014-01-01','2014-12-31',
5000000,0.08,0.15,0.05,0.06);

-- 2015: Ethereum Launch
INSERT INTO MARKET_DOMINANCE VALUES
(2015,'BTC',500.000000000000000,200.000000000000000000000000000000,'2015-01-01','2015-12-31',
7000000000,87.50,23.4,5.6,6.72),
(2015,'ETH',1.300000000000000,0.400000000000000000000000000000,'2015-08-07','2015-12-31',
65980000,0.82,0.8,0.2,0.24),
(2015,'XRP',0.014000000000000,0.003800000000000000000000000000,'2015-12-31','2015-01-01',
100000000,1.25,1.5,0.5,0.6),
(2015,'LTC',8.000000000000000,1.200000000000000000000000000000,'2015-07-09','2015-01-01',
150000000,1.88,0.9,0.25,0.3),
(2015,'DOGE',0.000200000000000,0.000100000000000000000000000000000,'2015-01-01','2015-12-31',
10000000,0.13,0.25,0.08,0.096);

-- 2016: DAO Hack & Recovery
INSERT INTO MARKET_DOMINANCE VALUES
(2016,'BTC',900.000000000000000,350.000000000000000000000000000000,'2016-12-31','2016-01-01',
14000000000,87.50,35.6,7.2,8.64),
(2016,'ETH',21.500000000000000,1.000000000000000000000000000000,'2016-06-16','2016-01-01',
7200000000,45.00,4.8,1.5,1.8),
(2016,'XRP',0.008900000000000,0.004400000000000000000000000000,'2016-12-31','2016-01-01',
1960000000,12.25,3.2,0.9,1.08),
(2016,'LTC',6.000000000000000,3.000000000000000000000000000000,'2016-06-16','2016-01-01',
200000000,1.25,1.1,0.3,0.36),
(2016,'XMR',2.500000000000000,0.500000000000000000000000000000,'2016-12-31','2016-01-01',
50000000,0.31,0.4,0.1,0.12);

-- ... [Continued through 2025 following same pattern]

-- 2025: Mature Market Projections
INSERT INTO MARKET_DOMINANCE VALUES
(2025,'BTC',97973.340000000000000,60000.000000000000000000000000000000,'2025-02-05','2025-01-01',
1940000000000,55.43,450.2,350.5,420.6),
(2025,'ETH',2800.000000000000000,2000.000000000000000000000000000000,'2025-02-05','2025-01-01',
327400000000,9.35,890.7,220.3,264.4),
(2025,'SOL',200.000000000000000,100.000000000000000000000000000000,'2025-02-05','2025-01-01',
90000000000,2.57,680.4,95.2,114.2),
(2025,'XRP',2.500000000000000,1.500000000000000000000000000000,'2025-02-05','2025-01-01',
144200000000,4.12,320.5,85.3,102.4),
(2025,'USDT',1.010000000000000,0.990000000000000000000000000000,'2025-01-01','2025-01-01',
140400000000,4.01,2450.8,180.5,216.6);
# MARKET_DOMINANCE DATA END

# REWARD_DETAILS DATA START
INSERT INTO REWARD_DETAILS (
    SYMBOL, EMISSION_TYPE, EMISSION_TIME,
    STARTING_TIME_BLOCK_REWARD, CURRENT_BLOCK_REWARD, BLOCK_REWARD_TIME
) VALUES
-- Halving-Based Emission (PoW)
('BTC', 'HALVING', 35040, 50.00000, 6.25000, 10.000000000000000000000000000000), -- Bitcoin (4-year halving)
('BCH', 'HALVING', 35040, 12.50000, 6.25000, 10.000000000000000000000000000000), -- Bitcoin Cash
('LTC', 'HALVING', 35040, 50.00000, 12.50000, 2.500000000000000000000000000000), -- Litecoin (2.5min blocks)
('ZEC', 'HALVING', 35040, 12.50000, 3.12500, 2.500000000000000000000000000000), -- Zcash
('ETC', 'HALVING', 35040, 5.00000, 2.56000, 13.000000000000000000000000000000), -- Ethereum Classic

-- Tail Emission (Fixed Post-Halving)
('XMR', 'TAIL EMISSION', 71112, 15.00000, 0.60000, 2.000000000000000000000000000000), -- Monero (tail since 2022)
('DOGE', 'TAIL EMISSION', 17520, 1000000.00000, 10000.00000, 1.000000000000000000000000000000), -- Dogecoin (fixed since 2015)

-- Linear Emission (PoS/Governance)
('ETH', 'LINEAR EMISSION', 87600, 2.00000, 0.56000, 0.200000000000000000000000000000), -- Ethereum (PoS ~12s blocks)
('BNB', 'LINEAR EMISSION', 0, 10.00000, 3.10000, 0.333000000000000000000000000000), -- BNB Chain (PoSA)
('ADA', 'LINEAR EMISSION', 262800, 20.00000, 4.60000, 0.333000000000000000000000000000), -- Cardano (~20s epochs)
('SOL', 'LINEAR EMISSION', 87600, 10.00000, 2.50000, 0.006700000000000000000000000000), -- Solana (400ms blocks)
('DOT', 'LINEAR EMISSION', 262800, 20.00000, 5.00000, 6.000000000000000000000000000000), -- Polkadot

-- Stablecoins/Non-Emission Tokens (Placeholder Values)
('USDT', 'TAIL EMISSION', 0, 0.00000, 0.00000, 0.000000000000000000000000000000), -- Tether
('USDC', 'TAIL EMISSION', 0, 0.00000, 0.00000, 0.000000000000000000000000000000), -- USD Coin
('DAI', 'TAIL EMISSION', 0, 0.00000, 0.00000, 0.000000000000000000000000000000), -- Dai
('XRP', 'TAIL EMISSION', 0, 0.00000, 0.00000, 3.500000000000000000000000000000), -- XRP (pre-mined)

-- Other Chains (Assumed Linear/Tail)
('AVAX', 'LINEAR EMISSION', 87600, 5.00000, 2.00000, 2.000000000000000000000000000000), -- Avalanche
('TRX', 'LINEAR EMISSION', 0, 32.00000, 16.00000, 3.000000000000000000000000000000), -- TRON
('SHIB', 'TAIL EMISSION', 0, 0.00000, 0.00000, 0.000000000000000000000000000000), -- Shiba Inu (ERC-20)
('MATIC', 'LINEAR EMISSION', 0, 5.00000, 2.00000, 2.100000000000000000000000000000), -- Polygon
('LINK', 'LINEAR EMISSION', 0, 10.00000, 5.00000, 0.300000000000000000000000000000); -- Chainlink

-- ... (Continue for remaining 25 entries with similar logic)

-- Continued from previous 25 entries...
INSERT INTO REWARD_DETAILS (SYMBOL, EMISSION_TYPE, EMISSION_TIME, STARTING_TIME_BLOCK_REWARD, CURRENT_BLOCK_REWARD, BLOCK_REWARD_TIME)  VALUES
('FTM', 'LINEAR EMISSION', 87600, 50.00000, 12.50000, 1.000000000000000000000000000000), -- Fantom (Lachesis aBFT)
('GRT', 'TAIL EMISSION', 0, 0.00000, 0.00000, 0.000000000000000000000000000000),         -- The Graph (ERC-20, no block rewards)
('ALGO', 'LINEAR EMISSION', 262800, 10.00000, 2.50000, 4.500000000000000000000000000000), -- Algorand (Pure PoS)
('VET', 'LINEAR EMISSION', 0, 100.00000, 50.00000, 10.000000000000000000000000000000),    -- VeChain (PoA)
('XTZ', 'LINEAR EMISSION', 87600, 40.00000, 10.00000, 1.000000000000000000000000000000),  -- Tezos (Liquid PoS)
('SAND', 'TAIL EMISSION', 0, 0.00000, 0.00000, 0.000000000000000000000000000000),         -- The Sandbox (ERC-20)
('MANA', 'TAIL EMISSION', 0, 0.00000, 0.00000, 0.000000000000000000000000000000),         -- Decentraland (ERC-20)
('AXS', 'LINEAR EMISSION', 262800, 20.00000, 5.00000, 0.500000000000000000000000000000),  -- Axie Infinity (Ronin sidechain)
('AAVE', 'TAIL EMISSION', 0, 0.00000, 0.00000, 0.000000000000000000000000000000),         -- Aave (Governance token)
('KSM', 'HALVING', 35040, 10.00000, 2.50000, 6.000000000000000000000000000000),           -- Kusama (Polkadot cousin)
('CHZ', 'LINEAR EMISSION', 0, 1000.00000, 200.00000, 5.000000000000000000000000000000),   -- Chiliz (PoA)
('HNT', 'TAIL EMISSION', 0, 0.00000, 0.00000, 0.000000000000000000000000000000),          -- Helium (migrated to Solana)
('OP', 'TAIL EMISSION', 0, 0.00000, 0.00000, 0.000000000000000000000000000000),           -- Optimism (Layer-2 governance)
('MKR', 'TAIL EMISSION', 0, 0.00000, 0.00000, 0.000000000000000000000000000000),          -- MakerDAO (Governance token)
('INJ', 'LINEAR EMISSION', 262800, 20.00000, 5.00000, 1.000000000000000000000000000000),  -- Injective (Tendermint BFT)
('IMX', 'TAIL EMISSION', 0, 0.00000, 0.00000, 0.000000000000000000000000000000),          -- Immutable X (zkEVM Layer-2)
('APT', 'LINEAR EMISSION', 87600, 10.00000, 3.00000, 0.500000000000000000000000000000),   -- Aptos (PoS)
('SEI', 'LINEAR EMISSION', 262800, 15.00000, 4.00000, 0.300000000000000000000000000000),  -- Sei (Tendermint BFT)
('LDO', 'TAIL EMISSION', 0, 0.00000, 0.00000, 0.000000000000000000000000000000),          -- Lido DAO (Governance token)
('ONDO', 'TAIL EMISSION', 0, 0.00000, 0.00000, 0.000000000000000000000000000000),         -- Ondo (RWA tokenization)
('FET', 'LINEAR EMISSION', 87600, 5.00000, 1.50000, 0.200000000000000000000000000000),    -- Fetch.ai (AI PoS)
('HBAR', 'TAIL EMISSION', 0, 0.00000, 0.00000, 0.000000000000000000000000000000),         -- Hedera (Fixed supply)
('CRO', 'LINEAR EMISSION', 0, 20.00000, 5.00000, 5.000000000000000000000000000000),       -- Cronos (PoS)
('ARB', 'TAIL EMISSION', 0, 0.00000, 0.00000, 0.000000000000000000000000000000),          -- Arbitrum (Layer-2)
('FIL', 'LINEAR EMISSION', 262800, 15.00000, 5.00000, 0.500000000000000000000000000000);  -- Filecoin (Storage-based)
# REWARD_DETAILS DATA END

INSERT INTO BLOCK_REWARD_EMISSION (SYMBOL, YEAR, DATE, BLOCK_REWARD, HALVING_YEAR_MARKET_PRICE, HALVING_YEAR_MARKET_CAP, NETWORK_HASH_RATE) VALUES
('BTC', 2012, '2012-11-28', 25.00000000, 13.00, 136.5, 0.0000028),
('BTC', 2016, '2016-07-09', 12.50000000, 650.00, 10237.5, 2.5),
('BTC', 2020, '2020-05-11', 6.25, 8700.00, 160280.0, 110.0),
('BTC', 2024, '2024-04-20', 3.125, 64000.00, 1256000.0, 560.0),
('LTC', 2015, '2015-08-25', 25.00000000, 2.57, 107.94, 0.000000015),
('LTC', 2019, '2019-08-05', 12.50000000, 80.70, 5084.1, 0.00035),
('LTC', 2023, '2023-08-02', 6.25, 75.00, 5512.5, 0.085);

INSERT INTO BLOCK_REWARD_EMISSION (SYMBOL, YEAR, DATE, BLOCK_REWARD, HALVING_YEAR_MARKET_PRICE, HALVING_YEAR_MARKET_CAP, NETWORK_HASH_RATE) VALUES
('BCH', 2020, '2020-04-08', 6.25, 240.00, 4380000000.00, 1500000000000000000.00),
('BCH', 2024, '2024-04-04', 3.125, 370.93, 7178000000.00, 3500000000000000000.00),
('XMR', 2022, '2022-05-31', 0.6, 226.00, 3899500000.00, 2500000000.00);


INSERT INTO HFT_AMF_FIRMS (COMPANY_NAME, HEAD_QUARTER, ESTABLISHED_YEAR, WORK_TYPE, FAMOUS_FOR) VALUES
('BlackRock', 'New York, USA', 1988, 'Asset Management', 'Largest asset manager globally; iShares ETF'),

('Fidelity', 'Boston, USA', 1946, 'Asset Management', 'Early institutional crypto adopter; Fidelity Digital Assets'),

('Grayscale', 'Stamford, USA', 2013, 'Digital Asset Management', 'Grayscale Bitcoin Trust (GBTC); Crypto investment pioneer'),

('ProShares', 'Bethesda, USA', 2006, 'ETF Provider', 'Launched first U.S. Bitcoin Futures ETF (BITO)'),

('VanEck', 'New York, USA', 1955, 'Asset & ETF Management', 'Crypto & Gold ETFs; XBTF Futures ETF'),

('ARK Invest', 'St. Petersburg, USA', 2014, 'Active Asset Management', 'Disruptive innovation; Cathie Wood-led crypto investments'),

('21Shares', 'Zurich, Switzerland', 2018, 'Crypto ETP Provider', 'World’s first crypto ETPs listed in Europe'),

('Franklin Templeton', 'San Mateo, USA', 1947, 'Asset Management', 'Entered crypto ETF space in 2024'),

('Bitwise', 'San Francisco, USA', 2017, 'Crypto Asset Management', 'Index-based crypto funds; Spot Bitcoin ETF (BITB)'),

('Virtu Financial', 'New York, USA', 2008, 'High-Frequency Trading (HFT)', 'Global market maker; algorithmic trading'),

('Jane Street', 'New York, USA', 2000, 'High-Frequency Trading (HFT)', 'Major ETF liquidity provider; active in crypto market'),

('Jump Trading', 'Chicago, USA', 1999, 'Proprietary Trading & HFT', 'Deep in crypto market making; Jump Crypto');



INSERT INTO CRYPTO_ETF
(ETF_NAME, ETF_CODE, COMPANY_NAME, LAUNCH_DATE, YEAR, TOTAL_AUM_UNDER_ETF, CRYPTO_SYMBOL, ETF_INVESTMENT_TYPE, EXPENSE_RATIO)
VALUES
('iShares Bitcoin Trust', 'IBIT', 'BlackRock', '2024-01-11', 2024, 56.70000000000000000000, 'BTC', 'Spot', 0.12000),

('Fidelity Wise Origin Bitcoin Fund', 'FBTC', 'Fidelity', '2024-01-11', 2024, 18.90000000000000000000, 'BTC', 'Spot', 0.25000),

('Grayscale Bitcoin Trust ETF', 'GBTC', 'Grayscale', '2024-01-11', 2024, 18.10000000000000000000, 'BTC', 'Spot (Converted)', 1.50000),

('ProShares Bitcoin Strategy ETF', 'BITO', 'ProShares', '2021-10-19', 2021, 1.70000000000000000000, 'BTC', 'Futures', 0.95000),

('VanEck Bitcoin Strategy ETF', 'XBTF', 'VanEck', '2021-11-15', 2021, 0.70000000000000000000, 'BTC', 'Futures', 0.65000);


insert into BROKERAGE (NAME, HEADQUARTER, ESTABLISHED_YEAR, OWN_CRYPTO_CURRENCY, FOUNDER_NAME) VALUES
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

insert into BROKERAGE (NAME, HEADQUARTER, ESTABLISHED_YEAR, OWN_CRYPTO_CURRENCY, FOUNDER_NAME)
values ('Mt. Gox','Shibuya, Tokyo, Japan',2010,null,'Jed McCaleb');

INSERT INTO BROKERAGE (name, HEADQUARTER, established_year, own_crypto_currency, founder_name)
VALUES
('Mt. Gox', 'Shibuya, Tokyo, Japan', 2010, NULL, 'Jed McCaleb');

INSERT INTO BROKERAGE (name, HEADQUARTER, established_year, own_crypto_currency, founder_name)
VALUES
('WazirX', 'Mumbai, India', 2018, 'WRX', 'Nischal Shetty'),
('NiceHash', 'Ljubljana, Slovenia', 2014, NULL, 'Matjaž Škorjanc, Marko Kobal'),
('FTX', 'Nassau, Bahamas', 2019, 'FTT', 'Sam Bankman-Fried');


INSERT INTO TOP_BROKERAGE (YEAR, BROKERAGE_NAME, TOTAL_MARKET_CAP, MARKET_SHARE, TOTAL_USER) VALUES
(2011, 'MT. GOX', 0.00000, 70.00000, 0.01000),
(2012, 'MT. GOX', 0.00000, 80.00000, 0.05000),
(2012, 'BITSTAMP', 0.00000, 10.00000, 0.01000),
(2013, 'MT. GOX', 0.00000, 60.00000, 0.10000),
(2013, 'BITSTAMP', 0.00000, 15.00000, 0.02000),
(2013, 'COINBASE', 0.00000, 5.00000, 0.10000),
(2014, 'BITSTAMP', 0.00000, 20.00000, 0.20000),
(2014, 'COINBASE', 0.00000, 10.00000, 0.50000),
(2014, 'KRAKEN', 0.00000, 5.00000, 0.10000),
(2014, 'BITFINEX', 0.00000, 5.00000, 0.05000),
(2015, 'COINBASE', 0.40000, 15.00000, 1.00000),
(2015, 'BITSTAMP', 0.00000, 10.00000, 0.30000),
(2015, 'KRAKEN', 0.00000, 5.00000, 0.20000),
(2015, 'BITFINEX', 0.00000, 5.00000, 0.10000),
(2016, 'COINBASE', 1.00000, 20.00000, 2.00000),
(2016, 'BITFINEX', 0.00000, 15.00000, 0.50000),
(2016, 'KRAKEN', 0.00000, 5.00000, 0.30000),
(2016, 'BITSTAMP', 0.00000, 5.00000, 0.20000),
(2017, 'COINBASE', 1.60000, 25.00000, 10.00000),
(2017, 'BINANCE', 0.00000, 20.00000, 5.00000),
(2017, 'BITFINEX', 0.00000, 10.00000, 1.00000),
(2017, 'KRAKEN', 0.00000, 5.00000, 0.50000),
(2017, 'BITSTAMP', 0.00000, 5.00000, 0.30000),
(2018, 'COINBASE', 8.00000, 20.00000, 13.00000),
(2018, 'BINANCE', 0.00000, 30.00000, 10.00000),
(2018, 'ROBINHOOD', 7.00000, 5.00000, 15.00000),
(2018, 'KRAKEN', 0.00000, 5.00000, 1.00000),
(2018, 'BITFINEX', 0.00000, 5.00000, 0.50000),
(2019, 'COINBASE', 8.00000, 20.00000, 15.00000),
(2019, 'BINANCE', 0.00000, 35.00000, 15.00000),
(2019, 'ROBINHOOD', 8.00000, 5.00000, 18.00000),
(2019, 'KRAKEN', 0.00000, 5.00000, 2.00000),
(2019, 'GEMINI', 0.00000, 3.00000, 0.50000),
(2020, 'COINBASE', 8.00000, 20.00000, 35.00000),
(2020, 'BINANCE', 0.00000, 35.00000, 20.00000),
(2020, 'ROBINHOOD', 11.00000, 5.00000, 20.00000),
(2020, 'KRAKEN', 0.00000, 5.00000, 3.00000),
(2020, 'GEMINI', 0.00000, 3.00000, 1.00000),
(2021, 'COINBASE', 60.00000, 15.00000, 73.00000),
(2021, 'ROBINHOOD', 30.00000, 5.00000, 23.00000),
(2021, 'BINANCE', 0.00000, 34.70000, 30.00000),
(2021, 'KRAKEN', 0.00000, 5.00000, 6.00000),
(2021, 'GEMINI', 0.00000, 3.00000, 2.00000),
(2022, 'COINBASE', 20.00000, 10.00000, 108.00000),
(2022, 'ROBINHOOD', 10.00000, 3.00000, 24.00000),
(2022, 'BINANCE', 0.00000, 35.00000, 35.00000),
(2022, 'KRAKEN', 0.00000, 5.00000, 8.00000),
(2022, 'CRYPTO.COM', 0.00000, 10.00000, 10.00000),
(2023, 'COINBASE', 35.00000, 10.00000, 110.00000),
(2023, 'ROBINHOOD', 12.00000, 3.00000, 25.00000),
(2023, 'BINANCE', 0.00000, 34.70000, 40.00000),
(2023, 'KRAKEN', 0.00000, 5.00000, 9.00000),
(2023, 'CRYPTO.COM', 0.00000, 11.20000, 12.00000),
(2024, 'COINBASE', 50.00000, 10.00000, 112.00000),
(2024, 'ROBINHOOD', 15.00000, 3.00000, 25.60000),
(2024, 'BINANCE', 0.00000, 34.70000, 45.00000),
(2024, 'CRYPTO.COM', 0.00000, 11.20000, 15.00000),
(2024, 'KRAKEN', 0.00000, 5.00000, 10.00000),
(2025, 'COINBASE', 71.20000, 10.00000, 115.00000),
(2025, 'ROBINHOOD', 20.00000, 3.00000, 26.00000),
(2025, 'BINANCE', 0.00000, 34.70000, 50.00000),
(2025, 'CRYPTO.COM', 0.00000, 11.20000, 15.00000),
(2025, 'KRAKEN', 0.00000, 5.00000, 10.00000);


INSERT INTO CONTROVERSY (YEAR, BROKERAGE_NAME, AFFECTED_CRYPTO, AFFECTED_AMOUNT_IN_BILLION, CONTROVERSY_DETAIL) VALUES
(2015, 'BITSTAMP', 'BTC', 0.005, 'HACKED, LOST ~19,000 BTC. SUSPENDED OPERATIONS FOR DAYS DUE TO PHISHING ATTACK TARGETING EMPLOYEES.'),
(2017, 'NICEHASH', 'BTC', 0.064, 'HACKED, LOST 4,700 BTC FROM HOT WALLET; REPAID USERS BY 2020.'),
(2020, 'KUCOIN', 'BTC', 0.281, 'HACKED, LOST $281M IN CRYPTO. RECOVERED MOST FUNDS BUT RAISED SECURITY CONCERNS.'),
(2021, 'ROBINHOOD', 'DOGE', NULL, 'RESTRICTED CRYPTO/STOCK TRADES (E.G., DOGECOIN, GAMESTOP) DUE TO CLEARINGHOUSE ISSUES, SPARKING MANIPULATION CLAIMS.'),
(2022, 'COINBASE', 'ETH', NULL, 'SUPER BOWL AD QR CODE CRASHED SITE, OVERWHELMING SERVERS WITH TRAFFIC.'),
(2022, 'FTX', 'SOL', 8.000, 'COLLAPSED AFTER $8B FRAUD; ALAMEDA MISUSED CUSTOMER FUNDS, TRIGGERING $6B WITHDRAWALS.'),
(2023, 'COINBASE', 'BTC', NULL, 'SEC SUED FOR UNREGISTERED SECURITIES EXCHANGE, TARGETING TOKENS LIKE ADA, SOL.'),
(2023, 'BINANCE', 'BNB', NULL, 'SEC SUED FOR UNREGISTERED EXCHANGE, OFFERING BNB, BUSD AS SECURITIES.'),
(2023, 'KRAKEN', 'BTC', NULL, 'SEC ALLEGED UNREGISTERED EXCHANGE OPERATIONS, TARGETING STAKING SERVICES.'),
(2023, 'BYBIT', 'BTC', 0.00106, 'INDIA FIU FINED $1.06M FOR PMLA VIOLATIONS; BYBIT PAID AND REGISTERED IN 2025.'),
(2023, 'BYBIT', 'SOL', 0.228, 'FTX SUED BYBIT FOR $1B OVER PRIORITIZED WITHDRAWALS; SETTLED FOR $228M IN 2024.'),
(2023, 'FTX', 'SOL', 8.000, 'SBF CONVICTED OF FRAUD, CONSPIRACY; SENTENCED TO 25 YEARS FOR $8B THEFT.'),
(2024, 'CRYPTO.COM', 'BTC', NULL, 'SUED SEC AFTER WELLS NOTICE, CHALLENGING JURISDICTION OVER TOKEN SALES.'),
(2024, 'ETORO', 'BTC', NULL, 'SETTLED WITH SEC, CEASED MOST U.S. CRYPTO TRADING FOR UNREGISTERED BROKER VIOLATIONS.'),
(2024, 'INTERACTIVE BROKERS', 'BTC', 0.048, '$48M LOSS FROM NYSE GLITCH AFFECTING TRADES, EXPOSING PLATFORM VULNERABILITIES.'),
(2024, 'WAZIRX', 'ETH', 0.2349, 'HACKED, LOST $234.9M TO LAZARUS GROUP VIA MULTISIG WALLET; HALTED TRADING.'),
(2024, 'WAZIRX', 'ETH', NULL, 'USER POLL FOR 55% FUND ACCESS SPARKED BACKLASH AS UNFAIR SOCIALIZED LOSS.'),
(2025, 'BYBIT', 'ETH', 1.5, 'HACKED, LOST $1.5B WORTH OF ETH TO LAZARUS GROUP VIA SAFE{WALLET} FLAW; RESERVES REPLENISHED.'),
(2025, 'BYBIT', 'SOL', NULL, 'AIRDROP DELAYS FOR $PAWS, $NOT, $MAJOR TOKENS CAUSED USER COMPLAINTS.'),
(2025, 'FTX', 'BTC', 16.000, 'REPAID $16B TO CREDITORS USING 2022 PRICES, ANGERING BITCOIN/SOLANA HOLDERS.'),
(2025, 'WAZIRX', 'BTC', NULL, 'REGULATORY SCRUTINY; DELHI HC SOUGHT RBI PROBE AFTER $234.9M HACK.'),
(2025, 'NICEHASH', 'ETH', NULL, 'USERS REPORTED ETH TRANSFER DELAYS TO WAZIRX AND HIGH BTC WITHDRAWAL FEES.');



# ACCEPTED_COUNTRYWISE_MOST_USED_CRYPTO DATA END
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

INSERT INTO COUNTRY (COUNTRY_CODE, COUNTRY_NAME, CRYPTO_STATUS, EDUCATION_PERCENTAGE, UNEMPLOYMENT_RATE, GDP) VALUES
('BTN', 'Bhutan', 'RESTRICTED', 66.6, 5.0, 2.5000000000);
INSERT INTO COUNTRY (COUNTRY_CODE, COUNTRY_NAME, CRYPTO_STATUS, EDUCATION_PERCENTAGE, UNEMPLOYMENT_RATE, GDP) VALUES
('IND', 'India', 'RESTRICTED', 77.7, 7.8, 3400.0000000000);
INSERT INTO COUNTRY (COUNTRY_CODE, COUNTRY_NAME, CRYPTO_STATUS, EDUCATION_PERCENTAGE, UNEMPLOYMENT_RATE, GDP) VALUES
('SVN', 'Slovenia', 'ACCEPTED', 98.5, 4.5, 68.0000000000)
,('SYC', 'Seychelles', 'ACCEPTED', 95.5, 3.0, 2.0000000000),
 ('IRL', 'Ireland', 'ACCEPTED', 99.0, 4.8, 589.0000000000),
 ('CYM', 'Cayman Islands', 'ACCEPTED', 98.0, 3.3, 6.8000000000),
 ('HKG', 'Hong Kong', 'ACCEPTED', 94.0, 3.3, 368.0000000000),  -- Special Administrative Region of China
('LUX', 'Luxembourg', 'ACCEPTED', 99.0, 4.8, 89.0000000000),   -- EU member with crypto-friendly laws
('ARE', 'United Arab Emirates', 'ACCEPTED', 98.0, 3.4, 500.0000000000),  -- Dubai's VARA regulations
('CYP', 'Cyprus', 'ACCEPTED', 97.5, 6.8, 28.0000000000),       -- EU member with crypto tax incentives
# ('SGP', 'Singapore', 'ACCEPTED', 97.0, 2.1, 466.0000000000),   -- MAS-regulated framework
('ISR', 'Israel', 'ACCEPTED', 97.0, 3.6, 520.0000000000),      -- Crypto taxed but not banned
('BHS', 'Bahamas', 'ACCEPTED', 95.0, 10.1, 13.0000000000)
 ;
                                                                                                                  ;
# ACCEPTED COUNTRY DATA START
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
# ACCEPTED COUNTRY DATA END

# BANNED COUNTRY DATA START
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
# BANNED COUNTRY DATA END

# ACCEPTED_COUNTRYWISE_MOST_USED_CRYPTO DATA END
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

# USER_AMOUNT_IN_BANNED_COUNTRY DATA START

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
# ...
('2020', 'NPL', 0.20000000000000000000), -- Pre-ban growth
('2021', 'NPL', 0.05000000000000000000), -- Ban enforced
('2022', 'NPL', 0.03000000000000000000),
('2023', 'NPL', 0.02000000000000000000),
('2024', 'NPL', 0.01500000000000000000),

-- Egypt (Banned 2018)
('2008', 'EGY', 0.00001000000000000000),
# ...
('2017', 'EGY', 0.60000000000000000000), -- Peak pre-ban
('2018', 'EGY', 0.25000000000000000000), -- Islamic law ban
('2019', 'EGY', 0.15000000000000000000),
('2024', 'EGY', 0.05000000000000000000),

-- Iraq (Banned 2017)
('2008', 'IRQ', 0.00000100000000000000),
# ...
('2016', 'IRQ', 0.30000000000000000000),
('2017', 'IRQ', 0.10000000000000000000), -- Ban enforced
('2024', 'IRQ', 0.05000000000000000000),

-- Morocco (Banned 2017)
('2008', 'MAR', 0.00010000000000000000),
# ...
('2016', 'MAR', 0.50000000000000000000),
('2017', 'MAR', 0.20000000000000000000), -- Ban enforced
('2024', 'MAR', 0.30000000000000000000), -- Anticipation of legalization

-- Qatar (Banned 2018)
('2008', 'QAT', 0.00000100000000000000),
# ...
('2017', 'QAT', 0.08000000000000000000),
('2018', 'QAT', 0.01000000000000000000), -- Strict ban
('2024', 'QAT', 0.00200000000000000000),

-- Tunisia (Banned 2018)
('2008', 'TUN', 0.00000100000000000000),
# ...
('2017', 'TUN', 0.10000000000000000000),
('2018', 'TUN', 0.04000000000000000000), -- Post-ban
('2024', 'TUN', 0.02000000000000000000),

-- Afghanistan (Banned 2022)
('2008', 'AFG', 0.00000010000000000000),
# ...
('2021', 'AFG', 0.03000000000000000000), -- Pre-Taliban peak
('2022', 'AFG', 0.00500000000000000000), -- Taliban ban
('2023', 'AFG', 0.00200000000000000000),
('2024', 'AFG', 0.00100000000000000000);

# USER_AMOUNT_IN_BANNED_COUNTRY DATA END


SELECT * FROM BLOCKCHAIN_ACCESS_TYPE;
SELECT * FROM BLOCKCHAIN_NETWORK_TYPE;
SELECT * FROM CONSENSUS_ALGORITHM_TYPE;
SELECT NAME FROM HASH_ALGO_NAME;
SELECT * FROM CRYPTO_CURRENCY_PERFORMANCE_METRICS WHERE CRYPTO_CURRENCY_PERFORMANCE_METRICS.AVERAGE_TRX_FEE>=1 ORDER BY AVERAGE_TRX_FEE ASC;
SELECT * FROM TOTAL_USER_DISTRIBUTION;
WITH TMP AS (SELECT SYMBOL,MAX_PRICE,MIN_PRICE,MAX_PRICE_DATE,MIN_PRICE_DATE,(MAX_PRICE-MIN_PRICE)*100/MIN_PRICE AS MAX_RETURN FROM CRYPTO ORDER BY CIRCULATING_SUPPLY DESC)
SELECT *,TMP.MAX_RETURN FROM TMP WHERE SYMBOL='XMR' ;

SELECT SYMBOL,DOMINANCE FROM MARKET_DOMINANCE WHERE YEAR=2025 ORDER BY DOMINANCE DESC ;


SELECT * FROM CRYPTO WHERE CONSENSUS_ALGORITHM_TYPE='PoS';


SELECT LENGTH('1840445685000.00000');

CREATE TABLE Test(
    VAR FLOAT
);
DROP TABLE Test;
INSERT INTO Test VALUES (1840445685000.00005);
SELECT * FROM Test;
SELECT * FROM TOP_BROKERAGE;

SELECT UPPER('create table Controversy(
    year year,
    id int auto_increment,
    brokerage_name varchar(200),
    controversy_detail varchar(400),
    affected_crypto varchar(10),
    constraint Controversy_pk primary key (id),
    constraint Controversy_fk foreign key (brokerage_name) references Brokerage(name),
    constraint Controversy_fk2 foreign key (affected_crypto) references AllCrypto(symbol)
);');


# QUERY FOR THIS BROKERAGE WHOSE HEADQUARTER IN THIS KIND OF COUNTRY WHERE CRYPTO IS ACCEPTED
SELECT BROKERAGE.NAME,BROKERAGE.HEADQUARTER,COUNTRY.CRYPTO_STATUS FROM BROKERAGE JOIN COUNTRY WHERE COUNTRY.CRYPTO_STATUS='ACCEPTED' AND BROKERAGE.HEADQUARTER LIKE
                                                                                                     CONCAT('%',COUNTRY.COUNTRY_NAME,'%');