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

create or replace function nomina (sucursal int, fecha_reporte date) returns 
table (nombre varchar(200), cedula varchar(10), cargo varchar(40),salario decimal (10,2),horasReq decimal(5,2), horasRea decimal(5,2))
as $$

		select (e.datos).nombre1||' '||(e.datos).nombre2 ||' '||(e.datos).apellido1||' '||(e.datos).apellido2 "Nombre",
		(e.datos).cedula_identidad "Cedula", c.nombre "Cargo", hs.salario "Salario",
		(select hex.horasReq from horas_extra(e.id,fecha_reporte) hex) "Horas Requeridas",
		(select hex.horasRea from horas_extra(e.id,fecha_reporte) hex) "Horas Realizadas"
		from historico_cargo hc, historico_salario hs, empleados e, cargos c where 
		e.id_sucursal=sucursal and hs.id_empleado=e.id and hc.id_empleado=e.id and 
		((hc.fecha_inicio < fecha_reporte and hc.fecha_fin isnull) or (hc.fecha_fin > fecha_reporte and 
		hc.fecha_inicio < fecha_reporte)) and 
		((hs.fecha_inicio < fecha_reporte and hs.fecha_fin isnull) or (hs.fecha_fin > fecha_reporte and 
		hs.fecha_inicio < fecha_reporte)) and hc.id_cargo=c.id; 
	
$$ language sql;

create or replace function total_nomina (sucursal int) returns decimal(12,2)
as $$
declare nomina_total decimal (12,2);
begin 
	
		select sum( hs.salario) from empleados e, historico_salario hs where 
		e.id_sucursal=sucursal and hs.id_empleado=e.id and  hs.fecha_fin isnull into nomina_total;
	
	return nomina_total;
	
end; $$ language plpgsql;

create or replace function horas_extra (emp int, fecha_reporte date) 
returns table (horasReq decimal(5,2), horasRea decimal(5,2))
as $$
declare horas_requeridas decimal (5,2); horas_realizadas decimal (5,2);
begin 
	
		select (EXTRACT(epoch FROM sum(dt.hora_salida - dt.hora_entrada))/3600)*4
		from historico_turno ht ,dias_turnos dt, turnos t 
		where dt.id_turno=t.id and ht.id_turno=t.id and ht.id_empleado=emp and ht.fecha_fin isnull into horas_requeridas;
	
		select (EXTRACT(epoch FROM sum(a.hora_salida - a.hora_entrada))/3600)from asistencia a 
		where a.id_empleado=emp and to_char(a.fecha, 'YYYY-MM') = to_char(fecha_reporte, 'YYYY-MM') into horas_realizadas;
	
	return query select horas_requeridas, horas_realizadas;
	
end; $$ language plpgsql;