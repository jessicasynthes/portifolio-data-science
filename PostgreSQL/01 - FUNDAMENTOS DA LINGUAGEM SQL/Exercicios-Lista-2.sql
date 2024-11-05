--------------------------------------------------------
-- Criando a tabela 'clientes'
CREATE TABLE schema1.clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255),
    cidade VARCHAR(255),
    estado VARCHAR(2),
    data_nascimento DATE
);


-- Inserindo registros na tabela 'clientes'
INSERT INTO schema1.clientes (nome, email, cidade, estado, data_nascimento) VALUES
('Carlos Silva', 'carlos.silva@exemplo.dsa.com', 'São Paulo', 'SP', '1980-05-15'),
('Maria Oliveira', 'maria.oliveira@exemplo.dsa.com', 'Rio de Janeiro', 'RJ', '1990-08-20'),
('João Pereira', 'joao.pereira@exemplo.dsa.com', 'Belo Horizonte', 'MG', '1985-11-30'),
('Ana Santos', '', 'Curitiba', 'PR', '1975-02-28'),
('Paulo Souza', 'paulo.souza@exemplo.dsa.com', 'Porto Alegre', 'RS', '1995-06-10'),
('Fernanda Barbosa', '', 'Salvador', 'BA', '1983-07-15'),
('Rodrigo Lima', 'rodrigo.lima@exemplo.dsa.com', 'Recife', 'PE', '1988-12-05'),
('Aline Teixeira', '', 'Fortaleza', 'CE', '1992-04-18'),
('Renato Gonçalves', 'renato.goncalves@exemplo.dsa.com', 'Goiânia', 'GO', '1978-09-12'),
('Patrícia Alves', 'patricia.alves@exemplo.dsa.com', 'São Luís', 'MA', '1987-03-22'),
('Ricardo Martins', 'ricardo.martins@exemplo.dsa.com', 'Natal', 'RN', '1993-01-19'),
('Sandra Ferreira', 'sandra.ferreira@exemplo.dsa.com', 'João Pessoa', 'PB', '1970-10-31'),
('Thiago Correia', 'thiago.correia@exemplo.dsa.com', 'Aracaju', 'SE', '1996-08-07'),
('Fábio Azevedo', 'fabio.azevedo@exemplo.dsa.com', 'Maceió', 'AL', '1982-05-21'),
('Juliana Castro', 'juliana.castro@exemplo.dsa.com', 'Teresina', 'PI', '1989-06-14');
----------------------------------------------------------
SELECT *
FROM schema1.clientes
----------------------------------------------------------

-- 1. Quantos clientes estão registrados por estado?

SELECT estado,
	COUNT(estado) AS contagem_estado
FROM schema1.clientes
GROUP BY estado
ORDER BY estado;

-- 2. Qual é a idade média dos clientes?

SELECT
	ROUND(AVG(2024 - EXTRACT(YEAR from data_nascimento)))
FROM schema1.clientes;

-- 3. Quantos clientes têm mais de 30 anos?

SELECT 
	2024 - EXTRACT(YEAR from data_nascimento) AS Idade
FROM schema1.clientes
WHERE 2024 - EXTRACT(YEAR from data_nascimento) > 30;
---------------------------------------------------------
SELECT 
	COUNT(*) AS Mais_30
FROM schema1.clientes
WHERE 2024 - EXTRACT(YEAR from data_nascimento) > 30;

-- 4. Quais são as 3 cidades com maior número de clientes?

SELECT cidade,
	COUNT(cidade) AS contagem_cidade
FROM schema1.clientes
GROUP BY cidade
ORDER BY contagem_cidade
LIMIT 3;

-- 5. Quantos clientes têm um endereço de e-mail registrado?

SELECT
	COUNT(email) AS contagem_email
FROM schema1.clientes
WHERE email != '';

--------------------------------------------------------------------
-- Criando a tabela 'produtos'
CREATE TABLE schema1.produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    preco DECIMAL(10, 2),
    quantidade INT,
    categoria VARCHAR(255),
    data_criacao DATE
);


