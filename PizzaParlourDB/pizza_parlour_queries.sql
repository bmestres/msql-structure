
SELECT 
    locality.name AS Location,
    product_category.name AS Category,
    SUM(order_line.units) AS Total_Drinks_Sold
FROM locality
JOIN store ON locality.locality_id = store.locality_id
JOIN `order` ON store.store_id = `order`.store_id
JOIN order_has_order_line ON `order`.order_id = order_has_order_line.order_id
JOIN order_line ON order_has_order_line.order_line_id = order_line.order_line_id
JOIN product ON order_line.product_id = product.product_id
JOIN product_category ON product.product_category_id = product_category.product_category_id
WHERE locality.locality_id = 1 
AND product_category.name = 'Soft Drinks'
GROUP BY locality.name, product_category.name;


SELECT 
    employee.name AS Name,
    employee.surname AS Surname,
    COUNT(`order`.order_id) AS Total_Orders
FROM employee
JOIN `order` ON employee.employee_id = `order`.employee_id
WHERE employee.employee_id = 1
GROUP BY employee.employee_id;
