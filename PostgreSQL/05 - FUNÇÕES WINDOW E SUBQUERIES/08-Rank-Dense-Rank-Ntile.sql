SELECT * FROM schema5.vendas2;

-- Criar um ranking das unidades vendidas, do maior para o menor, por ano.
-- Por exemplo: Qual funcionário conduziu a transação com maior número de unidades vendidas em cada ano?

-- Criar um ranking das unidades vendidas, do maior para o menor, por ano --
SELECT
		ano,
		funcionario,
		unidades_vendidas,
		RANK() OVER (PARTITION BY ano ORDER BY unidades_vendidas DESC) AS ranking_vendas
FROM schema5.vendas2

-- Por exemplo: Qual funcionário conduziu a transação com maior número de unidades vendidas em cada ano? --
SELECT *
FROM (
	SELECT
		ano,
		funcionario,
		unidades_vendidas,
		RANK() OVER (PARTITION BY ano ORDER BY unidades_vendidas DESC) AS ranking_vendas
FROM schema5.vendas2) AS subquery
WHERE ranking_vendas = 1;

-- Por exemplo: Qual funcionário conduziu a transação com menor número de unidades vendidas em cada ano? --

SELECT *
FROM (
	SELECT
		ano,
		funcionario,
		unidades_vendidas,
		RANK() OVER (PARTITION BY ano ORDER BY unidades_vendidas ASC) AS ranking_vendas
FROM schema5.vendas2) AS subquery
WHERE ranking_vendas = 1;

-- DENSE_RANK() --

SELECT
		ano,
		funcionario,
		unidades_vendidas,
		DENSE_RANK() OVER (PARTITION BY ano ORDER BY unidades_vendidas DESC) AS ranking_vendas
FROM schema5.vendas2

-- NTILE --

SELECT
		ano,
		funcionario,
		unidades_vendidas,
		NTILE(3) OVER (PARTITION BY ano ORDER BY unidades_vendidas DESC) AS ranking_vendas
FROM schema5.vendas2
