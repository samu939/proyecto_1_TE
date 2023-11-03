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
  ('Coca-cola', 'Bebida azucarada efervescente'),
  ('Manzana', 'Fruta roja'),
  ('Patilla', 'Fruta gigante verde'),
  ('Escobas', 'Herramienta de limpieza'),
  ('Barra de jabon', 'Producto de limpieza personal'),
  ('Cloro', 'Producto de limpieza del hogar'),
  ('Pera', 'Fruta verde'),
  ('Doritos', 'Tostadas de maiz con polvo de sabor a queso'),
  ('Pepsi', 'Bebida gaseosa azucarada'),
  ('Marilu', 'Galleta con crema relleno'),
  ('Vino Gato Negro', 'Vino tinto'),
  ('Cerveza Polar Lata', 'Polarcita en lata'),
  ('Ron Cacique', 'Ron añejo 15 años');

INSERT INTO historico_precios (id_producto, fecha_inicio, precio)
VALUES
  ((SELECT id FROM productos WHERE nombre = 'Pan'), '01-21-2023', 4),
  ((SELECT id FROM productos WHERE nombre = 'Carton de huevos'), '01-21-2023', 3.5),
  ((SELECT id FROM productos WHERE nombre = 'Leche'), '01-21-2023', 2.8),
  ((SELECT id FROM productos WHERE nombre = 'Pasta'), '01-21-2023', 2.5),
  ((SELECT id FROM productos WHERE nombre = 'Harina PAN'), '01-21-2023', 1.5),
  ((SELECT id FROM productos WHERE nombre = 'Tosticos'), '01-21-2023', 3.7),
  ((SELECT id FROM productos WHERE nombre = 'Oreo'), '01-21-2023', 2),
  ((SELECT id FROM productos WHERE nombre = 'Coca-cola'), '01-21-2023', 3),
  ((SELECT id FROM productos WHERE nombre = 'Manzana'), '01-21-2023', 1.5),
  ((SELECT id FROM productos WHERE nombre = 'Patilla'), '01-21-2023', 3),
  ((SELECT id FROM productos WHERE nombre = 'Escoba'), '01-21-2023', 8),
  ((SELECT id FROM productos WHERE nombre = 'Barra de jabon'), '01-21-2023', 1.5),
  ((SELECT id FROM productos WHERE nombre = 'Cloro'), '01-21-2023', 5),
  ((SELECT id FROM productos WHERE nombre = 'Pera'), '01-21-2023', 1.5),
  ((SELECT id FROM productos WHERE nombre = 'Doritos'), '01-21-2023', 2.7),
  ((SELECT id FROM productos WHERE nombre = 'Pepsi'), '01-21-2023', 2.5),
  ((SELECT id FROM productos WHERE nombre = 'Marilu'), '01-21-2023', 2),
  ((SELECT id FROM productos WHERE nombre = 'Vino Gato Negro'), '01-21-2023', 5),
  ((SELECT id FROM productos WHERE nombre = 'Cerveza Polar Lata'), '01-21-2023', 0.9),
  ((SELECT id FROM productos WHERE nombre = 'Ron Cacique'), '01-21-2023', 10);

INSERT INTO historico_promociones (id_producto, fecha_inicio_precio, fecha_inicio, fecha_fin,descuento)
VALUES
  ((SELECT id FROM productos WHERE nombre = 'Pan'), '01-21-2023', '02-21-2023','01-28-2023', 10),
  ((SELECT id FROM productos WHERE nombre = 'Carton de huevos'), '01-21-2023', '02-28-2023','03-28-2023', 5),
  ((SELECT id FROM productos WHERE nombre = 'Leche'), '01-21-2023', '03-10-2023','03-18-2023', 5),
  ((SELECT id FROM productos WHERE nombre = 'Pasta'), '01-21-2023', '04-24-2023','04-28-2023', 10),
  ((SELECT id FROM productos WHERE nombre = 'Harina PAN'), '01-21-2023', '05-27-2023','06-10-2023', 20),
  ((SELECT id FROM productos WHERE nombre = 'Tosticos'), '01-21-2023', '06-16-2023','06-26-2023', 5),
  ((SELECT id FROM productos WHERE nombre = 'Oreo'), '01-21-2023', '07-20-2023','07-28-2023', 15),
  ((SELECT id FROM productos WHERE nombre = 'Coca-cola'), '01-21-2023', '10-21-2023','10-28-2023', 10);

INSERT INTO sucursales (direccion, id_lugar)
VALUES
  ('Calle Urdaneta', (SELECT id from lugares_geo WHERE nombre = 'Chacao')),
  ('Calle Sucre', (SELECT id from lugares_geo WHERE nombre = 'Baruta')),
  ('Veracruz', (SELECT id from lugares_geo WHERE nombre = 'Libertador'));

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
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'John'), '01-01-2023', 600),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Jane'), '01-01-2023', 500),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Robert'), '01-01-2023', 400),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Emily'), '01-01-2023', 600),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Michael'), '01-01-2023', 350),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Sophia'), '01-01-2023', 300),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'David'), '01-01-2023', 200),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Olivia'), '01-01-2023', 250),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'John'), '04-01-2023', 660),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Jane'), '05-10-2023', 570),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Robert'), '02-01-2023', 500),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Emily'), '06-01-2023', 800),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Michael'), '01-15-2023', 450),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Sophia'), '03-20-2023', 380),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'David'), '07-01-2023', 400),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Olivia'), '09-01-2023', 300);

