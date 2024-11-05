SELECT * FROM schema6.lancamentosdsacontabeis;

-- Sumarização de Dados --

-- Crie uma query mostrando diversas métricas por centro de custo:
-- Contagem_Lancamentos;
-- Total_Valores_Lancamentos;
-- Media_Valores_Lancamentos;
-- Maior_Valor;
-- Menor_Valor;
-- Soma_Valores_USD;
-- Soma_Valores_EUR;
-- Soma_Valores_BRL;
-- Media_Taxa_Conversao;
-- Mediana_Valores.

-- Dica: Tome cuidado com valores nulos na coluna taxa_conversao;

SELECT centro_custo,
	COUNT(valor) AS Contagem_Lancamentos,
	SUM(valor) AS Total_Valores_Lancamentos,
	ROUND(AVG(valor), 2) AS Media_Valores_Lancamentos,
	MAX(valor) AS Maior_Valor,
	MIN(valor) AS Menor_Valor,
	COALESCE(ROUND(AVG(taxa_conversao), 2), 0.00) AS Media_Taxa_Conversao,
	SUM(valor) FILTER (WHERE moeda = 'USD') AS Soma_Valores_USD,
    SUM(valor) FILTER (WHERE moeda = 'EUR') AS Soma_Valores_EUR,
    SUM(valor) FILTER (WHERE moeda = 'BRL') AS Soma_Valores_BRL,
	percentile_cont(0.5) WITHIN GROUP (ORDER BY valor) AS Mediana_Valores
FROM schema6.lancamentosdsacontabeis
GROUP BY centro_custo
ORDER BY centro_custo;

-- Distribuição de Dados --

-- Crie uma query para mostrar a distribuição dos dados na tabela. À partir da coluna valor, o relatório deve mostrar:

-- Quantidade_Lançamentos,
-- Media_Valor,
-- Desvio_Padrao_Valor,
-- Menor_Valor,
-- Maior_Valor,
-- Primeiro_Quartil_Valor,
-- Segundo_Quartil_Valor_Mediana,
-- Terceiro_Quartil_Valor

SELECT centro_custo, moeda,
	COUNT(valor) AS Quantidade_Lançamentos,
	ROUND(STDDEV_POP(valor), 2) AS Desvio_Padrao_Valor,
	ROUND(AVG(valor), 2) AS Media_Valor,
	MIN(valor) AS Menor_Valor,
	MAX(valor) AS Maior_Valor,
	ROUND(CAST(percentile_cont(0.25) WITHIN GROUP (ORDER BY valor) AS NUMERIC), 2) AS Primeiro_Quartil_Valor,
	ROUND(CAST(percentile_cont(0.5) WITHIN GROUP (ORDER BY valor) AS NUMERIC), 2) AS Segundo_Quartil_Valor_Mediana,
	ROUND(CAST(percentile_cont(0.75) WITHIN GROUP (ORDER BY valor) AS NUMERIC), 2) AS Terceiro_Quartil_Valor
FROM schema6.lancamentosdsacontabeis
GROUP BY centro_custo, moeda
ORDER BY centro_custo, moeda;