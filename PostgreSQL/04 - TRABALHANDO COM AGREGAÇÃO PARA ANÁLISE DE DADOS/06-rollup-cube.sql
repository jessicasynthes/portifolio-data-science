-- Criação da tabela Clientes
CREATE TABLE IF NOT EXISTS schema4.vendas (
    ano INT NULL,
    pais VARCHAR(50) NULL,
    produto VARCHAR(50) NULL,
    faturamento INT NULL
);


-- Insere registros
INSERT INTO schema4.vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Brasil', 'Geladeira', 1130);

INSERT INTO schema4.vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Brasil', 'TV', 980);

INSERT INTO schema4.vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Argentina', 'Geladeira', 2180);

INSERT INTO schema4.vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Argentina', 'TV', 2240);

INSERT INTO schema4.vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Portugal', 'Smartphone', 2310);

INSERT INTO schema4.vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Portugal', 'TV', 1900);

INSERT INTO schema4.vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Inglaterra', 'Notebook', 1800);

INSERT INTO schema4.vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Brasil', 'Geladeira', 1400);

INSERT INTO schema4.vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Brasil', 'TV', 1345);

INSERT INTO schema4.vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Argentina', 'Geladeira', 2180);

INSERT INTO schema4.vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Argentina', 'TV', 1390);

INSERT INTO schema4.vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Portugal', 'Smartphone', 2480);

INSERT INTO schema4.vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Portugal', 'TV', 1980);

INSERT INTO schema4.vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Inglaterra', 'Notebook', 2300);

------------------------------------------------------------------------

-- ROLLUP --

SELECT * FROM schema4.vendas;

-- Faturamento total por ano
SELECT ano, SUM(faturamento)
FROM schema4.vendas
GROUP BY ano
ORDER BY ano;

-- Faturamento total por ano e total geral
SELECT COALESCE(TO_CHAR(ano,'9999'),'Total'), SUM(faturamento)
FROM schema4.vendas
GROUP BY ROLLUP(ano)
ORDER BY ano;

-- Faturamento total por ano e país com total geral
SELECT COALESCE(TO_CHAR(ano,'9999'),'Total') AS ano, COALESCE(pais,'Total') AS pais, SUM(faturamento)
FROM schema4.vendas
GROUP BY ROLLUP(ano, pais)
ORDER BY ano, pais;

-- CUBE --

-- Faturamento total por ano e país com total geral
SELECT COALESCE(TO_CHAR(ano,'9999'),'Total') AS ano, COALESCE(pais,'Total') AS pais, SUM(faturamento)
FROM schema4.vendas
GROUP BY CUBE(ano, pais)
ORDER BY ano, pais;
