CREATE SCHEMA IF NOT EXISTS rawdata AUTHORIZATION postgres;
CREATE SCHEMA IF NOT EXISTS research AUTHORIZATION postgres;

CREATE ROLE gdax_md LOGIN PASSWORD 'gdax_md';
GRANT CONNECT ON DATABASE mddb TO gdax_md;
-- GRANT SELECT ON ALL TABLES IN SCHEMA rawdata TO gdax_md;
-- GRANT INSERT ON ALL TABLES IN SCHEMA rawdata TO gdax_md;
-- GRANT CREATE ON SCHEMA rawdata to gdax_md;

CREATE ROLE readonlyuser LOGIN PASSWORD 'readonlyuser';
GRANT CONNECT ON DATABASE mddb TO readonlyuser;
-- GRANT SELECT ON ALL TABLES IN SCHEMA rawdata TO readonlyuser;
-- GRANT SELECT ON ALL TABLES IN SCHEMA research TO readonlyuser;

CREATE ROLE bars_cron LOGIN PASSWORD 'bars_cron';
GRANT CONNECT ON DATABASE mddb to bars_cron;

GRANT USAGE ON SCHEMA rawdata TO public;
GRANT USAGE ON SCHEMA research TO public;

DROP TABLE IF EXISTS rawdata.ticks;
CREATE TABLE rawdata.ticks (
  trade_id BIGINT,
  sequence BIGINT NOT NULL,
  maker_order_id CHAR(36),
  taker_order_id CHAR(36),
  time TIMESTAMPTZ NOT NULL,
  product_id CHAR(10) NOT NULL,
  trade_size FLOAT NOT NULL,
  price FLOAT NOT NULL,
  side CHAR(4),
  exchange CHAR(20) NOT NULL,
  PRIMARY KEY(time, product_id, exchange)
);
GRANT SELECT ON rawdata.ticks TO public;
GRANT INSERT ON rawdata.ticks TO gdax_md;

DROP TABLE IF EXISTS rawdata.historical_bars;
CREATE TABLE rawdata.historical_bars (
  time TIMESTAMPTZ NOT NULL,
  product_id CHAR(10) NOT NULL,
  low FLOAT NOT NULL,
  high FLOAT NOT NULL,
  open FLOAT NOT NULL,
  close FLOAT NOT NULL,
  volume FLOAT NOT NULL,
  value FLOAT, 
  exchange CHAR(20) NOT NULL,
  PRIMARY KEY(time, product_id, exchange)
);
GRANT SELECT ON rawdata.historical_bars TO public;
GRANT INSERT ON rawdata.historical_bars TO bars_cron;
