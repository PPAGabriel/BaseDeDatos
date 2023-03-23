CREATE or replace procedure pfarmacianome(codfar integer)
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
  r varchar;
  f1 varchar;
BEGIN
r=E'\n';
   select nomf into STRICT f1 from farmacias where codf=codfar;
   
   r=r||'Nombre de la Farmacia encontrada: '||f1||E'\n';
   
   raise notice '%',r;
   
   exception
   when no_data_found then
   r=r||'Farmacia no encontrada';
   raise notice '%',r;

end;
$$
