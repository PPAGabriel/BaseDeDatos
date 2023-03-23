/*
Trigger que impida que en una misma farmacia trabajen mas de dos personas
*/

DROP FUNCTION tfarmaciatrabajadores() CASCADE;
CREATE FUNCTION tfarmaciatrabajadores()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
r integer;
BEGIN
    select count(*) into r from traballan where codf=new.codf;

    if r>=2 then
        raise exception 'Ya hay dos personas trabajando en esta farmacia';
    else   
        raise notice 'Inserción aceptada';
    end if;
  return new;
END;
$$;
CREATE TRIGGER tfarmaciatrabajadorest before INSERT ON traballan for each row EXECUTE PROCEDURE tfarmaciatrabajadores();