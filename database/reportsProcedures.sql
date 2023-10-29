create or replace function gastos_mes (sucursal int, fecha_reporte date) returns decimal(12,2)
as $$
declare gastos decimal (12,2);
begin 
	
	select coalesce ((select sum(ha.monto) from historico_alquiler ha 
		where ha.id_sucursal = sucursal and to_char(ha.fecha, 'YYYY-MM') = to_char(fecha_reporte, 'YYYY-MM')),0)
		+ coalesce((select sum(hgp.monto) from historico_gastos_particulares hgp 
		where hgp.id_sucursal = sucursal and to_char(hgp.fecha, 'YYYY-MM') = to_char(fecha_reporte, 'YYYY-MM')),0)
		+ coalesce((select sum((ci.precio_unidad * ci.cantidad)+ci.gasto_transporte) from proveedores_compras_inventario ci, compras_inventario com  
		where com.id_sucursal = sucursal and to_char(ci.fecha, 'YYYY-MM') = to_char(fecha_reporte, 'YYYY-MM') and com.id=ci.id_compra_inventario),0)
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
		to_char(f.fecha , 'YYYY-MM') = to_char(fecha_reporte, 'YYYY-MM')),0)
	    into ganancias;
	
	return ganancias;
	
end; $$ language plpgsql;

create or replace function  rentabilidad_sucursales (mes int, ano int) 
returns table(id_suc int, dir varchar(50),gastos decimal(12,2),ganancias decimal(12,2),total decimal(12,2)) 
as $$

	select s.id, s.direccion, gastos_mes(s.id,(select cast ( cast (ano as varchar) || '-' || cast (mes as varchar) || '-' || '1' as date))) "Gastos", 
	ganancias_mes(s.id,(select cast ( cast (ano as varchar) || '-' || cast (mes as varchar) || '-' || '1' as date))) "Ganancias",
	ganancias_mes(s.id,(select cast ( cast (ano as varchar) || '-' || cast (mes as varchar) || '-' || '1' as date)))-
	gastos_mes(s.id,(select cast ( cast (ano as varchar) || '-' || cast (mes as varchar) || '-' || '1' as date))) as "Total" from sucursales s order by "Total" desc; 
	
$$ language sql;

create or replace function horas_extra (emp int,mes int, ano int) 
returns table (horasReq decimal(5,2), horasRea decimal(5,2))
as $$
declare horas_requeridas decimal (5,2); horas_realizadas decimal (5,2); fecha_reporte date;
begin 
		select cast ( cast (ano as varchar) || '-' || cast (mes as varchar) || '-' || '1' as date) into fecha_reporte;

		select (EXTRACT(epoch FROM sum(dt.hora_salida - dt.hora_entrada))/3600)*4
		from historico_turno ht ,dias_turnos dt, turnos t 
		where dt.id_turno=t.id and ht.id_turno=t.id and ht.id_empleado=emp and ((ht.fecha_inicio < fecha_reporte and ht.fecha_fin > fecha_reporte) or 
		(ht.fecha_inicio < fecha_reporte and ht.fecha_fin isnull)) into horas_requeridas;
	
		select (EXTRACT(epoch FROM sum(a.hora_salida - a.hora_entrada))/3600)from asistencia a 
		where a.id_empleado=emp and to_char(a.fecha, 'YYYY-MM') = to_char(fecha_reporte, 'YYYY-MM')  into horas_realizadas;
	
	return query select horas_requeridas, horas_realizadas;
	
end; $$ language plpgsql;

create or replace function nomina (sucursal int, mes int, ano int) returns 
table (nombre varchar(200), cedula varchar(10), cargo varchar(40),salario decimal (10,2),horasReq decimal(5,2), horasRea decimal(5,2))
as $$


		select (e.datos).nombre1||' '||(e.datos).nombre2 ||' '||(e.datos).apellido1||' '||(e.datos).apellido2 "Nombre",
		(e.datos).cedula_identidad "Cedula", c.nombre "Cargo", hs.salario "Salario",
		(select hex.horasReq from horas_extra(e.id,mes,ano) hex) "Horas Requeridas",
		(select hex.horasRea from horas_extra(e.id,mes,ano) hex) "Horas Realizadas"
		from historico_cargo hc, historico_salario hs, empleados e, cargos c where 
		e.id_sucursal=sucursal and hs.id_empleado=e.id and hc.id_empleado=e.id and 
		((hc.fecha_inicio < (select cast ( cast (ano as varchar) || '-' || cast (mes as varchar) || '-' || '1' as date)) 
		and hc.fecha_fin isnull) or (hc.fecha_fin > (select cast ( cast (ano as varchar) || '-' || cast (mes as varchar) || '-' || '1' as date)) and 
		hc.fecha_inicio < (select cast ( cast (ano as varchar) || '-' || cast (mes as varchar) || '-' || '1' as date)))) and 
		((hs.fecha_inicio < (select cast ( cast (ano as varchar) || '-' || cast (mes as varchar) || '-' || '1' as date)) and hs.fecha_fin isnull) or 
		(hs.fecha_fin > (select cast ( cast (ano as varchar) || '-' || cast (mes as varchar) || '-' || '1' as date)) and 
		hs.fecha_inicio < (select cast ( cast (ano as varchar) || '-' || cast (mes as varchar) || '-' || '1' as date)))) and hc.id_cargo=c.id and e.activo = true; 
	
