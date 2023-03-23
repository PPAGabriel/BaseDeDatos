/*
parea
procedemento que liste os codigos de todas as areas e para cada codigo de area os nomes dos asegurados de dita area xunto co numero total deles.
Se un area non ten asegurados debe imprimirse a mensaxe: area sen asegurados:
puntuacion:
amosar codigos de area: .5
amosar nomes de asegurados: 1
amosar numero total de asegurados: .25
amosar 'area sen asegurados' : .25 
call parea();
codigo de area: a1
luis
ana
numero de asegurados: 2
codigo de area: a2
pedro
juan
carlos
numero de asegurados: 3
codigo de area: a3
bieito
numero de asegurados: 1
codigo de area: a4
xoan
eva
comba
ainara
numero de asegurados: 4
codigo de area: a5
dorotea
elisa
amalia
dolores
maria
xose
andrea
iria
antia
xana
numero de asegurados: 10
codigo de area: a6
area  sen asegurados
codigo de area: a7
jose
numero de asegurados: 1
*/

CREATE or replace procedure parea()
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
    fila record;
    filax record;
    c1 integer;
    r varchar;
BEGIN
    r=E'\n';

    FOR fila IN select coda from area LOOP
    c1=0;
    r=r||'Codigo de area: '||fila.coda||E'\n';

        FOR filax IN select coda,nomas from asegurado where coda=fila.coda LOOP

        c1=c1+1;
        r=r||E'\t'||filax.nomas||E'\n';
        END LOOP;
    
    if c1=0 then
        r=r||E'\t'||'Area sin asegurados'||E'\n';
    else
        r=r||E'\t'||'Numero de asegurados: '||c1||E'\n';
    end if;

    END LOOP;

    raise notice '%',r;

end;
$$;