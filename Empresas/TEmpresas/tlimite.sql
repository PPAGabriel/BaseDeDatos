/*
tlimite
valor : 2'5 puntos
trigger que rexeite  entrevistar a unha persoa para un posto si xa se lle fixeron 2 ou mais entrevistas para outros postos xestionados polo mesmo  xestor que o do posto o que se presenta. 
ex:  insert into entrevista values('p16',5,'f','f');
ERROR:  non podes entrevistar a esta persoa para dito posto pois xa se lle fixeron 2 entrevistas para outros postos xestionados polo mesmo  xestor que o do posto o que se presenta
insert into entrevista values('p55',12,'f','f');
non existe a persoa ou o posto
insert into entrevista values('p12',55,'f','f');
non existe a persoa ou o posto
ex: insert into entrevista values('p12',5,'f','f');
NOTICE:   entrevista aceptada pois a persoa non tiña todavia duas  entrevistas co mesmo xestor deste posto
*/
DROP FUNCTION tlimite() CASCADE;
CREATE FUNCTION tlimite()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
 f1 integer;
 f2 integer;
 f3 varchar;
 f4 varchar;
 c integer;
 fila record;
 
BEGIN
  select count(cod_posto) into f1 from postos where cod_posto=new.cod_posto;
  select count(num_persoa) into f2 from persoas where num_persoa=new.num_persoa;
   if f1=0 or f2=0 then
   	  raise exception 'non existe a persoa ou o posto';
      else
      c = 0;
   	  select cod_xestor into f3 from postos where cod_posto=new.cod_posto;
   	  
      FOR fila in select cod_posto from entrevista where num_persoa=new.num_persoa LOOP
		select cod_xestor into f4 from postos where cod_posto=fila.cod_posto;
			if f3=f4 then
				c = c + 1;
			end if;
	  END LOOP;

        if c>1 then
            raise exception 'No puedes entrevistar a esta persona ya que le hicieron 2 entrevistas previamente para otros puestos gestionados por el mismo gestor que el del puesto al cual se presenta';	 
        else
            raise notice 'entrevista aceptada por tener menos de 2 entrevistas con el gestor';
        end if;

   end if;
  return new;
END;
$$;
CREATE TRIGGER tlimitet before INSERT ON entrevista for each row EXECUTE PROCEDURE tlimite();