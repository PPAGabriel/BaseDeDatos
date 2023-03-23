/*
Trigger que impida que en una misma farmacia trabaje más de un farmaceutico, a menos que el nuevo farmaceutico sea de la misma ciudad en la que está la farmacia
*/

DROP FUNCTION tfarmaceutico() CASCADE;
CREATE FUNCTION tfarmaceutico()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
c1 integer;
c2 integer;
c3 integer;
BEGIN
    select count(*) into c1 from traballan where codf=new.codf and dnip in (select dnip from farmaceuticos);

    if c1>=1 then
        select codc into c2 from farmacias where codf=new.codf;
        select codc into c3 from farmaceuticos where dnip=new.dnip;

        if c2=c3 then
            raise notice 'Inserción aceptada';
        else
            raise exception 'Este farmaceutico no puede trabajar en esta farmacia';
        end if;
    else
        raise notice 'Inserción aceptada';
    end if;

  return new;
END;
$$;
CREATE TRIGGER tfarmaceuticot before INSERT ON traballan for each row EXECUTE PROCEDURE tfarmaceutico();