CREATE OR REPLACE PROCEDURE select_empleados_samuel()
language plpgsql    
as $$
BEGIN
    SELECT * FROM empleados WHERE nombre = 'Samuel';
END;$$;
