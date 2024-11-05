-- JUNÇÃO DE MULTIPLAS TABELAS --
-- A cláusula ON especifica a condição de junção entre duas tabelas

SELECT p.id_pedido, c.nome AS nome_cliente, pr.nome AS nome_produto, p.quantidade, p.data_pedido
FROM schema3.pedidos p
JOIN schema3.clientes c ON c.id_cliente = p.id_cliente
JOIN schema3.produtos pr ON p.id_produto = pr.id_produto
ORDER BY c.nome;

-- A integridade referencial é ainda mais importante na junção de múltiplas tabelas
SELECT c.nome AS nome_cliente, pr.nome AS nome_produto, ps.quantidade
FROM schema3.pedidos_sem_ir ps
LEFT JOIN schema3.clientes c ON ps.id_cliente = c.id_cliente
LEFT JOIN schema3.produtos pr ON ps.id_produto = pr.id_produto
ORDER BY nome_produto;

-- Aplicando filtro
SELECT c.nome AS nome_cliente, pr.nome AS nome_produto, ps.quantidade
FROM schema3.pedidos ps
LEFT JOIN schema3.clientes c ON ps.id_cliente = c.id_cliente
LEFT JOIN schema3.produtos pr ON ps.id_produto = pr.id_produto
WHERE pr.nome IN('Produto D', 'Produto H')
ORDER BY nome_produto;

-- Podemos usar agregações na junção de múltiplas tabelas
SELECT pr.nome AS nome_produto, ROUND(AVG(ps.quantidade), 2) AS media_quantidade
FROM schema3.pedidos ps
LEFT JOIN schema3.clientes c ON ps.id_cliente = c.id_cliente
LEFT JOIN schema3.produtos pr ON ps.id_produto = pr.id_produto
WHERE pr.nome IN('Produto D', 'Produto H')
GROUP BY nome_produto
ORDER BY nome_produto;

-- A cláusula ON especifica a condição de junção entre duas tabelas
SELECT p.id_pedido, c.nome AS nome_cliente, pr.nome AS nome_produto, p.quantidade, p.data_pedido
FROM schema3.pedidos p
JOIN schema3.clientes c ON c.id_cliente = p.id_cliente
JOIN schema3.produtos pr ON p.id_produto = pr.id_produto;

-- Simplificando usando a clausula USING
SELECT p.id_pedido, c.nome AS nome_cliente, pr.nome AS nome_produto, p.quantidade, p.data_pedido
FROM schema3.pedidos p
JOIN schema3.clientes c USING (id_cliente)
JOIN schema3.produtos pr USING (id_produto);

-- Subqueries com junções
WITH ProdutosMaisVendidos AS (
	SELECT id_produto, SUM(quantidade) AS total_quantidade
	FROM schema3.pedidos
	GROUP BY id_produto
	ORDER BY total_quantidade DESC
	LIMIT 5
)
SELECT prod.id_produto, prod.nome AS produto, prod.categoria, cli.nome AS nome_cliente, cli.sobrenome, p.quantidade
FROM ProdutosMaisVendidos pmv
JOIN schema3.pedidos p USING (id_produto) 
JOIN schema3.produtos prod USING (id_produto)
JOIN schema3.clientes cli USING (id_cliente)
WHERE p.quantidade = (SELECT MAX(quantidade) FROM schema3.pedidos WHERE id_produto = pmv.id_produto);
