TRUNCATE asistencia, cargos, clientes, compras_inventario, dias, dias_turnos, empleados, factura,
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

INSERT INTO sucursales (direccion, id_lugar)
VALUES
  ('Edif Valmy, Avenida Francisco de Miranda', (SELECT id from lugares_geo WHERE nombre = 'Chacao')),
  ('Calle Urdaneta', (SELECT id from lugares_geo WHERE nombre = 'Chacao')),
  ('Calle Sucre', (SELECT id from lugares_geo WHERE nombre = 'Baruta')),
  ('Final Av Intercomunial El Hatillo', (SELECT id from lugares_geo WHERE nombre = 'Baruta')),
  ('Veracruz', (SELECT id from lugares_geo WHERE nombre = 'Libertador')),
  ('Av. Andres Bello', (SELECT id from lugares_geo WHERE nombre = 'Libertador'));

INSERT INTO empleados (datos, genero, fecha_nacimiento, activo, id_sucursal) VALUES  (check_null_datos('John', 'Doe', 'Smith', 'Johnson', 'Calle Principal 123', unique_cedula(format_cedula('V-1234567'),'empleados'), '555-1234'), 'M', '1990-01-01', true,1);
INSERT INTO empleados (datos, genero, fecha_nacimiento, activo, id_sucursal) VALUES  (check_null_datos('Robert', 'Lee', 'Williams', 'Brown', 'Carrera 789', unique_cedula(format_cedula('V-2468135'),'empleados'), '555-9012'), 'M', '1993-11-15', true,1);
INSERT INTO empleados (datos, genero, fecha_nacimiento, activo, id_sucursal) VALUES  (check_null_datos('Emily', 'Rose', 'Taylor', 'Clark', 'Avenida 987', unique_cedula(format_cedula('V-5432167'),'empleados'), '555-3456'), 'F', '1992-09-20', true,1);
INSERT INTO empleados (datos, genero, fecha_nacimiento, activo, id_sucursal) VALUES  (check_null_datos('Jane', 'Mary', 'Johnson', 'Doe', 'Avenida Central 456', unique_cedula(format_cedula('V-9876543'),'empleados'), '555-5678'), 'F', '1985-05-10', true,2);
INSERT INTO empleados (datos, genero, fecha_nacimiento, activo, id_sucursal) VALUES  (check_null_datos('Michael', 'James', 'Anderson', 'Wilson', 'Boulevard 654', unique_cedula(format_cedula('V-7896543'),'empleados'), '555-7890'), 'M', '1988-07-05', true,2);
INSERT INTO empleados (datos, genero, fecha_nacimiento, activo, id_sucursal) VALUES  (check_null_datos('Sophia', 'Grace', 'Parker', 'Cooper', 'Avenida 321', unique_cedula(format_cedula('V-3214567'),'empleados'), '555-2345'), 'F', '1991-03-08', true,2);
INSERT INTO empleados (datos, genero, fecha_nacimiento, activo, id_sucursal) VALUES  (check_null_datos('David', 'Thomas', 'Green', 'White', 'Calle 654', unique_cedula(format_cedula('V-1357924'),'empleados'), '555-6789'), 'M', '1987-12-25', true,3);
INSERT INTO empleados (datos, genero, fecha_nacimiento, activo, id_sucursal) VALUES  (check_null_datos('Olivia', 'Isabella', 'Harris', 'Martin', 'Carrera 987', unique_cedula(format_cedula('V-9872134'),'empleados'), '555-9012'), 'F', '1994-06-30', true,3);

INSERT INTO historico_salario (id_empleado, fecha_inicio, salario)
VALUES
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'John'), '08-12-2012', 600),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Jane'), '08-25-2020', 500),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Robert'), '08-12-2012', 400),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Emily'), '08-12-2012', 600),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Michael'), '08-12-2019', 350),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Sophia'), '08-12-2017', 300),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'David'), '08-12-2018', 200),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Olivia'), '08-25-2018', 250);

INSERT INTO cargos (nombre)
VALUES
  ('Gerente'), ('Supervisor'), ('Cajero'),
  ('Conserje'), ('Empaquetador'), ('Carnicero');

