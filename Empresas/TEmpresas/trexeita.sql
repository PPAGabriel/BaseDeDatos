/*
trexeita
valor : 2'5 puntos
trigger que impida entrevistar a unha persoa para un posto si dita persoa e rexeitada pola empresa a  que corresponde dito posto.
insert into entrevista values('p9',20,'f','f');
'non podes entrevistar a esta persoa para dito posto pois e rexeitada por a empresa que lle corresponde a dito posto'
insert into entrevista values('p90',7,'f','f');
 non existe a persoa ou o posto
insert into entrevista values('p9',70,'f','f');
 non existe a persoa ou o posto
insert into entrevista values('p9',6,'f','f');
entrevista aceptada
*/

DROP FUNCTION trexeita() CASCADE;
CREATE FUNCTION trexeita()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
    c1 integer;
    c2 integer;
    c3 integer;
    c4 integer;
    fila record;
BEGIN
    select count(*) into c1 from postos where cod_posto=new.cod_posto;
    select count(*) into c2 from persoas where num_persoa=new.num_persoa;

    if c1=0 or c2=0 then
        raise exception 'No existe la persona o el puesto';
    else
    c4=0;

        FOR fila in select cod_empresa from rexeita where num_persoa=new.num_persoa LOOP

            select count(cod_posto) into c3 from postos where cod_empresa=fila.cod_empresa;

            c4=c4+c3;

        END LOOP;

        if c4=0 then
            raise notice 'Entrevista aceptada';
        else
            raise exception 'No puedes entrevistar a esta persona para dicho puesto, pues es rechazada por la empresa que le corresponde a dicho puesto';
        end if;

    end if;
  return new;
END;
$$;
CREATE TRIGGER trexeitat before INSERT ON entrevista for each row EXECUTE PROCEDURE trexeita();