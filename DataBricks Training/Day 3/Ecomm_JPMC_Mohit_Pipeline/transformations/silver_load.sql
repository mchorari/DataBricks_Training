create streaming table mohit_silver.sales_clean 
(CONSTRAINT valid_order_id EXPECT (order_id IS NOT NULL) ON VIOLATION DROP ROW)
as
select distinct * from stream sales_pl_br ;

CREATE OR REFRESH STREAMING TABLE mohit_silver.products_clean;

CREATE FLOW product_flow AS AUTO CDC INTO
mohit_silver.products_clean
FROM
stream (products_pl_br)
KEYS(product_id)
APPLY AS DELETE WHEN operation='DELETE'
  SEQUENCE BY seqNum
  COLUMNS * EXCEPT (operation, seqNum,_rescued_data)
  STORED AS SCD TYPE 1;

  CREATE OR REFRESH STREAMING TABLE mohit_silver.customers_cleaned;

CREATE FLOW customer_flow
AS AUTO CDC INTO
  mohit_silver.customers_cleaned
FROM stream(customers_pl_br)
  KEYS (customer_id)
  APPLY AS DELETE WHEN operation = "DELETE"
  SEQUENCE BY sequenceNum
  COLUMNS * EXCEPT (operation, sequenceNum,_rescued_data)
  STORED AS SCD TYPE 2;
