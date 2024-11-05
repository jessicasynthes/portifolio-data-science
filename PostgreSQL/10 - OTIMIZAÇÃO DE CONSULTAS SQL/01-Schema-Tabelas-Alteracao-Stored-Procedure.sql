# SQL Para Análise de Dados e Data Science - Capítulo 21

-- Cria o schema
CREATE SCHEMA schema10 AUTHORIZATION bancodedados;


-- Cria tabela
CREATE TABLE schema10.autores (
    AutorID SERIAL,
    Nome VARCHAR(100) NOT NULL,
    Nacionalidade VARCHAR(50)
);


-- Cria tabela
CREATE TABLE schema10.livros (
    LivroID SERIAL,
    Titulo VARCHAR(100) NOT NULL,
    AnoPublicacao INT,
    Genero VARCHAR(50)
);


-- Cria tabela
CREATE TABLE schema10.autoreslivros (
    AutorID INT,
    LivroID INT
);


-- Altera a tabela criada
ALTER TABLE schema10.autoreslivros
ADD Preco DECIMAL(10,2),
ADD DataLancamento DATE;


-- Stored Procedure para carregar os dados
CREATE OR REPLACE PROCEDURE schema10.carrega_dados()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Inserindo dados na tabela Autores
    FOR i IN 1..100 LOOP
        INSERT INTO schema10.autores (Nome, Nacionalidade)
        VALUES ('Autor ' || i, 'Nacionalidade ' || i);
    END LOOP;

    -- Inserindo dados na tabela Livros
    FOR i IN 1..300 LOOP
        INSERT INTO schema10.livros (Titulo, AnoPublicacao, Genero)
        VALUES ('Livro ' || i, 2000 + (i % 20), 'Genero ' || (i % 5));
    END LOOP;

    -- Associando autores e livros de maneira simplificada, com preço e data de lançamento
    FOR i IN 1..1500000 LOOP
        BEGIN
            INSERT INTO schema10.autoreslivros (AutorID, LivroID, Preco, DataLancamento)
            VALUES (
                (SELECT AutorID FROM schema10.autores ORDER BY RANDOM() LIMIT 1), -- Seleciona um AutorID aleatório
                (SELECT LivroID FROM schema10.livros ORDER BY RANDOM() LIMIT 1), -- Seleciona um LivroID aleatório
                ROUND((RANDOM() * 200)::numeric, 2), -- Gera um preço aleatório entre 0 e 200
                ('2010-01-01'::date + (RANDOM() * (3650))::int * '1 day'::interval)::date -- Gera uma data de lançamento aleatória no intervalo de 10 anos
            );
        EXCEPTION WHEN unique_violation THEN
            -- Ignora a violação de chave primária e continua. Nosso objetivo é apenas criar dados fictícios de exemplo.
        END;
    END LOOP;
END;
$$;


-- Executa a SP
CALL schema10.carrega_dados();




