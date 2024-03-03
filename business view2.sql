/*What categories of tech products does Magist have?*/
use magist;
select*from 
 product_category_name_translation
 where product_category_name_english IN ("electronics" , "small_appliances", "computers" , "pc_gamer", "telephony" , "fixed_telephony" ,"computers_accessories");
 
 /*How many products of these tech categories have been sold (within the time window of the database snapshot)? What percentage does that represent from the overall number of products sold?*/

select COUNT(DISTINCT o.order_id)
from products p
 join order_items o on p.product_id=o.product_id
 join product_category_name_translation t on p.product_category_name=t.product_category_name
where product_category_name_english="electronics" or "small_appliances" or "computers" or "pc_gamer"or "telephony" or "fixed_telephony" or"computers_accessories";
select count(distinct order_id)
from order_items;
/*What percentage does that represent from the overall number of products sold?  2550/ 98666=2.58% */



select * from product_category_name_translation
 ;
 /*What’s the average price of the products being sold?*  '57.913530686033475'*/
select avg(o.price)
from products p
 join order_items o on p.product_id=o.product_id
 join product_category_name_translation t on p.product_category_name=t.product_category_name
where product_category_name_english="electronics" or "small_appliances" or "computers" or "pc_gamer"or "telephony" or "fixed_telephony" or"computers_accessories";
/*Are expensive tech products popular? */
select  p.product_category_name,o.price,
        case when o.price>100 THEN 1 ELSE 0 END   as popular
from products p
 join order_items o on p.product_id=o.product_id
 join product_category_name_translation t on p.product_category_name=t.product_category_name
where product_category_name_english="electronics" or "small_appliances" or "computers" or "pc_gamer"or "telephony" or "fixed_telephony" or"computers_accessories"
order by popular desc;