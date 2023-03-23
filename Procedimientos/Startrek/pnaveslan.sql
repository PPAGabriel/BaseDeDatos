/*
pnaveslan.sql
decir si ou non unha nave cuxo nome se pasa como parametro , ten capacidade para levar a toda a sua tripulacion dunha vez nas lanzaderas de que dispon.
call pnaveslan('voyager');
resultado:= 'a nave pode levar a todos os seus tripulantes no conxunto das suas lanzqderas';
call pnaveslan('enterprise');
a nave non pode levar a todos os seus tripulantes no conxunto das suas
lanzaderas
*/

CREATE or replace procedure pnaveslan(nomnave varchar)
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
data1 record;
cap integer;
t integer;
r varchar;
BEGIN
    r=E'\n';
    select codn,nomen,tripul into STRICT data1 from naves where nomen=nomnave;

    t=data1.tripul;

    select sum(capacidade) into cap from lanzaderas where codn=data1.codn;

    if cap>=t then
    r=r||'La nave puede llevar a todos los tripulantes en el conjunto de sus lanzaderas.';
    else
    r=r||'La nave no puede llevar a todos los tripulantes en el conjunto de sus lanzaderas';
    end if;

   raise notice '%',r;

   exception
    when no_data_found then
        raise notice 'Nombre no encontrado';

end;
$$;