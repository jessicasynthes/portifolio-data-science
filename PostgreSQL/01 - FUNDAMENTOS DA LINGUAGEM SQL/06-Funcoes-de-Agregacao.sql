SELECT *
FROM schema1.vendas;

-- FUNÇÕES DE AGREGAÇÃO

-- Query SQL para retornar a média de valor_unitario_venda com duas casas decimais

SELECT ROUND(AVG(valor_unitario_venda), 2) AS media_valor_unitario
FROM schema1.vendas;

-- Query SQL para retornar a contagem, valor mínimo, valor máximo e soma (total)
-- de valor_unitario_venda
SELECT 
	COUNT(valor_unitario_venda) AS quantidade_de_vendas,
	MIN(valor_unitario_venda) AS valor_minimo_de_venda_unitaria,
	MAX(valor_unitario_venda) AS valor_maximo_de_venda_unitaria,
	SUM(valor_unitario_venda) AS soma_total_de_vendas
FROM schema1.vendas;

-- Query SQL para retornar a média (com duas casas decimais) de valor_unitario_venda
-- por categoria de produto

SELECT 
	categoria_produto, 
	ROUND(AVG(valor_unitario_venda), 2) AS media_valor_unitario 
FROM schema1.vendas
GROUP BY categoria_produto
ORDER BY media_valor_unitario DESC;

-- Query SQL para retornar a soma de valor_unitario_venda por produto

SELECT 
	nome_produto, 
	SUM(valor_unitario_venda) AS soma_valor_unitario 
FROM schema1.vendas
GROUP BY nome_produto
ORDER BY soma_valor_unitario DESC;

-- Query SQL para retornar a soma de valor_unitario_venda por produto e categoria

SELECT 
	nome_produto,
	categoria_produto,
	SUM(valor_unitario_venda) AS soma_valor_unitario 
FROM schema1.vendas
GROUP BY nome_produto, categoria_produto
ORDER BY nome_produto, categoria_produto;

-- Query SQL para retornar a média (com duas casas decimais) de valor_unitario_venda
-- por categoria de produto, somente se a média for maior ou igual a 16

SELECT 
	nome_produto, 
	ROUND(AVG(valor_unitario_venda), 2) AS media_valor_unitario
FROM schema1.vendas
GROUP BY nome_produto
HAVING AVG(valor_unitario_venda) >= 16
ORDER BY media_valor_unitario DESC;

-- Query SQL para retornar a média (com duas casas decimais) de valor_unitario_venda
-- por produto e categoria, somente se a média for maior ou igual a 16 e unidades vendidas
-- maior do que 4, ordenado por nome de produto

SELECT 
	nome_produto, 
	categoria_produto,
	ROUND(AVG(valor_unitario_venda), 2) AS media_valor_unitario
FROM schema1.vendas
WHERE unidades_vendidas > 4
GROUP BY nome_produto, categoria_produto
HAVING AVG(valor_unitario_venda) >= 16 
ORDER BY nome_produto;

-- Query SQL para retornar a média (com duas casas decimais) de valor_unitario_venda
-- por produto e categoria, somente se a média for maior ou igual a 16 e o produto for B ou C,
-- ordenado por categoria

SELECT 
	nome_produto, 
	categoria_produto,
	ROUND(AVG(valor_unitario_venda), 2) AS media_valor_unitario
FROM schema1.vendas
WHERE nome_produto = 'Produto B' OR nome_produto = 'Produto C'
GROUP BY nome_produto, categoria_produto
HAVING AVG(valor_unitario_venda) >= 16 
ORDER BY categoria_produto;