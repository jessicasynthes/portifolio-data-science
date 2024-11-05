-- FULL JOIN --
-- Retorna todos os registros havendo ou não correspondência entre as tabelas

SELECT *
FROM schema3.produtos pd
FULL JOIN  schema3.pedidos p ON pd.id_produto = p.id_produto;

SELECT *
FROM schema3.produtos pd
FULL OUTER JOIN  schema3.pedidos p ON pd.id_produto = p.id_produto;

-- CROSS JOIN --
-- Produto cartesiano, ou seja, retorna todas as combinações possíveis entre
-- as tabelas

SELECT *
FROM schema3.produtos pd
CROSS JOIN schema3.pedidos p;

-- SELF JOIN --
-- Queremos listar os pares de pedido feitos pelo mesmo cliente
-- Ou seja, queremos todas as combinações de 2 pedidos diferentes para cada cliente

SELECT p1.id_pedido AS Pedido1_ID, p2.id_pedido AS Pedido2_ID, p1.id_cliente
FROM schema3.pedidos p1
JOIN schema3.pedidos p2
ON p1.id_cliente = p2.id_cliente AND p1.id_pedido < p2.id_pedido;

SELECT p1.id_pedido AS Pedido1_ID, p2.id_pedido AS Pedido2_ID, p3.id_pedido AS Pedido3_ID, p1.id_cliente
FROM schema3.pedidos p1
JOIN schema3.pedidos p2
ON p1.id_cliente = p2.id_cliente AND p1.id_pedido < p2.id_pedido
JOIN schema3.pedidos p3
ON p2.id_cliente = p3.id_cliente AND p2.id_pedido < p3.id_pedido;


