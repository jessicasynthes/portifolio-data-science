----------------------------------------------------------
SELECT *
FROM cap05.clientes
----------------------------------------------------------

-- 1. Quantos clientes estão registrados por estado?

SELECT estado,
	COUNT(estado) AS contagem_estado
FROM cap05.clientes
GROUP BY estado
ORDER BY estado;

-- 2. Qual é a idade média dos clientes?

SELECT
	ROUND(AVG(2024 - EXTRACT(YEAR from data_nascimento)))
FROM cap05.clientes;

-- 3. Quantos clientes têm mais de 30 anos?

SELECT 
	2024 - EXTRACT(YEAR from data_nascimento) AS Idade
FROM cap05.clientes
WHERE 2024 - EXTRACT(YEAR from data_nascimento) > 30;
---------------------------------------------------------
SELECT 
	COUNT(*) AS Mais_30
FROM cap05.clientes
WHERE 2024 - EXTRACT(YEAR from data_nascimento) > 30;

-- 4. Quais são as 3 cidades com maior número de clientes?

SELECT cidade,
	COUNT(cidade) AS contagem_cidade
FROM cap05.clientes
GROUP BY cidade
ORDER BY contagem_cidade
LIMIT 3;

-- 5. Quantos clientes têm um endereço de e-mail registrado?

SELECT
	COUNT(email) AS contagem_email
FROM cap05.clientes
WHERE email != '';

--------------------------------------------------------------------
SELECT *
FROM cap05.produtos;
--------------------------------------------------------------------

-- 6. Qual é o valor total de produtos em estoque por categoria?

SELECT categoria,
	SUM(preco * quantidade) AS valor_total
FROM cap05.produtos
GROUP BY categoria
ORDER BY categoria;

-- 7. Qual é a quantidade média de produtos em estoque por categoria?

SELECT categoria,
	ROUND(AVG(quantidade)) AS media_produtos
FROM cap05.produtos
GROUP BY categoria
ORDER BY categoria;

-- 8. Qual é o preço médio dos produtos por categoria?

SELECT categoria,
	ROUND(AVG(preco),2) AS preco_medio
FROM cap05.produtos
GROUP BY categoria
ORDER BY categoria;

-- 9. Qual é o número total de categorias de produtos?

SELECT
	COUNT(DISTINCT(categoria)) AS contagem_categorias
FROM cap05.produtos;

-- 10. Qual é a categoria com a maior quantidade de produtos em estoque?

SELECT categoria,
	SUM(quantidade) AS quantidade_categoria
FROM cap05.produtos
GROUP BY categoria
ORDER BY quantidade_categoria DESC
LIMIT 1;

-------------------------------------------------------------
SELECT *
FROM cap05.fornecedores
-------------------------------------------------------------

-- 11. Qual é a quantidade de fornecedores por estado?

SELECT estado,
	COUNT(nome) AS quantidade_fornecedores
FROM cap05.fornecedores
GROUP BY estado
ORDER BY estado;

-- 12. Qual é o estado com o maior número de fornecedores?

SELECT estado,
	COUNT(nome) AS quantidade_fornecedores
FROM cap05.fornecedores
GROUP BY estado
ORDER BY quantidade_fornecedores
LIMIT 1;

-- 13. Quantos fornecedores foram registrados no mês de Setembro de 2023?

SELECT
	COUNT(nome) AS quantidade_fornecedores
FROM cap05.fornecedores
WHERE EXTRACT(MONTH FROM data_registro) = 09;

-- 14. Qual é a média de registros de fornecedores por mês?

SELECT
	EXTRACT(MONTH FROM data_registro) AS mes_registro,
	COUNT(nome) AS quantidade_fornecedores
FROM cap05.fornecedores
GROUP BY EXTRACT(MONTH FROM data_registro);
----------------------------------------------------------
SELECT
	ROUND(AVG(quantidade_fornecedores))
FROM(
	SELECT
	EXTRACT(MONTH FROM data_registro) AS mes_registro,
	COUNT(nome) AS quantidade_fornecedores
	FROM cap05.fornecedores
	GROUP BY EXTRACT(MONTH FROM data_registro)
) AS fornecedores_mes;

-- 15. Qual é o fornecedor mais recente registrado?

SELECT nome,
	data_registro
FROM cap05.fornecedores
ORDER BY data_registro DESC
LIMIT 1;


---------------------------------------------------------------------
SELECT *
FROM cap05.vendas
---------------------------------------------------------------------


-- 16. Qual é o total de vendas por produto?

SELECT id_produto,
	SUM(valor) AS total_vendas
FROM cap05.vendas
GROUP BY id_produto
ORDER BY id_produto;

-- 17. Quantos produtos diferentes foram vendidos?

SELECT id_produto
FROM cap05.vendas
GROUP BY id_produto
ORDER BY id_produto;
-------------------------------------------------
SELECT
	COUNT(DISTINCT(id_produto)) AS contagem_produtos_diferentes
FROM cap05.vendas;

-- 18. Qual é o total de vendas por dia?

SELECT data_venda,
	SUM(valor) AS total_vendas
FROM cap05.vendas
GROUP BY data_venda
ORDER BY data_venda;

-- 19. Em quais dias o valor total de vendas foi superior a $100/50?

SELECT data_venda,
	SUM(valor) AS total_vendas
FROM cap05.vendas
GROUP BY data_venda
HAVING SUM(valor) > 100
ORDER BY total_vendas DESC;
--------------------------------------------------------------------
SELECT data_venda,
	SUM(valor) AS total_vendas
FROM cap05.vendas
GROUP BY data_venda
HAVING SUM(valor) > 50
ORDER BY total_vendas DESC;

-- 20. Quais produtos tiveram um valor total de vendas superior a $50?

SELECT id_produto,
	SUM(valor) AS total_vendas
FROM cap05.vendas
GROUP BY id_produto
HAVING SUM(valor) > 50
ORDER BY total_vendas DESC;