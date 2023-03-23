/*
procedimento phcamas que, pasandolle o numero de camas como parametro, devolte os nomes dos hospitais propios que as superan asi como os nomes dos hospitalizados de 1º categoria que estiveron neles, e o seu total. Se ningun hospital propio supera o numero de camas a mensaxe debe ser: 'ningun hospital propio supera ese numero de camas'
Si agun dos hospitais non ten hospitalizados de 1ª categoria a mensaxe debe ser : 'hospital sen hospitalizados'.

Ex:
call phcamas(150);

hospital: canalejo
dolores
dolores
o numero de hospitalizados e : 2

hospital: meixoeiro
hospital sen hospitalizados

hospital: paz
andrea
o numero de hospitalizados e : 1
Ex:
call  phcamas(3000);
ningun hospital propio supera ese numero de camas
*/

CREATE or replace procedure phcamas(nc integer)
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
  fila record;
  filax record;
  filay record;
  filaz record;
  r varchar;
  c1 integer;
  c2 integer;
BEGIN
c1=0;
r=E'\n';
   FOR fila in select codh from propio LOOP
    select nomh,numc into filax from hospital where codh=fila.codh;

    c2=0;

    if filax.numc>nc then
    c1=c1+1;
    r=r||'Hospital: '||filax.nomh||E'\n';
    end if;

    FOR filay in select codp from hosp1 where codh=fila.codh and filax.numc>nc LOOP

      c2=c2+1;

      select nomas into filaz from asegurado where codp=filay.codp;

      r=r||E'\t'||filaz.nomas||E'\n';

    END LOOP;

    if c2>0 then
      r=r||E'\t'||'Numero de hospitalizados: '||c2||E'\n';
    end if;

    if c2=0  and filax.numc>nc then
      r=r||E'\t'||'Hospital sin hospitalizados'||E'\n';
    end if;

   END LOOP;

   if c1=0 then
    r=r||'Ningun hospital propio supera este numero de camas'||E'\n';
   end if;

   raise notice '%',r;

end;
$$;