INSERT INTO historico_cargo (id_empleado, id_cargo, fecha_inicio)
VALUES
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'John'), (SELECT id FROM cargos WHERE nombre = 'Gerente'), '08-12-2012'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Jane'), (SELECT id FROM cargos WHERE nombre = 'Supervisor'), '08-25-2020'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Robert'), (SELECT id FROM cargos WHERE nombre = 'Carnicero'), '08-12-2012'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Emily'), (SELECT id FROM cargos WHERE nombre = 'Gerente'), '08-12-2012'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Michael'), (SELECT id FROM cargos WHERE nombre = 'Cajero'), '08-12-2019'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Sophia'), (SELECT id FROM cargos WHERE nombre = 'Cajero'), '08-12-2017'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'David'), (SELECT id FROM cargos WHERE nombre = 'Empaquetador'), '08-12-2018'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Olivia'), (SELECT id FROM cargos WHERE nombre = 'Conserje'), '08-25-2018');

INSERT INTO turnos (nombre)
VALUES
  ('Diurno entre semana'), ('Diurno fines de semana'), ('Nocturno entre semana'), ('Nocturno fines de semana');

INSERT INTO dias (nombre)
VALUES
  ('Lunes'), ('Martes'), ('Miércoles'),
  ('Jueves'), ('Viernes'), ('Sábado'), ('Domingo');

INSERT INTO dias_turnos (id_dia, id_turno, hora_entrada, hora_salida)
VALUES
  ((SELECT id FROM dias WHERE nombre = 'Lunes'), (SELECT id FROM turnos WHERE nombre = 'Diurno entre semana'), '08:00:00', '17:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Martes'), (SELECT id FROM turnos WHERE nombre = 'Diurno entre semana'), '08:00:00', '17:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Miércoles'), (SELECT id FROM turnos WHERE nombre = 'Diurno entre semana'), '08:00:00', '17:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Jueves'), (SELECT id FROM turnos WHERE nombre = 'Diurno entre semana'), '08:00:00', '17:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Viernes'), (SELECT id FROM turnos WHERE nombre = 'Diurno entre semana'), '08:00:00', '17:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Lunes'), (SELECT id FROM turnos WHERE nombre = 'Nocturno entre semana'), '16:00:00', '22:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Martes'), (SELECT id FROM turnos WHERE nombre = 'Nocturno entre semana'), '16:00:00', '22:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Miércoles'), (SELECT id FROM turnos WHERE nombre = 'Nocturno entre semana'), '16:00:00', '22:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Jueves'), (SELECT id FROM turnos WHERE nombre = 'Nocturno entre semana'), '16:00:00', '22:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Viernes'), (SELECT id FROM turnos WHERE nombre = 'Nocturno entre semana'), '16:00:00', '22:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Viernes'), (SELECT id FROM turnos WHERE nombre = 'Diurno fines de semana'), '08:00:00', '17:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Sábado'), (SELECT id FROM turnos WHERE nombre = 'Diurno fines de semana'), '08:00:00', '17:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Domingo'), (SELECT id FROM turnos WHERE nombre = 'Diurno fines de semana'), '09:00:00', '17:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Lunes'), (SELECT id FROM turnos WHERE nombre = 'Diurno fines de semana'), '08:00:00', '17:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Martes'), (SELECT id FROM turnos WHERE nombre = 'Diurno fines de semana'), '08:00:00', '17:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Viernes'), (SELECT id FROM turnos WHERE nombre = 'Nocturno fines de semana'), '16:00:00', '22:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Sábado'), (SELECT id FROM turnos WHERE nombre = 'Nocturno fines de semana'), '16:00:00', '22:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Domingo'), (SELECT id FROM turnos WHERE nombre = 'Nocturno fines de semana'), '16:00:00', '21:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Lunes'), (SELECT id FROM turnos WHERE nombre = 'Nocturno fines de semana'), '16:00:00', '22:00:00'),
  ((SELECT id FROM dias WHERE nombre = 'Martes'), (SELECT id FROM turnos WHERE nombre = 'Nocturno fines de semana'), '16:00:00', '22:00:00');

