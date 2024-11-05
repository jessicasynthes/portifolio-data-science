SELECT * FROM schema7.campanha_marketing;

-- RELATÓRIO DE RESUMO COM VARIÁVEIS QUANTITATIVAS --

-- 1. Totais dos anos 2022, 2023 e 2024 para as colunas orcamento, taxa_conversao e impressoes

SELECT
	EXTRACT (YEAR FROM data_fim) AS ano,
	SUM(orcamento) AS orcamento_anual,
	SUM(taxa_conversao) AS taxa_conversao_anual,
	SUM(impressoes) AS impressoes_anual
FROM schema7.campanha_marketing
WHERE EXTRACT (YEAR FROM data_fim) IN (2022,2023,2024)
GROUP BY EXTRACT (YEAR FROM data_fim)
ORDER BY ano DESC;

-- 2. Pivot da tabela --

SELECT
    'Total' as Total,
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2022 THEN orcamento ELSE 0 END) AS "Orcamento_2022",
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2022 THEN taxa_conversao ELSE 0 END) AS "Taxa_Conversao_2022",
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2022 THEN impressoes ELSE 0 END) AS "Impressoes_2022",
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2023 THEN orcamento ELSE 0 END) AS "Orcamento_2023",
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2023 THEN taxa_conversao ELSE 0 END) AS "Taxa_Conversao_2023",
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2023 THEN impressoes ELSE 0 END) AS "Impressoes_2023",
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2024 THEN orcamento ELSE 0 END) AS "Orcamento_2024",
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2024 THEN taxa_conversao ELSE 0 END) AS "Taxa_Conversao_2024",
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2024 THEN impressoes ELSE 0 END) AS "Impressoes_2024"
FROM
    schema7.campanha_marketing;
	
-- 3.Selecione id, nome_campanha, data_inicio e data_fim, junto com orcamento e taxa_conversao normalizados

-- Sem normalização

SELECT
    id,
    nome_campanha,
    data_inicio,
    data_fim,
    orcamento,
    taxa_conversao
FROM
    schema7.campanha_marketing;

-- Com normalização

WITH min_max AS (
    SELECT
        MIN(orcamento) as min_orcamento,
        MAX(orcamento) as max_orcamento,
        MIN(taxa_conversao) as min_taxa_conversao,
        MAX(taxa_conversao) as max_taxa_conversao
    FROM
        schema7.campanha_marketing
)
SELECT
    id,
    nome_campanha,
    data_inicio,
    data_fim,
    ROUND((orcamento - min_orcamento) / (max_orcamento - min_orcamento),5) as orcamento_normalizado,
    ROUND((taxa_conversao - min_taxa_conversao) / (max_taxa_conversao - min_taxa_conversao),5) as taxa_conversao_normalizada
FROM
    schema7.campanha_marketing, min_max;