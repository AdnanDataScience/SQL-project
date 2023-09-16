SELECT * FROM campusx.smartphones;

-- Find maximum price of phone based on each catagory
SELECT *, MAX(price) OVER(PARTITION BY brand_name) as max_price FROM campusx.smartphones;

-- Find lowest rating phone based on each catagory
SELECT brand_name, model, price, processor_speed, MIN(rating) OVER(PARTITION BY brand_name) as min_rating 
FROM campusx.smartphones GROUP BY model;
-- by price wise check
SELECT brand_name, model, price, processor_speed, MIN(rating) OVER(PARTITION BY price) as min_rating
 FROM campusx.smartphones;
-- overall fetching minimum rating 
SELECT brand_name, model, price, processor_speed, MIN(rating) OVER() as min_rating
FROM campusx.smartphones;

SELECT * FROM campusx.smartphones;

-- Fetch first 2 mobile from each brand
SELECT * FROM (
SELECT *, ROW_NUMBER() OVER(PARTITION BY brand_name) AS r_number 
FROM campusx.smartphones )  x
where x.r_number < 3;

SELECT * FROM (
SELECT *, ROW_NUMBER() OVER(PARTITION BY brand_name) AS r_number 
FROM campusx.smartphones )  x
where x.r_number < 3;
-- Fetch first 2 mobile  having maximum price from each brand 
SELECT * FROM campusx.smartphones;
SELECT * FROM (
SELECT *, RANK() OVER(PARTITION BY brand_name ORDER BY price DESC ) as top_price,
DENSE_RANK() OVER(PARTITION BY brand_name ORDER BY price DESC ) as top_dense_price
FROM campusx.smartphones) x
WHERE x.top_price < 3;

-- Fetch a query to display if the price of mobile is higher, middle, lower in each brand
-- Lead and Lag functions in sql
-- Lead means next record in a column and write it in another column
-- Lag means previous record in a column and write it another column

SELECT *, LAG(price) OVER(PARTITION BY brand_name) as prevous_price
FROM campusx.smartphones;

SELECT *, LEAD(price) OVER(PARTITION BY brand_name) as next_price,
LAG(price) OVER(PARTITION BY brand_name) as prevous_price
FROM campusx.smartphones;






