SELECT * FROM schema8.clientes;
SELECT * FROM schema8.produtos;
SELECT * FROM schema8.vendas;

-- 1. Qual o Número Total de Vendas e Média de Quantidade Vendida?

SELECT
	COUNT(id_vendas) AS Total_Vendas,
	ROUND(AVG(quantidade),2) AS Media_Produtos_Vendidos
FROM schema8.vendas;

-- 2. Qual o Número Total de Produtos Únicos Vendidos?

SELECT
	COUNT(DISTINCT(id_produto)) AS Produtos_Unicos_Vendidos
FROM schema8.vendas;

-- 3. Quantas Vendas Ocorreram Por Produto? Mostre o Resultado em Ordem Decrescente.

SELECT
	p.nome,
	COUNT(v.id_produto) AS Produtos_Vendidos
FROM schema8.vendas v
JOIN schema8.produtos p USING (id_produto)
GROUP BY p.nome
ORDER BY Produtos_Vendidos DESC;

-- 4. Quais os 5 Produtos com Maior Número de Vendas?

SELECT
	p.nome,
	COUNT(v.id_produto) AS Produtos_Vendidos
FROM schema8.vendas v
JOIN schema8.produtos p USING (id_produto)
GROUP BY p.nome
ORDER BY Produtos_Vendidos DESC
LIMIT 5;

-- 5. Quais Clientes Fizeram 6 ou Mais Transações de Compra?

SELECT
	c.nome,
	COUNT(v.id_cliente) AS transacoes
FROM schema8.vendas v
JOIN schema8.clientes c USING (id_cliente)
GROUP BY c.nome
HAVING COUNT(v.id_cliente) >= 6
ORDER BY transacoes DESC;

-- 6. Qual o Total de Transações Comerciais Por Mês no Ano de 2024? 
-- Apresente os Nomes dos Meses no Resultado, Que Deve Ser Ordenado Por Mês.

WITH meses_extenso AS(
	SELECT
	data_venda,
	CASE
	WHEN EXTRACT(MONTH FROM data_venda) = 1 THEN 'Janeiro'
	WHEN EXTRACT(MONTH FROM data_venda) = 2 THEN 'Fevereiro'
	WHEN EXTRACT(MONTH FROM data_venda) = 3 THEN 'Março'
	WHEN EXTRACT(MONTH FROM data_venda) = 4 THEN 'Abril'
	WHEN EXTRACT(MONTH FROM data_venda) = 5 THEN 'Maio'
	WHEN EXTRACT(MONTH FROM data_venda) = 6 THEN 'Junho'
	WHEN EXTRACT(MONTH FROM data_venda) = 7 THEN 'Julho'
	WHEN EXTRACT(MONTH FROM data_venda) = 8 THEN 'Agosto'
	WHEN EXTRACT(MONTH FROM data_venda) = 9 THEN 'Setembro'
	WHEN EXTRACT(MONTH FROM data_venda) = 10 THEN 'Outubro'
	WHEN EXTRACT(MONTH FROM data_venda) = 11 THEN 'Novembro'
	WHEN EXTRACT(MONTH FROM data_venda) = 12 THEN 'Dezembro'
	ELSE 'Mês inválido'
	END AS mes_extenso,
	EXTRACT(YEAR FROM data_venda) AS ano,
	EXTRACT(MONTH FROM data_venda) AS mes
	FROM schema8.vendas
)
SELECT
	Mes_Extenso,
	COUNT(data_venda)
FROM meses_extenso
WHERE ano = 2024
GROUP BY mes_extenso, mes
ORDER BY mes;

-- 7. Quantas Vendas de Notebooks Ocorreram em Junho e Julho de 2023?

SELECT
	p.nome,
	COUNT(v.id_produto) AS Produtos_Vendidos
FROM schema8.vendas v
JOIN schema8.produtos p USING (id_produto)
WHERE p.nome = 'Notebook' AND
v.data_venda >='2023-06-01' AND
v.data_venda <='2023-07-31'
GROUP BY p.nome
ORDER BY Produtos_Vendidos DESC;

-- 8. Qual o Total de Vendas Por Mês e Por Ano ao Longo do Tempo?

WITH meses_extenso AS(
	SELECT
	data_venda,
	quantidade,
	CASE
	WHEN EXTRACT(MONTH FROM data_venda) = 1 THEN 'Janeiro'
	WHEN EXTRACT(MONTH FROM data_venda) = 2 THEN 'Fevereiro'
	WHEN EXTRACT(MONTH FROM data_venda) = 3 THEN 'Março'
	WHEN EXTRACT(MONTH FROM data_venda) = 4 THEN 'Abril'
	WHEN EXTRACT(MONTH FROM data_venda) = 5 THEN 'Maio'
	WHEN EXTRACT(MONTH FROM data_venda) = 6 THEN 'Junho'
	WHEN EXTRACT(MONTH FROM data_venda) = 7 THEN 'Julho'
	WHEN EXTRACT(MONTH FROM data_venda) = 8 THEN 'Agosto'
	WHEN EXTRACT(MONTH FROM data_venda) = 9 THEN 'Setembro'
	WHEN EXTRACT(MONTH FROM data_venda) = 10 THEN 'Outubro'
	WHEN EXTRACT(MONTH FROM data_venda) = 11 THEN 'Novembro'
	WHEN EXTRACT(MONTH FROM data_venda) = 12 THEN 'Dezembro'
	ELSE 'Mês inválido'
	END AS mes_extenso,
	EXTRACT(YEAR FROM data_venda) AS ano,
	EXTRACT(MONTH FROM data_venda) AS mes
	FROM schema8.vendas
)
SELECT
	mes_extenso,
	ano,
	SUM(quantidade)
