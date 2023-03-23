CREATE or replace procedure pfarmacias ()
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
  r varchar;
  fila varchar;
BEGIN
r=E'\n';
   FOR fila in select nomf from farmacias LOOP
   r=r||'Nombre de la farmacia: '||fila||E'\n';
   END LOOP;
   raise notice '%',r;

end;
$$
