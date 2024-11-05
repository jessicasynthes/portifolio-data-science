SELECT * FROM schema5.vendas2;

-- Em ordem cronológica, qual é a 7ª transação da funcionária 'Agatha Christie'?
SELECT 
	funcionario, 
	ano, 
	mes,
	unidades_vendidas
FROM schema5.vendas2
WHERE funcionario = 'Agatha Christie'
ORDER BY ano, mes;

SELECT 
	funcionario, 
	ano, 
	mes,
	CASE
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
	END AS mes_numero,
	unidades_vendidas
FROM schema5.vendas2
WHERE funcionario = 'Agatha Christie'
ORDER BY ano, mes_numero;

-- Seria possível a descobrir a 7ª posição utilizando novos critérios e indexações.
-- Porém seguiremos utilizando função WINDOW que é muito mais prática e possui melhor performance.