-- OPERADORES RELACIONAIS

SELECT * 
FROM schema1.estudantes
WHERE nota_exame1 = 90;

SELECT * 
FROM schema1.estudantes
WHERE nota_exame1 > 90;

SELECT * 
FROM schema1.estudantes
WHERE nota_exame1 >= 90;

SELECT * 
FROM schema1.estudantes
WHERE nota_exame2 <= 76.5;

SELECT * 
FROM schema1.estudantes
WHERE nota_exame1 != 90;

SELECT * 
FROM schema1.estudantes
WHERE nota_exame1 <> 90;

SELECT * 
FROM schema1.estudantes
WHERE nota_exame1 = 90;

SELECT * 
FROM schema1.estudantes
WHERE 90 = nota_exame1;

SELECT * 
FROM schema1.estudantes
WHERE 90 = 90;

SELECT * 
FROM schema1.estudantes
WHERE nome = Xavier;

SELECT * 
FROM schema1.estudantes
WHERE nome = 'xavier';

SELECT * 
FROM schema1.estudantes
WHERE nome = 'Xavier';

-- OUTROS OPERADORES RELACIONAIS

-- OPERADOR IN

SELECT nome, sobrenome, nota_exame1, tipo_sistema_operacional
FROM schema1.estudantes
WHERE tipo_sistema_operacional IN ('Linux', 'Mac');

SELECT nome, sobrenome, nota_exame1, tipo_sistema_operacional
FROM schema1.estudantes
WHERE tipo_sistema_operacional IN ('Linux', 'FreeBSD');

SELECT nome, sobrenome, nota_exame1, tipo_sistema_operacional
FROM schema1.estudantes
WHERE tipo_sistema_operacional IN ('Unix');

SELECT nome, sobrenome, nota_exame1, tipo_sistema_operacional
FROM schema1.estudantes
WHERE tipo_sistema_operacional NOT IN ('Linux', 'Mac');


-- OPERADOR LIKE

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM schema1.estudantes
WHERE nome LIKE 'A%'
ORDER BY nome_completo;

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM schema1.estudantes
WHERE nome LIKE 'A%' OR nome LIKE 'B%' 
ORDER BY nome_completo;

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM schema1.estudantes
WHERE nome NOT LIKE 'A%'
ORDER BY nome_completo;

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM schema1.estudantes
WHERE nome NOT LIKE 'A%' AND NOT LIKE 'B%'
ORDER BY nome_completo;

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM schema1.estudantes
WHERE nome NOT LIKE 'A%' AND nome NOT LIKE 'B%'
ORDER BY nome_completo;


-- OPERADOR BETWEEN

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM schema1.estudantes
WHERE nota_exame1 BETWEEN 88 AND 90
ORDER BY nome_completo;

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM schema1.estudantes
WHERE nota_exame1 NOT BETWEEN 88 AND 90
ORDER BY nome_completo;

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2,
	   'Aprovado' AS status
FROM schema1.estudantes
WHERE nota_exame1 BETWEEN 88 AND 90
  AND tipo_sistema_operacional IN ('Linux', 'Mac')
  AND nome LIKE 'C%' OR nome LIKE 'H%' OR nome LIKE 'J%'
  AND nota_exame2 != 80
ORDER BY nome_completo;


-- LIMPAR A TABELA
TRUNCATE TABLE cap04.estudantes;