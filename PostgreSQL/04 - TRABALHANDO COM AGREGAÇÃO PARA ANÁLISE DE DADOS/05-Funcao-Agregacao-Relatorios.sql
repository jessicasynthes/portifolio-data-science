SELECT * FROM schema4.clientes;
SELECT * FROM schema4.pedidos;
SELECT * FROM schema4.produtos;

-- Altera a tabela de produtos e acrescenta uma coluna
ALTER TABLE IF EXISTS schema4.produtos
ADD COLUMN custo DECIMAL (10,2) NULL;

-- Atualiza a coluna
UPDATE schema4.produtos
SET custo = 43 + (id_prod -1) * 5.1
WHERE id_prod BETWEEN 10101 AND 10108;

-- Custo total schema4dos pedidos por estado

SELECT estado_cliente, SUM(custo) AS custo_total
FROM schema4.pedidos 
JOIN schema4.produtos ON id_produto = id_prod
JOIN schema4.clientes ON id_cliente = id_cli
GROUP BY estado_cliente
ORDER BY 2 DESC;

-- + 10% no custo dos pedidos de SP
SELECT 
	estado_cliente, 
	CASE
		WHEN estado_cliente = 'SP' THEN ROUND(SUM(custo + (custo * 0.10)),2)
		ELSE SUM(custo)
	END AS total_custo
FROM schema4.pedidos 
JOIN schema4.produtos ON id_produto = id_prod
JOIN schema4.clientes ON id_cliente = id_cli
GROUP BY estado_cliente
ORDER BY 2 DESC;

-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Apache' no nome

SELECT estado_cliente, nome_produto, SUM(custo) AS custo_total
FROM schema4.pedidos 
JOIN schema4.produtos ON id_produto = id_prod
JOIN schema4.clientes ON id_cliente = id_cli
GROUP BY estado_cliente, nome_produto
ORDER BY 2 DESC;


SELECT estado_cliente, nome_produto, SUM(custo) AS custo_total
FROM schema4.pedidos 
JOIN schema4.produtos ON id_produto = id_prod
JOIN schema4.clientes ON id_cliente = id_cli
WHERE nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Apache%'
GROUP BY estado_cliente, nome_produto
ORDER BY 3 DESC;

SELECT estado_cliente, SUM(custo) AS custo_total
FROM schema4.pedidos 
JOIN schema4.produtos ON id_produto = id_prod
JOIN schema4.clientes ON id_cliente = id_cli
WHERE nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Apache%'
GROUP BY estado_cliente
ORDER BY 2 DESC;

-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Apache' no nome
-- Pedidos com o custo total menor do que 120000
-- + 10% no custo dos pedidos de SP

SELECT 
	estado_cliente, 
	CASE
		WHEN estado_cliente = 'SP' THEN ROUND(SUM(custo + (custo * 0.10)),2)
		ELSE SUM(custo)
	END AS total_custo
FROM schema4.pedidos 
JOIN schema4.produtos ON id_produto = id_prod
JOIN schema4.clientes ON id_cliente = id_cli
WHERE nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Apache%'
GROUP BY estado_cliente
HAVING SUM(custo) < 120000
ORDER BY 2 DESC;

-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Apache' no nome
-- Pedidos com o custo total entre 150000 e 250000
-- + 10% no custo dos pedidos de SP

SELECT 
	estado_cliente, 
	CASE
		WHEN estado_cliente = 'SP' THEN ROUND(SUM(custo + (custo * 0.10)),2)
		ELSE SUM(custo)
	END AS total_custo
FROM schema4.pedidos 
JOIN schema4.produtos ON id_produto = id_prod
JOIN schema4.clientes ON id_cliente = id_cli
WHERE nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Apache%'
GROUP BY estado_cliente
HAVING SUM(custo) BETWEEN 150000 AND 250000
ORDER BY 2 DESC;

-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Apache' no nome
-- Pedidos com o custo total entre 150000 e 250000
-- + 10% no custo dos pedidos de SP
-- 'Com aumento de custo' SE estado = SP, SENÃO 'Sem aumento de custo'

SELECT 
	estado_cliente, 
	CASE
		WHEN estado_cliente = 'SP' THEN ROUND(SUM(custo + (custo * 0.10)),2)
		ELSE SUM(custo)
	END AS total_custo,
	CASE
		WHEN estado_cliente = 'SP' THEN 'Com aumento de custo'
		ELSE 'Sem aumento de custo'
	END AS status_aumento
FROM schema4.pedidos 
JOIN schema4.produtos ON id_produto = id_prod
JOIN schema4.clientes ON id_cliente = id_cli
WHERE nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Apache%'
GROUP BY estado_cliente
HAVING SUM(custo) BETWEEN 150000 AND 250000
ORDER BY 2 DESC;

