SELECT * FROM schema6.lancamentosdsacontabeis;

-- IDENTIFICAÇÃO DE OUTLIERS --

-- Vamos analisar a coluna valor

SELECT
	ROUND(AVG(valor), 2) AS media,
	PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY valor) AS mediana,
	MAX(valor) as maximo,
	MIN(valor) as minimo
FROM schema6.lancamentosdsacontabeis;

-- Criando Boxplot via SQL --

SELECT 
    centro_custo,
    moeda,
    MIN(VALOR) as minimo_valor,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor) AS q1, 
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY valor) AS q2,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) AS q3,
    MAX(valor) as maximo_valor
FROM
    schema6.lancamentosdsacontabeis
GROUP BY
    centro_custo, moeda;
	
-- Solução usando agragação --

SELECT 
    centro_custo,
    moeda,
    MIN(VALOR) as minimo_valor,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor) - 0.3 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor)) AS limite_inferior,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor) AS q1,
    ROUND(AVG(valor),2) AS media_valor, 
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY valor) AS q2,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) AS q3,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) + 0.3 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor)) AS limite_superior,
    MAX(valor) as maximo_valor
FROM
    schema6.lancamentosdsacontabeis
GROUP BY
    centro_custo, moeda;
	
-- Solução usando Common Table Expressions (CTE) --

WITH Estatisticas AS (
    SELECT
        centro_custo,
        moeda,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor) AS q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) AS q3
    FROM
        schema6.lancamentosdsacontabeis
    GROUP BY
        centro_custo, moeda
),
LimitesOutliers AS (
    SELECT
        centro_custo,
        moeda,
        q1,
        q3,
        q1 - 0.5 * (q3 - q1) AS limite_inferior,
        q3 + 0.5 * (q3 - q1) AS limite_superior
    FROM
        Estatisticas
)
SELECT
    L.id,
    L.data_lancamento,
    L.centro_custo,
    L.moeda,
	limite_inferior,
	limite_superior,
    L.valor
FROM
    schema6.lancamentosdsacontabeis L
INNER JOIN
    LimitesOutliers E
ON
    L.centro_custo = E.centro_custo AND L.moeda = E.moeda
WHERE
    L.valor < E.limite_inferior OR L.valor > E.limite_superior
ORDER BY
    L.valor, L.centro_custo, L.moeda;
	
-- Análise de séries temporais --

-- Identifique o erro de lógica na query abaixo:
WITH LancamentosOrdenados AS (
    SELECT
        data_lancamento,
        centro_custo,
        conta_credito,
        valor,
        ROW_NUMBER() OVER (PARTITION BY centro_custo ORDER BY data_lancamento) AS ordem
    FROM
        schema6.lancamentosdsacontabeis
),
MediaMovel AS (
    SELECT
        L1.centro_custo,
        L1.data_lancamento,
        L1.conta_credito,
        L1.valor,
        ROUND(AVG(L1.valor) OVER (PARTITION BY L1.centro_custo ORDER BY L1.ordem RANGE BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS media_movel_3dias
    FROM
        LancamentosOrdenados L1
)
SELECT
    M.centro_custo,
    M.conta_credito,
    M.data_lancamento,
    M.valor,
    M.media_movel_3dias,
    DENSE_RANK() OVER (PARTITION BY M.data_lancamento ORDER BY M.media_movel_3dias DESC) AS rank_media_movel
FROM
    MediaMovel M
ORDER BY
    M.data_lancamento, rank_media_movel;
	
	