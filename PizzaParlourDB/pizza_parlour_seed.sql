USE pizza_parlour;

INSERT INTO province(name)
VALUES 
('Barcelona'), ('Girona'), ('Tarragona'), ('Lleida');

INSERT INTO locality(name, province_id)
VALUES 
('Sabadell', 1), ('Olot', 2),  ('Alcanar', 3), ('Pont de Suert', 4);

INSERT INTO client(name, surname, address, locality_id, province_id, phone, postal_code)
VALUES 
('Martí', 'Salinas Pujol', 'Gran de gràcia 112', 1, 1, '+346742309', 08012),
('Maria', 'Lopez', 'Avinguda Diagonal 45', 1, 1, '600333444', 08002);

INSERT INTO store (adress, postal_code, locality_id, province_id) 
VALUES 
('Ronda Universitat 10', 08002, 1, 1),
('Carrer Migdia 23', 17002, 2, 2),
('Trafalgar', 43569, 3, 3); 

INSERT INTO employee(name, surname, nif, phone, role, store_id)
VALUES
('Carlos', 'Farinelli', '12345678E', '+346447895', 'cook', 1),
('Asumpta', 'Ordoñez', '98765432A', '+34987678234', 'rider',2),
('Teo', 'Gonzalez', '97463774C', '+34777342879', 'rider', 3);

-- INSERT INTO order (date_time, delivery_type, client_id, store_id, employer_id)
INSERT INTO `order` (date_time, delivery_type, client_id, store_id, employee_id)
VALUES
('2026-07-24 20:33:00', 'delivery', 1, 1, 1),
('2026-07-24 20:33:00', 'pickup', 2, 2, 2);

INSERT INTO product_category(name)
VALUES
('Classic Pizzas'),
('Soft Drinks');

INSERT INTO product(name, description, price, order_id, product_category_product_category_id)
VALUES
('Margherita Pizza', 'Tomato, Mozzarella, Basil', 10.50, 1, 1),
('Coca Cola', '330ml Can', 2.50, 1, 2);

INSERT INTO order_line (units, product_id)
VALUES
(2, 1),
(1, 2);

INSERT INTO order_has_order_line(order_id, order_line_id)
VALUES
(1, 1),
(1, 2);


 

 
 
