use medicos;

INSERT INTO Medicos (Nombre, Dirección, Teléfono, Población, Provincia, Código_Postal, NIF, Número_Seguridad_Social, Número_Colegiado, Tipo) VALUES
('Juan Pérez', 'Calle Mayor 1', '123456789', 'Madrid', 'Madrid', '28001', '12345678A', 'SS12345678', 'C12345', 'titular'),
('Ana García', 'Avenida de la Paz 10', '987654321', 'Barcelona', 'Barcelona', '08001', '87654321B', 'SS87654321', 'C67890', 'interino'),
('Carlos López', 'Calle del Sol 5', '234567890', 'Valencia', 'Valencia', '46001', '23456789C', 'SS23456789', 'C11223', 'sustituto'),
('María González', 'Paseo de Gracia 15', '876543210', 'Sevilla', 'Sevilla', '41001', '34567890D', 'SS34567890', 'C44556', 'titular'),
('Luis Fernández', 'Calle de la Luna 3', '345678901', 'Bilbao', 'Vizcaya', '48001', '45678901E', 'SS45678901', 'C77889', 'interino'),
('Isabel Martínez', 'Gran Vía 22', '456789012', 'Zaragoza', 'Zaragoza', '50001', '56789012F', 'SS56789012', 'C99112', 'sustituto'),
('Javier Sánchez', 'Calle Real 8', '567890123', 'Málaga', 'Málaga', '29001', '67890123G', 'SS67890123', 'C33445', 'titular'),
('Laura Díaz', 'Avenida Libertad 17', '678901234', 'Murcia', 'Murcia', '30001', '78901234H', 'SS78901234', 'C66778', 'interino'),
('Miguel Ramírez', 'Calle Nueva 6', '789012345', 'Granada', 'Granada', '18001', '89012345I', 'SS89012345', 'C99001', 'sustituto'),
('Carmen Torres', 'Plaza Mayor 2', '890123456', 'Alicante', 'Alicante', '03001', '90123456J', 'SS90123456', 'C22334', 'titular'),
('Pedro Ruiz', 'Calle San Juan 11', '901234567', 'Córdoba', 'Córdoba', '14001', '01234567K', 'SS01234567', 'C55667', 'interino'),
('Lucía Morales', 'Avenida Constitución 14', '012345678', 'Valladolid', 'Valladolid', '47001', '12345678L', 'SS12345678', 'C88990', 'sustituto'),
('Andrés Romero', 'Calle Victoria 9', '123456789', 'Oviedo', 'Asturias', '33001', '23456789M', 'SS23456789', 'C11223', 'titular'),
('Teresa Vázquez', 'Paseo del Prado 18', '234567890', 'Santander', 'Cantabria', '39001', '34567890N', 'SS34567890', 'C44556', 'interino'),
('Sergio Castillo', 'Calle Alcalá 4', '345678901', 'Gijón', 'Asturias', '33201', '45678901O', 'SS45678901', 'C77889', 'sustituto');

INSERT INTO Horario_Consultas (ID_Medico, Dia_Semana, Hora_Inicio, Hora_Fin) VALUES
(1, 'Lunes', '08:00:00', '12:00:00'),
(2, 'Martes', '09:00:00', '13:00:00'),
(3, 'Miércoles', '10:00:00', '14:00:00'),
(4, 'Jueves', '11:00:00', '15:00:00'),
(5, 'Viernes', '08:00:00', '12:00:00'),
(6, 'Sábado', '09:00:00', '13:00:00'),
(7, 'Domingo', '10:00:00', '14:00:00'),
(8, 'Lunes', '08:00:00', '12:00:00'),
(9, 'Martes', '09:00:00', '13:00:00'),
(10, 'Miércoles', '10:00:00', '14:00:00'),
(11, 'Jueves', '11:00:00', '15:00:00'),
(12, 'Viernes', '08:00:00', '12:00:00'),
(13, 'Sábado', '09:00:00', '13:00:00'),
(14, 'Domingo', '10:00:00', '14:00:00'),
(15, 'Lunes', '08:00:00', '12:00:00');

INSERT INTO Sustituciones (ID_Medico, Fecha_Alta, Fecha_Baja) VALUES
(1, '2023-01-01', '2023-02-01'),
(2, '2023-02-01', '2023-03-01'),
(3, '2023-03-01', '2023-04-01'),
(4, '2023-04-01', '2023-05-01'),
(5, '2023-05-01', '2023-06-01'),
(6, '2023-06-01', '2023-07-01'),
(7, '2023-07-01', '2023-08-01'),
(8, '2023-08-01', '2023-09-01'),
(9, '2023-09-01', '2023-10-01'),
(10, '2023-10-01', '2023-11-01'),
(11, '2023-11-01', '2023-12-01'),
(12, '2024-01-01', '2024-02-01'),
(13, '2024-02-01', '2024-03-01'),
(14, '2024-03-01', '2024-04-01'),
(15, '2024-04-01', '2024-05-01');

