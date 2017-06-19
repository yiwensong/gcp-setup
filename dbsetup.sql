CREATE SCHEMA IF NOT EXISTS rawdata AUTHORIZATION postgres;
CREATE SCHEMA IF NOT EXISTS research AUTHORIZATION postgres;

CREATE ROLE gdax_md LOGIN PASSWORD 'gdax_md';
GRANT CONNECT ON DATABASE mddb TO gdax_md;
GRANT CREATE ON SCHEMA rawdata to gdax_md;

CREATE ROLE readonlyuser LOGIN PASSWORD 'readonlyuser';
GRANT CONNECT ON DATABASE mddb TO readonlyuser;
GRANT SELECT ON ALL TABLES IN SCHEMA rawdata TO readonlyuser;
GRANT SELECT ON ALL TABLES IN SCHEMA research TO readonlyuser;

GRANT USAGE ON SCHEMA rawdata TO public;
GRANT USAGE ON SCHEMA research TO public;

CREATE TABLE IF NOT EXISTS rawdata.ticks (
  trade_id BIGINT,
  sequence BIGINT,
  maker_order_id CHAR(36),
  taker_order_id CHAR(36),
  trade_time TIMESTAMPTZ,
  product_id CHAR(7),
  trade_size FLOAT,
  price FLOAT,
  side CHAR(4),
  PRIMARY KEY(sequence)
);

