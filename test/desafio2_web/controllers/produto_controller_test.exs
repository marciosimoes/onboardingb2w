defmodule Desafio2Web.ProdutoControllerTest do
  use Desafio2Web.ConnCase

  alias Desafio2.MyApp

  @create_attrs %{descricao: "some descricao", nome: "some nome", preco: 120.5, quantidade: 42, sku: 42}
  @update_attrs %{descricao: "some updated descricao", nome: "some updated nome", preco: 456.7, quantidade: 43, sku: 43}
  @invalid_attrs %{descricao: nil, nome: nil, preco: nil, quantidade: nil, sku: nil}

  def fixture(:produto) do
    {:ok, produto} = MyApp.create_produto(@create_attrs)
    produto
  end

  describe "index" do
    test "lists all produtos", %{conn: conn} do
      conn = get(conn, Routes.produto_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Produtos"
    end
  end

  describe "new produto" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.produto_path(conn, :new))
      assert html_response(conn, 200) =~ "New Produto"
    end
  end

  describe "create produto" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.produto_path(conn, :create), produto: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.produto_path(conn, :show, id)

      conn = get(conn, Routes.produto_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Produto"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.produto_path(conn, :create), produto: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Produto"
    end
  end

  describe "edit produto" do
    setup [:create_produto]

    test "renders form for editing chosen produto", %{conn: conn, produto: produto} do
      conn = get(conn, Routes.produto_path(conn, :edit, produto))
      assert html_response(conn, 200) =~ "Edit Produto"
    end
  end

  describe "update produto" do
    setup [:create_produto]

    test "redirects when data is valid", %{conn: conn, produto: produto} do
      conn = put(conn, Routes.produto_path(conn, :update, produto), produto: @update_attrs)
      assert redirected_to(conn) == Routes.produto_path(conn, :show, produto)

      conn = get(conn, Routes.produto_path(conn, :show, produto))
      assert html_response(conn, 200) =~ "some updated descricao"
    end

    test "renders errors when data is invalid", %{conn: conn, produto: produto} do
      conn = put(conn, Routes.produto_path(conn, :update, produto), produto: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Produto"
    end
  end

  describe "delete produto" do
    setup [:create_produto]

    test "deletes chosen produto", %{conn: conn, produto: produto} do
      conn = delete(conn, Routes.produto_path(conn, :delete, produto))
      assert redirected_to(conn) == Routes.produto_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.produto_path(conn, :show, produto))
      end
    end
  end

  defp create_produto(_) do
    produto = fixture(:produto)
    %{produto: produto}
  end
end
