defmodule Desafio2.MyAppTest do
  use Desafio2.DataCase

  alias Desafio2.MyApp

  describe "produtos" do
    alias Desafio2.MyApp.Produto

    @valid_attrs %{descricao: "some descricao", nome: "some nome", preco: 120.5, quantidade: 42, sku: "ABC-1", barras: "0481321751"}
    @update_attrs %{descricao: "some updated descricao", nome: "some updated nome", preco: 456.7, quantidade: 43, sku: "ABC-1", barras: "0481321751"}
    @invalid_attrs %{descricao: nil, nome: nil, preco: nil, quantidade: nil, sku: nil, barras: nil}

    def produto_fixture(attrs \\ %{}) do
      {:ok, produto} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MyApp.create_produto()
      produto
    end

    test "list_produtos/0 returns all produtos" do
      produto = produto_fixture()
      assert MyApp.list_produtos() == [produto]
    end

    test "get_produto!/1 returns the produto with given id" do
      produto = produto_fixture()
      assert MyApp.get_produto!(produto.id).id == produto.id
    end

    test "create_produto/1 with valid data creates a produto" do
      assert {:ok, %Produto{} = produto} = MyApp.create_produto(@valid_attrs)
      assert produto.descricao == "some descricao"
      assert produto.nome == "some nome"
      assert produto.preco == 120.5
      assert produto.quantidade == 42
      assert produto.sku == "ABC-1"
      assert produto.barras == "0481321751"
    end

    test "create_produto/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MyApp.create_produto(@invalid_attrs)
    end

    test "update_produto/2 with valid data updates the produto" do
      produto = produto_fixture()
      assert {:ok, %Produto{} = produto} = MyApp.update_produto(produto, @update_attrs)
      assert produto.descricao == "some updated descricao"
      assert produto.nome == "some updated nome"
      assert produto.preco == 456.7
      assert produto.quantidade == 43
      assert produto.sku == "ABC-1"
      assert produto.barras == "0481321751"
    end

    test "update_produto/2 with invalid data returns error changeset" do
      produto = produto_fixture()
      assert {:error, %Ecto.Changeset{}} = MyApp.update_produto(produto, @invalid_attrs)
      assert produto.id == MyApp.get_produto!(produto.id).id
    end

    test "delete_produto/1 deletes the produto" do
      produto = produto_fixture()
      assert {:ok, %Produto{}} = MyApp.delete_produto(produto)
      assert_raise Ecto.NoResultsError, fn -> MyApp.get_produto!(produto.id) end
    end

    test "change_produto/1 returns a produto changeset" do
      produto = produto_fixture()
      assert %Ecto.Changeset{} = MyApp.change_produto(produto)
    end

    test "erro ao tentar criar relatorio vazio" do
      assert {:error, "não pode gerar relatorio vazio."} == MyApp.csv_content([])
    end
  end
end
