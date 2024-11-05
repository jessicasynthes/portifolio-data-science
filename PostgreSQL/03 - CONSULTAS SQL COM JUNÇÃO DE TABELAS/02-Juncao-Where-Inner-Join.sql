SELECT * FROM cap07.clientes
SELECT * FROM cap07.pedidos

-- Usando a clausula WHERE

SELECT nome, quantidade
FROM cap07.clientes, cap07.pedidos
WHERE cap07.clientes.id_cliente = cap07.pedidos.id_cliente;

SELECT nome, quantidade
FROM cap07.clientes, cap07.pedidos_sem_ir
WHERE cap07.clientes.id_cliente = cap07.pedidos_sem_ir.id_cliente;

-- Usando cláusula INNER JOIN
SELECT nome, quantidade
FROM cap07.clientes
INNER JOIN cap07.pedidos ON cap07.clientes.id_cliente = cap07.pedidos.id_cliente;

SELECT nome, quantidade
FROM cap07.clientes
INNER JOIN cap07.pedidos_sem_ir ON cap07.clientes.id_cliente = cap07.pedidos_sem_ir.id_cliente;

-- Usando apelidos (simplificando)

SELECT c.nome, c.id_cliente, p.quantidade, p.id_cliente
FROM cap07.clientes c
INNER JOIN cap07.pedidos p ON c.id_cliente = p.id_cliente;