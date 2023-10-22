TRUNCATE asistencia, cargos, clientes, compra_inventario, dias, dias_turnos, empleados, factura,
historico_alquiler, historico_cargo, historico_gastos_particulares, historico_precios, historico_promociones,
historico_salario, historico_turno, lugares_geo, productos, proveedores, sucursales, turnos CASCADE;

INSERT INTO productos (nombre, descripcion)
VALUES
  ('Pan', 'Pan cuadrado para hacer sanduches'),
  ('Carton de huevos', 'Carton de 12 huevos de gallina'),
  ('Leche', 'Carton de leche de larga duracion'),
  ('Pasta', 'Medio kilo de pasta estilo spaghetti'),
  ('Harina PAN', 'Harina de maiz para hacer arepas y empanadas'),
  ('Tosticos', 'Hojuelas de maiz fritas'),
  ('Oreo', 'Galletas de chocolate y crema de vainilla'),
  ('Coca-cola', 'Bebida azucarada efervescente');

INSERT INTO historico_precios (id_producto, fecha_inicio, precio)
VALUES
  ((SELECT id FROM productos WHERE nombre = 'Pan'), '10-21-2020', 4),
  ((SELECT id FROM productos WHERE nombre = 'Carton de huevos'), '10-21-2020', 3.5),
  ((SELECT id FROM productos WHERE nombre = 'Leche'), '10-21-2020', 4),
  ((SELECT id FROM productos WHERE nombre = 'Pasta'), '10-21-2020', 2.5),
  ((SELECT id FROM productos WHERE nombre = 'Harina PAN'), '10-21-2020', 1.5),
  ((SELECT id FROM productos WHERE nombre = 'Tosticos'), '10-21-2020', 3.7),
  ((SELECT id FROM productos WHERE nombre = 'Oreo'), '10-21-2020', 4),
  ((SELECT id FROM productos WHERE nombre = 'Coca-cola'), '10-21-2020', 3);

INSERT INTO historico_promociones (id_producto, fecha_inicio_precio, fecha_inicio, descuento)
VALUES
  ((SELECT id FROM productos WHERE nombre = 'Pan'), '10-21-2020', '10-21-2020', 5),
  ((SELECT id FROM productos WHERE nombre = 'Carton de huevos'), '10-21-2020', '10-21-2020', 5),
  ((SELECT id FROM productos WHERE nombre = 'Leche'), '10-21-2020', '10-21-2020', 5),
  ((SELECT id FROM productos WHERE nombre = 'Pasta'), '10-21-2020', '10-21-2020', 4),
  ((SELECT id FROM productos WHERE nombre = 'Harina PAN'), '10-21-2020', '10-21-2020', 4),
  ((SELECT id FROM productos WHERE nombre = 'Tosticos'), '10-21-2020', '10-21-2020', 4),
  ((SELECT id FROM productos WHERE nombre = 'Oreo'), '10-21-2020', '10-21-2020', 1),
  ((SELECT id FROM productos WHERE nombre = 'Coca-cola'), '10-21-2020', '10-21-2020', 1);

INSERT INTO empleados (nombre1, nombre2, apellido1, apellido2, direccion, numero_telefonico, genero, cedula_identidad, fecha_nacimiento, activo)
VALUES
  ('John', 'Doe', 'Smith', 'Johnson', 'Calle Principal 123', '555-1234', 'M', '1234567', '1990-01-01', true),
  ('Jane', 'Mary', 'Johnson', 'Doe', 'Avenida Central 456', '555-5678', 'F', '9876543', '1985-05-10', true),
  ('Robert', 'Lee', 'Williams', 'Brown', 'Carrera 789', '555-9012', 'M', '2468135', '1993-11-15', true),
  ('Emily', 'Rose', 'Taylor', 'Clark', 'Avenida 987', '555-3456', 'F', '5432167', '1992-09-20', true),
  ('Michael', 'James', 'Anderson', 'Wilson', 'Boulevard 654', '555-7890', 'M', '7896543', '1988-07-05', true),
  ('Sophia', 'Grace', 'Parker', 'Cooper', 'Avenida 321', '555-2345', 'F', '3214567', '1991-03-08', true),
  ('David', 'Thomas', 'Green', 'White', 'Calle 654', '555-6789', 'M', '1357924', '1987-12-25', true),
  ('Olivia', 'Isabella', 'Harris', 'Martin', 'Carrera 987', '555-9012', 'F', '9872134', '1994-06-30', true);

