CREATE or replace procedure ppostosnegados(dniv varchar)
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
  fila record;
  filap record;
  nper numeric;
  r varchar;
  c numeric;
BEGIN
c=0;
r=E'\n';

select num_persoa into nper from persoas where dni=dniv;
--r=r||nper||E'\n';
FOR fila IN select cod_empresa from rexeita where num_persoa=nper LOOP
--r=r||fila.cod_empresa||E'\n';
	FOR filap IN select cod_posto from postos where cod_empresa=fila.cod_empresa LOOP
	r=r||filap.cod_posto||E'\n';
	c=c+1;
	END LOOP;
END LOOP;
   
   if c>0 then
    raise notice '% Esta persona es rechazada para un total de % puestos',r,c;
   else
    raise notice 'Esta persona es entrevistable para cualquier puesto de cualquier empresa';
   end if;
   
end;
$$


/*
select num_persoa from persoas where dni='36202020';
 num_persoa 
------------
         20


select cod_empresa from rexeita where num_persoa=20;
 cod_empresa 
-------------
 e3
 e10

select cod_posto from postos where cod_empresa='e3' or cod_empresa='e10';
 cod_posto 
-----------
 p2
 p8
 p9
 p13
 p14
 p15
 p16
 p17

*/
