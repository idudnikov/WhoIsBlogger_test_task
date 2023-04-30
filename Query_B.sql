SELECT TO_CHAR(
  	TO_DATE (month_with_most_purchases.month::text, 'MM'), 'Month'
) as month_with_most_purchases
FROM
(
  SELECT
  	EXTRACT(MONTH FROM purchases.date) as month,
  	SUM(items.price) as purchase_sum
  FROM users
  	JOIN purchases ON users.userid = purchases.userid
    JOIN items ON purchases.itemid = items.itemid
  WHERE users.age > 34
  GROUP BY month
  ORDER BY purchase_sum DESC
  LIMIT 1
) AS month_with_most_purchases;
