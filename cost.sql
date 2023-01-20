SELECT p.name AS portfolio_name,
       SUM(t.price * t.quantity) AS total_cost
  FROM portfolios AS p
  FULL JOIN holdings AS h ON h.portfolio_id = p.id
  FULL JOIN transactions AS t on t.holding_id = h.id
 GROUP BY p.id;

SELECT p.name AS portfolio_name,
       SUM(t.price * t.quantity) AS total_cost
  FROM portfolios AS p
  LEFT JOIN holdings AS h ON h.portfolio_id = p.id
  LEFT JOIN transactions AS t on t.holding_id = h.id
 GROUP BY p.id;
