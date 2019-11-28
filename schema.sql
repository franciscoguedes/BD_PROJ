create table local_publico(
    latitude numeric(9,6),
    longitude numeric(8,6),
    nome varchar(80) not null,

    constraint pk_local_publico primary key(latitude, longitude));


create table item(
    id integer,
    descricao text not null,
    localizacao text not null,
    latitude numeric(9,6),
    longitude numeric(8,6),

    constraint pk_item primary key(id),
    constraint fk_item_local_publico foreign key(latitude, longitude)
        references local_publico(latitude, longitude));

create table anomalia(
    id integer,
    zona box not null,
    imagem text not null,
    lingua char(3) not null,
    ts timestamp not null,
    descricao text not null,
    tem_anomalia_redacao boolean not null,

    constraint pk_anomalia primary key(id));

create table anomalia_redacao(
    id integer,
    zona2 box not null,
    lingua2 char(3) not null,

    constraint pk_anomalia_redacao primary key(id));

create table duplicado(

    constraint fk_duplicado_item foreign key(item1)
        references item(id),
    constraint fk_duplicado_item foreign key(item2)
        references item(id));

create table utilizador(
    email varchar(254),
    password varchar(80) not null, 

    constraint pk_utilizador primary key(email));





create table utilizador_certificado(
    email varchar(254),

    constraint fk_utilizador_certificado_utilizador foreign key(email)
        references utilizador(email));

create table utilizador_regular(
    email varchar(254),

    constraint fk_utilizador_regular_utilizador foreign key(email)
        references utilizador(email));


--anomalia_id ou id??
create table incidencia (
    anomalia_id integer,
    item_id integer,
    email varchar(254),

    constraint fk_incidencia_anomalia foreign key(anomalia_id)
        references anomalia(id),
    constraint fk_incidencia_item foreign key(item_id)
        references item(id),
    constraint fk_incidencia_utilizador foreign key(email)
        references utilizador(email));

create table proposta_de_correcao(
    email varchar(254),
    nro integer,
    data_hora datetime,
    texto text,

    constraint pk_proposta_de_correcao primary key(email, nro),
    constraint fk_proposta_de_correcao_utilizador foreign key(email)
        references utilizador(email));

create table correcao(
    email varchar(254),
    nro integer,
    anomalia_id integer,

    constraint pk_correcao primary key(email, nro, anomalia_id),
    constraint fk_correcao_utilizador foreign key(email)
        references utilizador(email),
    constraint fk_correcao_incidencia foreign key(anomalia_id)
        references incidencia(anomalia_id));


