defmodule Desafio2.MyApp.Produto do
  use Ecto.Schema
  import Ecto.Changeset

  schema "produtos" do
    field :descricao, :string
    field :nome, :string
    field :preco, :float
    field :quantidade, :integer
    field :sku, :integer

    timestamps()
  end

  @doc false
  def changeset(produto, attrs) do
    produto
    |> cast(attrs, [:sku, :nome, :descricao, :quantidade, :preco])
    |> validate_required([:sku, :nome, :descricao, :quantidade, :preco])
  end
end