$$ language sql;

create or replace function total_nomina (sucursal int) returns decimal(12,2)
as $$
declare nomina_total decimal (12,2);
begin 
	
		select sum( hs.salario) from empleados e, historico_salario hs where 
		e.id_sucursal=sucursal and hs.id_empleado=e.id and  hs.fecha_fin isnull into nomina_total;
	
	return nomina_total;
	
end; $$ language plpgsql;

CREATE OR REPLACE FUNCTION id_ultima_compra_inventario_producto(id_p INTEGER,id_s INTEGER)
RETURNS INTEGER AS $id_ult_comp$
DECLARE
	id_ult_comp INTEGER;
BEGIN
    
     	SELECT MAX(ci.id) INTO id_ult_comp
			FROM compras_inventario ci
			WHERE ci.id_producto = id_p AND ci.id_sucursal = id_s;
			
		RETURN id_ult_comp;
    
END; $id_ult_comp$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION suma_compra_inv(id_comp_inv INTEGER)
RETURNS INTEGER AS $suma$
DECLARE
	suma INTEGER;
BEGIN
    
     	SELECT SUM(cantidad) INTO suma FROM proveedores_compras_inventario
    									 WHERE id_compra_inventario = id_comp_inv;
    
		RETURN suma;

END; $suma$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION nivel_inventario_producto(id_p INTEGER,id_s INTEGER)
RETURNS decimal(4,2) AS $nivel_inventario$
DECLARE
	id_ult_comp INTEGER; inv_rec INTEGER; vendidos INTEGER; inventario INTEGER; nivel_inventario decimal(4,2); 
BEGIN
    
    SELECT INTO id_ult_comp id_ultima_compra_inventario_producto(id_p,id_s);
    
    SELECT INTO inv_rec suma_compra_inv(id_ult_comp);
    
    SELECT SUM(df.cantidad) INTO vendidos FROM detalle_factura df
		INNER JOIN factura f ON df.id_factura = f.id
		INNER JOIN empleados e ON f.id_empleado = e.id 
		WHERE df.id_producto = id_p AND e.id_sucursal = id_s;

	SELECT SUM(suma_compra_inv(ci.id)) INTO inventario
	FROM compras_inventario ci
	WHERE ci.id_producto = id_p AND ci.id_sucursal = id_s;

	nivel_inventario := (inventario-vendidos)/inv_rec::decimal(4,2);

	RETURN nivel_inventario;
    
END; $nivel_inventario$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION nivel_inventario_sucursal(id_s INTEGER)
RETURNS TABLE (
	producto VARCHAR(40),
	nivel_inventario decimal(4,2)
) AS $$

BEGIN
    
    RETURN QUERY
	SELECT p.nombre, nivel_inventario_producto(p.id,id_s) nivel_inventario
	FROM productos p
	WHERE nivel_inventario_producto(p.id,id_s) < 0.30;
    
END; $$
LANGUAGE plpgsql;

create or replace function ADD_MONTHS(var_dte date,cnt int) returns setof date as
$$
declare
qry text;
begin
qry = format( 'select (''%s''::date + interval ''%s'')::date',var_dte,cnt||' month') ;
RETURN QUERY
     EXECUTE qry;
end
$$
language plpgsql

CREATE OR REPLACE FUNCTION gasto_compra_inv_en_rango_tabla(id_s INTEGER, fecha_inicio DATE, fecha_fin DATE)
RETURNS TABLE (
	fecha date,
	producto productos.nombre%type,
	proveedor proveedores.nombre%type,
	cantidad INTEGER,
	precio_unidad proveedores_compras_inventario.precio_unidad%type,
	gasto_transporte proveedores_compras_inventario.gasto_transporte%type
) AS $$
BEGIN

	RETURN QUERY SELECT p.fecha,prod.nombre as producto,prov.nombre as proveedor,p.cantidad,p.precio_unidad, p.gasto_transporte
	FROM compras_inventario c
	INNER JOIN proveedores_compras_inventario p ON c.id = p.id_compra_inventario
	INNER JOIN productos prod on c.id_producto = prod.id
	INNER JOIN proveedores prov on p.id_proveedor = prov.id
	WHERE c.id_sucursal = id_s AND p.fecha >= fecha_inicio AND p.fecha <= fecha_fin;

