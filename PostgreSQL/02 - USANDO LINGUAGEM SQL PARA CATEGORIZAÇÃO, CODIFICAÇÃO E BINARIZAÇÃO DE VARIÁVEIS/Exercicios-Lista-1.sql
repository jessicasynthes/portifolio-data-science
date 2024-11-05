# SQL Para Análise de Dados e Data Science - Capítulo 06


-- Criando a tabela 
CREATE TABLE schema2.vendas_loja_online (
    id_cliente INT PRIMARY KEY,
    pais_cliente VARCHAR(255),
    visitas_ultimo_mes VARCHAR(255),
    compras_ultimo_mes VARCHAR(255),
    total_gasto_ultimo_mes DECIMAL(10,2),
    fez_compra_mes_atual BOOLEAN
);

-- Inserindo registros na tabela 
INSERT INTO schema2.vendas_loja_online (id_cliente, pais_cliente, visitas_ultimo_mes, compras_ultimo_mes, total_gasto_ultimo_mes, fez_compra_mes_atual) VALUES 
(1000, 'Brasil', 'sim', '0-5', 100.50, TRUE),
(1001, 'Canadá', 'não', '6-10', 50.25, FALSE),
(1002, 'Inglaterra', 'não', '0-5', 250.75, TRUE),
(1003, 'Canadá', 'sim', '11-15', 340.20, FALSE),
(1004, 'Canadá', 'sim', '16-20', 150.00, FALSE),
(1005, 'Brasil', 'não', '11-15', 78.00, FALSE),
(1006, 'Canadá', 'sim', '0-5', 0.00, FALSE),
(1007, 'Canadá', 'não', '0-5', 0.00, FALSE),
(1008, 'Canadá', 'sim', '11-15', 90.00, FALSE),
(1009, 'Inglaterra', 'sim', '6-10', 179.30, TRUE);

-------------------------------------------------------
SELECT *
FROM schema2.vendas_loja_online
-------------------------------------------------------

-- CATEGORIZAÇÃO, CODIFICAÇÃO E BINARIZAÇÃO DAS VARIÁVEIS --

-- id_cliente --

SELECT id_cliente,
	CASE
		WHEN id_cliente = '1000' THEN 1
		WHEN id_cliente = '1001' THEN 2
		WHEN id_cliente = '1002' THEN 3
		WHEN id_cliente = '1003' THEN 4
		WHEN id_cliente = '1004' THEN 5
		WHEN id_cliente = '1005' THEN 6
		WHEN id_cliente = '1006' THEN 7
		WHEN id_cliente = '1007' THEN 8
		WHEN id_cliente = '1008' THEN 9
		WHEN id_cliente = '1009' THEN 10
		ELSE 0
	END AS id_cliente
FROM schema2.vendas_loja_online;

-- pais_cliente --

SELECT DISTINCT pais_cliente
FROM schema2.vendas_loja_online;

SELECT pais_cliente,
	CASE
		WHEN pais_cliente = 'Brasil' THEN 1
		WHEN pais_cliente = 'Canadá' THEN 2
		WHEN pais_cliente = 'Inglaterra' THEN 3
		ELSE 0
	END AS pais_cliente
FROM schema2.vendas_loja_online;

-- visitas_ultimo_mes --

SELECT visitas_ultimo_mes,
	CASE
		WHEN visitas_ultimo_mes = 'sim' THEN 1
		WHEN visitas_ultimo_mes = 'não' THEN 0
	END AS visitas_ultimo_mes
FROM schema2.vendas_loja_online;

-- compras_ultimo_mes --

SELECT DISTINCT compras_ultimo_mes
FROM schema2.vendas_loja_online
ORDER BY compras_ultimo_mes;

SELECT compras_ultimo_mes,
	CASE
		WHEN compras_ultimo_mes = '0-5' THEN 1
		WHEN compras_ultimo_mes = '6-10' THEN 2
		WHEN compras_ultimo_mes = '11-15' THEN 3
		WHEN compras_ultimo_mes = '16-20' THEN 4
		ELSE 0
	END AS compras_ultimo_mes
FROM schema2.vendas_loja_online;

-- total_gasto_ultimo_mes --

SELECT total_gasto_ultimo_mes,
	CASE
		WHEN total_gasto_ultimo_mes BETWEEN 0 AND 100 THEN 1
		WHEN total_gasto_ultimo_mes BETWEEN 100.01 AND 200 THEN 2
		WHEN total_gasto_ultimo_mes BETWEEN 200.01 AND 300 THEN 3
		WHEN total_gasto_ultimo_mes BETWEEN 300.01 AND 400 THEN 4
		ELSE 0
	END AS total_gasto_ultimo_mes
FROM schema2.vendas_loja_online;

-- fez_compra_mes_atual --

SELECT fez_compra_mes_atual,
	CASE
		WHEN fez_compra_mes_atual = 'true' THEN 1
		WHEN fez_compra_mes_atual = 'false' THEN 0
	END AS fez_compra_mes_atual
FROM schema2.vendas_loja_online;

---------------------------------------------------------
-- CRIANDO NOVA TABELA TRANSFORMADA --
---------------------------------------------------------
CREATE TABLE schema2.vendas_loja_online_transformada
AS
SELECT
	CASE
		WHEN id_cliente = '1000' THEN 1
		WHEN id_cliente = '1001' THEN 2
		WHEN id_cliente = '1002' THEN 3
		WHEN id_cliente = '1003' THEN 4
		WHEN id_cliente = '1004' THEN 5
		WHEN id_cliente = '1005' THEN 6
		WHEN id_cliente = '1006' THEN 7
		WHEN id_cliente = '1007' THEN 8
		WHEN id_cliente = '1008' THEN 9
		WHEN id_cliente = '1009' THEN 10
		ELSE 0
	END AS id_cliente,
	CASE
		WHEN pais_cliente = 'Brasil' THEN 1
		WHEN pais_cliente = 'Canadá' THEN 2
		WHEN pais_cliente = 'Inglaterra' THEN 3
		ELSE 0
	END AS pais_cliente,
	CASE
		WHEN visitas_ultimo_mes = 'sim' THEN 1
		WHEN visitas_ultimo_mes = 'não' THEN 0
	END AS visitas_ultimo_mes,
	CASE
		WHEN compras_ultimo_mes = '0-5' THEN 1
		WHEN compras_ultimo_mes = '6-10' THEN 2
		WHEN compras_ultimo_mes = '11-15' THEN 3
		WHEN compras_ultimo_mes = '16-20' THEN 4
		ELSE 0
	END AS compras_ultimo_mes,
	CASE
		WHEN total_gasto_ultimo_mes BETWEEN 0 AND 100 THEN 1
		WHEN total_gasto_ultimo_mes BETWEEN 100.01 AND 200 THEN 2
		WHEN total_gasto_ultimo_mes BETWEEN 200.01 AND 300 THEN 3
		WHEN total_gasto_ultimo_mes BETWEEN 300.01 AND 400 THEN 4
		ELSE 0
	END AS total_gasto_ultimo_mes,
	CASE
		WHEN fez_compra_mes_atual = 'true' THEN 1
		WHEN fez_compra_mes_atual = 'false' THEN 0
	END AS fez_compra_mes_atual
FROM schema2.vendas_loja_online;




