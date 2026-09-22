USE sistema_vendas;

INSERT INTO categorias (nome) VALUES
('Bebidas'),
('Mercearia'),
('Higiene');

INSERT INTO clientes (nome, email, telefone) VALUES
('João Silva', 'joao@email.com', '11999990001'),
('Ana Souza', 'ana@email.com', '11999990002'),
('Carlos Oliveira', 'carlos@email.com', '11999990003');

INSERT INTO produtos (id_categoria, nome, preco, estoque) VALUES
(1, 'Refrigerante 2L', 9.90, 50),
(1, 'Suco de Laranja 1L', 7.50, 30),
(2, 'Arroz 5kg', 28.90, 20),
(2, 'Feijão 1kg', 8.90, 40),
(3, 'Sabonete', 3.50, 100);

INSERT INTO vendas (id_cliente, subtotal, desconto, total, status) VALUES
(1, 57.70, 0.00, 57.70, 'FINALIZADA'),
(2, 214.50, 10.73, 203.77, 'FINALIZADA');

INSERT INTO itens_venda
(id_venda, id_produto, quantidade, preco_unitario, subtotal) VALUES
(1, 1, 2, 9.90, 19.80),
(1, 3, 1, 28.90, 28.90),
(1, 5, 2, 3.50, 7.00),
(1, 4, 1, 8.90, 8.90),
(2, 3, 5, 28.90, 144.50),
(2, 4, 5, 8.90, 44.50),
(2, 5, 5, 3.50, 17.50),
(2, 2, 1, 7.50, 7.50);
