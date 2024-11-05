
-- FILTROS DE COLUNA

-- Seleciona todas as linhas e colunas da tabela
SELECT * 
FROM schema1.estudantes;

-- Seleciona nome e sobrenome de todos os estudantes
SELECT nome, sobrenome
FROM schema1.estudantes;

-- Seleciona tipo de sistema operacional, nota no exame 1 e nota no exame 2 de todos os estudantes
SELECT tipo_sistema_operacional, nota_exame1, nota_exame2
FROM schema1.estudantes;

-- Seleciona tipo de sistema operacional, nota no exame 1, nota no exame 2, nome e sobrenome de todos os estudantes.
-- Nome e sobrenome são mostrados em uma única coluna no resultado exibindo o nome completo.
SELECT tipo_sistema_operacional, nota_exame1, nota_exame2, nome || ' ' || sobrenome
FROM schema1.estudantes;

-- Seleciona tipo de sistema operacional, nota no exame 1, nota no exame 2, nome e sobrenome de todos os estudantes.
-- Nome e sobrenome são mostrados em uma única coluna no resultado exibindo o nome completo.
-- Cria um apelido para a nova coluna de nome completo
SELECT tipo_sistema_operacional, nota_exame1, nota_exame2, nome || ' ' || sobrenome AS nome_completo
FROM schema1.estudantes;


-- FILTROS DE LINHA

-- Seleciona os 10 primeiros estudantes da tabela
SELECT *
FROM schema1.estudantes
LIMIT 10;

-- Selecione=a todos os estudantes que conseguiram nota igual a 90 em nota_exame1
SELECT * 
FROM schema1.estudantes
WHERE nota_exame1 = 90;

-- Seleciona todos os estudantes que conseguiram nota maior do que 90 em nota_exame1
SELECT * 
FROM schema1.estudantes
WHERE nota_exame1 > 90;

-- Seleciona somente os nomes dos estudantes que conseguiram nota maior do que 90 em nota_exame1
SELECT nome
FROM schema1.estudantes
WHERE nota_exame1 > 90;

-- Seleciona somente os nomes dos estudantes que conseguiram nota menor do que 90 em nota_exame1
-- Ordena o resultado
SELECT nome
FROM schema1.estudantes
WHERE nota_exame1 < 90
ORDER BY nome;

-- Retorna somente um nome se houver duplicidade
SELECT DISTINCT nome
FROM schema1.estudantes
WHERE nota_exame1 < 90
ORDER BY nome;

-- Retorna valores distintos por nome e sobrenome, ordenados por nome

SELECT DISTINCT nome, sobrenome
FROM schema1.estudantes
WHERE nota_exame1 < 90
ORDER BY nome;
