-- LABORATORY WORK 2
-- BY Tymoveiev_Nikita
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ продукту за умови, що постачальник купив більше 5 одиниць цього продукту.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT customers.cust_id , products.prod_id
FROM CUSTOMERS  LEFT OUTER JOIN ORDERS ON CUSTOMERS.cust_id = ORDERS.cust_id
 LEFT OUTER JOIN ORDERITEMS ON ORDERS.order_num = ORDERITEMS.order_num
 LEFT OUTER JOIN PRODUCTS ON ORDERITEMS.prod_id = PRODUCTS.prod_id
 LEFT OUTER JOIN VENDORS ON PRODUCTS.vend_id = VENDORS.vend_id
 WHERE orderitems.quantity > 5
group by customers.cust_id, products.prod_id
order by customers.cust_id;


  
/* --------------------------------------------------------------------------- 
2.  Вивести ключ постачальника на номери замовлень, що містять більше одного з його товарів.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT vendors.vend_id, orderitems.order_num, count(orderitems.order_num) COUNT_ITEM
FROM Vendors  LEFT JOIN Products on vendors.vend_id = products.vend_id
LEFT JOIN Orderitems on products.prod_id = orderitems.prod_id
GROUP BY orderitems.order_num, vendors.vend_id
HAVING count(orderitems.order_num) > 1
ORDER BY orderitems.order_num;

