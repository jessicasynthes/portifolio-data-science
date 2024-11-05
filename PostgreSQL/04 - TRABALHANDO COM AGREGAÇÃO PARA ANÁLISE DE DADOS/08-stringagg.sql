-- Faturamento total por país em 2024 mostrando todos os produtos vendidos como uma lista
SELECT
	pais,
	STRING_AGG(produto, ', ') AS produtos_vendidos,
	SUM(faturamento) AS faturamento_total
FROM schema4.vendas
WHERE ano = 2024
GROUP BY pais;