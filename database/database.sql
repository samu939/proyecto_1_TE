CREATE TABLE IF NOT EXISTS turnos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS dias (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(8) NOT NULL UNIQUE,
    CONSTRAINT val_dias CHECK (nombre IN ('Lunes','Martes','Miércoles','Jueves','Viernes','Sábado','Domingo'))
);

CREATE TABLE IF NOT EXISTS dias_turnos(
    id_dia INTEGER REFERENCES dias(id),
    id_turno INTEGER REFERENCES turnos(id),
    hora_entrada TIME NOT NULL,
    hora_salida TIME NOT NULL,
    PRIMARY KEY (id_dia,id_turno)
);

CREATE TABLE IF NOT EXISTS productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL UNIQUE, 
    descripcion TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS cargos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS proveedores(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL UNIQUE,
    direccion VARCHAR(50) NOT NULL,
    numero_telefonico CHAR(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS empleados (
    id SERIAL PRIMARY KEY,
    nombre1 VARCHAR(40) NOT NULL, 
    apellido1 VARCHAR(40) NOT NULL,
    apellido2 VARCHAR(40) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    genero CHAR(1) NOT NULL,
    numero_telefonico CHAR(11) NOT NULL,
    cedula_identidad VARCHAR(8) NOT NULL UNIQUE,
    fecha_nacimiento DATE NOT NULL,
    activo BOOLEAN NOT NULL,
    nombre2 VARCHAR(40),
    CONSTRAINT val_genero CHECK (genero IN ('M', 'F'))
);

CREATE TABLE IF NOT EXISTS clientes(
    id SERIAL PRIMARY KEY,
    nombre1 VARCHAR(40) NOT NULL, 
    apellido1 VARCHAR(40) NOT NULL,
    apellido2 VARCHAR(40) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    numero_telefonico CHAR(11) NOT NULL,
    nombre2 VARCHAR(40)
);

CREATE TABLE IF NOT EXISTS lugares_geo(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(6) NOT NULL,
    id_padre_lugar INTEGER REFERENCES lugares_geo(id),
    CONSTRAINT nombres_tipo CHECK (tipo IN ('estado','ciudad','municipio'))
);

CREATE TABLE IF NOT EXISTS sucursales (
    id SERIAL PRIMARY KEY,
    direccion VARCHAR(50) NOT NULL UNIQUE,
    id_lugar INTEGER REFERENCES lugares_geo(id)
);