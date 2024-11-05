SELECT * FROM schema5.vendas;

-- Unidades vendidas por ano, mes, funcionario, unidades vendidas e total das unidades vendidas no ano;

SELECT
	ano,
	mes,
	funcionario,
	unidades_vendidas,
	SUM(unidades_vendidas) OVER (PARTITION BY ano) AS unidades_vendidas_ano
FROM schema5.vendas
ORDER BY ano, mes, funcionario;

-- WINDOW + SUM, AVG, MIN E MAX --

SELECT
	ano,
	mes,
	funcionario,
	unidades_vendidas,
	MAX(unidades_vendidas) OVER (PARTITION BY ano) AS max_unidades_vendidas_ano,
	MIN(unidades_vendidas) OVER (PARTITION BY ano) AS min_unidades_vendidas_ano,
	ROUND(AVG(unidades_vendidas) OVER (PARTITION BY ano), 2) AS media_unidades_vendidas_ano,
	SUM(unidades_vendidas) OVER (PARTITION BY ano) AS total_unidades_vendidas_ano
FROM schema5.vendas
ORDER BY ano, mes, funcionario;

-- Unidades vendidas por ano, mes, funcionario, total das unidades vendidas no ano e
-- proporcional de cada funcionário em relação ao ano

SELECT
	ano,
	mes,
	funcionario,
	unidades_vendidas,
	ROUND(unidades_vendidas / SUM(unidades_vendidas) OVER (PARTITION BY ano) * 100, 2) AS proporcional_func_ano
FROM schema5.vendas
ORDER BY ano, mes, funcionario;

