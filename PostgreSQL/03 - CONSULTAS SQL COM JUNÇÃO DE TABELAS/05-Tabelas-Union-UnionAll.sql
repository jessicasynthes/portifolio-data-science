-- Cria a tabela
CREATE TABLE schema3.estudantes_ensino_medio (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

-- Insere registros na tabela
INSERT INTO schema3.estudantes_ensino_medio (nome) VALUES ('Alice');
INSERT INTO schema3.estudantes_ensino_medio (nome) VALUES ('Bob');
INSERT INTO schema3.estudantes_ensino_medio (nome) VALUES ('Carla');

-- Cria a tabela
CREATE TABLE schema3.estudantes_universidade  (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    especialidade VARCHAR(255) NOT NULL
);

-- Insere registros na tabela
INSERT INTO schema3.estudantes_universidade (nome, especialidade) VALUES ('Bob', 'Direito');
INSERT INTO schema3.estudantes_universidade (nome, especialidade) VALUES ('Maria', 'Medicina');
INSERT INTO schema3.estudantes_universidade (nome, especialidade) VALUES ('José', 'Engenharia');

------------------------------------------------------------------------------------------------

-- UNION --

SELECT id, nome FROM schema3.estudantes_ensino_medio
UNION
SELECT id, nome FROM schema3.estudantes_universidade
ORDER BY id;

-- UNION ALL --

SELECT id, nome FROM schema3.estudantes_ensino_medio
UNION ALL
SELECT id, nome FROM schema3.estudantes_universidade
ORDER BY id;

SELECT id, nome, 'Não se aplica' AS especialidade FROM schema3.estudantes_ensino_medio
UNION ALL
SELECT id, nome, especialidade FROM schema3.estudantes_universidade
ORDER BY id;
