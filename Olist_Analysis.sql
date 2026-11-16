SELECT
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(oi.price) DESC
    ) AS revenue_rank
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
JOIN olist_orders_dataset o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY p.product_category_name
ORDER BY revenue_rank;