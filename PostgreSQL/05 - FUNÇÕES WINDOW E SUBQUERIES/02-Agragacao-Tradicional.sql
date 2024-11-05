SELECT * FROM schema5.vendas;

-- Total geral de unidades vendidas;

SELECT SUM(unidades_vendidas) AS unidades_vendidas
FROM schema5.vendas;

-- Total de unidades vendidas por ano;

SELECT ano, SUM(unidades_vendidas) AS unidades_vendidas
FROM schema5.vendas
GROUP BY ano
ORDER BY ano;

-- Total de unidades vendidas por funcionário;

SELECT funcionario, SUM(unidades_vendidas) AS unidades_vendidas
FROM schema5.vendas
GROUP BY funcionario
ORDER BY unidades_vendidas DESC;

-- Total de unidades vendidas por ano e por funcionário;

SELECT ano, funcionario, SUM(unidades_vendidas) AS unidades_vendidas
FROM schema5.vendas
GROUP BY ano, funcionario
ORDER BY unidades_vendidas DESC;

-- Unidades vendidas por ano, mes e por funcionário;

SELECT ano, mes, funcionario, unidades_vendidas
FROM schema5.vendas
ORDER BY ano, mes, funcionario, unidades_vendidas;

-- Unidades vendidas por ano, mes, funcionário, unidades vendidas e total de unidades vendidas no ano;

SELECT 
    v.ano, 
    v.mes, 
    v.funcionario, 
    v.unidades_vendidas,
    u.unidades_vendidas_ano
FROM 
    schema5.vendas v
JOIN 
    (SELECT ano, SUM(unidades_vendidas) AS unidades_vendidas_ano
     FROM schema5.vendas
     GROUP BY ano) u
ON v.ano = u.ano
ORDER BY 
    v.unidades_vendidas DESC;