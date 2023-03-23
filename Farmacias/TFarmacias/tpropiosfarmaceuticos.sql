/*
Trigger que impida el registro de una persona en "propios" si ya se encuentra en la tabla "farmaceuticos" y viceversa
*/

DROP FUNCTION tpropios() CASCADE;
CREATE FUNCTION tpropios()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
r integer;
BEGIN
    select count(*) into r from farmaceuticos where dnip=new.dnip;

    if r>0 then
        raise exception 'La persona ya se encuentra registrada en la tabla Farmaceuticos';
    else   
        raise notice 'Persona registrada';
    end if;
  return new;
END;
$$;
CREATE TRIGGER tpropiost before INSERT ON propios for each row EXECUTE PROCEDURE tpropios();

/**********************************************/

DROP FUNCTION tfarmaceuticos() CASCADE;
CREATE FUNCTION tfarmaceuticos()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
r integer;
BEGIN
    select count(*) into r from propios where dnip=new.dnip;

    if r>0 then
        raise exception 'La persona ya se encuentra registrada en la tabla Propios';
    else   
        raise notice 'Persona registrada';
    end if;
  return new;
END;
$$;
CREATE TRIGGER tfarmaceuticost before INSERT ON farmaceuticos for each row EXECUTE PROCEDURE tfarmaceuticos();