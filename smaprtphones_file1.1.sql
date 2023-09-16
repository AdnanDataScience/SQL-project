SELECT * FROM campusx.smartphones;
SELECT * FROM campusx.smartphones;

-- FIRST VALUE FUNCTION
-- Find all the expensive mobile by each catogory
SELECT *, FIRST_VALUE(price) OVER(PARTITION BY brand_name ORDER BY price DESC) AS exp_product 
FROM campusx.smartphones;

SELECT *, FIRST_VALUE(brand_name) OVER(PARTITION BY brand_name ORDER BY price DESC) AS exp_product 
FROM campusx.smartphones;

-- LAST VALUE FUNCTION
SELECT *, LAST_VALUE(brand_name) OVER(PARTITION BY brand_name ORDER BY price DESC) AS least_product 
FROM campusx.smartphones;

-- FRAME CLAUSE
-- range between unbounded proceeding and unbounded following
SELECT *, LAST_VALUE(brand_name) OVER(PARTITION BY brand_name ORDER BY price DESC
range between unbounded preceding and unbounded following) AS least_product
FROM campusx.smartphones;

SELECT *, LAST_VALUE(brand_name) OVER(PARTITION BY brand_name ORDER BY price DESC
range between 2 preceding and 2 following) AS least_product
FROM campusx.smartphones;
-- NTH VALUE
-- Write a query to fetch second most expensive mobile price in each catagory mobile data

SELECT *, 
LAST_VALUE(brand_name) OVER(PARTITION BY brand_name ORDER BY price DESC
range between unbounded preceding and unbounded following) AS least_product,
NTH_VALUE(model,3) OVER(PARTITION BY brand_name ORDER BY price DESC) as third_value
FROM campusx.smartphones;

-- NTILE FUNCTIONS
-- it try to group togather the set of data within certain buckets
-- Write a query to segregate the all the expensive, mid level and cheaper mobile phones
SELECT *, NTILE(3) OVER(PARTITION BY brand_name ORDER BY price DESC) as grouped
FROM campusx.smartphones
WHERE brand_name= "apple";

 SELECT * FROM campusx.smartphones;
 
SELECT *, NTILE(3) OVER(PARTITION BY brand_name ORDER BY price DESC) as grouped
FROM campusx.smartphones
WHERE brand_name="samsung";

SELECT *,
CASE WHEN x.grouped = 1 THEN "Expensive phone"
	WHEN x.grouped = 2 THEN "Mid_level"
    WHEN x.grouped = 3 THEN "Cheaper phones"
END phone_catagory
from(
SELECT *, NTILE(3) OVER(PARTITION BY brand_name ORDER BY price DESC) as grouped
FROM campusx.smartphones
WHERE brand_name="samsung") x;

-- fetch the highest price of samsung mobile
SELECT brand_name, model, price, NTILE(1) OVER(PARTITION BY brand_name ORDER BY price DESC) as grouped
FROM campusx.smartphones
WHERE brand_name="samsung" LIMIT 1;

SELECT brand_name, MAX(price) as max_price
FROM campusx.smartphones
WHERE brand_name="samsung"