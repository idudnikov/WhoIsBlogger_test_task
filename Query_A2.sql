SELECT
	AVG(average_purchase)::numeric(10, 2) AS average_purchase_per_month_for_users_between_26_and_35
FROM
(
  SELECT
  	DATE_TRUNC('month', purchases.date) AS month,
    AVG(items.price)::numeric(10, 2) as average_purchase
  FROM users
  	JOIN purchases ON users.userid = purchases.userid
  	JOIN items ON purchases.itemid = items.itemid
  WHERE users.age BETWEEN 26 AND 35
  GROUP BY month
  ORDER BY month
) AS average_purchase_per_month;
