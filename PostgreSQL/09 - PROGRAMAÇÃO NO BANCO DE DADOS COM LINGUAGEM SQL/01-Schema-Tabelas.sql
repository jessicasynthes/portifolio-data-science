-- Cria o schema
CREATE SCHEMA schema9 AUTHORIZATION bancodedados;


-- Cria a tabela 'clientes'
CREATE TABLE schema9.clientes (
    cliente_id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255),
    cidade VARCHAR(255)
);

-- Cria a tabela 'interacoes'
CREATE TABLE schema9.interacoes (
    interacao_id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    tipo_interacao VARCHAR(50),
    descricao TEXT,
    data_hora DATE,
    FOREIGN KEY (cliente_id) REFERENCES schema9.clientes(cliente_id)
);

-- Cria a tabela 'vendas'
CREATE TABLE schema9.vendas (
    venda_id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    quantidade INT NOT NULL,
    valor_venda DECIMAL(10, 2) NOT NULL,
    data_venda DATE,
    FOREIGN KEY (cliente_id) REFERENCES schema9.clientes(cliente_id)
);