END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION gasto_compra_inv_en_rango(id_s INTEGER, fecha_inicio DATE, fecha_fin DATE)
RETURNS float AS $$
DECLARE total float;
BEGIN

	SELECT SUM(cantidad*precio_unidad + gasto_transporte) INTO total
		FROM gasto_compra_inv_en_rango_tabla(id_s, fecha_inicio,fecha_fin);

	RETURN total;

END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION gasto_particulares_en_rango_tabla(id_s INTEGER, fecha_inicio DATE, fecha_fin DATE)
RETURNS TABLE(
	fecha historico_gastos_particulares.fecha%type,
	monto historico_gastos_particulares.monto%type,
	descripcion historico_gastos_particulares.descripcion%type,
) AS $$
BEGIN

	RETURN QUERY SELECT fecha,monto,descripcion
		FROM historico_gastos_particulares h
		WHERE h.id_sucursal = id_s AND h.fecha >= fecha_inicio AND h.fecha <= fecha_fin;

	RETURN total;

END; $total$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION gasto_particulares_en_rango(id_s INTEGER, fecha_inicio DATE, fecha_fin DATE)
RETURNS float AS $total$
DECLARE total float;
BEGIN

	SELECT SUM(h.monto) INTO total
		FROM historico_gastos_particulares h
		WHERE h.id_sucursal = id_s AND h.fecha >= fecha_inicio AND h.fecha <= fecha_fin;

	RETURN total;

END; $total$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION salario_emp_mes(id_e INTEGER, fecha DATE)
RETURNS float AS $$
DECLARE salario float;
BEGIN

	SELECT h.salario INTO salario
	FROM historico_salario h
	WHERE h.id_empleado = id_e AND h.fecha_inicio = (SELECT MAX(h.fecha_inicio)
											  FROM historico_salario h
											  WHERE h.id_empleado = id_e AND h.fecha_inicio <= fecha)

	RETURN salario;

END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION gastos_nomina_en_rango_tabla(id_s INTEGER, fecha_inicio DATE, fecha_fin DATE)
RETURNS TABLE(
	mes varchar(20),
	costo historico_salario.salario%type
) AS $$
DECLARE fecha_i DATE; fecha_f DATE; temp_date DATE; m_between INTEGER; nom_mes historico_salario.salario%type;

BEGIN

	DROP TABLE IF EXISTS nom_mes_table;

	CREATE TEMP TABLE nom_mes_table(
		mes varchar(20),
		costo historico_salario.salario%type
	);

	SELECT into fecha_f date_trunc('month', fecha_fin)::DATE;

	if EXTRACT(DAY FROM fecha_inicio) = 1 then
   		fecha_i := fecha_inicio;
	else

		SELECT INTO fecha_i date_trunc('month',fecha_inicio + INTERVAL '1 month')::DATE;

	end if;

	select INTO m_between extract(year from age(fecha_f, fecha_i)) * 12 +
	extract(month from age(fecha_f, fecha_i));

	for mes_add in 0..m_between loop

		SELECT INTO temp_date ADD_MONTHS(fecha_i,mes_add);

		SELECT SUM(salario_emp_mes(e.id,temp_date)) INTO nom_mes
		FROM empleados e WHERE e.id_sucursal = id_s;

		INSERT INTO nom_mes_table (mes,costo) VALUES (TO_CHAT(temp_date,'Mon, yyyy'),nom_mes);

	end loop;

	RETURN QUERY SELECT * FROM nom_mes_table;

END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION gastos_nomina_en_rango(id_s INTEGER, fecha_inicio DATE, fecha_fin DATE)
RETURNS float AS $total$
DECLARE total float;
BEGIN

	SELECT SUM(costo) INTO total
	FROM gastos_nomina_en_rango_tabla(id_s,fecha_inicio,fecha_fin);

	RETURN total;

END; $total$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION gastos_sucursal_en_rango(id_s INTEGER, fecha_inicio DATE, fecha_fin DATE)
RETURNS float AS $total$
DECLARE total float;
BEGIN

	total := gastos_nomina_en_rango(id_s,fecha_inicio,fecha_fin) + 
			 gasto_particulares_en_rango(id_s, fecha_inicio, fecha_fin) +
			 gasto_compra_inv_en_rango(id_s, fecha_inicio, fecha_fin);

	RETURN total;

END; $total$
LANGUAGE plpgsql;