USE sistema_vendas;

-- 1. Produtos com suas categorias
SELECT
    p.id_produto,
    p.nome AS produto,
    c.nome AS categoria,
    p.preco,
    p.estoque
FROM produtos p
INNER JOIN categorias c
    ON p.id_categoria = c.id_categoria
ORDER BY p.nome;

-- 2. Histórico de vendas com cliente
SELECT
    v.id_venda,
    c.nome AS cliente,
    v.data_venda,
    v.subtotal,
    v.desconto,
    v.total,
    v.status
FROM vendas v
LEFT JOIN clientes c
    ON v.id_cliente = c.id_cliente
ORDER BY v.data_venda DESC;

-- 3. Itens de cada venda
SELECT
    v.id_venda,
    p.nome AS produto,
    iv.quantidade,
    iv.preco_unitario,
    iv.subtotal
FROM itens_venda iv
INNER JOIN vendas v
    ON iv.id_venda = v.id_venda
INNER JOIN produtos p
    ON iv.id_produto = p.id_produto
ORDER BY v.id_venda, p.nome;

-- 4. Faturamento total de vendas finalizadas
SELECT
    SUM(total) AS faturamento_total
FROM vendas
WHERE status = 'FINALIZADA';

-- 5. Produtos com estoque baixo
SELECT
    id_produto,
    nome,
    estoque
FROM produtos
WHERE estoque <= 10
ORDER BY estoque ASC;

-- 6. Total vendido por produto
SELECT
    p.nome AS produto,
    SUM(iv.quantidade) AS unidades_vendidas,
    SUM(iv.subtotal) AS valor_vendido
FROM itens_venda iv
INNER JOIN produtos p
    ON iv.id_produto = p.id_produto
INNER JOIN vendas v
    ON iv.id_venda = v.id_venda
WHERE v.status = 'FINALIZADA'
GROUP BY p.id_produto, p.nome
ORDER BY valor_vendido DESC;

-- 7. View para facilitar consultas de vendas
CREATE OR REPLACE VIEW vw_resumo_vendas AS
SELECT
    v.id_venda,
    c.nome AS cliente,
    v.data_venda,
    v.subtotal,
    v.desconto,
    v.total,
    v.status
FROM vendas v
LEFT JOIN clientes c
    ON v.id_cliente = c.id_cliente;
