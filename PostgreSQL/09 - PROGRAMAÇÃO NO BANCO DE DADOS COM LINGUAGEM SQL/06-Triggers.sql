-- Esta function será chamada quando uma nova venda for inserida na tabela vendas. 
-- Ela atualizará a coluna ultima_compra na tabela clientes.
CREATE OR REPLACE FUNCTION schema9.atualizar_ultima_compra()
RETURNS TRIGGER AS $$
BEGIN
    -- Atualiza a coluna 'ultima_compra' na tabela 'clientes'
    UPDATE schema9.clientes
    SET ultima_compra = NEW.data_venda
    WHERE cliente_id = NEW.cliente_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Cria a trigger
CREATE TRIGGER atualiza_data_venda
AFTER INSERT ON schema9.vendas
FOR EACH ROW
EXECUTE FUNCTION schema9.atualizar_ultima_compra();

-- Executa a View
SELECT * FROM schema9.retorna_vendas_cliente_10; --11817.00

-- Transação no banco de dados para inserir uma venda

BEGIN; -- Inicia a transação

-- Insere uma nova venda para o cliente de id 10
INSERT INTO schema9.vendas (cliente_id, quantidade, valor_venda, data_venda)
VALUES (10, 1, 120.00, CURRENT_DATE);

-- Se tudo ocorreu bem, confirma as alterações
COMMIT;

-- Transação no banco de dados para inserir uma transação completa em todas as tabelas

BEGIN; -- Inicia a transação

-- Insere um novo cliente e captura o cliente_id gerado
WITH novo_cliente AS (
    INSERT INTO schema9.clientes (nome, endereco, cidade) 
    VALUES ('Novo Cliente DSA', '123 Rua Principal', 'São Paulo') 
    RETURNING cliente_id
)
-- Insere uma nova interação com o cliente_id obtido
, nova_interacao AS (
    INSERT INTO schema9.interacoes (cliente_id, tipo_interacao, descricao, data_hora)
    SELECT cliente_id, 'Email', 'Email de boas-vindas enviado', CURRENT_DATE
    FROM novo_cliente
    RETURNING interacao_id
)
-- Insere uma nova venda com o cliente_id obtido
INSERT INTO schema9.vendas (cliente_id, quantidade, valor_venda, data_venda)
SELECT cliente_id, 1, 100.00, CURRENT_DATE
FROM novo_cliente;

-- Se tudo ocorreu bem, confirma as alterações
COMMIT;

-- Verifica os clientes que fizeram as compras mais recentes
SELECT * FROM schema9.clientes
WHERE ultima_compra IS NOT NULL;

