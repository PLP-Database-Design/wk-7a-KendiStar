--Question one 

-- Step 1: Assume you've loaded the original table `ProductDetail`

-- Step 2: Convert to 1NF
WITH split_products AS (
    SELECT 
        OrderID,
        CustomerName,
        TRIM(JSON_UNQUOTE(JSON_EXTRACT(js.value, '$'))) AS Product
    FROM (
        SELECT 
            OrderID,
            CustomerName,
            JSON_TABLE(
                CONCAT('["', REPLACE(Products, ', ', '","'), '"]'),
                '$[*]' COLUMNS (value VARCHAR(100) PATH '$')
            ) AS js
        FROM ProductDetail
    ) AS sub
)
SELECT * FROM split_products;





--Question two
--Create a orders table (1 row per order)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

--Create a orderitems table(one product per row)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
