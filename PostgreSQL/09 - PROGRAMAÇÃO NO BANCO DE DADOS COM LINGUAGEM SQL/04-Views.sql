SELECT * FROM schema9.clientes;
SELECT * FROM schema9.interacoes;
SELECT * FROM schema9.vendas;
-------------------------------

CREATE VIEW schema9.clientes_interacao_email_rua_a AS
SELECT
	c.cliente_id,
	c.nome,
	c.cidade
FROM schema9.clientes c
JOIN schema9.interacoes i ON c.cliente_id = i.cliente_id
WHERE c.endereco LIKE '%Rua A%' AND
i.tipo_interacao = 'Email';

-- Consultar a View
SELECT * FROM schema9.clientes_interacao_email_rua_a;

-- Filtrar pela view
SELECT * FROM schema9.clientes_interacao_email_rua_a
WHERE cliente_id > 280;

-- Nome, rua e cidade do cliente com a data da última interação por e-mail
CREATE VIEW schema9.clientes_interacoes_resumo AS
SELECT
	c.nome,
	c.endereco,
	c.cidade,
	MAX(i.data_hora) AS ultima_interacao
FROM schema9.clientes c
LEFT JOIN schema9.interacoes i ON c.cliente_id = i.cliente_id
WHERE i.tipo_interacao = 'Email'
GROUP BY c.nome, c.endereco, c.cidade
ORDER BY ultima_interacao DESC;

-- Consultar a View
SELECT * FROM schema9.clientes_interacoes_resumo;


-- MATERIALIZED --
CREATE MATERIALIZED VIEW schema9.clientes_interacoes_resumo_mv AS
SELECT
	c.nome,
	c.endereco,
	c.cidade,
	MAX(i.data_hora) AS ultima_interacao
FROM schema9.clientes c
LEFT JOIN schema9.interacoes i ON c.cliente_id = i.cliente_id
WHERE i.tipo_interacao = 'Email'
GROUP BY c.nome, c.endereco, c.cidade
ORDER BY ultima_interacao DESC;

-- Consultar a Materialized View
SELECT * FROM schema9.clientes_interacoes_resumo_mv;
