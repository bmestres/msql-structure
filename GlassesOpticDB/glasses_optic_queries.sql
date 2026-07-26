USE glasses_optic;

-- Test 01: list the total invoices of a client (id 1) during year 2023 
SELECT 
    sale.sale_id AS Invoice_Num,
    sale.sale_date AS Date_Time,
    client.name AS Name
FROM sale
JOIN client ON sale.client_id = client.client_id
WHERE sale.sale_date BETWEEN '2023-01-01 00:00:00' AND '2023-12-31 23:59:59' 
AND client.client_id = 1;

-- Test 02: list the different models of glasses an employee sold throughout 2023

SELECT DISTINCT
	glasses.model AS Glasses_Model,
    employee.name AS Employee_Name
FROM sale
JOIN employee ON sale.employee_id = employee.employee_id
JOIN glasses ON sale.glasses_id = glasses.glasses_id
WHERE sale.sale_date BETWEEN '2023-01-01 00:00:00' AND '2023-12-31 23:59:59'
AND sale.employee_id = 2;

-- Test 03: List the different suppliers who have supplied glasses sold successfully

SELECT DISTINCT 
    provider.name AS Provider_Name
FROM sale
JOIN glasses ON sale.glasses_id = glasses.glasses_id
JOIN brand ON glasses.brand_id = brand.brand_id
JOIN provider ON brand.provider_id = provider.provider_id;





    



