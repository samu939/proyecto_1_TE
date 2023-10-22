CREATE TABLE IF NOT EXISTS turnos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS dias (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(10) NOT NULL UNIQUE,
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

CREATE TABLE IF NOT EXISTS clientes(
    id SERIAL PRIMARY KEY,
    nombre1 VARCHAR(40) NOT NULL,
    apellido1 VARCHAR(40) NOT NULL,
    apellido2 VARCHAR(40) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    cedula_identidad VARCHAR(10) NOT NULL UNIQUE,
    numero_telefonico CHAR(11) NOT NULL,
    nombre2 VARCHAR(40)
);

CREATE TABLE IF NOT EXISTS lugares_geo(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(10) NOT NULL,
    id_padre_lugar INTEGER REFERENCES lugares_geo(id),
    CONSTRAINT nombres_tipo CHECK (tipo IN ('estado','ciudad','municipio'))
);

CREATE TABLE IF NOT EXISTS sucursales (
    id SERIAL PRIMARY KEY,
    direccion VARCHAR(50) NOT NULL UNIQUE,
    id_lugar INTEGER REFERENCES lugares_geo(id)
);

CREATE TABLE IF NOT EXISTS empleados (
    id SERIAL PRIMARY KEY,
    id_sucursal INTEGER REFERENCES sucursales(id),
    nombre1 VARCHAR(40) NOT NULL,
    apellido1 VARCHAR(40) NOT NULL,
    apellido2 VARCHAR(40) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    genero CHAR(1) NOT NULL,
    numero_telefonico CHAR(11) NOT NULL,
    cedula_identidad VARCHAR(10) NOT NULL UNIQUE,
    fecha_nacimiento DATE NOT NULL,
    activo BOOLEAN NOT NULL,
    nombre2 VARCHAR(40),
    CONSTRAINT val_genero CHECK (genero IN ('M', 'F'))
);

CREATE TABLE IF NOT EXISTS historico_salario (
    id_empleado INTEGER REFERENCES empleados(id),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    salario DECIMAL(10,2) NOT NULL,
    CONSTRAINT val_salario CHECK (salario >= 0),
    PRIMARY KEY (id_empleado,fecha_inicio)
);

CREATE TABLE IF NOT EXISTS historico_cargo (
    id_empleado INTEGER REFERENCES empleados(id),
    id_cargo INTEGER REFERENCES cargos(id),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    PRIMARY KEY (id_empleado,id_cargo,fecha_inicio)
);

CREATE TABLE IF NOT EXISTS historico_turno (
    id_empleado INTEGER REFERENCES empleados(id),
    id_turno INTEGER REFERENCES turnos(id),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    PRIMARY KEY (id_empleado,id_turno,fecha_inicio)
);

CREATE TABLE IF NOT EXISTS asistencia (
    id_empleado INTEGER,
    id_turno INTEGER,
    fecha_turno DATE,
    fecha DATE NOT NULL,
    hora_entrada TIME,
    hora_salida TIME,
    motivo_ausencia VARCHAR(100),
    PRIMARY KEY (id_empleado,id_turno,fecha_turno,fecha),
    FOREIGN KEY (id_empleado,id_turno,fecha_turno) REFERENCES historico_turno(id_empleado,id_turno,fecha_inicio)
);

CREATE TABLE IF NOT EXISTS historico_alquiler (
    id_sucursal SERIAL REFERENCES sucursales(id),
    fecha DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    CONSTRAINT val_monto CHECK (monto >= 0),
    PRIMARY KEY (id_sucursal,fecha)
);

CREATE TABLE IF NOT EXISTS historico_gastos_particulares (
    id_sucursal SERIAL REFERENCES sucursales(id),
    id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    CONSTRAINT val_monto CHECK (monto >= 0)
);

CREATE TABLE IF NOT EXISTS historico_precios (
    id_producto INTEGER REFERENCES productos(id),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    precio DECIMAL(10,2) NOT NULL,
    CONSTRAINT val_precio CHECK (precio >= 0),
    PRIMARY KEY (id_producto,fecha_inicio)
);

CREATE TABLE IF NOT EXISTS historico_promociones (
    id_producto INTEGER,
    fecha_inicio_precio DATE,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    descuento INTEGER NOT NULL,
    CONSTRAINT val_descuento CHECK (descuento > 0 AND descuento <= 100),
    PRIMARY KEY (id_producto,fecha_inicio,fecha_inicio_precio),
    FOREIGN KEY (id_producto,fecha_inicio_precio) REFERENCES historico_precios(id_producto,fecha_inicio)
);

CREATE TABLE IF NOT EXISTS factura (
    id SERIAL PRIMARY KEY,
    id_cliente INTEGER REFERENCES clientes(id),
    id_empleado INTEGER REFERENCES empleados(id),
    fecha DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    CONSTRAINT val_monto CHECK (monto >= 0)
);

CREATE TABLE IF NOT EXISTS detalle_factura (
    id_factura INTEGER REFERENCES factura(id),
    id_producto INTEGER,
    fecha_inicio_precio DATE,
    cantidad INTEGER NOT NULL,
    CONSTRAINT val_cantidad CHECK (cantidad > 0),
    PRIMARY KEY (id_factura,id_producto,fecha_inicio_precio),
    FOREIGN KEY (id_producto,fecha_inicio_precio) REFERENCES historico_precios(id_producto,fecha_inicio)
);

CREATE TABLE IF NOT EXISTS compra_inventario (
    id_sucursal SERIAL REFERENCES sucursales(id),
    id_proveedor INTEGER REFERENCES proveedores(id),
    id_producto INTEGER REFERENCES productos(id),
    fecha DATE NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unidad DECIMAL (10,2) NOT NULL,
    gasto_transporte DECIMAL (10,2) NOT NULL,
    CONSTRAINT val_transporte CHECK (gasto_transporte >= 0),
    CONSTRAINT val_precio CHECK (precio_unidad >= 0),
    CONSTRAINT val_cantidad CHECK (cantidad > 0),
    PRIMARY KEY (id_sucursal,id_proveedor,id_producto,fecha)
);



