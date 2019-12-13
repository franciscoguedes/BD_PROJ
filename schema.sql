drop table local_publico cascade;
drop table item cascade;
drop table anomalia cascade;
drop table anomalia_traducao cascade;
drop table duplicado cascade;
drop table utilizador cascade;
drop table utilizador_certificado cascade;
drop table utilizador_regular cascade;
drop table incidencia cascade;
drop table proposta_de_correcao cascade;
drop table correcao cascade;


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
    zona varchar(80) not null,
    imagem text not null,
    lingua char(3) not null,
    ts timestamp not null,
    descricao text not null,
    tem_anomalia_redacao boolean not null,

    primary key(id));

create table anomalia_traducao(
    id integer,
    zona2 varchar(80) not null,
    lingua2 char(3) not null,

    primary key(id),
    foreign key (id)
        references anomalia(id));

create table duplicado(
    item1 integer not null,
    item2 integer not null,

    check (item1 < item2),
    primary key(item1, item2),
    foreign key(item1)
        references item(id),
    foreign key(item2)
        references item(id));

create table utilizador(
    email varchar(254),
    pass varchar(80) not null,
    primary key(email));


create table utilizador_certificado(
    email varchar(254),
    primary key (email),
    foreign key(email)
        references utilizador(email) DEFERRABLE INITIALLY DEFERRED);

create table utilizador_regular(
    email varchar(254),
    primary key (email),
    foreign key(email)
        references utilizador(email) DEFERRABLE INITIALLY DEFERRED);


create table incidencia (
    anomalia_id integer,
    item_id integer,
    email varchar(254),

    primary key (anomalia_id),
    foreign key(anomalia_id)
        references anomalia(id),
    foreign key(item_id)
        references item(id),
    foreign key(email)
        references utilizador(email));

create table proposta_de_correcao(
    email varchar(254),
    nro integer,
    data_hora timestamp not null,
    texto varchar(254) not null,

    primary key(email, nro),
    foreign key(email)
        references utilizador_certificado(email));

create table correcao(
    email varchar(254),
    nro integer,
    anomalia_id integer,

    primary key(email, nro, anomalia_id),
    foreign key(email, nro)
        references proposta_de_correcao(email, nro),
    foreign key(anomalia_id)
        references incidencia(anomalia_id));



--R-1  A zona da anomalia_tradução não se pode sobrepor à zona da anomalia correspondente
CREATE OR REPLACE FUNCTION check_zona_sobreposta()
RETURNS TRIGGER
AS $$
BEGIN
  IF NOT EXISTS(SELECT * FROM anomalia WHERE anomalia.id = NEW.id AND anomalia.zona != NEW.zona2) THEN
    RAISE EXCEPTION	'Anomalia sobreposta	%',	NEW.id
    USING HINT	=	'Please	get your shit together.';

  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_zona_sobreposta BEFORE INSERT OR UPDATE ON anomalia_traducao
FOR EACH ROW EXECUTE PROCEDURE check_zona_sobreposta();

--R-4 email de utilizador tem de figurar em utilizador_qualificado ou utilizador_regular
CREATE OR REPLACE FUNCTION check_utilizador()
RETURNS TRIGGER
AS $$
BEGIN
  IF (NOT EXISTS (SELECT * FROM utilizador_regular WHERE NEW.email = utilizador_regular.email)
          AND (NOT EXISTS (SELECT * FROM utilizador_certificado WHERE NEW.email = utilizador_certificado.email))) THEN
  --IF NEW.email = utilizador_certificado OR NEW.email = utilizador_regular THEN
    RAISE EXCEPTION 'O email do utilizador nao consta nas devidas tabelas %', NEW.email
    USING HINT	=	'Please	get your shit together.';
    
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_utilizador AFTER INSERT ON utilizador
FOR EACH ROW EXECUTE PROCEDURE check_utilizador();

-- R-5 email não pode figurar em utilizador_regular
CREATE OR REPLACE FUNCTION check_utilizador_certificado()
RETURNS TRIGGER
AS $$
BEGIN
  IF EXISTS (SELECT * FROM utilizador_regular WHERE NEW.email = utilizador_regular.email) THEN
    RAISE EXCEPTION 'O utilizador qualificado nao pode estar na tabela de utilizador regular'
    USING HINT = 'Please	get your shit together.';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_utilizador_certificado AFTER INSERT ON utilizador_certificado
FOR EACH ROW EXECUTE PROCEDURE check_utilizador_certificado();

--R-6 email não pode figurar em utilizador_qualificado
CREATE OR REPLACE FUNCTION check_utilizador_regular()
RETURNS TRIGGER
AS $$
BEGIN
  IF EXISTS (SELECT * FROM utilizador_certificado WHERE NEW.email = utilizador_certificado.email) THEN
    RAISE EXCEPTION 'O utilizador regular nao pode estar na tabela de utilizador certificado'
    USING HINT = 'Please	get your shit together.';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_utilizador_regular AFTER INSERT ON utilizador_regular
FOR EACH ROW EXECUTE PROCEDURE check_utilizador_regular();

