SELECT * FROM schema6.lancamentosdsacontabeis;

-- ANÁLISE MULTIVARIADA --

-- Lab 2 - Análise Multivariada --
-- Aqui estão os requisitos do relatório:
-- Calcule o valor total dos lançamentos;
-- Calcule a média dos lançamentos;
-- Calcule a contagem dos lançamentos
-- Calcule a média do valor de taxa de conversão somente se a moeda for diferente de BRL;
-- Crie um ranking por valor total dos lançamentos[x], por média do valor e por média da taxa de conversão;
-- Queremos o resultado somente se o centro de custo for 'Compras' ou 'RH'.


SELECT centro_custo,
	COUNT(valor) AS Contagem_Lancamentos,
	SUM(valor) AS Total_Lancamentos,
	RANK() OVER (ORDER BY SUM(valor) DESC) AS Ranking_Total_Lancamentos,
	ROUND(AVG(valor), 2) AS Media_Lancamentos,
	RANK() OVER (ORDER BY ROUND(AVG(valor), 2) DESC) AS Ranking_Media_Lancamentos,
	COALESCE(ROUND(AVG(taxa_conversao) FILTER (WHERE moeda != 'BRL'), 2), 0.00) AS Media_Taxa_Conversao,
	RANK() OVER (ORDER BY COALESCE(ROUND(AVG(taxa_conversao) FILTER (WHERE moeda != 'BRL'), 2), 0.00) DESC) AS Ranking_Media_Taxa_Conversao
FROM schema6.lancamentosdsacontabeis
GROUP BY centro_custo
HAVING centro_custo = 'Compras' OR centro_custo = 'RH';

-- Professor --

SELECT
    A.centro_custo,
    A.moeda,
    SUM(A.valor) AS total_valor_lancamento,
    DENSE_RANK() OVER (ORDER BY SUM(A.valor) DESC) AS rank_total_valor,
    ROUND(AVG(A.valor), 2) AS media_valor_lancamento,
    DENSE_RANK() OVER (ORDER BY AVG(A.valor) DESC) AS rank_media_valor,
    COUNT(A.*) AS numero_de_lancamentos,
    COALESCE(ROUND(AVG(A.taxa_conversao) FILTER (WHERE A.moeda != 'BRL'),2), 0) AS media_taxa_conversao,
    DENSE_RANK() OVER (ORDER BY COALESCE(ROUND(AVG(A.taxa_conversao) FILTER (WHERE A.moeda != 'BRL'),2), 0) DESC) AS rank_media_taxa
FROM
    schema6.lancamentosdsacontabeis A
WHERE 
    A.centro_custo IN ('Compras', 'RH')
GROUP BY
    A.centro_custo, A.moeda
ORDER BY 
    rank_total_valor, rank_media_valor, rank_media_taxa



