-- Função para inserir clientes no banco de dados fazendo validações
CREATE OR REPLACE FUNCTION schema9.inserir_novo_cliente(nome_cliente VARCHAR, endereco_cliente VARCHAR, cidade_cliente VARCHAR)
RETURNS VOID AS $$
BEGIN
    -- Tenta inserir um novo cliente
    INSERT INTO schema9.clientes (nome, endereco, cidade)
    VALUES (nome_cliente, endereco_cliente, cidade_cliente);

    -- Se tudo ocorrer bem, a função termina aqui

    -- Se der erro, retorna conforme abaixo
    EXCEPTION
        WHEN unique_violation THEN
            RAISE NOTICE 'Erro: o cliente já existe.';
        WHEN check_violation THEN
            RAISE NOTICE 'Erro: violação de restrição de verificação.';
        WHEN others THEN
            RAISE NOTICE 'Erro inesperado: %', SQLERRM;
            -- Reverte as alterações feitas na transação atual
            ROLLBACK;
END;
$$ LANGUAGE plpgsql;

-- Executa a função
SELECT schema9.inserir_novo_cliente('DSA Novo Cliente 1', '80 Rua Z', 'Blumenau');
SELECT schema9.inserir_novo_cliente('DSA Novo Cliente 2', '90 Rua Y', 'Natal');
SELECT schema9.inserir_novo_cliente('DSA Novo Cliente 3', '100 Rua X', 'Palmas');

-- Vamos cadastrar vendas para os clientes

BEGIN; -- Inicia a transação

-- Insere uma nova venda para o cliente de id 1001
INSERT INTO schema9.vendas (cliente_id, quantidade, valor_venda, data_venda)
VALUES (1002, 2, 453.00, CURRENT_DATE);

-- Se tudo ocorreu bem, confirma as alterações
COMMIT;


BEGIN; -- Inicia a transação

-- Insere uma nova venda para o cliente de id 1002
INSERT INTO schema9.vendas (cliente_id, quantidade, valor_venda, data_venda)
VALUES (1003, 2, 670.00, CURRENT_DATE);

-- Se tudo ocorreu bem, confirma as alterações
COMMIT;


BEGIN; -- Inicia a transação

-- Insere uma nova venda para o cliente de id 1003
INSERT INTO schema9.vendas (cliente_id, quantidade, valor_venda, data_venda)
VALUES (1004, 2, 345.00, CURRENT_DATE);

-- Se tudo ocorreu bem, confirma as alterações
COMMIT;