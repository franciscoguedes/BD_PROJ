create table d_utilizador(
    id_utilizador integer,
    email varchar(80),
    tipo varchar(80),
    primary key(id_utilizador)
);

create table d_tempo(
    id_tempo integer,
    dia integer,
    dia_da_semana varchar(80),
    semana integer,
    mes integer,
    trimestre integer,
    ano integer,
    primary key(id_tempo)
);

create table d_local(
    id_local integer,
    latitude numeric(9,6),
    longitude numeric(8,6),
    primary key(id_local);
)

create table d_lingua(
    id_lingua integer,
    lingua varchar(80),
    primary key(id_lingua);
)

create table f_anomalia(
    id_utilizador integer,
    id_tempo integer,
    id_local integer,
    id_lingua integer,
    tipo_anomalia varchar(80),
    com_proposta boolean,
    primary key(id_utilizador ,
    id_tempo,
    id_local,
    id_lingua),
    foreign key(id_utilizador)
        references d_utilizador(id_utilizador),
    
    foreign key(id_tempo)
        references d_tempo(id_tempo),
    
    foreign key(id_local)
        references d_local(id_local),
    
    foreign key(id_lingua)
        references d_lingua(id_lingua);
)



--data analytics 

select tipo, lingua, dia_da_semana, 
from (((f_anomalia 
        natural join d_utilizador) t1 
    natural join d_tempo) t2 
    natural join d_lingua) t3 
group by rollup (tipo, lingua, dia_da_semana);