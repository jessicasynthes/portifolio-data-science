SELECT * FROM schema4.clientes;
SELECT * FROM schema4.pedidos;
SELECT * FROM schema4.produtos;

-- Soma do total de pedidos --
SELECT SUM(valor_pedido)
FROM schema4.pedidos;

-- Soma (total) do valor dos pedidos por cidade --

SELECT cidade_cliente, SUM(valor_pedido)
FROM schema4.pedidos, schema4.clientes
WHERE id_cliente = id_cli
GROUP BY cidade_cliente
ORDER BY 2 DESC;

-- Soma (total) do valor dos pedidos por estado e cidade (com cláusula WHERE) --

SELECT  estado_cliente, cidade_cliente, SUM(valor_pedido)
FROM schema4.pedidos, schema4.clientes
WHERE id_cliente = id_cli
GROUP BY estado_cliente, cidade_cliente
ORDER BY 3 DESC;

-- Soma (total) do valor dos pedidos por estado e cidade (com cláusula JOIN) -- 
SELECT  estado_cliente, cidade_cliente, SUM(valor_pedido) AS total
FROM schema4.pedidos 
JOIN schema4.clientes ON id_cliente = id_cli
GROUP BY estado_cliente, cidade_cliente
ORDER BY total DESC;

-- Soma (total) do valor dos pedidos por estado e cidade. Retornar cidades sem pedidos. --
SELECT  estado_cliente, cidade_cliente, COALESCE(SUM(valor_pedido), 0.00) AS total
FROM schema4.pedidos 
RIGHT JOIN schema4.clientes ON id_cliente = id_cli
GROUP BY estado_cliente, cidade_cliente
ORDER BY total DESC;