INSERT INTO Empleados (Nombre, Dirección, Teléfono, Población, Provincia, Código_Postal, NIF, Número_Seguridad_Social, Tipo) VALUES
('Antonio Navarro', 'Calle del Mar 21', '234567890', 'Madrid', 'Madrid', '28001', '34567890P', 'SS34567890', 'ATS'),
('Beatriz Herrero', 'Avenida de América 32', '345678901', 'Barcelona', 'Barcelona', '08001', '45678901Q', 'SS45678901', 'ATS_de_zona'),
('Clara Torres', 'Calle del Norte 45', '456789012', 'Valencia', 'Valencia', '46001', '56789012R', 'SS56789012', 'auxiliar_de_enfermería'),
('David Marín', 'Plaza del Oeste 11', '567890123', 'Sevilla', 'Sevilla', '41001', '67890123S', 'SS67890123', 'celador'),
('Elena Moya', 'Avenida del Sur 34', '678901234', 'Bilbao', 'Vizcaya', '48001', '78901234T', 'SS78901234', 'administrativo'),
('Fernando Rivas', 'Calle Central 27', '789012345', 'Zaragoza', 'Zaragoza', '50001', '89012345U', 'SS89012345', 'ATS'),
('Gabriela Cruz', 'Calle del Este 19', '890123456', 'Málaga', 'Málaga', '29001', '90123456V', 'SS90123456', 'ATS_de_zona'),
('Hugo Gómez', 'Avenida de la Paz 41', '901234567', 'Murcia', 'Murcia', '30001', '01234567W', 'SS01234567', 'auxiliar_de_enfermería'),
('Irene Ortega', 'Calle Nueva 14', '012345678', 'Granada', 'Granada', '18001', '12345678X', 'SS12345678', 'celador'),
('Jorge Sanz', 'Plaza Vieja 7', '123456789', 'Alicante', 'Alicante', '03001', '23456789Y', 'SS23456789', 'administrativo'),
('Karla Márquez', 'Calle Mayor 1', '234567890', 'Córdoba', 'Córdoba', '14001', '34567890Z', 'SS34567890', 'ATS'),
('Luis Fernández', 'Avenida del Sol 22', '345678901', 'Valladolid', 'Valladolid', '47001', '45678901A', 'SS45678901', 'ATS_de_zona'),
('María Gil', 'Calle Real 33', '456789012', 'Oviedo', 'Asturias', '33001', '56789012B', 'SS56789012', 'auxiliar_de_enfermería'),
('Nicolás Peña', 'Plaza Central 16', '567890123', 'Santander', 'Cantabria', '39001', '67890123C', 'SS67890123', 'celador'),
('Olga Castillo', 'Calle Mayor 2', '678901234', 'Gijón', 'Asturias', '33201', '78901234D', 'SS78901234', 'administrativo');

INSERT INTO Vacaciones (ID_Medico, ID_Empleado, Fecha_Inicio, Fecha_Fin, Estado) VALUES
(1, 1, '2024-06-01', '2024-06-15', 'planificadas'),
(2, 2, '2024-06-15', '2024-06-30', 'disfrutadas'),
(3, 3, '2024-07-01', '2024-07-15', 'planificadas'),
(4, 4, '2024-07-15', '2024-07-30', 'disfrutadas'),
(5, 5, '2024-08-01', '2024-08-15', 'planificadas'),
(6, 6, '2024-08-15', '2024-08-30', 'disfrutadas'),
(7, 7, '2024-09-01', '2024-09-15', 'planificadas'),
(8, 8, '2024-09-15', '2024-09-30', 'disfrutadas'),
(9, 9, '2024-10-01', '2024-10-15', 'planificadas'),
(10, 10, '2024-10-15', '2024-10-30', 'disfrutadas'),
(11, 11, '2024-11-01', '2024-11-15', 'planificadas'),
(12, 12, '2024-11-15', '2024-11-30', 'disfrutadas'),
(13, 13, '2024-12-01', '2024-12-15', 'planificadas'),
(14, 14, '2024-12-15', '2024-12-30', 'disfrutadas'),
(15, 15, '2025-01-01', '2025-01-15', 'planificadas');

INSERT INTO Pacientes (ID_Medico, Nombre, Dirección, Teléfono, Código_Postal, NIF, Número_Seguridad_Social) VALUES
(1, 'Carlos Pérez', 'Calle del Olivo 10', '987654321', '28001', '87654321A', 'SS87654321A'),
(2, 'Ana López', 'Avenida del Prado 15', '876543210', '08001', '76543210B', 'SS76543210B'),
(3, 'María Gómez', 'Calle del Parque 22', '765432109', '46001', '65432109C', 'SS65432109C'),
(4, 'Luis Hernández', 'Paseo de las Flores 8', '654321098', '41001', '54321098D', 'SS54321098D'),
(5, 'Carmen Ruiz', 'Calle de la Estrella 17', '543210987', '48001', '43210987E', 'SS43210987E'),
(6, 'Javier Torres', 'Gran Vía 3', '432109876', '50001', '32109876F', 'SS32109876F'),
(7, 'Laura Ramírez', 'Calle Nueva 21', '321098765', '29001', '21098765G', 'SS21098765G'),
(8, 'Miguel Sánchez', 'Avenida de la Luz 14', '210987654', '30001', '10987654H', 'SS10987654H'),
(9, 'Teresa Fernández', 'Calle Real 6', '109876543', '18001', '09876543I', 'SS09876543I'),
(10, 'Pedro Díaz', 'Plaza Mayor 12', '098765432', '03001', '98765432J', 'SS98765432J'),
(11, 'Isabel Ortega', 'Calle del Mar 7', '987654321', '14001', '87654321K', 'SS87654321K'),
(12, 'Antonio Vázquez', 'Avenida Libertad 5', '876543210', '47001', '76543210L', 'SS76543210L'),
(13, 'Beatriz Rivas', 'Calle San Juan 13', '765432109', '33001', '65432109M', 'SS65432109M'),
(14, 'Clara Navarro', 'Plaza Nueva 9', '654321098', '39001', '54321098N', 'SS54321098N'),
(15, 'David Castillo', 'Calle Mayor 4', '543210987', '33201', '43210987O', 'SS43210987O');
