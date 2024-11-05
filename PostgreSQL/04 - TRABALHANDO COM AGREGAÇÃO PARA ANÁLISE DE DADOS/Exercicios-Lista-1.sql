-- Criação da tabela 
CREATE TABLE schema4.vendas (
    ID INT PRIMARY KEY,
    DataVenda DATE,
    Produto VARCHAR(50),
    Quantidade INT,
    ValorUnitario DECIMAL(10, 2),
    Vendedor VARCHAR(50)
);


-- Insert
INSERT INTO schema4.vendas (ID, DataVenda, Produto, Quantidade, ValorUnitario, Vendedor) VALUES
(1, '2023-11-01', 'Produto A', 10, 100.00, 'Zico'),
(2, '2023-11-01', 'Produto B', 5, 200.00, 'Romário'),
(3, '2023-11-02', 'Produto A', 7, 100.00, 'Ronaldo'),
(4, '2023-11-02', 'Produto C', 3, 150.00, 'Bebeto'),
(5, '2023-11-03', 'Produto B', 8, 200.00, 'Romário'),
(6, '2023-11-03', 'Produto A', 5, 100.00, 'Zico'),
(7, '2023-11-04', 'Produto C', 10, 150.00, 'Bebeto'),
(8, '2023-11-04', 'Produto A', 2, 100.00, 'Ronaldo'),
(9, '2023-11-05', 'Produto B', 6, 200.00, 'Romário'),
(10, '2023-11-05', 'Produto C', 4, 150.00, 'Bebeto');

-----------------------------------------------------------
SELECT * FROM schema4.vendas;
-----------------------------------------------------------

-- 1. Qual o total de vendas por produto?

SELECT produto, SUM(quantidade * valorunitario) AS total_vendas
FROM schema4.vendas
GROUP BY produto
ORDER BY total_vendas DESC;

-- 2. Qual o total de vendas por vendedor?
SELECT vendedor, SUM(quantidade * valorunitario) AS total_vendas
FROM schema4.vendas
GROUP BY vendedor
ORDER BY total_vendas DESC;

-- 3. Qual o total de vendas por dia?
SELECT datavenda, SUM(quantidade * valorunitario) AS total_vendas
FROM schema4.vendas
GROUP BY datavenda
ORDER BY total_vendas DESC;

-- 4. Como as vendas se acumulam por dia e por produto (incluindo subtotais diários)?
SELECT
	CASE
		WHEN GROUPING(datavenda) = 1 THEN 'Total por data'
		ELSE CAST(datavenda AS VARCHAR)
	END AS datavenda, 
	CASE
		WHEN GROUPING(produto) = 1 THEN 'Total em vendas de produtos'
		ELSE produto
	END AS produto, 
	SUM(quantidade * valorunitario) AS total_vendas
FROM schema4.vendas
GROUP BY ROLLUP(datavenda, produto)
ORDER BY GROUPING(datavenda, produto), total_vendas DESC;

-- OU --

SELECT
	datavenda,
	STRING_AGG(produto, ', ') AS produtos_vendidos,
	SUM(quantidade * valorunitario) AS total_vendas
FROM schema4.vendas
GROUP BY datavenda
ORDER BY datavenda;

-- 5. Qual a combinação de vendedor e produto gerou mais vendas (incluindo todos os subtotais possíveis)?
SELECT
	CASE
		WHEN GROUPING(vendedor) = 1 THEN 'Total em vendas por vendedores'
		ELSE vendedor
	END AS datavenda, 
	CASE
		WHEN GROUPING(produto) = 1 THEN 'Total em vendas de produtos'
		ELSE produto
	END AS produto, 
	SUM(quantidade * valorunitario) AS total_vendas
FROM schema4.vendas
GROUP BY CUBE (vendedor, produto)
ORDER BY GROUPING(vendedor, produto), total_vendas DESC;

-- 6. Imagine que você queira analisar as vendas totais por Produto, por Vendedor e também o total geral de todas as vendas. 
-- Como seria a Query SQL?

SELECT
	CASE
		WHEN GROUPING(vendedor) = 1 THEN 'Total em vendas por vendedores'
		ELSE vendedor
	END AS datavenda, 
	CASE
		WHEN GROUPING(produto) = 1 THEN 'Total em vendas de produtos'
		ELSE produto
	END AS produto, 
	SUM(quantidade * valorunitario) AS total_vendas
FROM schema4.vendas
GROUP BY ROLLUP(produto, vendedor)
ORDER BY GROUPING(produto, vendedor), total_vendas DESC;

-- OU --

SELECT
	COALESCE(produto, 'Todos') AS produto,
	COALESCE(vendedor, 'Todos') AS vendedor,
	SUM(quantidade * valorunitario) AS total_vendas
FROM schema4.vendas
GROUP BY GROUPING SETS (
	(produto),
	(vendedor),
	()
);