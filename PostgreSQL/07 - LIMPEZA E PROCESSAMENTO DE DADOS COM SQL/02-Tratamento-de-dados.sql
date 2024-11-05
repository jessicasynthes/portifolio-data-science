SELECT * FROM schema7.campanha_marketing;

-- 1. Crie uma query que identifique o total de valores ausentes em todas as colunas

SELECT * FROM schema7.campanha_marketing
WHERE id IS NULL OR
nome_campanha IS NULL OR
data_inicio IS NULL OR
data_fim IS NULL OR
orcamento IS NULL OR
publico_alvo IS NULL OR
canais_divulgacao IS NULL OR
tipo_campanha IS NULL OR
taxa_conversao IS NULL OR
impressoes IS NULL;


-- 2. Crie uma query que identifique se em qualquer coluna há o caracter "?".

SELECT * FROM schema7.campanha_marketing
WHERE CAST(id AS TEXT) LIKE '%?%' OR
CAST(nome_campanha AS TEXT) LIKE '%?%' OR
CAST(data_inicio AS TEXT) LIKE '%?%' OR
CAST(data_fim AS TEXT) LIKE '%?%' OR
CAST(orcamento AS TEXT) LIKE '%?%' OR
CAST(publico_alvo AS TEXT) LIKE '%?%' OR
CAST(canais_divulgacao AS TEXT) LIKE '%?%' OR
CAST(tipo_campanha AS TEXT) LIKE '%?%' OR
CAST(taxa_conversao AS TEXT) LIKE '%?%' OR
CAST(impressoes AS TEXT) LIKE '%?%';

-- 3. Crie uma query que identifique duplicatas (sem considerar a coluna id)

SELECT 
    nome_campanha,
    data_inicio,
    data_fim,
    orcamento,
    publico_alvo,
    canais_divulgacao,
    tipo_campanha,
    taxa_conversao,
    impressoes,
    COUNT(*) as duplicatas
FROM 
    schema7.campanha_marketing
GROUP BY 
    nome_campanha,
    data_inicio,
    data_fim,
    orcamento,
    publico_alvo,
    canais_divulgacao,
    tipo_campanha,
    taxa_conversao,
    impressoes
HAVING 
    COUNT(*) > 1;
	
-- 4. Crie uma query que identifique duplicatas considerando as colunas:
-- nome_campanha, data_inicio, publico_alvo, canais_divulgacao;

SELECT 
    nome_campanha,
    data_inicio,
    publico_alvo,
    canais_divulgacao,
    COUNT(*) as duplicatas
FROM 
    schema7.campanha_marketing
GROUP BY 
    nome_campanha,
    data_inicio,
    publico_alvo,
    canais_divulgacao
HAVING 
    COUNT(*) > 1;
	
	
-- 5. Crie uma query que identifique outliers nas 3 colunas numéricas.   
-- Considere como outliers valores que estejam acima ou abaixo das seguintes regras: 
-- media + 1.5 * desvio_padrão
-- media - 1.5 * desvio_padrão

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
SELECT
    id,
    nome_campanha,
    data_inicio,
    data_fim,
    orcamento,
    publico_alvo,
    canais_divulgacao,
    taxa_conversao,
    impressoes
FROM
    schema7.campanha_marketing,
    stats
WHERE
    orcamento < (avg_orcamento - 1.5 * stddev_orcamento) OR 
    orcamento > (avg_orcamento + 1.5 * stddev_orcamento) OR
    taxa_conversao < (avg_taxa_conversao - 1.5 * stddev_taxa_conversao) OR 
    taxa_conversao > (avg_taxa_conversao + 1.5 * stddev_taxa_conversao) OR
    impressoes < (avg_impressoes - 1.5 * stddev_impressoes) OR 
    impressoes > (avg_impressoes + 1.5 * stddev_impressoes);
	
-- TRATAMENTO DE DADOS AUSENTES --

--1. Crie uma query que identifique os valores únicos da coluna publico_alvo;
SELECT DISTINCT publico_alvo
FROM schema7.campanha_marketing;

--2. Crie uma query com update que substitua o caracter "?" na coluna publico_alvo pelo valor "Outros"
UPDATE schema7.campanha_marketing
SET publico_alvo = 'Outros'
WHERE publico_alvo = '?';

--3. Crie uma query que identifique o total de registros de cada valor da coluna canais_divulgacao;
SELECT canais_divulgacao,
COUNT (*) as Total_Registros
FROM schema7.campanha_marketing
GROUP BY canais_divulgacao;

--4. Crie uma query com update que substitua os valores ausentes pela moda da coluna canais_divulgacao;
WITH moda AS(
	SELECT canais_divulgacao
	FROM schema7.campanha_marketing
	GROUP BY canais_divulgacao
	ORDER BY COUNT (canais_divulgacao) DESC
	LIMIT 1
)
UPDATE schema7.campanha_marketing
SET canais_divulgacao = (SELECT canais_divulgacao FROM moda)
WHERE canais_divulgacao IS NULL;

--5. Crie uma query que identifique o total de registros de cada valor da coluna tipo_campanha
SELECT tipo_campanha,
COUNT (*) as Total_Registros
FROM schema7.campanha_marketing
GROUP BY tipo_campanha;

--6. Cponsidere que os valores ausentes na coluna tipo_campanha sejam erros de coleta de dados.
-- Crie uma query com delete que remova os registros onde tipo_campnha tiver valor nulo.

DELETE FROM schema7.campanha_marketing
WHERE tipo_campanha IS NULL;

