-- Cria function para gerar relatório de vendas
CREATE OR REPLACE FUNCTION schema9.relatorio_vendas_clientes()
RETURNS TABLE (nome_cliente VARCHAR, valor_total_vendas DECIMAL, data_ultima_compra DATE) AS $$
DECLARE

    -- Variáveis
    cliente_record RECORD;
    cursor_clientes CURSOR FOR SELECT * FROM schema9.clientes WHERE ultima_compra IS NOT NULL;
BEGIN

    -- Abre o cursor
    OPEN cursor_clientes;

    -- Loop em cada registro do cursor para gerar os valores de saída
    LOOP
        FETCH cursor_clientes INTO cliente_record;
        EXIT WHEN NOT FOUND;

        -- Nome vem do cursor
        nome_cliente := cliente_record.nome; 
        
        -- Total de vendas vem da outra função
        SELECT INTO valor_total_vendas schema9.calcular_total_vendas_cliente(cliente_record.cliente_id); 

        -- Data vem do cursor
        data_ultima_compra := cliente_record.ultima_compra; 

        RETURN NEXT; 

    END LOOP;
    CLOSE cursor_clientes;
END;
$$ LANGUAGE plpgsql;


-- Executa a function
SELECT * FROM schema9.relatorio_vendas_clientes();