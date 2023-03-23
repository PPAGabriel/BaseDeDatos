/*
tsospeita
valor : 2.5 puntos
trigger que rexeite  entrevistar a unha persoa para un posto si o xestor de dito posto ten os mesmos apelidos que a persoa entrevistada 
ex: insert into entrevista values('p18',8,'f','f');
ERROR:  non podes entrevistar a esta persoa para dito posto pois o xestor do posto ten os seus apelidos
ex: insert into entrevista values('p9',23,'f','f');
NOTICE:   entrevista aceptada pois a persoa non ten os apelidos do xestor do posto
*/

DROP FUNCTION tsospeita() CASCADE;
CREATE FUNCTION tsospeita()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
d1 varchar;
d2 record;
d3 record;
BEGIN
    select cod_xestor into d1 from postos where cod_posto=new.cod_posto;
    select ap1_xestor,ap2_xestor into d2 from xestores where cod_xestor=d1;
    select ap1_persoa,ap2_persoa into d3 from persoas where num_persoa=new.num_persoa;

    if d2.ap1_xestor=d3.ap1_persoa and d2.ap2_xestor=d3.ap2_persoa then
        raise exception 'No puedes entrevistar a esta persona para dicho puesto si el gestor de este tiene los mismos apellidos que la persona entrevistada';
    else
        raise notice 'Entrevista aceptada pues la persona no tiene los apellidos del gestor de dicho puesto';
    end if;
  return new;
END;
$$;
CREATE TRIGGER tsospeitat before INSERT ON entrevista for each row EXECUTE PROCEDURE tsospeita();

