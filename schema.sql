create table local_publico(
    latitude numeric(9,6),
    longitude numeric(8,6),
    nome varchar(80) not null,

    primary key(latitude, longitude));


create table item(
    id integer,
    descricao text not null,
    localizacao text not null,
    latitude numeric(9,6),
    longitude numeric(8,6),

    primary key(id),
    foreign key(latitude, longitude)
        references local_publico(latitude, longitude));

create table anomalia(
    id integer,
    zona box not null,
    imagem text not null,
    lingua char(3) not null,
    ts timestamp not null,
    descricao text not null,
    tem_anomalia_redacao boolean not null6

    primary key(id));

create table anomalia_redacao(
    id integer,
    zona2 box not null,
    lingua2 char(3) not null,

    primary key(id));

create table duplicado(

    foreign key(item1)
        references item(id)
)