INSERT INTO cargos (nombre)
VALUES
  ('Gerente'), ('Supervisor'), ('Cajero'),
  ('Conserje'), ('Empaquetador'), ('Carnicero');

INSERT INTO historico_cargo (id_empleado, id_cargo, fecha_inicio)
VALUES
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'John'), (SELECT id FROM cargos WHERE nombre = 'Cajero'), '08-12-2012'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Jane'), (SELECT id FROM cargos WHERE nombre = 'Supervisor'), '08-25-2020'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Robert'), (SELECT id FROM cargos WHERE nombre = 'Carnicero'), '08-12-2012'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Emily'), (SELECT id FROM cargos WHERE nombre = 'Gerente'), '08-12-2012'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Michael'), (SELECT id FROM cargos WHERE nombre = 'Gerente'), '08-12-2019'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Sophia'), (SELECT id FROM cargos WHERE nombre = 'Cajero'), '08-12-2017'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'David'), (SELECT id FROM cargos WHERE nombre = 'Cajero'), '08-12-2018'),
  ((SELECT id FROM empleados WHERE (datos).nombre1 = 'Olivia'), (SELECT id FROM cargos WHERE nombre = 'Gerente'), '08-25-2018');

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
  ('Santa Teresa', 'Maracay, hacienda Santa Teresa', '04149623301'),
  ('Dove', 'La Trinidad, Piedra Azul', '0414825309'),
  ('Las Llaves', 'Santa Mónica', '04242549901'),
  ('Licores Mundiales', 'Prados del Este, Av. Principal', '04167453326');

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
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'), '01-08-2023', 80, 'Mantenimiento de cajeros'),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'), '01-12-2023', 30, 'Mantenimiento de neveras'),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'), '03-08-2023', 150, 'Compra de equipo computacional'),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'), '04-11-2023', 30, 'Reparacion filtracion de agua'),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'), '04-18-2023', 50, 'Gastos legales'),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'), '06-29-2023', 60, 'Pago a abogados'),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'), '07-01-2023', 80, 'Mantenimiento de anaqueles'),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'), '08-15-2023', 80, 'Mantenimiento de neveras'),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'), '01-20-2023', 80, 'Compra de equipos de refrigeracion'),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'), '03-21-2023', 40, 'Productos de limpieza'),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'), '03-26-2023', 30, 'Mantenimiento de neveras'),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'), '04-21-2023', 40, 'Productos de limpieza'),
  ((SELECT id FROM sucursales WHERE direccion = 'Veracruz'), '01-11-2023', 100, 'Gastos legales'),
  ((SELECT id FROM sucursales WHERE direccion = 'Veracruz'), '01-17-2023', 70, 'Mantenimiento de luces'),
  ((SELECT id FROM sucursales WHERE direccion = 'Veracruz'), '03-17-2023', 50, 'Mantenimiento de cajeros');

INSERT INTO historico_alquiler (id_sucursal, fecha, monto)
VALUES
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'), '01-01-2023', 500),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'), '01-01-2023', 500),
  ((SELECT id FROM sucursales WHERE direccion = 'Veracruz'), '01-01-2023', 500);
  
INSERT INTO factura (id_cliente, id_empleado, fecha, monto)
VALUES
  (1, 1, '01-21-2023', 17.5),
  (3, 1, '01-21-2023', 30.3),
  (5, 1, '01-22-2023', 12.3),
  (7, 11,'01-22-2022', 8.0),
  (9, 11,'01-23-2022', 12.4),
  (11, 11,'01-23-2023', 6.3),
  (13, 13,'01-24-2023', 13.5),
  (1, 13,'01-25-2023', 15.5),
  (15, 13,'01-26-2023', 10),
  (11, 13,'01-26-2023', 21);

INSERT INTO detalle_factura (id_factura, id_producto, fecha_inicio_precio, cantidad)
VALUES
  (1, 1, '01-21-2023', 2),
  (1, 2, '01-21-2023', 1),
  (1, 7, '01-21-2023', 3),

  (2, 5, '01-21-2023', 3),
  (2, 6, '01-21-2023', 4),
  (2, 8, '01-21-2023', 3),
  (2, 7, '01-21-2023', 1),

  (3, 1, '01-21-2023', 1),
  (3, 8, '01-21-2023', 1),
  (3, 3, '01-21-2023', 1),
  (3, 4, '01-21-2023', 2),

  (4, 4, '01-21-2023', 2),
  (4, 1, '01-21-2023', 1),
  (4, 5, '01-21-2023', 1),

  (5, 7, '01-21-2023', 1),
  (5, 6, '01-21-2023', 2),
  (5, 8, '01-21-2023', 1),

  (6, 2, '01-21-2023', 1),
  (6, 3, '01-21-2023', 1),

  (7, 4, '01-21-2023', 4),
  (7, 2, '01-21-2023', 1),

  (8, 1, '01-21-2023', 2),
  (8, 4, '01-21-2023', 3),

  (9, 6, '01-21-2023', 1),
  (9, 8, '01-21-2023', 1),

  (10, 1, '01-21-2023', 1),
  (10, 5, '01-21-2023', 2),
  (10, 4, '01-21-2023', 3),
  (10, 8, '01-21-2023', 1),
  (10, 2, '01-21-2023', 1);

