SELECT
    orderid
    ,orderdate
    ,CASE
        WHEN orderdate LIKE '___01%' THEN 'Q1'
        WHEN orderdate LIKE '___02%' THEN 'Q1'
        WHEN orderdate LIKE '___03%' THEN 'Q1'
        WHEN orderdate LIKE '___04%' THEN 'Q2'
        WHEN orderdate LIKE '___05%' THEN 'Q2'
        WHEN orderdate LIKE '___06%' THEN 'Q2'
        WHEN orderdate LIKE '___07%' THEN 'Q3'
        WHEN orderdate LIKE '___08%' THEN 'Q3'
        WHEN orderdate LIKE '___09%' THEN 'Q3'
    ELSE 'Q4'
    END AS quarter
    ,substr(orderdate,-4,4) AS year
    ,customername
    ,state
    ,city
FROM 
    orders;
