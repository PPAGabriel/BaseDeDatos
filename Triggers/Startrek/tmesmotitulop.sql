/*
tmesmotitulop

impedir que se rexistre una película de igual titulo que calquera das series existentes

insert into peliculas values ('pel10','cosmos',1980, 'adams');rexeitada insercion;

insert into peliculas values ('pel10','cosmas',1980, 'adams');
aceptada insercion
*/

DROP FUNCTION tmesmotitulop() CASCADE;
CREATE FUNCTION tmesmotitulop()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
    fila record;
    c integer;

BEGIN
c=0;
    FOR fila IN select titulo from series LOOP
        if fila.titulo=new.titulo then
            c=1;
        end if;
    END LOOP;

    if c=1 then
        raise exception 'Insercion rechazada';
    else
        raise notice 'Aceptada insercion';
    end if;


  return new;
END;
$$;
CREATE TRIGGER tmesmotitulopt before INSERT ON peliculas for each row EXECUTE PROCEDURE tmesmotitulop();