-- Inserindo registros na tabela 'produtos'
INSERT INTO schema1.produtos (nome, preco, quantidade, categoria, data_criacao) VALUES
('Produto A', 25.50, 100, 'Categoria 1', '2023-01-01'),
('Produto B', 15.75, 200, 'Categoria 1', '2023-01-02'),
('Produto C', 30.00, 150, 'Categoria 2', '2023-01-03'),
('Produto D', 10.00, 250, 'Categoria 2', '2023-01-04'),
('Produto E', 8.50, 300, 'Categoria 3', '2023-01-05'),
('Produto F', 19.99, 120, 'Categoria 3', '2023-01-06'),
('Produto G', 45.00, 80, 'Categoria 4', '2023-01-07'),
('Produto H', 60.00, 70, 'Categoria 4', '2023-01-08'),
('Produto I', 12.99, 200, 'Categoria 5', '2023-01-09'),
('Produto J', 7.50, 330, 'Categoria 5', '2023-01-10'),
('Produto K', 22.00, 110, 'Categoria 1', '2023-01-11'),
('Produto L', 31.25, 90, 'Categoria 2', '2023-01-12'),
('Produto M', 40.00, 60, 'Categoria 3', '2023-01-13'),
('Produto N', 55.00, 50, 'Categoria 4', '2023-01-14'),
('Produto O', 20.00, 130, 'Categoria 5', '2023-01-15');
--------------------------------------------------------------------
SELECT *
FROM schema1.produtos;
--------------------------------------------------------------------

-- 6. Qual é o valor total de produtos em estoque por categoria?

SELECT categoria,
	SUM(preco * quantidade) AS valor_total
FROM schema1.produtos
GROUP BY categoria
ORDER BY categoria;

-- 7. Qual é a quantidade média de produtos em estoque por categoria?

SELECT categoria,
	ROUND(AVG(quantidade)) AS media_produtos
FROM schema1.produtos
GROUP BY categoria
ORDER BY categoria;

-- 8. Qual é o preço médio dos produtos por categoria?

SELECT categoria,
	ROUND(AVG(preco),2) AS preco_medio
FROM schema1.produtos
GROUP BY categoria
ORDER BY categoria;

-- 9. Qual é o número total de categorias de produtos?

SELECT
	COUNT(DISTINCT(categoria)) AS contagem_categorias
FROM schema1.produtos;

-- 10. Qual é a categoria com a maior quantidade de produtos em estoque?

SELECT categoria,
	SUM(quantidade) AS quantidade_categoria
FROM schema1.produtos
GROUP BY categoria
ORDER BY quantidade_categoria DESC
LIMIT 1;

-------------------------------------------------------------
-- Criando a tabela 'fornecedores'
CREATE TABLE schema1.fornecedores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    cidade VARCHAR(255),
    estado VARCHAR(2),
    email VARCHAR(255),
    data_registro DATE
);


-- Inserindo registros na tabela 'funcionarios'
INSERT INTO schema1.fornecedores (nome, cidade, estado, email, data_registro) VALUES
('Fornecedor 1', 'São Paulo', 'SP', 'fornecedor1@exemplo.dsa.com', '2023-09-01'),
('Fornecedor 2', 'Rio de Janeiro', 'RJ', 'fornecedor2@exemplo.dsa.com', '2023-09-02'),
('Fornecedor 3', 'Belo Horizonte', 'MG', 'fornecedor3@exemplo.dsa.com', '2023-09-03'),
('Fornecedor 4', 'Porto Alegre', 'RS', 'fornecedor4@exemplo.dsa.com', '2023-09-04'),
('Fornecedor 5', 'Curitiba', 'PR', 'fornecedor5@exemplo.dsa.com', '2023-09-05'),
('Fornecedor 6', 'Recife', 'PE', 'fornecedor6@exemplo.dsa.com', '2023-09-06'),
('Fornecedor 7', 'Salvador', 'BA', 'fornecedor7@exemplo.dsa.com', '2023-10-07'),
('Fornecedor 8', 'Fortaleza', 'CE', 'fornecedor8@exemplo.dsa.com', '2023-10-08'),
('Fornecedor 9', 'Goiânia', 'GO', 'fornecedor9@exemplo.dsa.com', '2023-10-09'),
('Fornecedor 10', 'Manaus', 'AM', 'fornecedor10@exemplo.dsa.com', '2023-10-10');
-------------------------------------------------------------
SELECT *
FROM schema1.fornecedores
-------------------------------------------------------------

-- 11. Qual é a quantidade de fornecedores por estado?

