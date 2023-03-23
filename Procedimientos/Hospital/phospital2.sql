/*phospital2
procedemento que amose os nomes de todos os hospitais e para ca un deles os nomes dos medicos que prescribiron  hospitalizacions a asegurados de primeira categoria 
*/

CREATE or replace procedure phospital2()
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
  fila record;
  filax record;
  filay record;
  r varchar;
  c integer;
BEGIN
r=E'\n';

    FOR fila in select codh,nomh from hospital LOOP
        c=0;
        r=r||fila.nomh||':'||E'\n';

        FOR filax in select codm from hosp1 where codh=fila.codh LOOP
            c=c+1;
            select nomm into filay from medico where codm=filax.codm;
            r=r||E'\t'||filay.nomm||E'\n';

        END LOOP;

    if c=0 then
        r=r||E'\t'||'No hay medicos que hayan prescrito hospitalizaciones a asegurados de 1ra.'||E'\n';
    end if;

    END LOOP;

    

   raise notice '%',r;

end;
$$;