/*
trigger tsalmax() que deniegue la inserción de jugadores con salarios superiores que el máximo que ya tienen los jugadores del equipo

select max(salario) from xogador where codequ='e5';
*/

DROP FUNCTION tsalmax() CASCADE;
CREATE FUNCTION tsalmax()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
$$
DECLARE
mxsal integer;
BEGIN

select max(salario) into mxsal from xogador where codequ=new.codequ;

if mxsal<new.salario then
	raise exception 'Inserción denegada: el salario es más alto que los de su equipo';
else
	raise notice 'Jugador añadido';
end if;
return new;
END;
$$;

CREATE trigger tsalmaxt before INSERT ON xogador FOR each ROW execute procedure tsalmax();