INSERT INTO historico_turno (id_empleado, id_turno, fecha_inicio)
VALUES
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'John'), (SELECT id FROM turnos WHERE nombre = 'Diurno entre semana'), '08-12-2012'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Jane'), (SELECT id FROM turnos WHERE nombre = 'Diurno entre semana'), '08-25-2020'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Robert'), (SELECT id FROM turnos WHERE nombre = 'Nocturno entre semana'), '08-12-2012'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Emily'), (SELECT id FROM turnos WHERE nombre = 'Nocturno entre semana'), '08-12-2012'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Michael'), (SELECT id FROM turnos WHERE nombre = 'Diurno fines de semana'), '08-12-2019'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Sophia'), (SELECT id FROM turnos WHERE nombre = 'Diurno fines de semana'), '08-12-2017'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'David'), (SELECT id FROM turnos WHERE nombre = 'Nocturno fines de semana'), '08-12-2018'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Olivia'), (SELECT id FROM turnos WHERE nombre = 'Nocturno fines de semana'), '08-25-2018');

INSERT INTO asistencia (id_empleado,id_turno,fecha_turno,fecha,hora_entrada,hora_salida,motivo_ausencia)
VALUES
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'John'), (SELECT id FROM turnos WHERE nombre = 'Diurno entre semana'), '08-12-2012','03-15-2022','07:58:00','17:05:00',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'John'), (SELECT id FROM turnos WHERE nombre = 'Diurno entre semana'), '08-12-2012','03-16-2022','08:02:00','17:06:22',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'John'), (SELECT id FROM turnos WHERE nombre = 'Diurno entre semana'), '08-12-2012','03-17-2022','08:30:13','17:45:21',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Jane'), (SELECT id FROM turnos WHERE nombre = 'Diurno entre semana'), '08-25-2020','03-15-2022',NULL,NULL,'Cita médica'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Jane'), (SELECT id FROM turnos WHERE nombre = 'Diurno entre semana'), '08-25-2020','03-16-2022','07:55:51','16:58:10',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Jane'), (SELECT id FROM turnos WHERE nombre = 'Diurno entre semana'), '08-25-2020','03-17-2022','07:59:30','17:01:12',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Robert'), (SELECT id FROM turnos WHERE nombre = 'Nocturno entre semana'), '08-12-2012','03-15-2022','16:15:01','22:10:03',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Robert'), (SELECT id FROM turnos WHERE nombre = 'Nocturno entre semana'), '08-12-2012','03-16-2022','16:02:29','22:10:03',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Robert'), (SELECT id FROM turnos WHERE nombre = 'Nocturno entre semana'), '08-12-2012','03-17-2022','15:59:59','22:01:01',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Emily'), (SELECT id FROM turnos WHERE nombre = 'Nocturno entre semana'), '08-12-2012','03-15-2022','16:05:15','21:45:10',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Emily'), (SELECT id FROM turnos WHERE nombre = 'Nocturno entre semana'), '08-12-2012','03-16-2022','16:04:10','21:40:15',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Emily'), (SELECT id FROM turnos WHERE nombre = 'Nocturno entre semana'), '08-12-2012','03-17-2022',NULL,NULL,'Infección viral'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Michael'), (SELECT id FROM turnos WHERE nombre = 'Diurno fines de semana'), '08-12-2019','03-15-2022','08:09:11','16:59:41',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Michael'), (SELECT id FROM turnos WHERE nombre = 'Diurno fines de semana'), '08-12-2019','03-16-2022','08:03:23','16:58:22',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Michael'), (SELECT id FROM turnos WHERE nombre = 'Diurno fines de semana'), '08-12-2019','03-17-2022','08:02:58','17:10:45',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Sophia'), (SELECT id FROM turnos WHERE nombre = 'Diurno fines de semana'), '08-12-2017','03-15-2022','08:02:09','17:10:45',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Sophia'), (SELECT id FROM turnos WHERE nombre = 'Diurno fines de semana'), '08-12-2017','03-16-2022',NULL,NULL,'Lele panza'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Sophia'), (SELECT id FROM turnos WHERE nombre = 'Diurno fines de semana'), '08-12-2017','03-17-2022','07:52:12','17:01:12',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'David'), (SELECT id FROM turnos WHERE nombre = 'Nocturno fines de semana'), '08-12-2018','03-15-2022','16:30:34','22:01:11',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'David'), (SELECT id FROM turnos WHERE nombre = 'Nocturno fines de semana'), '08-12-2018','03-16-2022','16:12:02','21:56:12',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'David'), (SELECT id FROM turnos WHERE nombre = 'Nocturno fines de semana'), '08-12-2018','03-17-2022','15:56:12','22:09:22',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Olivia'), (SELECT id FROM turnos WHERE nombre = 'Nocturno fines de semana'), '08-25-2018','03-15-2022','16:01:15','22:02:42',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Olivia'), (SELECT id FROM turnos WHERE nombre = 'Nocturno fines de semana'), '08-25-2018','03-16-2022','15:56:55','22:01:29',NULL),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Olivia'), (SELECT id FROM turnos WHERE nombre = 'Nocturno fines de semana'), '08-25-2018','03-17-2022','16:57:12','22:06:10',NULL);

