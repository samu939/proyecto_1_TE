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
  ('John', 'Doe', 'Smith', 'Johnson', 'Calle Principal 123', '555-1234', 'M', '1234567', '1990-01-01', true),
  ('Jane', 'Mary', 'Johnson', 'Doe', 'Avenida Central 456', '555-5678', 'F', '9876543', '1985-05-10', true),
  ('Robert', 'Lee', 'Williams', 'Brown', 'Carrera 789', '555-9012', 'M', '2468135', '1993-11-15', true),
  ('Emily', 'Rose', 'Taylor', 'Clark', 'Avenida 987', '555-3456', 'F', '5432167', '1992-09-20', true),
  ('Michael', 'James', 'Anderson', 'Wilson', 'Boulevard 654', '555-7890', 'M', '7896543', '1988-07-05', true),
  ('Sophia', 'Grace', 'Parker', 'Cooper', 'Avenida 321', '555-2345', 'F', '3214567', '1991-03-08', true),
  ('David', 'Thomas', 'Green', 'White', 'Calle 654', '555-6789', 'M', '1357924', '1987-12-25', true),
  ('Olivia', 'Isabella', 'Harris', 'Martin', 'Carrera 987', '555-9012', 'F', '9872134', '1994-06-30', true);

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

INSERT INTO cargos (nombre)
VALUES
  ('Gerente'), ('Supervisor'), ('Cajero'),
  ('Conserje'), ('Empaquetador'), ('Carnicero');

INSERT INTO proveedores (nombre, direccion, numero_telefonico)
VALUES
  ('Polar', 'Los Palos Grandes, calle la Goleada', '0412-3698745'),
  ('Pepsico', 'La Castellana, calle el Tartago', '0412-3697435'),
  ('Nabisco', 'El Rosal, calle el Perro', '0416-5698740'),
  ('Bimbo', 'Altamira, calle la Tucupita', '0412-7921682'),
  ('Capri', 'La Candelaria, calle la Rosita', '0416-6987742'),
  ('Santa Teresa', 'Maracay, hacienda Santa Teresa', '0414-9623301');

INSERT INTO lugares_geo (nombre, tipo)
VALUES
  ('Miranda', 'estado'), ('Zulia', 'estado'), ('Sucre', 'estado'),
  ('Bolivar', 'estado'), ('Aragua', 'estado'), ('Falcon', 'estado'),

INSERT INTO lugares_geo (nombre, tipo, id_padre_lugar)
VALUES
  ('Caracas', 'Ciudad', (SELECT id FROM lugares_geo WHERE nombre = 'Miranda')),
  ('Maracaibo', 'Ciudad', (SELECT id FROM lugares_geo WHERE nombre = 'Zulia')),
  ('Maracay', 'Ciudad', (SELECT id FROM lugares_geo WHERE nombre = 'Aragua')),
  ('Coro', 'Ciudad', (SELECT id FROM lugares_geo WHERE nombre = 'Falcon')),
  ('Cumana', 'Ciudad', (SELECT id FROM lugares_geo WHERE nombre = 'Sucre'));

INSERT INTO lugares_geo (nombre, tipo, id_padre_lugar)
VALUES
  ('Chacao', 'Municipio', (SELECT id FROM lugares_geo WHERE nombre = 'Miranda')),
  ('Baruta', 'Municipio', (SELECT id FROM lugares_geo WHERE nombre = 'Miranda')),
  ('Libertador', 'Municipio', (SELECT id FROM lugares_geo WHERE nombre = 'Miranda')),
  ('Sucre', 'Municipio', (SELECT id FROM lugares_geo WHERE nombre = 'Miranda'));

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