INSERT INTO historico_salario (id_empleado, fecha_inicio, salario)
VALUES
  ((SELECT id FROM empleados WHERE nombre1 = 'John'), '08-12-2012', 600),
  ((SELECT id FROM empleados WHERE nombre1 = 'Jane'), '08-25-2020', 500),
  ((SELECT id FROM empleados WHERE nombre1 = 'Robert'), '08-12-2012', 400),
  ((SELECT id FROM empleados WHERE nombre1 = 'Emily'), '08-12-2012', 600),
  ((SELECT id FROM empleados WHERE nombre1 = 'Michael'), '08-12-2019', 350),
  ((SELECT id FROM empleados WHERE nombre1 = 'Sophia'), '08-12-2017', 300),
  ((SELECT id FROM empleados WHERE nombre1 = 'David'), '08-12-2018', 200),
  ((SELECT id FROM empleados WHERE nombre1 = 'Olivia'), '08-25-2018', 250);

INSERT INTO cargos (nombre)
VALUES
  ('Gerente'), ('Supervisor'), ('Cajero'),
  ('Conserje'), ('Empaquetador'), ('Carnicero');

INSERT INTO historico_cargo (id_empleado, id_cargo, fecha_inicio)
VALUES
  ((SELECT id FROM empleados WHERE nombre1 = 'John'), (SELECT id FROM cargos WHERE nombre = 'Gerente'), '08-12-2012'),
  ((SELECT id FROM empleados WHERE nombre1 = 'Jane'), (SELECT id FROM cargos WHERE nombre = 'Supervisor'), '08-25-2020'),
  ((SELECT id FROM empleados WHERE nombre1 = 'Robert'), (SELECT id FROM cargos WHERE nombre = 'Carnicero'), '08-12-2012'),
  ((SELECT id FROM empleados WHERE nombre1 = 'Emily'), (SELECT id FROM cargos WHERE nombre = 'Gerente'), '08-12-2012'),
  ((SELECT id FROM empleados WHERE nombre1 = 'Michael'), (SELECT id FROM cargos WHERE nombre = 'Cajero'), '08-12-2019'),
  ((SELECT id FROM empleados WHERE nombre1 = 'Sophia'), (SELECT id FROM cargos WHERE nombre = 'Cajero'), '08-12-2017'),
  ((SELECT id FROM empleados WHERE nombre1 = 'David'), (SELECT id FROM cargos WHERE nombre = 'Empaquetador'), '08-12-2018'),
  ((SELECT id FROM empleados WHERE nombre1 = 'Olivia'), (SELECT id FROM cargos WHERE nombre = 'Conserje'), '08-25-2018');

INSERT INTO turnos (nombre)
VALUES
  ('Mañana'), ('Tarde'), ('Noche');

INSERT INTO historico_turno (id_empleado, id_turno, fecha_inicio)
VALUES
  ((SELECT id FROM empleados WHERE nombre1 = 'John'), (SELECT id FROM turnos WHERE nombre = 'Mañana'), '08-12-2012'),
  ((SELECT id FROM empleados WHERE nombre1 = 'Jane'), (SELECT id FROM turnos WHERE nombre = 'Mañana'), '08-25-2020'),
  ((SELECT id FROM empleados WHERE nombre1 = 'Robert'), (SELECT id FROM turnos WHERE nombre = 'Tarde'), '08-12-2012'),
  ((SELECT id FROM empleados WHERE nombre1 = 'Emily'), (SELECT id FROM turnos WHERE nombre = 'Tarde'), '08-12-2012'),
  ((SELECT id FROM empleados WHERE nombre1 = 'Michael'), (SELECT id FROM turnos WHERE nombre = 'Mañana'), '08-12-2019'),
  ((SELECT id FROM empleados WHERE nombre1 = 'Sophia'), (SELECT id FROM turnos WHERE nombre = 'Noche'), '08-12-2017'),
  ((SELECT id FROM empleados WHERE nombre1 = 'David'), (SELECT id FROM turnos WHERE nombre = 'Noche'), '08-12-2018'),
  ((SELECT id FROM empleados WHERE nombre1 = 'Olivia'), (SELECT id FROM turnos WHERE nombre = 'Noche'), '08-25-2018');

