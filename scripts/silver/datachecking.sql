--expectaion_no rsults
select cst_key from bronze.crm_cust_info where cst_key!=TRIM(cst_key)
--data standardization and consistency
select distinct cst_gndr from bronze.crm_cust_info
--for silver layer
select * from silver.crm_cust_info
--expectaion_no rsults
select cst_key from silver.crm_cust_info where cst_key!=TRIM(cst_key)
--data standardization and consistency
select distinct cst_gndr from silver.crm_cust_info