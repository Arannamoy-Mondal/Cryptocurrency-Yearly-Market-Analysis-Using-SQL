CREATE DATABASE CRYPTO_MARKET_ANALYSIS_PROJECT_DATABASE;


USE CRYPTO_MARKET_ANALYSIS_PROJECT_DATABASE;


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
    ELECTRICITY_COST_PER_TRANSACTION DECIMAL(65,15),
    HEAT_IMMERSION_PER_TX DECIMAL(65,2),
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
  CHECK ( DOMINANCE<=100 ),
  CONSTRAINT MARKET_DOMINANCE_SYSMBOL_FK1 FOREIGN KEY (SYMBOL) REFERENCES CRYPTO(SYMBOL),
  CONSTRAINT MARKET_DOMINANCE_PK PRIMARY KEY (SYMBOL,YEAR),
  CONSTRAINT MARKETDOMINANCE_YEAR_FK1 FOREIGN KEY (YEAR) REFERENCES TOTAL_USER_DISTRIBUTION(YEAR)
);

DROP TABLE MARKET_DOMINANCE;
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
                                                , ELECTRICITY_COST_PER_TRANSACTION, HEAT_IMMERSION_PER_TX,
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
(2025, 'ONDO', 1.000000000000000, 0.500000000000000000000000000000, '2025-02-05', '2025-01-01', 600000000.0000000000, 0.02);
# MARKET_DOMINANCE DATA END


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


SELECT UPPER('INSERT INTO MarketDominance (year, symbol, total_value, dominance) VALUES
(2009, ''BTC'', 0.00001, 100.00),
(2010, ''BTC'', 0.001, 100.00),
(2011, ''BTC'', 0.01, 100.00),
(2012, ''BTC'', 0.1, 95.00),
(2013, ''BTC'', 1.2, 80.00),
(2013, ''DOGE'', 0.001, 0.07),
(2014, ''BTC'', 4.0, 80.00),
(2014, ''DOGE'', 0.02, 0.40),
(2014, ''USDT'', 0.01, 0.20),
(2014, ''XMR'', 0.01, 0.20),
(2015, ''BTC'', 5.0, 71.43),
(2015, ''ETH'', 0.7, 10.00),
(2015, ''DOGE'', 0.02, 0.29),
(2015, ''USDT'', 0.02, 0.29),
(2015, ''XMR'', 0.01, 0.14),
(2016, ''BTC'', 12.0, 70.59),
(2016, ''ETH'', 1.5, 8.82),
(2016, ''DOGE'', 0.03, 0.18),
(2016, ''USDT'', 0.05, 0.29),
(2016, ''XMR'', 0.1, 0.59),
(2017, ''BTC'', 320.0, 53.33),
(2017, ''ETH'', 70.0, 11.67),
(2017, ''DOGE'', 0.2, 0.03),
(2017, ''USDT'', 1.0, 0.17),
(2017, ''XMR'', 2.0, 0.33),
(2018, ''BTC'', 70.0, 53.85),
(2018, ''ETH'', 15.0, 11.54),
(2018, ''DOGE'', 0.2, 0.15),
(2018, ''USDT'', 2.0, 1.54),
(2018, ''XMR'', 1.0, 0.77),
(2019, ''BTC'', 130.0, 54.17),
(2019, ''ETH'', 20.0, 8.33),
(2019, ''DOGE'', 0.3, 0.13),
(2019, ''USDT'', 4.0, 1.67),
(2019, ''XMR'', 1.5, 0.63),
(2020, ''BTC'', 500.0, 65.79),
(2020, ''ETH'', 80.0, 10.53),
(2020, ''DOGE'', 0.5, 0.07),
(2020, ''USDT'', 15.0, 1.97),
(2020, ''XMR'', 2.5, 0.33),
(2020, ''SOL'', 0.1, 0.01),
(2020, ''DOT'', 3.0, 0.39),
(2021, ''BTC'', 1300.0, 59.09),
(2021, ''ETH'', 400.0, 18.18),
(2021, ''DOGE'', 50.0, 2.27),
(2021, ''USDT'', 60.0, 2.73),
(2021, ''XMR'', 5.0, 0.23),
(2021, ''SOL'', 70.0, 3.18),
(2021, ''DOT'', 30.0, 1.36),
(2022, ''BTC'', 400.0, 50.00),
(2022, ''ETH'', 150.0, 18.75),
(2022, ''DOGE'', 10.0, 1.25),
(2022, ''USDT'', 65.0, 8.13),
(2022, ''XMR'', 2.0, 0.25),
(2022, ''SOL'', 15.0, 1.88),
(2022, ''DOT'', 5.0, 0.63),
(2023, ''BTC'', 1000.0, 58.82),
(2023, ''ETH'', 250.0, 14.71),
(2023, ''DOGE'', 15.0, 0.88),
(2023, ''USDT'', 90.0, 5.29),
(2023, ''XMR'', 3.0, 0.18),
(2023, ''SOL'', 50.0, 2.94),
(2023, ''DOT'', 7.0, 0.41),
(2024, ''BTC'', 1880.0, 63.30),
(2024, ''ETH'', 217.0, 7.31),
(2024, ''DOGE'', 25.0, 0.84),
(2024, ''USDT'', 100.0, 3.37),
(2024, ''XMR'', 4.0, 0.13),
(2024, ''SOL'', 90.0, 3.03),
(2024, ''DOT'', 10.0, 0.34);')