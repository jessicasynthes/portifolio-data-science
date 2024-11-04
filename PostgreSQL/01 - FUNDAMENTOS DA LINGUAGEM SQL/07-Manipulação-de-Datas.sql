select *
from schema1.dsa_vendas

-- Query SQL para retornar o valor total final de vendas por dia.

select data_venda,
	sum(valor_unitario_venda * unidades_vendidas) as total_vendas
from schema1.dsa_vendas
group by data_venda
order by data_venda;

-- Query SQL para retornar a média do valor total final de vendas por mês.

select
	extract(year from data_venda) AS Ano,
	extract(month from data_venda) AS Mes,
	round(avg(valor_unitario_venda * unidades_vendidas), 2) as media_valor_total
from schema1.dsa_vendas
group by extract(year from data_venda), extract(month from data_venda)
order by Ano, Mes;

-- Query SQL para retornar a média do valor total final de vendas no dia 1 de cada mês.

select
	extract(year from data_venda) AS Ano,
	extract(month from data_venda) AS Mes,
	extract(day from data_venda) AS Dia,
	round(avg(valor_unitario_venda * unidades_vendidas), 2) as media_valor_total
from schema1.dsa_vendas
group by extract(year from data_venda), extract(month from data_venda), extract(day from data_venda)
having extract(day from data_venda) < 02
order by Ano, Mes;

-- Query SQL para retornar a média do valor total final de vendas entre os dias 10 e 20 de cada mês.

select
	extract(year from data_venda) AS Ano,
	extract(month from data_venda) AS Mes,
	round(avg(valor_unitario_venda * unidades_vendidas), 2) as media_valor_total
from schema1.dsa_vendas
where extract(day from data_venda) between 10 and 20
group by extract(year from data_venda), extract(month from data_venda)
order by Ano, Mes;