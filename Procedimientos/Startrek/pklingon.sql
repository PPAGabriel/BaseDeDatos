/*
procedemento que devolva todos os titulos da peliculas e para cada una delas os nomes dos personaxes klingon que interveñen nela
*/

CREATE or replace procedure pklingon()
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
  fila record;
  filax record;
  filay record;
  per record;
  r varchar;
  c integer;
BEGIN
   r=E'\n';
    FOR fila IN select codpel,titulo from peliculas LOOP
    c=0;
    r=r||fila.titulo||E'\n';
        FOR filax IN select codpel,codper from interpretespel where codpel=fila.codpel LOOP
            FOR filay IN select codper from klingon where codper=filax.codper LOOP
                c=c+1;
                select codper,nomper into per from personaxes where codper=filay.codper;
                r=r||E'\t'||per.nomper||E'\n';
            END LOOP;
        END LOOP;
         
    if c=0 then
        r=r||E'\t'||'No tiene personajes klingon'||E'\n';
    else
    end if;

    END LOOP;

   raise notice '%',r;

end;
$$;