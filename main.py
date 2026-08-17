from datetime import datetime
from pathlib import Path
import json

ARQUIVO_DADOS = Path("dados_vendas.json")


def carregar_dados():
    if ARQUIVO_DADOS.exists():
        with open(ARQUIVO_DADOS, "r", encoding="utf-8") as arquivo:
            return json.load(arquivo)
    return {"produtos": [], "vendas": []}


def salvar_dados(dados):
    with open(ARQUIVO_DADOS, "w", encoding="utf-8") as arquivo:
        json.dump(dados, arquivo, ensure_ascii=False, indent=4)


def gerar_id(itens):
    return max((item["id"] for item in itens), default=0) + 1


def cadastrar_produto(dados):
    print("\n--- CADASTRO DE PRODUTO ---")
    nome = input("Nome do produto: ").strip()

    if not nome:
        print("Nome inválido.")
        return

    try:
        preco = float(input("Preço: R$ ").replace(",", "."))
        estoque = int(input("Quantidade em estoque: "))
        if preco <= 0 or estoque < 0:
            raise ValueError
    except ValueError:
        print("Informe valores numéricos válidos.")
        return

    produto = {
        "id": gerar_id(dados["produtos"]),
        "nome": nome,
        "preco": preco,
        "estoque": estoque
    }

    dados["produtos"].append(produto)
    salvar_dados(dados)
    print(f"Produto '{nome}' cadastrado com sucesso!")


def listar_produtos(dados):
    print("\n--- PRODUTOS ---")

    if not dados["produtos"]:
        print("Nenhum produto cadastrado.")
        return

    for produto in dados["produtos"]:
        print(
            f'ID: {produto["id"]} | '
            f'{produto["nome"]} | '
            f'R$ {produto["preco"]:.2f} | '
            f'Estoque: {produto["estoque"]}'
        )


def calcular_desconto(valor):
    if valor >= 500:
        return 0.10
    if valor >= 200:
        return 0.05
    return 0.0


def registrar_venda(dados):
    print("\n--- REGISTRO DE VENDA ---")

    if not dados["produtos"]:
        print("Cadastre pelo menos um produto antes de realizar uma venda.")
        return

    listar_produtos(dados)

    try:
        produto_id = int(input("\nID do produto: "))
        quantidade = int(input("Quantidade: "))
    except ValueError:
        print("Informe valores válidos.")
        return

    produto = next(
        (p for p in dados["produtos"] if p["id"] == produto_id),
        None
    )

    if produto is None:
        print("Produto não encontrado.")
        return

    if quantidade <= 0:
        print("A quantidade deve ser maior que zero.")
        return

    if quantidade > produto["estoque"]:
        print("Estoque insuficiente.")
        return

    subtotal = produto["preco"] * quantidade
    percentual_desconto = calcular_desconto(subtotal)
    desconto = subtotal * percentual_desconto
    total = subtotal - desconto

    produto["estoque"] -= quantidade

    venda = {
        "id": gerar_id(dados["vendas"]),
        "data": datetime.now().strftime("%d/%m/%Y %H:%M"),
        "produto": produto["nome"],
        "quantidade": quantidade,
        "subtotal": round(subtotal, 2),
        "desconto": round(desconto, 2),
        "total": round(total, 2)
    }

    dados["vendas"].append(venda)
    salvar_dados(dados)

    print("\nVenda registrada com sucesso!")
    print(f"Subtotal: R$ {subtotal:.2f}")
    print(f"Desconto: {percentual_desconto * 100:.0f}%")
    print(f"Total: R$ {total:.2f}")


def relatorio_vendas(dados):
    print("\n--- RELATÓRIO DE VENDAS ---")

    if not dados["vendas"]:
        print("Nenhuma venda registrada.")
        return

    faturamento = sum(venda["total"] for venda in dados["vendas"])
    descontos = sum(venda["desconto"] for venda in dados["vendas"])
    quantidade_itens = sum(venda["quantidade"] for venda in dados["vendas"])

    for venda in dados["vendas"]:
        print(
            f'#{venda["id"]} | {venda["data"]} | '
            f'{venda["produto"]} | Qtd: {venda["quantidade"]} | '
            f'Total: R$ {venda["total"]:.2f}'
        )

    print("\n--- RESUMO ---")
    print(f"Vendas realizadas: {len(dados['vendas'])}")
    print(f"Itens vendidos: {quantidade_itens}")
    print(f"Descontos concedidos: R$ {descontos:.2f}")
    print(f"Faturamento: R$ {faturamento:.2f}")


def menu():
    dados = carregar_dados()

    while True:
        print("\n" + "=" * 45)
        print("       SISTEMA DE REGISTRO DE VENDAS")
        print("=" * 45)
        print("1 - Cadastrar produto")
        print("2 - Listar produtos")
        print("3 - Registrar venda")
        print("4 - Relatório de vendas")
        print("0 - Sair")

        opcao = input("\nEscolha uma opção: ").strip()

        if opcao == "1":
            cadastrar_produto(dados)
        elif opcao == "2":
            listar_produtos(dados)
        elif opcao == "3":
            registrar_venda(dados)
        elif opcao == "4":
            relatorio_vendas(dados)
        elif opcao == "0":
            print("Sistema encerrado.")
            break
        else:
            print("Opção inválida.")


if __name__ == "__main__":
    menu()
