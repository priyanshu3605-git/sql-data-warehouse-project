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

--for prod table
select prd_id,count(*) from bronze.crm_prd_info
group by prd_id having count(*)>1 or prd_id is null

select prd_cost from bronze.crm_prd_info where
prd_cost<0 or prd_cost is null

select distinct prd_line from bronze.crm_prd_info

select * from bronze.crm_prd_info
where prd_end_dt<prd_start_dt

select * from silver.crm_prd_info

--for sales tables
select nullif(sls_order_dt,0) sls_order_dt
from bronze.crm_sales_details where sls_order_dt<=0
or len(sls_order_dt)!=8

select distinct sls_sales,
sls_quantity,
sls_price
from bronze.crm_sales_details
where sls_sales!=sls_quantity*sls_price
or sls_sales is null or sls_quantity is null or sls_price is null
or sls_sales<=0 or sls_quantity<=0 or sls_price<=0
order by sls_sales,
sls_quantity,
sls_price

select cid,bdate,
gen from bronze.erp_cust_az12

--for erp_loc_a101
select cst_key from silver.crm_cust_info