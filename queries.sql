
select nome, count(*)

from local_publico 
    inner join item
        on local_publico.latitude = item.latitude and local_publico.longitude = item.longitude
    inner join incidencia
        on incidencia.anomalia_id = item.id

group by nome
having count(*) >= all (
    select count(*)
    from local_publico
    group by nome
);


select utilizador_regular.email, count(*)

from utilizador_regular
    inner join utilizador
        on utilizador.email = utilizador_regular.email
    inner join incidencia
        on utilizador.email = incidencia.email
    inner join anomalia
        on anomalia.id = incidencia.anomalia_id
    inner join anomalia_traducao
        on anomalia_traducao.id = anomalia.id
where anomalia.ts between ('2019-01-01 00:00:00') and ('2019-06-30 23:59:59')
group by utilizador_regular.email
having count(*) >= all (
    select count(*)
    from utilizador_regular
    group by utilizador_regular.email
);

select distinct email
<<<<<<< HEAD
from (incidencia
    join anomalia 
        on incidencia.anomalia_id = anomalia.id
    join item 
        on item.id = incidencia.item_id
    ) t1
=======
from (
    incidencia
    join 
    anomalia on incidencia.anomalia_id = anomalia.id
    join
    item on item.id = incidencia.item_id
    ) table1
>>>>>>> bf30d497cff2ec203a8cae315feac00e01bbdb06
where ts between '2019-01-01 00:00:00' and '2019-12-31 23:59:59' and latitude > 39.336775
    and not exists(
        select latitude, longitude
        from local_publico
        where latitude > 39.336775
        except
        select latitude, longitude
<<<<<<< HEAD
        from(incidencia
            join item 
                on item.id = incidencia.item_id
            ) t2         
        where latitude > 39.336775 and t1.email = t2.email
    );
    
select email
from utilizador_certificado t1
where exists(
	select anomalia_id
	from((utilizador_certificado natural join utilizador 
		natural join incidencia natural join local_publico) a1 
		join anomalia on anomalia.id = a1.anomalia_id) a2
	where a2.latitude < 39.336775 and 
		a2.ts  between '2019-01-01 00:00:00' and '2019-12-31 23:59:59'
	except
	select anomalia_id
	from (utilizador_certificado natural join utilizador natural join incidencia natural join proposta_de_correcao) t2
	where t2.email = t1.email 
)
group by email;
=======
        from( 
            incidencia
            join
            item on item.id = incidencia.item_id
            ) table2           
        where latitude > 39.336775
        and table1.email = table2.email
    );
    
    
select distinct email
from (
    utilizador_certificado
    natural join
    proposta_de_correcao
    natural join
    incidencia
    join
    anomalia on incidencia.anomalia_id = anomalia.id
    join
    item on item.id = incidencia.item_id
    ) table1
where ts between '2019-01-01 00:00:00' and '2019-12-31 23:59:59' and latitude < 39.336775
    and exists(
        select anomalia_id
        from incidencia
            join item on item.id = incidencia.item_id
        where latitude < 39.336775
        except
        select anomalia_id
        from(
            utilizador_certificado
            natural join
            proposta_de_correcao
            natural join
            incidencia
            join
            anomalia on incidencia.anomalia_id = anomalia.id
        ) table2
        where latitude < 39.336775
        and table1.email = table2.email
    );

>>>>>>> bf30d497cff2ec203a8cae315feac00e01bbdb06
  
