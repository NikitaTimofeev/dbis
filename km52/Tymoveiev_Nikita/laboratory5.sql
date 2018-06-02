-- LABORATORY WORK 5
-- BY Tymoveiev_Nikita
--1--
CREATE or replace FUNCTION FUNCTION1 (
    or_num orders.order_num%TYPE
)
   return VARCHAR2 as
    prod_name products.prod_name%type;
    price ORDERITEMS.ITEM_PRICE%type;
    order_num OrderItems.order_num%TYPE;
BEGIN
    order_num := or_num; 
    SELECT products.prod_name, orderitems.item_price INTO prod_name, price
    FROM Products LEFT JOIN ORDERITEMS ON products.prod_id = orderitems.prod_id 
    WHERE prod_price = price
    GROUP BY order_num, prod_name, item_price;
    
    RETURN prod_name;
END function1;


--2--

create or replace procedure getVendorName (prod_name products.prod_name%TYPE)
as 
vendor vendors.vend_name%TYPE; 
name_ products.prod_name%TYPE;
myex EXCEPTION;

BEGIN

SELECT products.prod_name, vendors.vend_name INTO name_ , vendor
FROM VENDORS LEFT JOIN PRODUCTS ON vendors.vend_id = products.vend_id
where prod_name = prod_name;
IF prod_name is NULL THEN
RAISE myex;
ELSE dbms_output.put_line(vendor);
end if;
EXCEPTION
       WHEN myex then DBMS_output.put_line('ERROR');
       
end getVendorName;

--3--
create or replace procedure getVendorName (prod_name products.prod_name%TYPE)
as 
vendor vendors.vend_name%TYPE; 
name_ products.prod_name%TYPE;
myex EXCEPTION;

BEGIN

SELECT products.prod_name, vendors.vend_name INTO name_ , vendor
FROM VENDORS LEFT JOIN PRODUCTS ON vendors.vend_id = products.vend_id
where prod_name = prod_name;
IF prod_name is NULL THEN
RAISE myex;
ELSE dbms_output.put_line(vendor);
end if;
EXCEPTION
       WHEN myex then DBMS_output.put_line('ERROR');
       
end getVendorName;
