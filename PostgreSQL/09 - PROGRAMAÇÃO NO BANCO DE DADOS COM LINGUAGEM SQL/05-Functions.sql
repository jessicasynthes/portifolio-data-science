-- Vamos criar um relatório que calcula o valor total de vendas para um cliente específico. 
-- Se não houve venda, o relatório deve retornar zero.
CREATE OR REPLACE FUNCTION schema9.calcular_total_vendas_cliente(cliente_id_param INT)
RETURNS DECIMAL(10, 2) AS $$
DECLARE
    total_vendas DECIMAL(10, 2);
BEGIN
    SELECT SUM(valor_venda) INTO total_vendas
    FROM schema9.vendas
    WHERE cliente_id = cliente_id_param;

    IF total_vendas IS NULL THEN
        RETURN 0;
    ELSE
        RETURN total_vendas;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Selecionando com a function

SELECT schema9.calcular_total_vendas_cliente(10);

-- Retorna o cliente de id 10 com o total de vendas
SELECT 
    c.cliente_id,
    c.nome,
    c.cidade,
    schema9.calcular_total_vendas_cliente(10) AS total_vendas
FROM 
    schema9.clientes c
WHERE 
    c.cliente_id = 10;
	

