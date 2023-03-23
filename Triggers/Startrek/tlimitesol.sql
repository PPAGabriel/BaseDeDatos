/*
tlimitesol
impedir que una personaxe poda ter por xefe a un soldado (inserindo)

puntuacion: 2,5

insert into personaxes values ('p48','zira','soldado','p21');
'este personaxe non debe ter por xefe a un soldado'

insert into personaxes values ('p48','zira','soldado','p46');
'rexistro inserido'

*/

DROP FUNCTION tlimitesol() CASCADE;
CREATE FUNCTION tlimitesol()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
    x varchar;
BEGIN
    select graduacion into x from personaxes where codper=new.codper2;

    if x='soldado' then
        raise exception 'Este personaje no debe tener por jefe a un soldado';
    else
        raise notice 'Registro aceptado';
    end if;
    
  return new;
END;
$$;
CREATE TRIGGER tlimitesolt before INSERT ON personaxes for each row EXECUTE PROCEDURE tlimitesol();