/*
Trigger que impida que se pueda registrar en el stock de una farmacia un medicamento del que ya hay más de 3 unidades en stock (independiente de su presentación) si además esa farmacia está en una ciudad donde hay por lo menos una farmacia más
*/

DROP FUNCTION tpresentacion() CASCADE;
CREATE FUNCTION tpresentacion()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
fila record
c1 integer;
c2 integer;
cd integer;
BEGIN
c=0;
    FOR fila in select cantidads from stock where codm=new.codm LOOP
        c1=c1+fila.cantidads;
    END LOOP;

    select codc into cd from farmacias where codf=new.codf;

    select count(*) into c2 from farmacias where codc=cd;

    if c1>3 then
        if c2>1 then
            raise exception 'Ya hay más de tres unidades en stock de este medicamento';
        else
            raise notice 'Inserción aceptada';
        end if;
    else   
        raise notice 'Inserción aceptada';
    end if;
    
  return new;
END;
$$;
CREATE TRIGGER tpresentaciont before INSERT ON stock for each row EXECUTE PROCEDURE tpresentacion();