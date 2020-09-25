defmodule Desafio2.MyApp.Produto do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:id, :sku, :nome, :descricao, :quantidade, :preco]}
  @primary_key {:id, :binary_id, autogenerate: true}
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

  def from_json(json) do
    Poison.decode!(json, as: %Desafio2.MyApp.Produto{})
  end
end
