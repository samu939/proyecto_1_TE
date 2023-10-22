TRUNCATE productos, empleados, clientes, cargos, proveedores, lugares_geo, sucursales, turnos, dias, dias_turnos CASCADE;

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

INSERT INTO empleados (nombre1, nombre2, apellido1, apellido2, direccion, numero_telefonico, genero, cedula_identidad, fecha_nacimiento, activo)
VALUES
  ('John', 'Doe', 'Smith', 'Johnson', 'Calle Principal 123', '555-1234', 'M', 'V-1234567', '1990-01-01', true),
  ('Jane', 'Mary', 'Johnson', 'Doe', 'Avenida Central 456', '555-5678', 'F', 'V-9876543', '1985-05-10', true),
  ('Robert', 'Lee', 'Williams', 'Brown', 'Carrera 789', '555-9012', 'M', 'V-2468135', '1993-11-15', true),
  ('Emily', 'Rose', 'Taylor', 'Clark', 'Avenida 987', '555-3456', 'F', 'V-5432167', '1992-09-20', true),
  ('Michael', 'James', 'Anderson', 'Wilson', 'Boulevard 654', '555-7890', 'M', 'V-7896543', '1988-07-05', true),
  ('Sophia', 'Grace', 'Parker', 'Cooper', 'Avenida 321', '555-2345', 'F', 'V-3214567', '1991-03-08', true),
  ('David', 'Thomas', 'Green', 'White', 'Calle 654', '555-6789', 'M', 'V-1357924', '1987-12-25', true),
  ('Olivia', 'Isabella', 'Harris', 'Martin', 'Carrera 987', '555-9012', 'F', 'V-9872134', '1994-06-30', true);

INSERT INTO clientes (nombre1, nombre2, apellido1, apellido2, direccion, numero_telefonico,cedula_identidad)
VALUES
  ('Luis', 'Miguel', 'Sánchez', 'Gómez', 'Calle Principal 123', '555-1234','V-25469789'),
  ('María', 'Fernanda', 'Rodríguez', 'López', 'Avenida Central 456', '555-5678','V-15478963'),
  ('Carlos', 'Andrés', 'González', 'Rivas', 'Carrera 789', '555-9012','V-21647896'),
  ('Ana', 'Isabel', 'Torres', 'Martínez', 'Avenida 987', '555-3456','V-6978456'),
  ('Javier', 'Alejandro', 'Hernández', 'Castro', 'Boulevard 654', '555-7890','V-15698746'),
  ('Laura', 'Carolina', 'Pérez', 'Vargas', 'Avenida 321', '555-2345','V-9645721'),
  ('Diego', 'Sebastián', 'Ramírez', 'Rojas', 'Calle 654', '555-6789','V-14451214'),
  ('Valeria', 'Florencia', 'Silva', 'Luna', 'Carrera 987', '555-9012','V-13564897');

INSERT INTO cargos (nombre)
VALUES
  ('Gerente'), ('Supervisor'), ('Cajero'),
  ('Conserje'), ('Empaquetador'), ('Carnicero');

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

INSERT INTO turnos (nombre)
VALUES
  ('Mañana'), ('Tarde'), ('Noche');

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
