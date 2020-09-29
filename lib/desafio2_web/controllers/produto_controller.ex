defmodule Desafio2Web.ProdutoController do
  use Desafio2Web, :controller

  alias Desafio2.MyApp
  alias Desafio2.MyApp.ElasticSearch
  alias Desafio2.MyApp.Produto

  def index(conn, _params) do
    produtos = MyApp.list_produtos()
    render(conn, "index.html", produtos: produtos)
  end

  def new(conn, _params) do
    changeset = MyApp.change_produto(%Produto{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"produto" => produto_params}) do
    case MyApp.create_produto(produto_params) do
      {:ok, produto} ->
        ElasticSearch.post(:produtos, :new, conn, produto_params)
        conn
        |> put_flash(:info, "Produto created successfully.")
        |> redirect(to: Routes.produto_path(conn, :show, produto))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    produto = MyApp.get_produto!(id)
    render(conn, "show.html", produto: produto)
  end

  def search(conn, %{"nome" => nome}) do
    produtos = ElasticSearch.get(:produtos, :new, "nome", nome)
    render(conn, "search.html", produtos: produtos)
  end

  def edit(conn, %{"id" => id}) do
    produto = MyApp.get_produto!(id)
    changeset = MyApp.change_produto(produto)
    render(conn, "edit.html", produto: produto, changeset: changeset)
  end

  def update(conn, %{"id" => id, "produto" => produto_params}) do
    produto = MyApp.get_produto!(id)

    case MyApp.update_produto(produto, produto_params) do
      {:ok, produto} ->
        ElasticSearch.post(:produtos, :update, conn, produto_params)
        conn
        |> put_flash(:info, "Produto updated successfully.")
        |> redirect(to: Routes.produto_path(conn, :show, produto))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", produto: produto, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}  = idDel) do
    produto = MyApp.get_produto!(id)
    {:ok, _produto} = MyApp.delete_produto(produto)

    ElasticSearch.post(:produtos, :destroy, conn, idDel)
    conn
    |> put_flash(:info, "Produto deleted successfully.")
    |> redirect(to: Routes.produto_path(conn, :index))
  end
end
