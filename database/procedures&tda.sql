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

