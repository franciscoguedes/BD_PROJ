--1.1: Nesta situação não é vantajoso a criação de um index visto que devolve mais do que 10% do registos totais da tabela
--1.2
CREATE INDEX data_index ON proposta_de_correcao(data_hora);


--2 Não é necessário visto que anomalia_id já é uma chave primária da tabela

--3.1  Nesta situação não é vantajoso a criação de um index visto que devolve mais do que 10% do registos totais da tabela
--3.2  Neste caso trocando a ordem da chave primária da correcao para (anomalia_id, email, nro) por exemplo já temos um index para a anomalia_id que nos dá um speedup
--4
CREATE INDEX group_index ON anomalia(ts, tem_anomalia_redacao, lingua) WHERE tem_anomalia_redacao is TRUE;