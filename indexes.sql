--1.1: Nesta situação não é vantajoso a criação de um index visto que devolve mais do que 10% do registos totais da tabela
--1.2
CREATE INDEX data_index ON proposta_de_correcao(data_hora);


--2
CREATE INDEX anomalia_index ON incidencia USING HASH(anomalia_id);

--3.1:  Nesta situação não é vantajoso a criação de um index visto que devolve mais do que 10% do registos totais da tabela
--3.2
CREATE INDEX anomalia_index ON incidencia(anomalia_id);

--4
CREATE INDEX ts_index ON anomalia(ts);
CREATE INDEX anomalia_redacao_index ON anomalia(tem_anomalia_redacao) WHERE tem_anomalia_redacao is TRUE;
CREATE INDEX language_index ON anomalia(<SOME_PATTERN%>);