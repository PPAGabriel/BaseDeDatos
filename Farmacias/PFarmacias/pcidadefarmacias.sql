CREATE or replace procedure pcidadefarmacias(codciud integer)
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
  r varchar;
  fila record;
  c integer;
BEGIN
c=0;
r=E'\n';
   FOR fila in select nomf from farmacias where codc=codciud LOOP
    c=c+1;
    r=r||fila.nomf||E'\n';
   END LOOP;
   
   if c=0 then
    r=r||'No se encontraron farmacias en esta ciudad'||E'\n';
   end if;
   
   raise notice '%',r;

end;
$$