INSERT INTO clientes (nombre1, nombre2, apellido1, apellido2, direccion, numero_telefonico)
VALUES
  ('Luis', 'Miguel', 'Sánchez', 'Gómez', 'Calle Principal 123', '555-1234'),
  ('María', 'Fernanda', 'Rodríguez', 'López', 'Avenida Central 456', '555-5678'),
  ('Carlos', 'Andrés', 'González', 'Rivas', 'Carrera 789', '555-9012'),
  ('Ana', 'Isabel', 'Torres', 'Martínez', 'Avenida 987', '555-3456'),
  ('Javier', 'Alejandro', 'Hernández', 'Castro', 'Boulevard 654', '555-7890'),
  ('Laura', 'Carolina', 'Pérez', 'Vargas', 'Avenida 321', '555-2345'),
  ('Diego', 'Sebastián', 'Ramírez', 'Rojas', 'Calle 654', '555-6789'),
  ('Valeria', 'Florencia', 'Silva', 'Luna', 'Carrera 987', '555-9012');

INSERT INTO proveedores (nombre, direccion, numero_telefonico)
VALUES
  ('Polar', 'Los Palos Grandes, calle la Goleada', '04123698745'),
  ('Pepsico', 'La Castellana, calle el Tartago', '04123697435'),
  ('Nabisco', 'El Rosal, calle el Perro', '04165698740'),
  ('Bimbo', 'Altamira, calle la Tucupita', '04127921682'),
  ('Capri', 'La Candelaria, calle la Rosita', '04166987742'),
  ('Santa Teresa', 'Maracay, hacienda Santa Teresa', '04149623301');

INSERT INTO lugares_geo (nombre, tipo)
VALUES
  ('Miranda', 'estado'), ('Zulia', 'estado'), ('Sucre', 'estado'),
  ('Bolivar', 'estado'), ('Aragua', 'estado'), ('Falcon', 'estado');

INSERT INTO lugares_geo (nombre, tipo, id_padre_lugar)
VALUES
  ('Caracas', 'ciudad', (SELECT id FROM lugares_geo WHERE nombre = 'Miranda')),
  ('Maracaibo', 'ciudad', (SELECT id FROM lugares_geo WHERE nombre = 'Zulia')),
  ('Maracay', 'ciudad', (SELECT id FROM lugares_geo WHERE nombre = 'Aragua')),
  ('Coro', 'ciudad', (SELECT id FROM lugares_geo WHERE nombre = 'Falcon')),
  ('Cumana', 'ciudad', (SELECT id FROM lugares_geo WHERE nombre = 'Sucre'));

INSERT INTO lugares_geo (nombre, tipo, id_padre_lugar)
VALUES
  ('Chacao', 'municipio', (SELECT id FROM lugares_geo WHERE nombre = 'Miranda')),
  ('Baruta', 'municipio', (SELECT id FROM lugares_geo WHERE nombre = 'Miranda')),
  ('Libertador', 'municipio', (SELECT id FROM lugares_geo WHERE nombre = 'Miranda')),
  ('Sucre', 'municipio', (SELECT id FROM lugares_geo WHERE nombre = 'Miranda'));

INSERT INTO sucursales (direccion, id_lugar)
VALUES
  ('Edif Valmy, Avenida Francisco de Miranda', (SELECT id from lugares_geo WHERE nombre = 'Chacao')),
  ('Calle Urdaneta', (SELECT id from lugares_geo WHERE nombre = 'Chacao')),
  ('Calle Sucre', (SELECT id from lugares_geo WHERE nombre = 'Baruta')),
  ('Final Av Intercomunial El Hatillo', (SELECT id from lugares_geo WHERE nombre = 'Baruta')),
  ('Veracruz', (SELECT id from lugares_geo WHERE nombre = 'Libertador')),
  ('Av. Andres Bello', (SELECT id from lugares_geo WHERE nombre = 'Libertador'));

