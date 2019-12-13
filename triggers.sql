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

