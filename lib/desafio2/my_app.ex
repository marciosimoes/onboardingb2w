defmodule Desafio2.MyApp do
  @moduledoc """
  The MyApp context.
  """

  import Ecto.Query, warn: false
  alias Desafio2.Repo
  alias Desafio2.RedisService

  alias Desafio2.MyApp.Produto

  @doc """
  Returns the list of produtos.

  ## Examples

      iex> list_produtos()
      [%Produto{}, ...]

  """
  def list_produtos do
    Repo.all(Produto)
  end

  @doc """
  Gets a single produto.

  Raises `Ecto.NoResultsError` if the Produto does not exist.

  ## Examples

      iex> get_produto!(123)
      %Produto{}

      iex> get_produto!(456)
      ** (Ecto.NoResultsError)

  """

  def get_produto!(id) do
    with {:error} <- RedisService.get(id),
      %Produto{} = produto <- Repo.get!(Produto, id) do
        RedisService.set(produto)
        produto
      else
        {:ok, json} ->
          Produto.from_json(json)
        _ ->
          {:error, :not_found}
    end
  end

  @doc """
  Creates a produto.

  ## Examples

      iex> create_produto(%{field: value})
      {:ok, %Produto{}}

      iex> create_produto(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_produto(attrs \\ %{}) do
    %Produto{}
    |> Produto.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a produto.

  ## Examples

      iex> update_produto(produto, %{field: new_value})
      {:ok, %Produto{}}

      iex> update_produto(produto, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_produto(%Produto{} = produto, attrs) do
    RedisService.del(produto)
    produto
    |> Produto.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a produto.

  ## Examples

      iex> delete_produto(produto)
      {:ok, %Produto{}}

      iex> delete_produto(produto)
      {:error, %Ecto.Changeset{}}

  """
  def delete_produto(%Produto{} = produto) do
    RedisService.del(produto)
    Repo.delete(produto)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking produto changes.

  ## Examples

      iex> change_produto(produto)
      %Ecto.Changeset{data: %Produto{}}

  """
  def change_produto(%Produto{} = produto, attrs \\ %{}) do
    Produto.changeset(produto, attrs)
  end

  ## Gerador do conteudo do CSV de reporte
  def csv_content do
    list_produtos = list_produtos()
    produtos = for produto <- list_produtos do
      [produto.sku, produto.nome, produto.descricao, produto.quantidade, produto.preco, produto.barras]
    end
    [["sku","nome","descricao","quantidade","preco","codigo de barras"] | produtos]
  end
end
