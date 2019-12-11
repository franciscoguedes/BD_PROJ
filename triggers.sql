CREATE OR REPLACE FUNCTION zona_sobreposta()
RETURNS TRIGGER
AS $$
BEGIN
  IF NEW.zona2 != anomalia.zona AND NEW.id = anomalia.id THEN
    INSERT INTO anomalia_traducao
    VALUES (NEW.id, NEW.zona2, NEW.lingua2)
  ELSE
    RAISE EXCEPTION	'Anomalia sobreposta	%',	NEW.id
    USING HINT	=	'Please	get your shit together.';

  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER zona_sobreposta BEFORE INSERT ON anomalia_traducao
FOR EACH ROW EXECUTE PROCEDURE zona_sobreposta();
