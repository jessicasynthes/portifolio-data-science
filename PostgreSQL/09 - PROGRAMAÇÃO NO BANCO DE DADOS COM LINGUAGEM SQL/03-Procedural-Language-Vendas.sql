-- Cria a Stored Procedure 
CREATE OR REPLACE PROCEDURE schema9.inserir_interacoes_exemplo()
LANGUAGE plpgsql
AS $$
DECLARE

    -- Variáveis
    cliente RECORD;
    data_aleatoria DATE;
    
BEGIN

    -- Itera sobre cada cliente na tabela 'clientes'
    FOR cliente IN SELECT cliente_id FROM schema9.clientes LOOP
    
        -- Gera uma data aleatória entre 2021 e 2025
        data_aleatoria := '2021-01-01'::DATE + (trunc(random() * (365 * 5))::INT);

        -- Insere uma interação de exemplo para cada cliente com data aleatória
        INSERT INTO schema9.interacoes (cliente_id, tipo_interacao, descricao, data_hora) VALUES
        (cliente.cliente_id, 'Email', 'Email enviado com informações do produto', data_aleatoria),
        (cliente.cliente_id, 'Telefone', 'Chamada telefônica para acompanhamento', data_aleatoria),
        (cliente.cliente_id, 'Reunião', 'Reunião agendada para discussão de detalhes', data_aleatoria);

    END LOOP;
END;
$$;

-- Para executar a Stored Procedure, use:
CALL schema9.inserir_interacoes_exemplo();


-- Cria a Stored Procedure 
CREATE OR REPLACE PROCEDURE schema9.inserir_vendas_exemplo()
LANGUAGE plpgsql
AS $$
DECLARE

    -- Variáveis
    cliente RECORD;
    numero_vendas INT;
    quantidade_venda INT;
    valor_venda DECIMAL(10, 2);
    data_venda_aleatoria DATE;
    
BEGIN

    -- Itera sobre cada cliente na tabela 'clientes'
    FOR cliente IN SELECT cliente_id FROM schema9.clientes LOOP
    
        -- Gera entre 1 a 5 vendas para cada cliente
        numero_vendas := trunc(random() * 5 + 1)::INT; 

        -- Insere vendas aleatórias para o cliente
        FOR i IN 1..numero_vendas LOOP
        
            -- Gera um valor aleatório para a venda (Valores entre 500 e 10500)
            valor_venda := trunc(random() * 10000 + 500)::DECIMAL; 

            -- Gera uma quantidade aleatória para a venda
            quantidade_venda := trunc(random() * 10 + 1)::INT;

            -- Gera uma data de venda aleatória entre 2021 e 2025
            data_venda_aleatoria := '2021-01-01'::DATE + (trunc(random() * (365 * 5))::INT);

            -- Insere a venda na tabela 'vendas'
            INSERT INTO schema9.vendas (cliente_id, quantidade, valor_venda, data_venda) VALUES
            (cliente.cliente_id, quantidade_venda, valor_venda, data_venda_aleatoria);
            
        END LOOP;
    END LOOP;
END;
$$;

-- Para executar a Stored Procedure, use:
CALL schema9.inserir_vendas_exemplo();
