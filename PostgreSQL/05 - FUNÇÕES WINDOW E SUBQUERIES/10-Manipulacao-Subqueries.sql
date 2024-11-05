SELECT * FROM schema5.vendas2;

-- Subqueries Correlatas --

-- Crie uma querie que selecione os funcionários justamente com o valor maximo
-- de unidades vendidas de cada um por ano, comparando com a média de vendas do ano;

SELECT 
    v.funcionario,
    v.ano,
    v.unidades_vendidas AS maior_venda_ano,
    (SELECT ROUND(AVG(unidades_vendidas), 2)
     FROM schema5.vendas2 
     WHERE ano = v.ano) AS media_vendas_ano
FROM 
    schema5.vendas2 v
WHERE 
    v.unidades_vendidas = (SELECT MAX(unidades_vendidas) 
                           FROM schema5.vendas2
                           WHERE funcionario = v.funcionario AND ano = v.ano)
ORDER BY 
    v.funcionario, v.ano;
	
-- Subqueries com Agregação --

SELECT 
    v.funcionario,
    ano,
    mes,
    unidades_vendidas,
    ROUND((unidades_vendidas / total_vendas) * 100, 2) AS percentual_do_total
FROM schema5.vendas2 AS v,
    (SELECT funcionario, SUM(unidades_vendidas) AS total_vendas 
     FROM schema5.vendas2
     GROUP BY funcionario) AS vendas_totais
WHERE v.funcionario = vendas_totais.funcionario
ORDER BY v.funcionario, ano, CASE
                WHEN mes = 'Janeiro' THEN 1
                WHEN mes = 'Fevereiro' THEN 2
                WHEN mes = 'Março' THEN 3
                WHEN mes = 'Abril' THEN 4
                WHEN mes = 'Maio' THEN 5
                WHEN mes = 'Junho' THEN 6
                WHEN mes = 'Julho' THEN 7
                WHEN mes = 'Agosto' THEN 8
                WHEN mes = 'Setembro' THEN 9
                WHEN mes = 'Outubro' THEN 10
                WHEN mes = 'Novembro' THEN 11
                WHEN mes = 'Dezembro' THEN 12
            END;