FROM meses_extenso
GROUP BY mes_extenso, mes, ano
ORDER BY ano, mes;

-- 9. Quais Produtos Tiveram Menos de 100 Transações de Venda?

SELECT
	p.nome,
	COUNT(v.id_produto) AS Produtos_Vendidos
FROM schema8.vendas v
JOIN schema8.produtos p USING (id_produto)
GROUP BY p.nome
HAVING COUNT(v.id_produto) <= 100
ORDER BY Produtos_Vendidos DESC;

-- 10. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch?

WITH validacao AS (
SELECT 
	c.nome AS Nome,
	CASE
		WHEN p.nome = 'Smartphone' THEN 'Sim'
		ELSE 'Não'
	END AS Smartphone,
	CASE
		WHEN p.nome = 'Smartwatch' THEN 'Sim'
		ELSE 'Não'
	END AS Smartwatch
FROM schema8.vendas v
JOIN schema8.produtos p USING (id_produto)
JOIN schema8.clientes c USING (id_cliente)
GROUP BY c.nome, p.nome
ORDER BY c.nome
)
SELECT
  Nome
FROM validacao
WHERE (Smartphone = 'Sim' OR Smartwatch = 'Sim')
GROUP BY Nome
HAVING COUNT(Nome) = 2
ORDER BY Nome;

-- 11. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch, Mas Não Compraram Notebook?

-- Clientes que compraram Smartphone
WITH clientes_smartphone AS (
    SELECT Id_Cliente
    FROM schema8.vendas
    JOIN schema8.produtos ON vendas.Id_Produto = produtos.Id_Produto
    WHERE produtos.nome = 'Smartphone'
),
-- Clientes que compraram Smartwatch
clientes_smartwatch AS (
    SELECT Id_Cliente
    FROM schema8.vendas
    JOIN schema8.produtos ON vendas.Id_Produto = produtos.Id_Produto
    WHERE produtos.nome = 'Smartwatch'
),
-- Clientes que compraram Notebook
clientes_notebook AS (
    SELECT Id_Cliente
    FROM schema8.vendas
    JOIN schema8.produtos ON vendas.Id_Produto = produtos.Id_Produto
    WHERE produtos.nome = 'Notebook'
)
-- Clientes que compraram Smartphone e Smartwatch, mas não compraram Notebook
SELECT clientes.nome
FROM schema8.clientes
WHERE Id_Cliente IN (
    SELECT Id_Cliente FROM clientes_smartphone
    INTERSECT
    SELECT Id_Cliente FROM clientes_smartwatch
)
AND Id_Cliente NOT IN (
    SELECT Id_Cliente FROM clientes_notebook
);

-- 12. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch, Mas Não Compraram Notebook em Maio/2024?

-- Clientes que compraram Smartphone em Maio/2024
WITH clientes_smartphone AS (
    SELECT Id_Cliente
    FROM schema8.vendas
    JOIN schema8.produtos ON vendas.Id_Produto = produtos.Id_Produto
    WHERE produtos.nome = 'Smartphone'
      AND DATE_PART('year', vendas.Data_Venda) = 2024
      AND DATE_PART('month', vendas.Data_Venda) = 5
),
-- Clientes que compraram Smartwatch em Maio/2024
clientes_smartwatch AS (
    SELECT Id_Cliente
    FROM schema8.vendas
    JOIN schema8.produtos ON vendas.Id_Produto = produtos.Id_Produto
    WHERE produtos.nome = 'Smartwatch'
      AND DATE_PART('year', vendas.Data_Venda) = 2024
      AND DATE_PART('month', vendas.Data_Venda) = 5
),
-- Clientes que compraram Notebook em Maio/2024
clientes_notebook AS (
    SELECT Id_Cliente
    FROM schema8.vendas
    JOIN schema8.produtos ON vendas.Id_Produto = produtos.Id_Produto
    WHERE produtos.nome = 'Notebook'
      AND DATE_PART('year', vendas.Data_Venda) = 2024
      AND DATE_PART('month', vendas.Data_Venda) = 5
)
-- Clientes que compraram Smartphone e Smartwatch, mas não Notebook em Maio/2024
SELECT schema8.clientes.nome
FROM schema8.clientes
WHERE Id_Cliente IN (
    SELECT Id_Cliente FROM clientes_smartphone
    INTERSECT
    SELECT Id_Cliente FROM clientes_smartwatch
)
AND Id_Cliente NOT IN (
    SELECT Id_Cliente FROM clientes_notebook
);

-- 13.  Qual  a  Média  Móvel  de  Quantidade  de  Unidades  Vendidas  ao  Longo  do  Tempo? 
-- Considere Janela de 7 Dias.

SELECT
	data_venda,
	quantidade,
	ROUND(AVG(quantidade) OVER (ORDER BY data_venda ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING),2) AS media_movel
FROM schema8.vendas;

-- 14. Qual a Média Móvel e Desvio Padrão Móvel de Quantidade de Unidades Vendidas ao Longo do Tempo?
-- Considere Janela de 7 Dias.

SELECT
	data_venda,
	quantidade,
	ROUND(AVG(quantidade) OVER (ORDER BY data_venda ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING),2) AS media_movel,
	ROUND(STDDEV(quantidade) OVER (ORDER BY data_venda ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING),2) AS desvio_padrao_movel
FROM schema8.vendas;


-- 15. Quais Clientes Estão Cadastrados, Mas Ainda Não Fizeram Transação?

SELECT
	c.nome
FROM schema8.vendas v
RIGHT JOIN schema8.clientes c USING (id_cliente)
WHERE v.data_venda IS NULL
ORDER BY c.nome;


