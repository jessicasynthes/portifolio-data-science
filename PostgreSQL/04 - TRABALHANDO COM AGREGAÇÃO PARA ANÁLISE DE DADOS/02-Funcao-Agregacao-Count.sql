SELECT * FROM schema4.clientes;
SELECT * FROM schema4.pedidos;
SELECT * FROM schema4.produtos;

-- COUNT --
SELECT COUNT (*)
FROM schema4.clientes;

SELECT COUNT (*)
FROM schema4.pedidos;

SELECT COUNT (*)
FROM schema4.produtos;

-- Contagem utilizando chave primária --

SELECT COUNT (id_cli)
FROM schema4.clientes;

-- COUNT com cláusula GROUP BY --
SELECT cidade_cliente,
COUNT (id_cli)
FROM schema4.clientes
GROUP BY cidade_cliente;

-- ordenado pela própria contagem --
SELECT cidade_cliente,
COUNT (id_cli)
FROM schema4.clientes
GROUP BY cidade_cliente
ORDER BY COUNT (id_cli) DESC;

-- ordenado pelo número da contagem do select --
SELECT cidade_cliente,
COUNT (id_cli)
FROM schema4.clientes
GROUP BY cidade_cliente
ORDER BY 2 DESC;

-- ordenado por alias (apelido) -- 
SELECT cidade_cliente,
COUNT (id_cli) AS contagem
FROM schema4.clientes
GROUP BY cidade_cliente
ORDER BY contagem DESC;

-- Número de clientes que fizeram pedidos --

SELECT id_cliente, 
COUNT(id_cliente)
FROM schema4.pedidos
GROUP BY id_cliente;

SELECT COUNT(DISTINCT id_cliente)
FROM schema4.pedidos;

-- Número de cidades de clientes cadastrados --
SELECT cidade_cliente,
COUNT(cidade_cliente)
FROM schema4.clientes
GROUP BY cidade_cliente;

SELECT COUNT(DISTINCT cidade_cliente)
FROM schema4.clientes;

-- Contagem de pedidos de clientes do estado do RJ ou SP

--(errada)--
SELECT estado_cliente, COUNT(*) AS total_pedidos
FROM schema4.pedidos AS P, schema4.clientes AS C
WHERE P.id_cliente = C.id_cli
AND estado_cliente = 'RJ' OR  estado_cliente = 'SP'
GROUP BY estado_cliente;

--(certa)--
SELECT estado_cliente, COUNT(*) AS total_pedidos
FROM schema4.pedidos AS P, schema4.clientes AS C
WHERE P.id_cliente = C.id_cli
AND (estado_cliente = 'RJ' OR  estado_cliente = 'SP')
GROUP BY estado_cliente;

--(simplificando a lógica)--
SELECT C.estado_cliente, COUNT(P.id_pedido) AS total_pedidos
FROM schema4.clientes C
INNER JOIN schema4.pedidos P ON C.id_cli = P.id_cliente
WHERE C.estado_cliente IN ('RJ','SP')
GROUP BY C.estado_cliente;






