CREATE TABLE IF NOT EXISTS dim_tiempo(
    id_tiempo serial primary key not null,
    ano int not null,
    mes int not null,
    dia int not null
);

CREATE TABLE IF NOT EXISTS dim_empleado(
    id_empleado serial primary key not null,
    nombre varchar(150) not null,
    cargo varchar(20) not null
);

CREATE TABLE IF NOT EXISTS dim_cliente(
    id_cliente serial primary key not null,
    nombre varchar(150) not null,
    direccion varchar(150) not null 
);

CREATE TABLE IF NOT EXISTS dim_sucursal(
    id_sucursal serial primary key not null,
    nombre varchar(100) not null,
    ubicacion varchar(150) not null 
);

CREATE TABLE IF NOT EXISTS dim_producto(
    id_producto serial primary key not null,
    nombre varchar(150) not null
);

CREATE TABLE IF NOT EXISTS ventas_diarias(
    id_tiempo int not null references dim_tiempo (id_tiempo),
    id_empleado int not null references dim_empleado (id_empleado),
    id_cliente int not null references dim_cliente (id_cliente),
    id_sucursal int not null references dim_sucursal (id_sucursal),
    id_producto int not null references dim_producto (id_producto),
    ventas_totales decimal (15,2) not null,
    cantidad_vendida int not null,
    constraint pk_ventas primary key (id_sucursal,id_empleado,id_tiempo,id_cliente,id_producto) 
);
