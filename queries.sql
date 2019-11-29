
select nome, count(*)

from local_publico 
    inner join item
        on local_publico.latitude = item.latitude and local_publico.longitude = item.longitude
    inner join incidencia
        on incidencia.anomalia_id = item.id

group by nome
havinh count(*) >= all (
    select count(*)
    from 
    group by nome
)
