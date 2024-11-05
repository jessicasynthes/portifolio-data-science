select *
from schema1.vendas

-- SUBQUERIES

-- Sem subquery;
-- Query SQL para retornar a média de valor_unitario_venda por produto, somente se a media for
-- maior do que 5 e a categoria de produtos for 1 ou 2.

select nome_produto,
	round(avg(valor_unitario_venda),2) as media_valor_unitario
from schema1.vendas
where categoria_produto in ('Categoria 1', 'Categoria 2')
group by nome_produto
having avg(valor_unitario_venda) > 5
order by nome_produto;

-- Usando subquery
select 
	nome_produto,
	round(avg(valor_unitario_venda),2) as media_valor_unitario
from (
	select nome_produto, valor_unitario_venda
	from schema1.vendas
	where categoria_produto in ('Categoria 1', 'Categoria 2')
) as sub_query
group by nome_produto
having avg(valor_unitario_venda) > 5
order by nome_produto;

-- Query SQL que retorne somente registros cuja média de unidadees vendidas seja maior do que 2.
-- Desse resultado, retorne os produtos cuja média de vendas for maior do que 15.
-- Somente registros se categoria de produto for 1 ou 2

select
	nome_produto,
	round(avg(valor_unitario_venda), 2) as media_valor_unitario
from (
	select nome_produto, valor_unitario_venda
	from schema1.vendas
	where categoria_produto in ('Categoria 1', 'Categoria 2')
	group by nome_produto, valor_unitario_venda
	having avg(unidades_vendidas) > 2
) as sub_query
group by nome_produto
having avg(valor_unitario_venda) > 15
order by nome_produto;
