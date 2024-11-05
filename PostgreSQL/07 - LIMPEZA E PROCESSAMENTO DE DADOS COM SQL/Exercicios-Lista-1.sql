SELECT * FROM schema7.campanha_marketing;

--1. Crie uma query que identifique valores ausentes na coluna Orçamento

--Contagem
SELECT
	COUNT(*) - COUNT(orcamento) AS orcamento_missing
FROM schema7.campanha_marketing
-- Visualização
SELECT * FROM schema7.campanha_marketing
WHERE orcamento IS NULL;

-- 2.Considere  que  orçamento  nulo  para  público  alvo  igual  "Outros"  não  seja  uma informação relevante.
-- Crie uma query com delete que remova registros se a coluna orcamento tiver valor ausente 
-- e a coluna publico_alvo tiver o valor "Outros".

SELECT orcamento,
	publico_alvo
FROM schema7.campanha_marketing
WHERE orcamento IS NULL AND publico_alvo = 'Outros';

DELETE FROM schema7.campanha_marketing
WHERE orcamento IS NULL AND publico_alvo = 'Outros';

-- 3.Crie uma query que preencha os valores ausentes da coluna orcamento com a média da coluna, 
-- mas segmentado pela coluna canais_divulgacao.

SELECT
	canais_divulgacao,
	ROUND (AVG (orcamento), 2) as media
FROM schema7.campanha_marketing
GROUP BY canais_divulgacao;
	
UPDATE schema7.campanha_marketing
SET orcamento = 48350.20
WHERE orcamento IS NULL AND canais_divulgacao = 'Sites de Notícias';

UPDATE schema7.campanha_marketing
SET orcamento = 48589.76
WHERE orcamento IS NULL AND canais_divulgacao = 'Google';

UPDATE schema7.campanha_marketing
SET orcamento = 48577.83
WHERE orcamento IS NULL AND canais_divulgacao = 'Redes Sociais';

-- 4. Use como estratégia de tratamento de outliers criar uma nova coluna e preenchê-la com 
-- True se houver outlier no registro e False caso contrário.

--Criando a coluna
ALTER TABLE schema7.campanha_marketing
ADD COLUMN outlier BOOLEAN;

--Atribuindo valores (TRUE)
WITH stats AS (
    SELECT
        AVG(orcamento) AS avg_orcamento,
        STDDEV(orcamento) AS stddev_orcamento,
        AVG(taxa_conversao) AS avg_taxa_conversao,
        STDDEV(taxa_conversao) AS stddev_taxa_conversao,
        AVG(impressoes) AS avg_impressoes,
        STDDEV(impressoes) AS stddev_impressoes
    FROM
        schema7.campanha_marketing
)

UPDATE schema7.campanha_marketing
SET outlier = TRUE
FROM
    stats
WHERE outlier IS NULL AND
    orcamento < (avg_orcamento - 1.5 * stddev_orcamento) OR 
    orcamento > (avg_orcamento + 1.5 * stddev_orcamento) OR
    taxa_conversao < (avg_taxa_conversao - 1.5 * stddev_taxa_conversao) OR 
    taxa_conversao > (avg_taxa_conversao + 1.5 * stddev_taxa_conversao) OR
    impressoes < (avg_impressoes - 1.5 * stddev_impressoes) OR 
    impressoes > (avg_impressoes + 1.5 * stddev_impressoes);

--Atribuindo valores (FALSE)
UPDATE schema7.campanha_marketing
SET outlier = FALSE
WHERE outlier IS NULL;

-- Validando alterações
SELECT outlier, COUNT(*) 
FROM schema7.campanha_marketing
GROUP BY outlier;

-- 5.Aplique label encoding(técnica de representação numérica de dados de texto)
-- na coluna publico_alvo e salve o resultado em uma nova coluna chamada publico_alvo_encoded.

-- Criando a coluna
ALTER TABLE schema7.campanha_marketing
ADD COLUMN publico_alvo_encoded INTEGER;

-- Label Encoding
UPDATE schema7.campanha_marketing
SET publico_alvo_encoded =
CASE 
	WHEN publico_alvo = 'Publico Alvo 1' THEN 1
	WHEN publico_alvo = 'Publico Alvo 2' THEN 2
	WHEN publico_alvo = 'Publico Alvo 3' THEN 3
	WHEN publico_alvo = 'Publico Alvo 4' THEN 4
	WHEN publico_alvo = 'Publico Alvo 5' THEN 5
	WHEN publico_alvo = 'Outros' THEN 0
END;

-- 6. Aplique label encoding na coluna canais_divulgacao e salve o resultado 
-- em uma nova coluna chamada canais_divulgacao_encoded.

-- Criando a coluna
ALTER TABLE schema7.campanha_marketing
ADD COLUMN canais_divulgacao_encoded INTEGER;

-- Label Encoding
UPDATE schema7.campanha_marketing
SET canais_divulgacao_encoded =
CASE 
	WHEN canais_divulgacao = 'Google' THEN 1
	WHEN canais_divulgacao = 'Redes Sociais' THEN 2
	WHEN canais_divulgacao = 'Sites de Notícias' THEN 3
END;

-- 7. Aplique label encoding na coluna tipo_campanha e salve o resultado 
-- em uma nova coluna chamada tipo_campanha_encoded.

-- Criando a coluna
ALTER TABLE schema7.campanha_marketing
ADD COLUMN tipo_campanha_encoded INTEGER;

-- Label Encoding
UPDATE schema7.campanha_marketing
SET tipo_campanha_encoded =
CASE 
	WHEN tipo_campanha = 'Divulgação' THEN 1
	WHEN tipo_campanha = 'Mais Seguidores' THEN 2
	WHEN tipo_campanha = 'Promocional' THEN 3
END;

-- 8.Faça o drop das 3 colunas originais que foram codificadas nos itens 5, 6 e 7.

ALTER TABLE schema7.campanha_marketing
DROP COLUMN publico_alvo;

ALTER TABLE schema7.campanha_marketing
DROP COLUMN canais_divulgacao;

ALTER TABLE schema7.campanha_marketing
DROP COLUMN tipo_campanha;