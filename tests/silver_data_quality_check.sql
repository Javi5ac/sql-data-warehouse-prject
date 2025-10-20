/*
Data Quality (DQ) Validation Script:
	Runs a series of validation (PKs, formatting, business rules) and profiling (DISTINCT) 
	queries against Bronze/Silver layers. Most validation checks should return zero rows.
*/

-- Check For Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT 
cst_id, 
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

-- Check for unwanted spaces
-- Expectation: No Results
SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

-- Data Standarization & Consistency
SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info,

SELECt DISTINCT
cst_marital_status
FROM bronze.crm_cust_info

-- Check for prd_id duplicates
-- Expectation: No result
SELECT
prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT (*) > 1 OR prd_id IS NULL

--Check for unwanted Spaces
-- Expectation: No result

SELECT
prd_nm
FROM silver.crm_prd_info
WHERE TRIM(prd_nm) != prd_nm

-- Check for NULLs or Negative Numbers
-- Expectation: No result
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0

-- Data standarization & Consistency
SELECT DISTINCT
	prd_line
FROM silver.crm_prd_info

-- Checl for invalid date orders
-- Expectation: No result
SELECT*
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

SELECT * FROM silver.crm_prd_info

-- Check for Invalid Dates
-- Expectation: No results
SELECT
	NULLIF(sls_ship_dt,0) sls_order_dt 
FROM silver.crm_sales_details
WHERE sls_ship_dt <= 0 
OR LEN(sls_ship_dt) != 8 
OR sls_ship_dt > 20500101 
OR sls_ship_dt < 19000101

-- Check for Invalid Date Orders
-- Expectation: No results
SELECT
	*
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_due_dt OR sls_order_dt > sls_ship_dt OR sls_ship_dt > sls_due_dt 

-- Check Data Consistency: Between Sales, Quantity and Price
-- >> Sales = Quantity * Price
-- >> Values must not be NULL, zero or negative.
-- Expectation: No result
SELECT DISTINCT
	sls_sales,
	sls_quantity,
	sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales,sls_quantity, sls_price

-- Inditify Out of Range Dates

SELECT DISTINCT
bdate
FROM bronze.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate >GETDATE()

-- Data Standarization & Consistency

SELECT DISTINCT 
gen
FROM bronze.erp_cust_az12

-- Data Standarization & Consistency
SELECT DISTINCT
cntry
FROM bronze.erp_loc_a101
ORDER BY cntry
