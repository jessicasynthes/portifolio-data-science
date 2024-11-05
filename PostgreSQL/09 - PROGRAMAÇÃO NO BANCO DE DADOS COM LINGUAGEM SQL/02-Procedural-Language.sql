-- Crie uma Stored Procedure (SP) que gere dados aleatórios de clientes e carregue os dados na tabela de clientes
-- A SP deve permitir cadastrar qualquer número de clientes

CREATE OR REPLACE PROCEDURE schema9.inserir_clientes_aleatorios(num_clientes INT)
LANGUAGE plpgsql
AS $$
DECLARE
	nome_aleatorio VARCHAR(255);
	endereco_aleatorio VARCHAR(255);
	cidade_aleatoria VARCHAR(255);
	lista_cidades TEXT[] := ARRAY['São Paulo', 
                                  'Rio de Janeiro', 
                                  'Belo Horizonte', 
                                  'Vitória', 
                                  'Porto Alegre', 
                                  'Salvador', 
                                  'Blumenau', 
                                  'Curitiba', 
                                  'Fortaleza', 
                                  'Manaus', 
                                  'Recife', 
                                  'Goiânia'
    ];
BEGIN
	FOR i IN 1..num_clientes LOOP
	-- Gera um nome aleatório no formato: Cliente_i_LETRA
        nome_aleatorio := 'Cliente_' || i || '_' || chr(trunc(65 + random()*25)::int);
	-- Gera um endereço aleatório no formato: Rua LETRA, numero
		endereco_aleatorio := 'Rua ' || chr(trunc(65 + random()*25)::int) || ', ' || trunc(random()*1000)::text;
	-- Seleciona uma cidade aleatória da lista
		SELECT INTO cidade_aleatoria 
            lista_cidades[trunc(random() * array_upper(lista_cidades, 1)) + 1] AS cidade;
			
	-- Insere os dados na tabela 'clientes'
        INSERT INTO schema9.clientes (nome, endereco, cidade) VALUES
        (nome_aleatorio, endereco_aleatorio, cidade_aleatoria);
		
	END LOOP;
END;
$$;

-- Para executar a Stored Procedure e inserir um número específico de clientes, use:
CALL schema9.inserir_clientes_aleatorios(1000);