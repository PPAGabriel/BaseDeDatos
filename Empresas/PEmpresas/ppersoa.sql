/*
ppersoa
procedemento chamado ppersoa que amose para unha persoa cuxo dni se pasa por parámetro o seu nome e os postos para os que se lle fixeron entrevistas e o nome e apelidos do xestor que llas fixo 
call ppersoa('36555555');
persoa: elisa,bermudez,bastos
postos e xestor que o xestionou:
p1 : ricardo,leiro,suarez
p342 : eva,bastos,boullosa
p14 : ricardo,leiro,suarez
*/

CREATE or replace procedure ppersoa(dniv varchar)
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
r varchar;
f1 record;
f2 varchar;
f3 record;
fila record;
BEGIN
   r=E'\n';
   select  num_persoa,nom_persoa,ap1_persoa,ap2_persoa into f1 from persoas where dni=dniv;
   
   r=r||'Persona: '||f1.nom_persoa || ', ' || f1.ap1_persoa || ', ' || f1.ap2_persoa ||E'\n'||'Puestos y persoa que lo gestiono:'||E'\n';

   FOR fila IN select cod_posto from entrevista where num_persoa=f1.num_persoa LOOP

    select cod_xestor into f2 from postos where cod_posto=fila.cod_posto;
    select nom_xestor,ap1_xestor,ap2_xestor into f3 from xestores where cod_xestor=f2;

    r=r||E'\t'||fila.cod_posto||': '||f3.nom_xestor||','||f3.ap1_xestor||','||f3.ap2_xestor||E'\n';

   END LOOP;

   raise notice '%',r;

end;
$$;