-- todo: historico_gastos_particulares

INSERT INTO historico_alquiler (id_sucursal, fecha, monto)
VALUES
  ((SELECT id FROM sucursales WHERE direccion = 'Edif Valmy, Avenida Francisco de Miranda'), '08-19-2005', 950),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'), '08-19-2006', 1200),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'), '08-19-2008', 700),
  ((SELECT id FROM sucursales WHERE direccion = 'Final Av Intercomunial El Hatillo'), '08-19-2004', 800),
  ((SELECT id FROM sucursales WHERE direccion = 'Veracruz'), '08-19-2005', 450),
  ((SELECT id FROM sucursales WHERE direccion = 'Av. Andres Bello'), '08-19-2007', 300);

INSERT INTO dias (nombre)
VALUES
  ('Lunes'), ('Martes'), ('Miércoles'),
  ('Jueves'), ('Viernes'), ('Sábado'), ('Domingo');

INSERT INTO dias_turnos (id_dia, id_turno, hora_entrada, hora_salida)
VALUES
  ((SELECT id FROM dias WHERE nombre = 'Lunes'), (SELECT id FROM turnos WHERE nombre = 'Mañana'), '08:00:00', '17:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Martes'), (SELECT id FROM turnos WHERE nombre = 'Mañana'), '08:00:00', '17:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Miércoles'), (SELECT id FROM turnos WHERE nombre = 'Mañana'), '08:00:00', '17:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Jueves'), (SELECT id FROM turnos WHERE nombre = 'Mañana'), '08:00:00', '17:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Viernes'), (SELECT id FROM turnos WHERE nombre = 'Mañana'), '08:00:00', '17:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Sábado'), (SELECT id FROM turnos WHERE nombre = 'Mañana'), '08:00:00', '17:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Domingo'), (SELECT id FROM turnos WHERE nombre = 'Mañana'), '08:00:00', '17:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Lunes'), (SELECT id FROM turnos WHERE nombre = 'Tarde'), '13:00:00', '19:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Martes'), (SELECT id FROM turnos WHERE nombre = 'Noche'), '19:00:00', '24:00:00');

INSERT INTO factura (id_cliente, id_empleado, fecha, monto)
VALUES
  ((SELECT id FROM clientes WHERE nombre1 = 'Luis'), (SELECT id FROM empleados WHERE nombre1 = 'John'), '10-21-2023', 65.7),
  ((SELECT id FROM clientes WHERE nombre1 = 'Luis'), (SELECT id FROM empleados WHERE nombre1 = 'Jane'), '10-01-2023', 150.2),
  ((SELECT id FROM clientes WHERE nombre1 = 'Luis'), (SELECT id FROM empleados WHERE nombre1 = 'Robert'), '05-19-2023', 89.6),
  ((SELECT id FROM clientes WHERE nombre1 = 'Carlos'), (SELECT id FROM empleados WHERE nombre1 = 'Robert'), '05-19-2022', 15.1),
  ((SELECT id FROM clientes WHERE nombre1 = 'Carlos'), (SELECT id FROM empleados WHERE nombre1 = 'David'), '07-19-2022', 95.9),
  ((SELECT id FROM clientes WHERE nombre1 = 'Carlos'), (SELECT id FROM empleados WHERE nombre1 = 'Olivia'), '05-19-2023', 210.6),
  ((SELECT id FROM clientes WHERE nombre1 = 'Javier'), (SELECT id FROM empleados WHERE nombre1 = 'Robert'), '11-02-2022', 23.1),
  ((SELECT id FROM clientes WHERE nombre1 = 'Laura'), (SELECT id FROM empleados WHERE nombre1 = 'David'), '12-29-2022', 49.9),
  ((SELECT id FROM clientes WHERE nombre1 = 'Diego'), (SELECT id FROM empleados WHERE nombre1 = 'Olivia'), '12-01-2023', 60.6);

