USE glasses_optic;

INSERT INTO address (street, number, floor, door, city, pc, country)
VALUES
('Balmes', '120', '3', '2', 'Barcelona', '08008', 'Spain'),
('Atocha', '27', '2', '7', 'Madrid', '28012', 'Spain'),
('Diagonal', '512', '5', '1', 'Barcelona', '08006', 'Spain'),
('Sants', '85', '1', 'C', 'Barcelona', '08014', 'Spain'),
('Gran Via de Les Corts Catalanes', '10', 'Bajos', '1', 'Madrid', '28013', 'Spain');

INSERT INTO employee (name)
VALUES
('Mario Alvarado'),
('Laura Pérez'),
('Carlos Rubio');

INSERT INTO provider (name, phone, fax, nif, address_id)
VALUES
('Biòptic', '934578692', '934568791', 'B1257897', 1),
('Tech Glass', '935578468', '935578567', 'E4896533', 2),
('Miller & Marc', '933334476', '933334577', 'N9862568', 3);

INSERT INTO client (name, phone, email, registration, recommended_by_id, address_id)
VALUES
('Rodrigo Pascual', '+346768729', 'rodrigo_p_casanov225@gmail.com', '2022-10-15 10:30:00', NULL, 4),
('Ana Triviño', '+346123456', 'ana.lopez@example.com', '2023-01-12 11:15:00', NULL, 5),
('David Escrivà', '+346998877', 'david.b@example.com', '2023-03-20 16:45:00', 1, 1),
('Sofia Castells', '+346554433', 'sofia.v@example.com', '2023-06-05 09:30:00', 2, 2);

INSERT INTO brand (name, provider_id)
VALUES
('Project Lobster', 1),
('Kaleos', 3),
('Xavier Garcia', 2),
('Kimze', 2);

INSERT INTO glasses (model, prescription_left, prescription_right, mount_color, colour_glassLeft, colour_glassRight, price, mount_type, brand_id)
VALUES
 ('Aviator Classic', 1.25, 1.00, 'Black', 'Clear', 'Clear', 159.99, 'metal', 1),
('Wayfarer Retro', 2.50, 2.25, 'Matte Silver', 'Blue', 'Blue', 189.50, 'plastic', 2),
('Round Minimalist', 0.75, 0.50, 'Tortoiseshell', 'Green', 'Green', 220.00, 'plastic', 3),
('Sport Tech Pro', 3.00, 3.25, 'Gold', 'Brown', 'Brown', 275.75, 'rimless', 4),
('Reading Basics', 1.00, 1.00, 'Red', 'Clear', 'Clear', 55.00, 'plastic', 1);

INSERT INTO sale (sale_date, employee_id, client_id, glasses_id)
VALUES
('2023-01-15 10:00:00', 1, 1, 1),
('2023-03-22 12:30:00', 2, 3, 2), 
('2023-06-10 17:15:00', 2, 1, 3), 
('2023-08-05 11:45:00', 2, 4, 4),
('2023-11-20 16:00:00', 1, 2, 5),
('2024-02-14 09:30:00', 1, 3, 1);

