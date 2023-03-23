/*trigger thorasmaxs

impedir que un mismo actor interprete mas de 500 horas en una misma serie

insert into interpretesser values('a18','p16','s3',1)

rexeitada insercion, ese actor non pode traballa mais de 500 horas na serie s3

insert into interpretesser values('a12','p16','s3',101)
rexeitada insercion, ese actor non pode traballa mais de 500 horas na serie s3

insert into interpretesser values('a12','p16','s3',100)
aceptada insercion
*/

drop function tmaxhorasp() cascade;
create function tmaxhorasp() returns trigger language plpsql as $$
declare
suma integer;

begin
select sum(coalesce(horas,0)) into suma from interpretesser where coda=new.coda and cods=new.cods;
suma=suma+new.horas;

if suma>500 then
raise exception 'demasiadas horas';
else
raise notice 'aceptada insercion';
end if;

return new;
end;
$$
CREATE TRIGGER tmaxhoraspt before INSERT ON interpretesser for each row EXECUTE PROCEDURE tmaxhorasp();