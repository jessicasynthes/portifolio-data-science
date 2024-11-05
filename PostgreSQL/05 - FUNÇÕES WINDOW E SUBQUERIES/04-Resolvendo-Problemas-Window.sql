SELECT * FROM schema5.vendas;

-- Unidades vendidas por ano para cada funcionário, total de unidades vendidas em cada ano e
-- proporcional de cada funcionário em relação ao total do ano;

-- Opção 1 - Função Window --

SELECT
	ano,
	funcionario,
	unidades_vendidas,
	ROUND(unidades_vendidas / SUM (unidades_vendidas) OVER (PARTITION BY ano) * 100, 2) AS proporcional_func_ano
FROM schema5.vendas
ORDER BY ano, funcionario;

-- Opção 2 - Função Window + GROUP BY --

SELECT
	ano,
	funcionario,
	unidades_vendidas,
	SUM(unidades_vendidas) OVER (PARTITION BY ano) AS unidades_vendidas_func,
	ROUND(unidades_vendidas / SUM (unidades_vendidas) OVER (PARTITION BY ano) * 100, 2) AS proporcional_func_ano
FROM schema5.vendas
GROUP BY ano, funcionario, unidades_vendidas
ORDER BY ano, funcionario;

-- Opção 3 - CTE e Views Temporárias
WITH vendas_agregadas AS (
	SELECT ano, funcionario, SUM(unidades_vendidas) AS total_unidades_vendidas
	FROM schema5.vendas
	GROUP BY ano, funcionario
),
total_ano AS (
	SELECT ano, SUM(total_unidades_vendidas) AS total_unidades_ano
	FROM vendas_agregadas
	GROUP BY ano
)
SELECT
	v.ano,
	v.funcionario,
	v.total_unidades_vendidas,
	t.total_unidades_ano,
	ROUND(v.total_unidades_vendidas/t.total_unidades_ano * 100, 2) AS proporcional_func_ano
FROM vendas_agregadas v
JOIN total_ano t ON v.ano = t.ano
ORDER BY v.ano, v.funcionario;

-- Opção 4 - A melhor performance

SELECT
	ano,
	funcionario,
	SUM(unidades_vendidas) AS total_unidades_vendidas,
	SUM(SUM(unidades_vendidas)) OVER (PARTITION BY ano) AS total_unidades_ano,
	ROUND((SUM(unidades_vendidas) / SUM(SUM(unidades_vendidas)) OVER (PARTITION BY ano)) * 100, 2) AS proporcional_func_ano
FROM schema5.vendas
GROUP BY ano, funcionario
ORDER BY ano, funcionario;

