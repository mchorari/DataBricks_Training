--path s3://jpmctraining/input_files/sales

-- ingesting sales to bronze
create streaming table sales_pl_br as 
select * from STREAM read_files('s3://jpmctraining/input_files/sales',format=>'csv') ;

--ingesting products to bronze
create streaming table products_pl_br as 
select * from STREAM read_files('s3://jpmctraining/input_files/products',format=>'csv') ;

--ingesting customers to bronze
create streaming table customers_pl_br as 
select * from STREAM read_files('s3://jpmctraining/input_files/customers',format=>'csv') ;