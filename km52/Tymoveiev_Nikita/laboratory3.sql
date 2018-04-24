-- LABORATORY WORK 3
-- BY Tymoveiev_Nikita
/*1. Написати PL/SQL код, що додає замовників, щоб сумарна кількість усіх замовників була 10. Ключі замовників test1….testn. 
Решта значень обов’язкових полів відповідає полям  замовника з ключем 1000000001.
10 балів*/
SET SERVEROUTPUT ON

DECLARE
     CustomerName customers.cust_name%TYPE;
    CustomerId customers.cust_id%TYPE;
    CustCount
    int := 0;

BEGIN
    CustomerId := '1000000001';
    SELECT
        COUNT(DISTINCT customers.cust_id)
    INTO
        CustCount
    FROM
        customers;

    SELECT
        cust_name
    INTO
        CustomerName
    FROM
        customers
    WHERE
        cust_id = CustomerId;

    FOR i IN 1.. ( 10 - CustCount ) LOOP
        INSERT INTO customers (
            cust_id,
            cust_name
        ) VALUES (
            'test'
            || i,
            CustomerName
        );

    END LOOP;

END;

/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він має більше 3 замовлень - статус  = "yes"
Якщо він має 3 замовленя - статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/
SET SERVEROUTPUT ON

DECLARE
    customer_id       customers.cust_id%TYPE;
    customer_status   VARCHAR(50) := ' ';
    orders_count      INTEGER := 0;
    customer_name     customers.cust_name%TYPE;
BEGIN
    customer_id := '1000000001';
    SELECT
        customers.cust_name,
        COUNT(order_num)
    INTO
        customer_name,orders_count
    FROM
        customers left
        JOIN orders ON customers.cust_id = orders.cust_id
    WHERE
        customers.cust_id = customer_id
    GROUP BY
        customers.cust_id,
        customers.cust_name;

    IF
        orders_count > 3
    THEN
        customer_status := 'yes';
    ELSIF orders_count = 3 THEN
        customer_status := 'no';
    ELSE
        customer_status := 'unknown';
    END IF;

    dbms_output.put_line(trim(customer_name)
    || '  '
    || customer_status);
END;
/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки замовлень має кожен з покупців, що проживає в Австрії.
3.2. Як звуть постачальника з Германії, що продає свої товари більше ніж у 3 різних замовленнях.
6 балів.*/

create or replace view  lab3 AS
SELECT customers.cust_id, customers.cust_name, customers.cust_country, orderitems.order_item, orderitems.quantity, products.prod_id, vendors.vend_id , vendors.vend_name, vendors.vend_country 
FROM CUSTOMERS  JOIN ORDERS ON CUSTOMERS.cust_id = ORDERS.cust_id
 JOIN ORDERITEMS ON ORDERS.order_num = ORDERITEMS.order_num
 JOIN PRODUCTS ON ORDERITEMS.prod_id = PRODUCTS.prod_id
 JOIN VENDORS ON PRODUCTS.vend_id = VENDORS.vend_id;
 
 SELECT cust_name, count(prod_id)
 from lab3
 where cust_country = 'Austria'
 group by cust_id, cust_name;
 
 SELECT  vend_name, prod_id
 from lab3
 WHERE vend_country = 'Germany'
 group by vend_name, prod_id
 having count(prod_id) > 3;
