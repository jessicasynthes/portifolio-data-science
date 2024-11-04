-- OPERADORES LÓGICOS

SELECT nome, nota_exame1, nota_exame2
FROM schema1.estudantes
WHERE nota_exame1 > 90 AND nota_exame2 > 90;

SELECT nome, nota_exame1, nota_exame2
FROM schema1.estudantes
WHERE nota_exame1 > 90 OR nota_exame2 > 90;

SELECT nome, nota_exame1, nota_exame2
FROM schema1.estudantes
WHERE NOT nota_exame1 > 90;

SELECT nome, nota_exame1, nota_exame2
FROM schema1.estudantes
WHERE nota_exame1 > 90 AND nota_exame2 > 90 AND tipo_sistema_operacional = 'Windows';

SELECT nome, nota_exame1, nota_exame2
FROM schema1.estudantes
WHERE (nota_exame1 > 90 OR nota_exame2 > 90) 
  AND tipo_sistema_operacional = 'Linux';

SELECT nome, nota_exame1, nota_exame2
FROM schema1.estudantes
WHERE (nota_exame1 > 90 OR nota_exame2 > 90) 
  AND tipo_sistema_operacional != 'Linux';

SELECT nome, nota_exame1, nota_exame2
FROM schema1.estudantes
WHERE (nota_exame1 > 90 OR nota_exame2 > 90) 
  AND tipo_sistema_operacional != 'Linux'
  AND NOT nome IN ('Carol', 'Grace');
