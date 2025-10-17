/* 
	FUNCTION: 
	This script is meant to create all the tables you need in order to then load the data from the source with the structure better suits it.
	It also has a function to check if the table already exists, if is yes, then it would be deleted and then, another one would be 
	created. 

	WARNING:
	Use this script with caution, because it would delete all the tables you might have created. 
	Always check first if they are loaded with data and make copies in case you need them
*/


-- Function that check wether a tables exists or not, if it exists then it would be droped. 
IF OBJECT_ID ('bronze.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;

-- Creates a Table with the same structure as de csv source files
CREATE TABLE bronze.crm_cust_info (
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_material_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE
);

IF OBJECT_ID ('bronze.crm_prd_info' ,'U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info
CREATE TABLE bronze.crm_prd_info (
	prd_id INT,
	prd_key NVARCHAR(50),
	prd_name NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATETIME,
	prd_end_dt DATETIME
);

IF OBJECT_ID ('bronze.crm_sales_details' ,'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details
CREATE TABLE bronze.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd__key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
);

IF OBJECT_ID ('bronze.erp_cust_AZ12' ,'U') IS NOT NULL
	DROP TABLE bronze.erp_cust_AZ12
CREATE TABLE bronze.erp_cust_AZ12 (
	CID NVARCHAR(50),
	BDATE DATE,
	GEN NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_LOC_A101' ,'U') IS NOT NULL
	DROP TABLE bronze.erp_LOC_A101
CREATE TABLE bronze.erp_LOC_A101 (
	CID NVARCHAR(50),
	CNTRY NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_PX_CAT_G1V2' ,'U') IS NOT NULL
	DROP TABLE bronze.erp_PX_CAT_G1V2
CREATE TABLE bronze.erp_PX_CAT_G1V2(
	ID NVARCHAR (50),
	CAT NVARCHAR (50),
	SUBCAT NVARCHAR (50),
	MAINTENANCE VARCHAR (50)
);