INSERT INTO compras_inventario (id_sucursal, id_producto)
VALUES
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'),1),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'),2),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'),3),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'),4),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'),5),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'),6),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'),7),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Sucre'),8),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'),1),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'),2),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'),3),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'),4),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'),5),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'),6),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'),7),
  ((SELECT id FROM sucursales WHERE direccion = 'Calle Urdaneta'),8),
  ((SELECT id FROM sucursales WHERE direccion = 'Veracruz'),1),
  ((SELECT id FROM sucursales WHERE direccion = 'Veracruz'),2),
  ((SELECT id FROM sucursales WHERE direccion = 'Veracruz'),3),
  ((SELECT id FROM sucursales WHERE direccion = 'Veracruz'),4),
  ((SELECT id FROM sucursales WHERE direccion = 'Veracruz'),5),
  ((SELECT id FROM sucursales WHERE direccion = 'Veracruz'),6),
  ((SELECT id FROM sucursales WHERE direccion = 'Veracruz'),7),
  ((SELECT id FROM sucursales WHERE direccion = 'Veracruz'),8);

INSERT INTO proveedores_compras_inventario (id_compra_inventario, id_proveedor, fecha, cantidad, precio_unidad, gasto_transporte)
VALUES
  (1, (SELECT id FROM proveedores WHERE nombre = 'Bimbo'), '01-21-2023', 10, 1, 8),
  (1, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '01-22-2023', 8, 0.8, 9),
  (2, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '01-21-2023', 10, 1, 5),
  (3, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '01-21-2023', 10, 0.7, 6),
  (4, (SELECT id FROM proveedores WHERE nombre = 'Capri'), '01-21-2023', 10, 0.8, 4),
  (4, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '01-21-2023', 10, 0.9, 3),
  (5, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '01-21-2023', 10, 0.5, 3),
  (6, (SELECT id FROM proveedores WHERE nombre = 'Pepsico'), '01-21-2023', 8, 1.3, 5),
  (7, (SELECT id FROM proveedores WHERE nombre = 'Nabisco'), '01-21-2023', 5, 0.4, 2),
  (8, (SELECT id FROM proveedores WHERE nombre = 'Pepsico'), '01-21-2023', 10, 1, 4),
  (9, (SELECT id FROM proveedores WHERE nombre = 'Bimbo'), '01-21-2023', 10, 1, 8),
  (9, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '01-22-2023', 8, 0.8, 9),
  (10, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '01-21-2023', 10, 1, 5),
  (11, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '01-21-2023', 10, 0.7, 6),
  (12, (SELECT id FROM proveedores WHERE nombre = 'Capri'), '01-21-2023', 10, 0.8, 4),
  (12, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '01-21-2023', 10, 0.9, 3),
  (13, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '01-21-2023', 10, 0.5, 3),
  (14, (SELECT id FROM proveedores WHERE nombre = 'Pepsico'), '01-21-2023', 8, 1.3, 5),
  (15, (SELECT id FROM proveedores WHERE nombre = 'Nabisco'), '01-21-2023', 5, 0.4, 2),
  (16, (SELECT id FROM proveedores WHERE nombre = 'Pepsico'), '01-21-2023', 10, 1, 4),
  (17, (SELECT id FROM proveedores WHERE nombre = 'Bimbo'), '01-21-2023', 10, 1, 8),
  (17, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '01-22-2023', 8, 0.8, 9),
  (18, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '01-21-2023', 10, 1, 5),
  (19, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '01-21-2023', 10, 0.7, 6),
  (20, (SELECT id FROM proveedores WHERE nombre = 'Capri'), '01-21-2023', 10, 0.8, 4),
  (20, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '01-21-2023', 10, 0.9, 3),
  (21, (SELECT id FROM proveedores WHERE nombre = 'Polar'), '01-21-2023', 10, 0.5, 3),
  (22, (SELECT id FROM proveedores WHERE nombre = 'Pepsico'), '01-21-2023', 8, 1.3, 5),
  (23, (SELECT id FROM proveedores WHERE nombre = 'Nabisco'), '01-21-2023', 5, 0.4, 2),
  (24, (SELECT id FROM proveedores WHERE nombre = 'Pepsico'), '01-21-2023', 10, 1, 4);
  