INSERT INTO clientes (datos) VALUES (check_null_datos('Luis', 'Miguel', 'Sánchez', 'Gómez', 'Calle Principal 123', unique_cedula(format_cedula('V-25469789'),'clientes'), '555-1234'));
INSERT INTO clientes (datos) VALUES (check_null_datos('María', 'Fernanda', 'Rodríguez', 'López', 'Avenida Central 456',  unique_cedula(format_cedula('V-15478963'),'clientes'), '555-5678'));
INSERT INTO clientes (datos) VALUES (check_null_datos('Carlos', 'Andrés', 'González', 'Rivas', 'Carrera 789',  unique_cedula(format_cedula('V-21647896'),'clientes'), '555-9012'));
INSERT INTO clientes (datos) VALUES (check_null_datos('Ana', 'Isabel', 'Torres', 'Martínez', 'Avenida 987',  unique_cedula(format_cedula('V-6978456'),'clientes'), '555-3456'));
INSERT INTO clientes (datos) VALUES (check_null_datos('Javier', 'Alejandro', 'Hernández', 'Castro', 'Boulevard 654',  unique_cedula(format_cedula('V-15698746'),'clientes'), '555-7890'));
INSERT INTO clientes (datos) VALUES (check_null_datos('Laura', 'Carolina', 'Pérez', 'Vargas', 'Avenida 321',  unique_cedula(format_cedula('V-9645721'),'clientes'), '555-2345'));
INSERT INTO clientes (datos) VALUES (check_null_datos('Diego', 'Sebastián', 'Ramírez', 'Rojas', 'Calle 654',  unique_cedula(format_cedula('V-14451214'),'clientes'), '555-6789'));
INSERT INTO clientes (datos) VALUES (check_null_datos('Valeria', 'Florencia', 'Silva', 'Luna', 'Carrera 987',  unique_cedula(format_cedula('V-13564897'),'clientes'), '555-9012'));

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


INSERT INTO historico_gastos_particulares (id_sucursal, fecha, monto, descripcion)
VALUES
  ((SELECT id FROM sucursales WHERE direccion = 'Edif Valmy, Avenida Francisco de Miranda'), '08-19-2017', 50, 'Reparo de nevera'),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'), '08-19-2018', 80, 'Mantenimiento de cajeros'),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'), '08-19-2019', 30, 'Mantenimiento de neveras'),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'), '08-19-2021', 300, 'Compra de equipos de refrigeracion'),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'), '08-10-2021', 30, 'Productos de limpieza'),
  ((SELECT id FROM sucursales WHERE direccion = 'Veracruz'), '08-19-2022', 200, 'Gastos legales'),
  ((SELECT id FROM sucursales WHERE direccion = 'Veracruz'), '08-19-2022', 70, 'Mantenimiento de luces');

INSERT INTO historico_alquiler (id_sucursal, fecha, monto)
VALUES
  ((SELECT id FROM sucursales WHERE direccion = 'Edif Valmy, Avenida Francisco de Miranda'), '08-19-2005', 950),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'), '08-19-2006', 1200),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'), '08-19-2008', 700),
  ((SELECT id FROM sucursales WHERE direccion = 'Final Av Intercomunial El Hatillo'), '08-19-2004', 800),
  ((SELECT id FROM sucursales WHERE direccion = 'Veracruz'), '08-19-2005', 450),
  ((SELECT id FROM sucursales WHERE direccion = 'Av. Andres Bello'), '08-19-2007', 300);

