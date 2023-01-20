SELECT p.id AS portfolio_id
       p.name AS portfolio_name,
       SUM(t.price * t.quantity) AS total_cost
  FROM portfolios AS p
  FULL JOIN holdings AS h ON h.portfolio_id = p.id
  FULL JOIN transactions AS t on t.holding_id = h.id
 GROUP BY p.id;