/*How many months of data are included in the magist database?   25 */
SELECT COUNT(DISTINCT DATE_FORMAT(order_purchase_timestamp, '%Y-%m')) AS total_monthsorders
from orders
;

select*from orders;

/*How many sellers are there?    3095*/
select  COUNT(DISTINCT seller_id) 
from sellers;  
/*How many Tech sellers are there?*/
select p.product_category_name,s.seller_id
from sellers;
select COUNT(DISTINCT s.seller_id) ,
p.product_id,s.seller_id
from order_items o  
left join sellers s on o.seller_id=s.seller_id
left join products p on o.product_id=p.product_id
where  product_category_name in ("eletronicos","eletroportateis","informatica_acessorios","pc_gamer","pcs","telefonia","telefonia_fixa")
;
/*What is the total amount earned by all sellers?*/
select*from sellers;
select*from order_items;
/*What is the total amount earned by all sellers?  13591643.701720357 */
select sum(o.price)
from sellers s 
left join order_items o on s.seller_id=o.seller_id;
/* What is the total amount earned by all Tech sellers?  '1870609.246133566'*/
select sum(o.price)
from
order_items o  
left join sellers s on o.seller_id=s.seller_id
left join products p on o.product_id=p.product_id
where  product_category_name in ("eletronicos","eletroportateis","informatica_acessorios","pc_gamer","pcs","telefonia","telefonia_fixa")
;
select* from orders;
/*What’s the average time between the order being placed and the product being delivered?  '12.5035'
*/
select AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp))
from orders
where order_purchase_timestamp is not null;


/*How many orders are delivered on time vs orders delivered with a delay?*/
SELECT 
    CASE
        WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 'On Time'
        ELSE 'Delayed'
    END AS delivery_status,
    COUNT(*) AS num_orders
FROM
    orders
WHERE
    order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status;
select* from orders;
select* from products;

/*Is there any pattern for delayed orders, e.g. big products being delayed more often?*/
SELECT
    p.product_category_name,
    AVG(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1 ELSE 0 END) AS delay_rate
FROM
    orders o
JOIN
    order_items oi ON o.order_id = oi.order_id
JOIN
    products p ON oi.product_id = p.product_id
GROUP BY
    p.product_category_name
ORDER BY
    delay_rate DESC;