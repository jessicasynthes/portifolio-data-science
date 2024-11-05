
-- Criação da tabela Autores
CREATE TABLE schema3.autores (
    id_autor SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE
);

-- Criação da tabela Livros
CREATE TABLE schema3.livros (
    id_livro SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    ano_publicacao INT
);

-- Criação da tabela LivrosAutores
CREATE TABLE schema3.livros_vendidos (
    id_livro INT NOT NULL REFERENCES schema3.livros(id_livro),
    id_autor INT NOT NULL REFERENCES schema3.autores(id_autor),
    PRIMARY KEY (id_livro, id_autor)
);

-- Inserindo registros na tabela de autores
INSERT INTO schema3.autores (nome, data_nascimento) VALUES
('Yuval Noah Harari', '1976-02-24'),
('Leonard Mlodinow', '1954-11-26'),
('Dale Carnegie', '1888-11-24'),
('Stephen R. Covey', '1932-10-24');

-- Inserindo registros na tabela de livros
INSERT INTO schema3.livros (titulo, ano_publicacao) VALUES
('Sapiens - Uma breve história da humanidade', 2020),
('21 lições para o século 21', 2018),
('O andar do bêbado: Como o acaso determina nossas vidas', 2018),
('Uma breve história do tempo', 2015),
('Os 7 Hábitos das Pessoas Altamente Eficazes', 2017);

-- Inserindo registros na tabela de LivrosAutores
INSERT INTO schema3.livros_vendidos (id_livro, id_autor) VALUES
(1, 1), 
(3, 2), 
(5, 4); 

---------------------------------------------------------------------------------
SELECT * FROM schema3.autores;
SELECT * FROM schema3.livros;
SELECT * FROM schema3.livros_vendidos;
---------------------------------------------------------------------------------


-- 1. Liste todos os livros vendidos e seus respectivos autores.

SELECT lv.id_livro, l.titulo AS Titulo_Livro, a.nome AS Nome_Autor
FROM schema3.livros_vendidos lv
JOIN schema3.livros l USING (id_livro)
JOIN schema3.autores a USING (id_autor);


-- 2. Liste todos os autores e seus respectivos livros, incluindo autores que não têm livros cadastrados.

SELECT
	CASE
		WHEN lv.id_autor IS NULL THEN 0
		ELSE lv.id_autor
	END AS id_autor,
	a.nome AS Nome_Autor,
	CASE
		WHEN l.titulo IS NULL THEN 'Não encontrado'
		ELSE l.titulo
	END AS Titulo_Publicacao
FROM schema3.livros_vendidos lv
JOIN schema3.livros l USING (id_livro)
RIGHT JOIN schema3.autores a USING (id_autor)
ORDER BY a.nome;


-- 3. Liste todos os livros e seus respectivos autores, incluindo livros que não têm autores cadastrados.

SELECT
	CASE
		WHEN lv.id_livro IS NULL THEN 0
		ELSE lv.id_livro
	END AS id_livro,
	l.titulo AS Titulo_Livro,
	CASE
		WHEN a.nome IS NULL THEN 'Não encontrado'
		ELSE a.nome
	END AS Nome_Autor
FROM schema3.livros_vendidos lv
JOIN schema3.autores a USING (id_autor)
RIGHT JOIN schema3.livros l USING (id_livro)
ORDER BY l.titulo;

-- 4. Liste os autores que nasceram antes de 1970 e os livros que eles escreveram.

SELECT 
	CASE
		WHEN lv.id_autor IS NULL THEN 0
		ELSE lv.id_autor
	END AS id_autor,
	a.nome AS Nome_Autor,
	CASE
		WHEN l.titulo IS NULL THEN 'Não encontrado'
		ELSE l.titulo
	END AS Titulo_Publicacao, 
	a.data_nascimento
FROM schema3.livros_vendidos lv
JOIN schema3.livros l USING (id_livro)
RIGHT JOIN schema3.autores a USING (id_autor)
WHERE EXTRACT(YEAR FROM a.data_nascimento) < 1970;

-- 5. Liste os livros publicados após 2017, incluindo os que não têm autores associados.

SELECT 
	CASE
		WHEN lv.id_livro IS NULL THEN 0
		ELSE lv.id_livro
	END AS id_livro,
	l.titulo AS Titulo_Publicacao,
	CASE
		WHEN a.nome IS NULL THEN 'Não encontrado'
		ELSE a.nome
	END AS Nome_Autor, 
	l.ano_publicacao
FROM schema3.livros_vendidos lv
JOIN schema3.autores a USING (id_autor)
RIGHT JOIN schema3.livros l USING (id_livro)
WHERE l.ano_publicacao >= 2017
ORDER BY l.ano_publicacao;