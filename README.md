# Sistema de Registro de Vendas em Python

Projeto desenvolvido para praticar lógica de programação e criar uma aplicação simples de registro de vendas.

## Funcionalidades

- Cadastro de produtos
- Controle de estoque
- Listagem de produtos
- Registro de vendas
- Cálculo automático de descontos
- Validação de estoque
- Relatório de vendas
- Cálculo de faturamento total
- Persistência dos dados em arquivo JSON

## Regras de desconto

- Compras a partir de R$ 200: 5% de desconto
- Compras a partir de R$ 500: 10% de desconto
- Abaixo de R$ 200: sem desconto

## Tecnologias

- Python 3
- JSON
- Estruturas condicionais
- Funções
- Listas e dicionários
- Manipulação de arquivos
- Tratamento de exceções

## Como executar

1. Instale o Python 3.
2. Abra o terminal na pasta do projeto.
3. Execute:

```bash
python main.py
```

O arquivo `dados_vendas.json` será criado automaticamente após o primeiro cadastro ou venda.

## Objetivo

Projeto acadêmico para demonstrar conhecimentos iniciais em Python, lógica de programação, manipulação de dados e desenvolvimento de aplicações de linha de comando.


## Módulo MySQL

O projeto também possui um módulo de banco de dados MySQL preparado para uma futura evolução da aplicação:

- Modelagem de categorias, produtos, clientes, vendas e itens de venda
- Chaves primárias e estrangeiras
- Índices e constraints
- Consultas com JOIN e agregações
- View para resumo de vendas
- Dados de teste

Arquivos em `database/mysql/`:

- `01_schema.sql`
- `02_seed.sql`
- `03_queries.sql`
- `README.md`

Esse módulo pode futuramente ser integrado ao Python e servir como base para uma API/backend.
