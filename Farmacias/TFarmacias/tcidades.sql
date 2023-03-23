/*
Trigger que impida el registro de dos ciudades con el mismo nombre
*/

DROP FUNCTION tcidades() CASCADE;
CREATE FUNCTION tcidades()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
r integer;
BEGIN
    select count(*) into r from cidades where nomc=new.nomc;

    if r>0 then
        raise exception 'No se pueden tener dos ciudades con el mismo nombre';
    else   
        raise notice 'ciudad insertada';
    end if;
  return new;
END;
$$;
CREATE TRIGGER tcidadest before INSERT ON cidades for each row EXECUTE PROCEDURE tcidades();