INSERT INTO detalle_factura (id_factura, id_producto, fecha_inicio_precio, cantidad)
VALUES
  ((SELECT id FROM factura WHERE monto = 65.7), (SELECT id FROM productos WHERE nombre = 'Pan'), '10-21-2020', 2),
  ((SELECT id FROM factura WHERE monto = 150.2), (SELECT id FROM productos WHERE nombre = 'Leche'), '10-21-2020', 1),
  ((SELECT id FROM factura WHERE monto = 89.6), (SELECT id FROM productos WHERE nombre = 'Pasta'), '10-21-2020', 2),
  ((SELECT id FROM factura WHERE monto = 15.1), (SELECT id FROM productos WHERE nombre = 'Tosticos'), '10-21-2020', 2),
  ((SELECT id FROM factura WHERE monto = 95.9), (SELECT id FROM productos WHERE nombre = 'Harina PAN'), '10-21-2020', 2),
  ((SELECT id FROM factura WHERE monto = 210.6), (SELECT id FROM productos WHERE nombre = 'Harina PAN'), '10-21-2020', 2),
  ((SELECT id FROM factura WHERE monto = 23.1), (SELECT id FROM productos WHERE nombre = 'Oreo'), '10-21-2020', 1),
  ((SELECT id FROM factura WHERE monto = 49.9), (SELECT id FROM productos WHERE nombre = 'Coca-cola'), '10-21-2020', 2),
  ((SELECT id FROM factura WHERE monto = 60.6), (SELECT id FROM productos WHERE nombre = 'Carton de huevos'), '10-21-2020', 1);

INSERT INTO compra_inventario (id_sucursal, id_proveedor, id_producto, fecha, cantidad, precio_unidad, gasto_transporte)
VALUES
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'), (SELECT id FROM proveedores WHERE nombre = 'Polar'), (SELECT id FROM productos WHERE nombre = 'Harina PAN'), '10-21-2023', 60, 0.8, 5),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'), (SELECT id FROM proveedores WHERE nombre = 'Polar'), (SELECT id FROM productos WHERE nombre = 'Harina PAN'), '10-21-2023', 70, 0.8, 5),
  ((SELECT id FROM sucursales WHERE direccion = 'Veracruz'), (SELECT id FROM proveedores WHERE nombre = 'Polar'), (SELECT id FROM productos WHERE nombre = 'Harina PAN'), '10-21-2023', 100, 0.75, 8),
  ((SELECT id FROM sucursales WHERE direccion = 'Av. Andres Bello'), (SELECT id FROM proveedores WHERE nombre = 'Nabisco'), (SELECT id FROM productos WHERE nombre = 'Oreo'), '05-16-2023', 40, 2, 6),
  ((SELECT id FROM sucursales WHERE direccion = 'Final Av Intercomunial El Hatillo'), (SELECT id FROM proveedores WHERE nombre = 'Nabisco'), (SELECT id FROM productos WHERE nombre = 'Oreo'), '05-30-2023', 30, 2, 5),
  ((SELECT id FROM sucursales WHERE direccion = 'Edif Valmy, Avenida Francisco de Miranda'), (SELECT id FROM proveedores WHERE nombre = 'Nabisco'), (SELECT id FROM productos WHERE nombre = 'Oreo'), '05-01-2023', 60, 2, 7),
  ((SELECT id FROM sucursales WHERE direccion = 'Edif Valmy, Avenida Francisco de Miranda'), (SELECT id FROM proveedores WHERE nombre = 'Bimbo'), (SELECT id FROM productos WHERE nombre = 'Pan'), '05-01-2023', 30, 1.5, 7),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'), (SELECT id FROM proveedores WHERE nombre = 'Bimbo'), (SELECT id FROM productos WHERE nombre = 'Pan'), '05-01-2023', 50, 1.5, 7),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'), (SELECT id FROM proveedores WHERE nombre = 'Bimbo'), (SELECT id FROM productos WHERE nombre = 'Pan'), '05-01-2023', 40, 1.5, 7);

