SELECT * FROM schema5.vendas2;

-- Numerar as transações de cada funcionario por ano e mês
SELECT *
FROM (
	SELECT
		funcionario,
		ano,
		mes,
		unidades_vendidas,
		ROW_NUMBER() OVER (PARTITION BY funcionario ORDER BY ano, CASE
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
			END) AS numero_transacao
	FROM schema5.vendas2 ) AS subquery
WHERE funcionario = 'Agatha Christie' AND numero_transacao = 7;