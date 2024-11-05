-- Cria o schema
CREATE SCHEMA schema8 AUTHORIZATION bancodedados;

-- Cria as tabelas:

CREATE TABLE schema8.clientes (
    Id_Cliente UUID PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE schema8.produtos (
    Id_Produto UUID PRIMARY KEY,
    nome VARCHAR(255),
    preco DECIMAL
);

CREATE TABLE schema8.vendas (
    Id_Vendas UUID PRIMARY KEY,
    Id_Cliente UUID REFERENCES schema8.clientes(Id_Cliente),
    Id_Produto UUID REFERENCES schema8.produtos(Id_Produto),
    Quantidade INTEGER,
    Data_Venda DATE
);