SELECT estado,
	COUNT(nome) AS quantidade_fornecedores
FROM schema1.fornecedores
GROUP BY estado
ORDER BY estado;

-- 12. Qual é o estado com o maior número de fornecedores?

SELECT estado,
	COUNT(nome) AS quantidade_fornecedores
FROM schema1.fornecedores
GROUP BY estado
ORDER BY quantidade_fornecedores
LIMIT 1;

-- 13. Quantos fornecedores foram registrados no mês de Setembro de 2023?

SELECT
	COUNT(nome) AS quantidade_fornecedores
FROM schema1.fornecedores
WHERE EXTRACT(MONTH FROM data_registro) = 09;

-- 14. Qual é a média de registros de fornecedores por mês?

SELECT
	EXTRACT(MONTH FROM data_registro) AS mes_registro,
	COUNT(nome) AS quantidade_fornecedores
FROM schema1.fornecedores
GROUP BY EXTRACT(MONTH FROM data_registro);
----------------------------------------------------------
SELECT
	ROUND(AVG(quantidade_fornecedores))
FROM(
	SELECT
	EXTRACT(MONTH FROM data_registro) AS mes_registro,
	COUNT(nome) AS quantidade_fornecedores
	FROM schema1.fornecedores
	GROUP BY EXTRACT(MONTH FROM data_registro)
) AS fornecedores_mes;

-- 15. Qual é o fornecedor mais recente registrado?

SELECT nome,
	data_registro
FROM schema1.fornecedores
ORDER BY data_registro DESC
LIMIT 1;


---------------------------------------------------------------------
-- Criando a tabela 'vendas'
CREATE TABLE schema1.vendas (
    id SERIAL PRIMARY KEY,
    data_venda DATE,
    valor DECIMAL(10, 2),
    id_produto INT
);


-- Inserindo registros na tabela 'vendas'
INSERT INTO schema1.vendas (data_venda, valor, id_produto) VALUES
('2023-01-01', 25.50, 1),
('2023-01-02', 30.00, 2),
('2023-01-03', 20.00, 3),
('2023-01-03', 40.00, 3),
('2023-01-04', 92.00, 3),
('2023-02-03', 50.00, 3),
('2023-02-03', 22.00, 3),
('2023-03-03', 20.00, 3),
('2023-04-23', 45.00, 3),
('2023-04-23', 45.00, 3),
('2023-04-23', 76.00, 3),
('2023-05-09', 15.00, 3),
('2023-05-21', 55.00, 3),
('2023-06-03', 87.00, 3),
('2023-06-04', 54.50, 3),
('2023-06-05', 65.00, 3),
('2023-06-06', 64.00, 3),
('2023-06-20', 18.75, 20);
---------------------------------------------------------------------
SELECT *
FROM schema1.vendas
---------------------------------------------------------------------


-- 16. Qual é o total de vendas por produto?

SELECT id_produto,
	SUM(valor) AS total_vendas
FROM schema1.vendas
GROUP BY id_produto
ORDER BY id_produto;

-- 17. Quantos produtos diferentes foram vendidos?

SELECT id_produto
FROM schema1.vendas
GROUP BY id_produto
ORDER BY id_produto;
-------------------------------------------------
SELECT
	COUNT(DISTINCT(id_produto)) AS contagem_produtos_diferentes
FROM schema1.vendas;

-- 18. Qual é o total de vendas por dia?

SELECT data_venda,
	SUM(valor) AS total_vendas
FROM schema1.vendas
GROUP BY data_venda
ORDER BY data_venda;

-- 19. Em quais dias o valor total de vendas foi superior a $100/50?

SELECT data_venda,
	SUM(valor) AS total_vendas
FROM schema1.vendas
GROUP BY data_venda
HAVING SUM(valor) > 100
ORDER BY total_vendas DESC;
--------------------------------------------------------------------
SELECT data_venda,
	SUM(valor) AS total_vendas
FROM schema1.vendas
GROUP BY data_venda
HAVING SUM(valor) > 50
ORDER BY total_vendas DESC;

-- 20. Quais produtos tiveram um valor total de vendas superior a $50?

SELECT id_produto,
	SUM(valor) AS total_vendas
FROM schema1.vendas
GROUP BY id_produto
HAVING SUM(valor) > 50
ORDER BY total_vendas DESC;