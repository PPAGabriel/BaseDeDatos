/*
procedimiento chamado pcolexiadopartidos que amose cada colexiado o nome e as datas dos partidos nos que interven
*/

CREATE or replace procedure pcolexiadopartidos()
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
  fila record;
  filax record;
  partdata record;
  r varchar;
  c integer;
BEGIN
   r=E'\n';
   c=0;
   FOR fila IN select codc,nomc from colexiado LOOP
   r=r||fila.codc||', '||fila.nomc||':'||E'\n';
   	FOR filax IN select codc,codpar from interven where codc=fila.codc LOOP
	   c=c+1;
   		select codpar,nompar,data into partdata from partido where codpar=filax.codpar;
   		r=r||E'\t'||partdata.nompar||', '||partdata.data||E'\n';
   	END LOOP;
   	
   	if c=0 then
	   	r=r||E'\t'||'No tiene partidos arbitrados.' || E'\n';
	else
		r=r||E'\n'||E'\t'||'TOTAL DE PARTIDOS: '||c||E'\n';
	     
   	end if;
   	c=0;
   END LOOP;
   
   
   
   raise notice '%',r;

end;
$$




