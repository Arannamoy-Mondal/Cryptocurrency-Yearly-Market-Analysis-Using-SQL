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

# AllCrypto table start

select * from AllCrypto;

insert into AllCrypto (name, max_price, min_price,
                       max_total_market_cap, min_total_market_cap, total_supply,
                       circulating_supply, blockchain_type, consensus_algorithm,
                       blockchain_network_type, founded, added_time_in_db,symbol)
values ('Bitcoin',108000,0.05816,'$1.3T','$0.5M',
       '21 M','19.5 M','Public','PoW','Layer-1',2008,
       curdate(),'BTC'),
    






;

# drop table AllCrypto;



