-- Query for portfolio#index (all portfolios)
SELECT p.id, p.name, h.symbol, SUM(t.quantity) AS qty, SUM(t.price * t.quantity) AS amount_invested
  FROM portfolios               AS p
  LEFT OUTER JOIN holdings      AS h ON h.portfolio_id = p.id
  LEFT OUTER JOIN transactions  AS t ON t.holding_id = h.id
 GROUP BY p.id, h.symbol
 ORDER BY p.id, h.symbol;

-- Query for portfolio#show (single portfolio)
SELECT h.id,
       h.symbol,
       SUM(t.quantity) AS quantity,
       (SUM(t.price * t.quantity) / SUM(t.quantity)) AS average_cost
  FROM holdings                 AS h
  LEFT OUTER JOIN transactions  AS t ON t.holding_id = h.id
 WHERE h.portfolio_id = 83
 GROUP BY h.id
 ORDER BY h.symbol;
-- EXPLAIN ANALYZE
  -- planning time 0.098ms
  -- execution time 0.056ms
  -- actual time=0.032..0.033 rows=6 loops=1
