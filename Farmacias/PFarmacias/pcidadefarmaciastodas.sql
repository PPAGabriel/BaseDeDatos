CREATE or replace procedure pcidadefarmaciastodas()
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
  r varchar;
  fila record;
  filax record;
BEGIN
r=E'\n';
   FOR fila in select codc,nomc from cidades LOOP
     	r=r||'Ciudad: '||fila.nomc||E'\n';
     	FOR filax in select nomf from farmacias where codc=fila.codc LOOP
     	r=r||E'\t'||filax.nomf||E'\n';
     	END LOOP;
   END LOOP;
   raise notice '%',r;

end;
$$
