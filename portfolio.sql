-- Query for portfolio#index (all portfolios)
SELECT p.id, p.name, SUM(t.price * t.quantity) AS invested
  FROM portfolios               AS p
  LEFT OUTER JOIN holdings      AS h ON h.portfolio_id = p.id
  LEFT OUTER JOIN transactions  AS t ON t.holding_id = h.id
 GROUP BY p.id;

-- Query for portfolio#show (single portfolio)

SELECT h.id AS holding_id, 
       h.symbol AS holding_symbol, 
       h.portfolio_id AS portfolio_id, 
       (SUM(t.price * t.quantity) / SUM(t.quantity)) AS wac
  FROM holdings AS h
  LEFT OUTER JOIN transactions AS t ON t.holding_id = h.id
 GROUP BY h.id;