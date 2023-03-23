/*
Trigger que impida que se pueda registrar en el stock de una farmacia un medicamento del que ya hay más de 3 unidades en stock (independiente de su presentación)
*/

DROP FUNCTION tmaxstock() CASCADE;
CREATE FUNCTION tmaxstock()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
fila record
c integer;
BEGIN
c=0;
    FOR fila in select cantidads from stock where codm=new.codm LOOP
        c=c+fila.cantidads;
    END LOOP;

    if c>3 then
        raise exception 'Ya hay más de tres unidades en stock de este medicamento';
    else   
        raise notice 'Inserción aceptada';
    end if;
  return new;
END;
$$;
CREATE TRIGGER tmaxstockt before INSERT ON stock for each row EXECUTE PROCEDURE tmaxstock();