SELECT * FROM schema4.clientes;
SELECT * FROM schema4.pedidos;
SELECT * FROM schema4.produtos;

-- Maior valor --
SELECT MAX (valor_pedido) AS maximo
FROM schema4.pedidos;

-- Menor valor --
SELECT MIN (valor_pedido) AS maximo
FROM schema4.pedidos;

-- AVG --
SELECT ROUND(AVG(valor_pedido),2) AS media
FROM schema4.pedidos;

-- Média do valor dos pedidos por cidade
SELECT cidade_cliente, ROUND(AVG(valor_pedido), 2) AS media
FROM schema4.pedidos P, schema4.clientes C
WHERE P.id_cliente = C.id_cli
GROUP BY cidade_cliente;

-- Insere um novo registro na tabela de clientes
INSERT INTO schema4.clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente)
VALUES (1011, 'Agatha Christie', 'Ouro', 'Belo Horizonte', 'MG');

-- Média do valor dos pedidos por cidade (mostrar cidades sem pedidos)

--(EXIBINDO ZERO)--
SELECT cidade_cliente, COALESCE(ROUND(AVG(valor_pedido), 2),0.00) AS media
FROM schema4.pedidos P
RIGHT JOIN schema4.clientes C ON p.id_cliente = c.id_cli
GROUP BY cidade_cliente
ORDER BY media DESC;

--(EXIBINDO TEXTO)--
SELECT 
	cidade_cliente,
	CASE
		WHEN AVG(valor_pedido) IS NULL THEN 'Não houve pedido'
		ELSE CAST(ROUND(AVG(valor_pedido), 2)AS VARCHAR) 
	END AS media
FROM schema4.clientes C
LEFT JOIN schema4.pedidos P ON p.id_cliente = c.id_cli
GROUP BY cidade_cliente
ORDER BY media DESC;

SELECT 
	cidade_cliente,
	CASE
		WHEN AVG(valor_pedido) IS NULL THEN 'Não houve pedido'
		ELSE CAST(ROUND(AVG(valor_pedido), 2)AS VARCHAR) 
	END AS media
FROM schema4.clientes C
LEFT JOIN schema4.pedidos P ON p.id_cliente = c.id_cli
GROUP BY cidade_cliente
ORDER BY 
	CASE
		WHEN AVG(valor_pedido) IS NULL THEN 1
		ELSE 0
	END,
	media DESC;



