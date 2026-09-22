# Banco de Dados MySQL — Sistema de Vendas

Módulo de banco de dados do **Sistema de Registro de Vendas em Python**.

A ideia é evoluir o projeto de uma aplicação simples com persistência em JSON para uma arquitetura maior, na qual o MySQL possa ser utilizado por uma futura API/backend.

## Estrutura

- `01_schema.sql` — criação do banco, tabelas, relacionamentos, constraints e índices.
- `02_seed.sql` — dados iniciais para testes.
- `03_queries.sql` — consultas com JOIN, agregações, filtros e uma VIEW.

## Modelo

O banco possui:

`categorias` → organiza os produtos.

`produtos` → armazena preço, estoque e categoria.

`clientes` → cadastro dos clientes.

`vendas` → registra cada venda e seus valores.

`itens_venda` → relaciona produtos e vendas, permitindo vários produtos na mesma venda.

## Conceitos demonstrados

- MySQL
- CREATE DATABASE / CREATE TABLE
- Primary Key e Foreign Key
- Relacionamentos
- INNER JOIN e LEFT JOIN
- WHERE e ORDER BY
- GROUP BY e funções de agregação
- VIEW
- INDEX
- ENUM
- DECIMAL para valores monetários
- Constraints de validação

## Como executar

No MySQL Workbench ou em um cliente MySQL:

1. Execute `01_schema.sql`.
2. Execute `02_seed.sql`.
3. Execute `03_queries.sql`.

## Próxima evolução

Este módulo pode futuramente ser conectado ao projeto Python por meio de uma camada de acesso a dados e, depois, transformado em uma API REST com autenticação, controle de estoque e dashboard.

> Projeto acadêmico/portfólio desenvolvido para demonstrar conhecimentos de banco de dados e SQL.
