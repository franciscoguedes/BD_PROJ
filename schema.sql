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
    tem_anomalia_redacao boolean not null,

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

create table utilizador(
    email varchar(254),
    password varchar(80) not null, 

    primary key(email));

create table utilizador_certificado(
    email varchar(254),

    foreign key(email)
        references utilizador(email));

create table utilizador_regular(
    email varchar(254),

    foreign key(email)
        references utilizador(email));

create table incidencia (
    anomalia_id integer,
    item_id integer,
    email varchar(254),

    foreign key(anomalia_id)
        references anomalia(id),
    foreign key(item_id)
        references item(id),
    foreign key(email)
        references utilizador(email));

create table proposta_de_correcao(
    email varchar(254),
    nro integer,
    data_hora datetime,
    texto text,

    primary key(email, nro),
    foreign key(email)
        references utilizador(email));

create table correcao(
    email varchar(254),
    nro integer,
    anomalia_id integer,

    primary key(email, nro, anomalia_id),
    foreign key(email)
        references utilizador(email)
    foreign key(anomalia_id)
        references incidencia(anomalia_id));


