-- INNER JOIN --

-- Retorne id, nome e estado do cliente, id e quantidade do pedidos de todos os clientes
-- Ordene pelo id do cliente

SELECT * FROM schema3.clientes;
SELECT * FROM schema3.pedidos;

SELECT c.id_cliente, c.nome, c.estado, p.id_pedido, p.quantidade
FROM schema3.pedidos p
INNER JOIN schema3.clientes c ON p.id_cliente = c.id_cliente
ORDER BY c.id_cliente;

-- Usamos INNER JOIN porque queremos relacionar por registros presentes em ambas as tabelas;

-- LEFT OUTER JOIN --

-- Retorne id, nome e estado do cliente, id e quantidade do pedidos de todos os clientes,
-- Independente de ter feito ou não pedido
-- Ordene pelo id do cliente

SELECT c.id_cliente, c.nome, c.estado, p.id_pedido, p.quantidade
FROM schema3.clientes c
LEFT JOIN schema3.pedidos p ON c.id_cliente = p.id_cliente
ORDER BY c.id_cliente;

-- Tratando valores nulos
SELECT 
	c.id_cliente, 
	c.nome, 
	c.estado,
	CASE
		WHEN p.quantidade IS NULL THEN '0'
		ELSE CAST(p.quantidade AS VARCHAR)
	END AS quantidade,
	CASE
		WHEN p.id_pedido IS NULL THEN '0'
		ELSE CAST(p.id_pedido AS VARCHAR)
	END AS id_pedido
FROM schema3.clientes c
LEFT JOIN schema3.pedidos p ON c.id_cliente = p.id_cliente
ORDER BY c.id_cliente;