INSERT INTO factura (id_cliente, id_empleado, fecha, monto)
VALUES
  ((SELECT id FROM clientes WHERE (datos).nombre1 = 'Luis'), (SELECT id FROM empleados WHERE (datos).nombre1 = 'John'), '10-21-2023', 65.7),
  ((SELECT id FROM clientes WHERE (datos).nombre1 = 'Luis'), (SELECT id FROM empleados WHERE (datos).nombre1 = 'Jane'), '10-01-2023', 150.2),
  ((SELECT id FROM clientes WHERE (datos).nombre1 = 'Luis'), (SELECT id FROM empleados WHERE (datos).nombre1 = 'Robert'), '05-19-2023', 89.6),
  ((SELECT id FROM clientes WHERE (datos).nombre1 = 'Carlos'), (SELECT id FROM empleados WHERE (datos).nombre1 = 'Robert'), '05-19-2022', 15.1),
  ((SELECT id FROM clientes WHERE (datos).nombre1 = 'Carlos'), (SELECT id FROM empleados WHERE (datos).nombre1 = 'David'), '07-19-2022', 95.9),
  ((SELECT id FROM clientes WHERE (datos).nombre1 = 'Carlos'), (SELECT id FROM empleados WHERE (datos).nombre1 = 'Olivia'), '05-19-2023', 210.6),
  ((SELECT id FROM clientes WHERE (datos).nombre1 = 'Javier'), (SELECT id FROM empleados WHERE (datos).nombre1 = 'Robert'), '11-02-2022', 23.1),
  ((SELECT id FROM clientes WHERE (datos).nombre1 = 'Laura'), (SELECT id FROM empleados WHERE (datos).nombre1 = 'David'), '12-29-2022', 49.9),
  ((SELECT id FROM clientes WHERE (datos).nombre1 = 'Diego'), (SELECT id FROM empleados WHERE (datos).nombre1 = 'Olivia'), '12-01-2023', 60.6);

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

INSERT INTO compras_inventario (id_sucursal, id_producto)
VALUES
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'),(SELECT id FROM productos WHERE nombre = 'Harina PAN')),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'),(SELECT id FROM productos WHERE nombre = 'Pan')),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'),(SELECT id FROM productos WHERE nombre = 'Coca-cola')),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'),(SELECT id FROM productos WHERE nombre = 'Pan')),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'),(SELECT id FROM productos WHERE nombre = 'Oreo')),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'),(SELECT id FROM productos WHERE nombre = 'Leche')),
  ((SELECT id FROM sucursales WHERE direccion = 'Av. Andres Bello'),(SELECT id FROM productos WHERE nombre = 'Pasta')),
  ((SELECT id FROM sucursales WHERE direccion = 'Av. Andres Bello'),(SELECT id FROM productos WHERE nombre = 'Carton de huevos')),
  ((SELECT id FROM sucursales WHERE direccion = 'Av. Andres Bello'),(SELECT id FROM productos WHERE nombre = 'Pasta'));


INSERT INTO proveedores_compras_inventario (id_compra_inventario, id_proveedor, fecha, cantidad, precio_unidad, gasto_transporte)
VALUES
  (1, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '10-21-2023', 60, 0.8, 5),
  (2, (SELECT id FROM proveedores WHERE nombre = 'Bimbo'), '10-21-2023', 70, 0.8, 5),
  (3, (SELECT id FROM proveedores WHERE nombre = 'Pepsico'), '10-21-2023', 50, 0.75, 8),
  (4, (SELECT id FROM proveedores WHERE nombre = 'Bimbo'), '05-16-2023', 50, 2, 6),
  (4, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '05-17-2023', 50, 2, 5),
  (5, (SELECT id FROM proveedores WHERE nombre = 'Nabisco'), '05-01-2023', 60, 2, 7),
  (6, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '05-01-2023', 30, 1.5, 7),
  (7, (SELECT id FROM proveedores WHERE nombre = 'Pepsico'), '05-01-2023', 50, 1.5, 7),
  (7, (SELECT id FROM proveedores WHERE nombre = 'Bimbo'), '05-01-2023', 40, 1.5, 7),
  (7, (SELECT id FROM proveedores WHERE nombre = 'Pepsico'), '05-06-2023', 40, 1.5, 7),
  (8, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '05-06-2023', 40, 1.5, 7),
  (9, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '06-15-2023', 60, 1.5, 7);
