--check for nulls and duplicates
select cst_id,count(*) from bronze.crm_cust_info
group by cst_id having count(*)>1 or cst_id is null
--selecting the rank 1 row by window functns
insert into silver.crm_cust_info (
cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_martial_status,
cst_gndr,
cst_create_date
)
select cst_id,cst_key
,trim(cst_firstname) as cst_firstname, trim(cst_lastname)as cst_lastname,
case when upper(cst_martial_status)='s' then 'single' 
     when upper(cst_martial_status)='m' then 'married' 
     else 'n/a' 
end cst_martial_status,
case when upper(cst_gndr)='F' then 'female' 
     when upper(cst_gndr)='M' then 'male' 
     else 'n/a' 
end cst_gndr,
cst_create_date from(
select *,ROW_NUMBER() over (partition by cst_id order by cst_create_date desc)
as flaglast from bronze.crm_cust_info where cst_id is not null)t where flaglast=1
--chek for unwanteds spaces
select cst_firstname from bronze.crm_cust_info where cst_firstname!=trim(cst_firstname)
select cst_lastname from bronze.crm_cust_info where cst_lastname!=trim(cst_lastname)

--for prod table
select prd_id,count(*) from bronze.crm_prd_info
group by prd_id having count(*)>1 or prd_id is null


