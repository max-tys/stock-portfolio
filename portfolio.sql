-- Query for portfolio#index (all portfolios)
SELECT p.id, p.name, SUM(t.price * t.quantity) AS invested
  FROM portfolios               AS p
  LEFT OUTER JOIN holdings      AS h ON h.portfolio_id = p.id
  LEFT OUTER JOIN transactions  AS t ON t.holding_id = h.id
 GROUP BY p.id;

-- Query for portfolio#show (single portfolio)

SELECT p.id AS portfolio_id,
       p.name AS portfolio_name,
       h.id AS holding_id, 
       h.symbol AS holding_symbol,
       (SUM(t.price * t.quantity) / SUM(t.quantity)) AS wac
  FROM portfolios               AS p
  LEFT OUTER JOIN holdings      AS h ON h.portfolio_id = p.id
  LEFT OUTER JOIN transactions  AS t ON t.holding_id = h.id
 GROUP BY p.id, h.id;