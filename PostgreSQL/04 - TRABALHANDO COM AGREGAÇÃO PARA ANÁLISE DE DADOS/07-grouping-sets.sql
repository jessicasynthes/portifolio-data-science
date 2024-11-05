SELECT * FROM schema4.vendas;

-- Faturamento total por ano e produto com total geral
SELECT
	CASE	
		WHEN ano IS NULL THEN 'Total Geral'
		ELSE CAST(ano AS VARCHAR)
	END AS ano,
	CASE	
		WHEN produto IS NULL THEN 'Todos os produtos'
		ELSE produto
	END AS produto,
	SUM(faturamento) AS faturamento_total
FROM schema4.vendas
GROUP BY ROLLUP(ano,produto)
ORDER BY GROUPING(produto), ano, faturamento_total;

----------------------
SELECT
	CASE	
		WHEN GROUPING(ano) = 1 THEN 'Total de todos os anos'
		ELSE CAST(ano AS VARCHAR)
	END AS ano,
	CASE	
		WHEN GROUPING(pais) = 1 THEN 'Total de todos os paises'
		ELSE pais
	END AS pais,
	CASE	
		WHEN GROUPING(produto) = 1 THEN 'Total de todos os produtos'
		ELSE produto
	END AS produto,
	SUM(faturamento) AS faturamento_total
FROM schema4.vendas
GROUP BY ROLLUP(ano, pais, produto)
ORDER BY GROUPING(ano, pais, produto), faturamento_total;