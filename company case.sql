/*How many orders are there in the dataset?   99441 */
use magist;
SELECT 
    COUNT(*) AS order_count
FROM
    orders;


 
/*Are orders actually delivered?  delivered: 96478*/
SELECT 
    order_status, COUNT(*) AS orders
FROM
    orders
GROUP BY order_status;

/*Is Magist having user growth? */
SELECT 
    YEAR(order_purchase_timestamp) AS purchase_year,
    MONTH(order_purchase_timestamp) AS purchase_month,
    COUNT(order_id)
FROM
    orders
GROUP BY purchase_year , purchase_month
ORDER BY purchase_year , purchase_month;

/*How many products are there on the products table?   32951*/
use magist;
SELECT 
    COUNT(DISTINCT product_id) AS amount_product
FROM
    products
;

/*Which are the categories with the most products   cama_mesa_banho   3029*/
SELECT 
    product_category_name,
    COUNT(DISTINCT product_id) AS amount_product
FROM
    products
GROUP BY product_category_name
ORDER BY amount_product DESC;
select count(product_category_name)
from products; /*32951*/

select count(distinct (product_id))
from products;
/*How many of those products were present in actual transactions?   32951*/
SELECT 
    COUNT(DISTINCT product_id) AS n_product
FROM
    order_items;
/*What’s the price for the most expensive and cheapest products? most expensive:6735; cheapest; 0.85*/
SELECT 
    MAX(price) AS most_expensice, MIN(price) AS cheapest
FROM
    order_items;
/*What are the highest and lowest payment values? highest:13664.1;lowest:0  */  
SELECT 
    MAX(payment_value), MIN(payment_value)
FROM
    order_payments;
/*What’s the highest someone has paid for an order?    13664.09 */ 
SELECT 
    SUM(payment_value) AS total_value
FROM
    order_payments
GROUP BY order_id
ORDER BY total_value DESC
LIMIT 1;