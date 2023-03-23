/*
Trigger que impida que en una misma farmacia trabaje más de un farmaceutico
*/

DROP FUNCTION tfarmaceutico() CASCADE;
CREATE FUNCTION tfarmaceutico()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
c1 integer;
BEGIN
    select count(*) into c1 from traballan where codf=new.codf and dnip in (select dnip from farmaceuticos);

    if c1>=1 then
            raise notice 'No puede trabajar más de un farmaceutico por farmacia';
        else
            raise exception 'Inserción aceptada';
        end if;

  return new;
END;
$$;
CREATE TRIGGER tfarmaceuticot before INSERT ON traballan for each row EXECUTE PROCEDURE tfarmaceutico();