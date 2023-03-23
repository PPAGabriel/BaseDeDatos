/*
tmaxpostos
impedir que un mesmo xestor poda xestionar mais de 7 postos
exemplos:
insert into postos values ('p19', 'disenador web', 3000,365,'pe2','e8','x1');
 este xestor xa xestiona 7 postos
insert into postos values ('p19', 'disenador web', 3000,365,'pe2','e8','x2');
 insercion aceptada
*/

DROP FUNCTION tmaxpostos() CASCADE;
CREATE FUNCTION tmaxpostos()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
  f1 integer;
BEGIN
  select count(*) into f1 from postos where cod_xestor=new.cod_xestor;
  
  if f1>=7 then
    raise exception 'Este gestor ya gestiona 7 puestos';
  else
    raise notice 'Insercion aceptada';
  end if;

  return new;
END;
$$;
CREATE TRIGGER tmaxpostost before INSERT ON postos for each row EXECUTE PROCEDURE tmaxpostos();