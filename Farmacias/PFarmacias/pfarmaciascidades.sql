CREATE or replace procedure pfarmaciascidades ()
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
  r varchar;
  fila record;
  cd varchar;
BEGIN
   r=E'\n';
   FOR fila in select nomf,codc from farmacias LOOP
   	r=r||'Nombre de la farmacia: '||fila.nomf||E'\n';
   	select nomc into cd from cidades where codc=fila.codc;
   	r=r||E'\t'||'Ciudad: '||cd||E'\n'||E'\n';
   END LOOP;
   raise notice '%',r;

end;
$$
