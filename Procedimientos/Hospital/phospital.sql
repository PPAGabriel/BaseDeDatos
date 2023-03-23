/*
phospitalp
procedimento que, pasandolle o nome dun hospital, imprima os nomes dos asegurados de 1ra categoria que foron hospitalizados nel .
 Se non ten asegurados de primeira categoria hospitalizados debe imprimirse a mensaxe 'este hospital non ten asegurados de 1ra categoria hospitalizados'  
 Se o hospital non existe debe imprimirse a mensaxe adecuada (mediante tratamento de excepcions) .

call phospitalp ('povisa');
andrea
dorotea

call phospitalp ('sonic');
este hospital non ten asegurados de 1ra categoria hospitalizados


execute phospital ('roma');
este hospital non existe
*/

CREATE or replace procedure phospital(nomhosp varchar)
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
    select codh,nomh into STRICT fila from hospital where nomh=nomhosp;
    c=0;

    FOR filax in select codp,numas from hosp1 where codh=fila.codh LOOP
    c=c+1;

        FOR filay in select nomas from asegurado where codp=filax.codp and numas=filax.numas LOOP

        r=r||E'\t'||filay.nomas||E'\n';

        END LOOP;
    END LOOP;

    if c=0 then
         r=r||E'\t'||'Hospital sin asegurados'||E'\n';
    end if;
   
    raise notice '%',r;

    exception
    when no_data_found then
    r=r||'Hospital no encontrado.';
    raise notice '%',r;

end;
$$;