create type datos_personales as (
	nombre1 varchar(40),
	nombre2 varchar(40),
	apellido1 varchar(40),
	apellido2 varchar(40),
	direccion varchar(50),
	cedula_identidad varchar(10),
	numero_telefonico char(11)
);
CREATE OR REPLACE function  check_null_datos
	(nombre1 varchar(40),
	nombre2 varchar(40),
	apellido1 varchar(40),
	apellido2 varchar(40),
	direccion varchar(50),
	numero_telefonico char(11),
	cedula_identidad varchar(10))
returns setof datos_personales
as $$
declare datos datos_personales;
BEGIN
    
	if nombre1 isnull or apellido1 isnull or apellido2 isnull or direccion isnull or numero_telefonico isnull or
	cedula_identidad isnull then 
	
		raise exception 'Los datos personales no pueden ser nulos' using hint = 'revise los datos ingresados';
	
	else
	
		datos = (nombre1,nombre2,apellido1,apellido2,direccion,numero_telefonico,cedula_identidad);
		return next datos;
	
	end if;
	
END;$$ language plpgsql;

create or replace function format_cedula (cedula varchar) returns varchar
as $$
begin
	
	if cedula not like 'V-%' then 
	
		raise exception 'La cedula debe empezar con V-' ;
	
	else

		return cedula;
	
	end if;
	
end; $$ language plpgsql;

create or replace function unique_cedula (cedula varchar, tab varchar) returns varchar
as $$
declare cedula_repetida varchar; query varchar;
begin
	
	query =concat('select (datos).cedula_identidad from ',tab ,' where (datos).cedula_identidad = ''',cedula,''';');
	
	execute query into cedula_repetida;
	if cedula_repetida isnull then 
	
		return cedula;
		
	else

		raise exception 'La cedula no puede estar repetida' ;
	
	end if;
	
end; $$ language plpgsql;

create or replace function gastos_mes (sucursal int, fecha_reporte date) returns decimal(12,2)
as $$
declare gastos decimal (12,2);
begin 
	
	select coalesce ((select sum(ha.monto) from historico_alquiler ha 
		where ha.id_sucursal = sucursal and to_char(ha.fecha, 'YYYY-MM') = to_char(fecha_reporte, 'YYYY-MM') 
		and ha.fecha <= fecha_reporte),0)
		+ coalesce((select sum(hgp.monto) from historico_gastos_particulares hgp 
		where hgp.id_sucursal = sucursal and to_char(hgp.fecha, 'YYYY-MM') = to_char(fecha_reporte, 'YYYY-MM')
		and hgp.fecha<= fecha_reporte),0)
		+ coalesce((select sum((ci.precio_unidad * ci.cantidad)+ci.gasto_transporte) from compra_inventario ci  
		where ci.id_sucursal = sucursal and to_char(ci.fecha, 'YYYY-MM') = to_char(fecha_reporte, 'YYYY-MM')
		and ci.fecha<= fecha_reporte),0)
		+coalesce ((select sum( hs.salario) from empleados e, historico_salario hs where 
		e.id_sucursal=sucursal and hs.id_empleado=e.id and (hs.fecha_fin isnull or hs.fecha_fin < fecha_reporte)
		and hs.fecha_inicio < fecha_reporte),0) 
	    into gastos;
	
	return gastos;
	
end; $$ language plpgsql;

create or replace function ganancias_mes (sucursal int, fecha_reporte date) returns decimal(12,2)
as $$
declare ganancias decimal (12,2);
begin 
	
	select coalesce ((select sum(f.monto) from factura f, empleados e 
		where e.id_sucursal = sucursal and f.id_empleado=e.id and 
		to_char(f.fecha , 'YYYY-MM') = to_char(fecha_reporte, 'YYYY-MM') 
		and f.fecha <= fecha_reporte),0)
	    into ganancias;
	
	return ganancias;
	
end; $$ language plpgsql;

create or replace function  rentabilidad_sucursales (fecha_reporte date) 
returns table(id_suc int, dir varchar(50),gastos decimal(12,2),ganancias decimal(12,2),total decimal(12,2)) 
as $$

	select s.id, s.direccion, gastos_mes(s.id,fecha_reporte) "Gastos", ganancias_mes(s.id,fecha_reporte) "Ganancias",
	ganancias_mes(s.id,fecha_reporte)-gastos_mes(s.id,fecha_reporte) as "Total" from sucursales s order by "Total" desc; 
	
$$ language sql;
