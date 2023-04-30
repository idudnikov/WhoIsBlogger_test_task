SELECT
	item_id,
	item_revenue,
	TO_CHAR(SUM(item_revenue::float /
                (SELECT SUM(items.price) as total_items_sales
                 FROM items
                 JOIN purchases ON items.itemid = purchases.itemid
                 WHERE EXTRACT(YEAR FROM purchases.date) = 2019)
               ) * 100, 'fm99D00%') AS item_share_in_total_revenue
FROM
(
  SELECT
  	items.itemid as item_id,
  	SUM(items.price) AS item_revenue
  FROM users
  	JOIN purchases ON users.userid = purchases.userid
    JOIN items ON purchases.itemid = items.itemid
  WHERE EXTRACT(YEAR FROM purchases.date) = 2019
  GROUP BY item_id
  ORDER BY item_revenue DESC
  LIMIT 3
) AS top_3_items_by_revenue
GROUP BY item_id, item_revenue
ORDER BY item_revenue DESC;
