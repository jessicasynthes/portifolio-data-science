SELECT * FROM schema5.vendas2;

-- Ranking geral de dados --
SELECT
		ano,
		funcionario,
		unidades_vendidas,
		RANK() OVER (ORDER BY unidades_vendidas DESC) AS ranking_vendas
FROM schema5.vendas2

-- Soma acumulada ao longo do tempo --
SELECT 
		funcionario,
		ano,
		mes,
		unidades_vendidas,
		SUM(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano, CASE
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
			END) AS soma_acumulada
FROM schema5.vendas2; 

-- Média acumulada até o ponto --
SELECT 
		funcionario,
		ano,
		mes,
		unidades_vendidas,
		ROUND(AVG(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano, CASE
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
			END), 2) AS media_acumulada_ate_ponto_atual
FROM schema5.vendas2; 

-- Média móvel ao longo do tempo -- 

SELECT 
		funcionario,
		ano,
		mes,
		unidades_vendidas,
		ROUND(AVG(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano, CASE
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
			END ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) AS media_movel
FROM schema5.vendas2; 

-- LEAD --

SELECT 
		funcionario,
		ano,
		mes,
		unidades_vendidas,
		COALESCE (CAST(LEAD(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano, CASE
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
			END) AS VARCHAR), 'Sem dados') AS proxima_transacao
FROM schema5.vendas2;

-- LAG --

SELECT 
		funcionario,
		ano,
		mes,
		unidades_vendidas,
		COALESCE (CAST(LAG(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano, CASE
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
			END) AS VARCHAR), 'Sem dados') AS proxima_transacao
FROM schema5.vendas2;