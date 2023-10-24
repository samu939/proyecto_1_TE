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
		e.id_sucursal=sucursal and hs.id_empleado=e.id and ((hs.fecha_inicio < fecha_reporte and hs.fecha_fin isnull) 
		or (hs.fecha_fin > fecha_reporte and hs.fecha_inicio < fecha_reporte))),0) 
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

create or replace function nomina (sucursal int) returns 
table (nombre varchar(200), cedula varchar(10), cargo varchar(40),salario decimal (10,2))
as $$

		select (e.datos).nombre1||' '||(e.datos).nombre2 ||' '||(e.datos).apellido1||' '||(e.datos).apellido2 "Nombre",
		(e.datos).cedula_identidad "Cedula", c.nombre "Cargo", hs.salario "Salario" 
		from historico_cargo hc, historico_salario hs, empleados e, cargos c where 
		e.id_sucursal=sucursal and hs.id_empleado=e.id and hc.id_empleado=e.id and hs.fecha_fin isnull and hc.fecha_fin isnull 
		and hc.id_cargo=c.id; 
	
$$ language sql;

create or replace function total_nomina (sucursal int) returns decimal(12,2)
as $$
declare nomina_total decimal (12,2);
begin 
	
		select sum( hs.salario) from empleados e, historico_salario hs where 
		e.id_sucursal=sucursal and hs.id_empleado=e.id and  hs.fecha_fin isnull into nomina_total;
	
	return nomina_total;
	
end; $$ language plpgsql;