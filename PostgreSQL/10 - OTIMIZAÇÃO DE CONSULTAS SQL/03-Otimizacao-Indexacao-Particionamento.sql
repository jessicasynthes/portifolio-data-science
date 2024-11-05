-- Versão melhorada da query anterior
SELECT a.Nome AS AutorNome, l.Titulo AS LivroTitulo, l.Genero AS LivroGenero, al.Preco, al.DataLancamento
FROM schema10.autores a
JOIN schema10.autoreslivros al ON a.AutorID = al.AutorID
JOIN schema10.livros l ON al.LivroID = l.LivroID
ORDER BY a.Nome, l.Titulo, al.DataLancamento;

-- ESTRATÉGIA 1 - INDEXAÇÃO --


CREATE INDEX idx_autoreslivros_autorid ON schema10.autoreslivros(AutorID);
CREATE INDEX idx_autoreslivros_livroid ON schema10.autoreslivros(LivroID);

-- Índice composto para autores baseado no nome
CREATE INDEX idx_autores_nome ON schema10.autores(Nome);

-- Índice composto para livros baseado no título
CREATE INDEX idx_livros_titulo ON schema10.livros(Titulo);
CREATE INDEX idx_autoreslivros_datalancamento ON schema10.autoreslivros(DataLancamento);

-- ESTRATÉGIA 2 - PARTICIONAMENTO --

-- Cria nova tabela ativando o particionamento
CREATE TABLE schema10.autoreslivros_part (
    AutorID INT,
    LivroID INT,
    Preco DECIMAL(10,2),
    DataLancamento DATE
) PARTITION BY RANGE (DataLancamento);

-- Cria as partições
CREATE TABLE schema10.autoreslivros_p1 PARTITION OF schema10.autoreslivros_part
    FOR VALUES FROM ('2010-01-01') TO ('2016-01-01');

CREATE TABLE schema10.autoreslivros_p2 PARTITION OF schema10.autoreslivros_part
    FOR VALUES FROM ('2016-01-01') TO ('2021-01-01');

-- Copia os registros da tabela original para a nova tabela
INSERT INTO schema10.autoreslivros_part (AutorID, LivroID, Preco, DataLancamento)
SELECT AutorID, LivroID, Preco, DataLancamento FROM schema10.autoreslivros;

-- Altera o nome da tabela original
ALTER TABLE IF EXISTS schema10.autoreslivros RENAME TO autoreslivros_old;

-- Altera o nome da nova tabela
ALTER TABLE schema10.autoreslivros_part RENAME TO autoreslivros;

-- Versão melhorada da query

SELECT a.Nome AS AutorNome, l.Titulo AS LivroTitulo, l.Genero AS LivroGenero, al.Preco, al.DataLancamento
FROM schema10.autores a
JOIN schema10.autoreslivros al ON a.AutorID = al.AutorID
JOIN schema10.livros l ON al.LivroID = l.LivroID
WHERE al.DataLancamento >= '2016-01-01'
ORDER BY a.Nome, l.Titulo, al.DataLancamento;

EXPLAIN SELECT a.Nome AS AutorNome, l.Titulo AS LivroTitulo, l.Genero AS LivroGenero, al.Preco, al.DataLancamento
FROM schema10.autores a
JOIN schema10.autoreslivros al ON a.AutorID = al.AutorID
JOIN schema10.livros l ON al.LivroID = l.LivroID
WHERE al.DataLancamento >= '2016-01-01'
ORDER BY a.Nome, l.Titulo, al.DataLancamento;

-- Versão melhorada da query - PARTE 2

SELECT a.Nome AS AutorNome, l.Titulo AS LivroTitulo, l.Genero AS LivroGenero, al.Preco, al.DataLancamento
FROM schema10.autores a
JOIN schema10.autoreslivros al ON a.AutorID = al.AutorID
JOIN schema10.livros l ON al.LivroID = l.LivroID
WHERE al.DataLancamento = '2016-01-01' OR al.DataLancamento <=  '2012-01-01'
ORDER BY a.Nome, l.Titulo, al.DataLancamento;

EXPLAIN SELECT a.Nome AS AutorNome, l.Titulo AS LivroTitulo, l.Genero AS LivroGenero, al.Preco, al.DataLancamento
FROM schema10.autores a
JOIN schema10.autoreslivros al ON a.AutorID = al.AutorID
JOIN schema10.livros l ON al.LivroID = l.LivroID
WHERE al.DataLancamento = '2016-01-01' OR al.DataLancamento <=  '2012-01-01'
ORDER BY a.Nome, l.Titulo, al.DataLancamento;






