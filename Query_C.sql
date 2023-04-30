SELECT
	items.itemid AS item_with_most_annual_revenue
FROM items
	JOIN purchases ON purchases.itemid = items.itemid
WHERE EXTRACT(YEAR FROM purchases.date) =
(
  SELECT EXTRACT(YEAR FROM purchases.date) as YEAR
  FROM purchases
  ORDER BY year DESC
  LIMIT 1
)
GROUP BY item_with_most_annual_revenue
ORDER BY price DESC
LIMIT 1;
