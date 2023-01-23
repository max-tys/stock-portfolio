-- Query for portfolio#index (all portfolios)
SELECT p.id, p.name, SUM(t.price * t.quantity) AS invested
  FROM portfolios               AS p
  LEFT OUTER JOIN holdings      AS h ON h.portfolio_id = p.id
  LEFT OUTER JOIN transactions  AS t ON t.holding_id = h.id
 GROUP BY p.id;

-- Query for portfolio#show (single portfolio)

SELECT h.id AS holding_id, 
       h.symbol,
       SUM(t.quantity) AS quantity,
       (SUM(t.price * t.quantity) / SUM(t.quantity)) AS wac
  FROM portfolios               AS p
  LEFT OUTER JOIN holdings      AS h ON h.portfolio_id = p.id
  LEFT OUTER JOIN transactions  AS t ON t.holding_id = h.id
 WHERE p.id = 70
 GROUP BY h.id
 ORDER BY h.symbol;