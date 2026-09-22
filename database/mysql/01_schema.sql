-- Sistema de Registro de Vendas
-- Banco de dados MySQL
-- Estrutura preparada para futura integração com uma API/backend.

CREATE DATABASE IF NOT EXISTS sistema_vendas;
USE sistema_vendas;

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE,
    telefone VARCHAR(20),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT,
    nome VARCHAR(150) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL DEFAULT 0,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_produto_categoria
        FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    CONSTRAINT chk_produto_preco CHECK (preco >= 0),
    CONSTRAINT chk_produto_estoque CHECK (estoque >= 0)
);

CREATE TABLE vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    subtotal DECIMAL(10,2) NOT NULL DEFAULT 0,
    desconto DECIMAL(10,2) NOT NULL DEFAULT 0,
    total DECIMAL(10,2) NOT NULL DEFAULT 0,
    status ENUM('ABERTA', 'FINALIZADA', 'CANCELADA') NOT NULL DEFAULT 'FINALIZADA',
    CONSTRAINT fk_venda_cliente
        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT chk_venda_valores CHECK (
        subtotal >= 0 AND desconto >= 0 AND total >= 0
    )
);

CREATE TABLE itens_venda (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_item_venda
        FOREIGN KEY (id_venda) REFERENCES vendas(id_venda)
        ON DELETE CASCADE,
    CONSTRAINT fk_item_produto
        FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    CONSTRAINT chk_item_quantidade CHECK (quantidade > 0),
    CONSTRAINT chk_item_preco CHECK (preco_unitario >= 0)
);

CREATE INDEX idx_produtos_categoria ON produtos(id_categoria);
CREATE INDEX idx_vendas_cliente ON vendas(id_cliente);
CREATE INDEX idx_vendas_data ON vendas(data_venda);
CREATE INDEX idx_itens_venda ON itens_venda(id_venda);
