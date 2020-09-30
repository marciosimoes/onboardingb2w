defmodule Desafio2.MyApp.Produto do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:id, :sku, :nome, :descricao, :quantidade, :preco, :barras]}
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "produtos" do
    field :descricao, :string
    field :nome, :string
    field :preco, :float
    field :quantidade, :integer
    field :sku, :string
    field :barras, :string

    timestamps()
  end

  @doc false
  def changeset(produto, attrs) do
    produto
    |> cast(attrs, [:sku, :nome, :descricao, :quantidade, :preco, :barras])
    |> validate_format(:sku, ~r/\A[a-zA-Z0-9'-]*\z/, message: "apenas alphanumerico ou hifen")
    |> validate_required([:nome])
    |> validate_number(:preco, greater_than: 0)
    |> validate_length(:barras, min: 8)
    |> validate_length(:barras, max: 13)
  end

  def from_json(json) do
    Poison.decode!(json, as: %Desafio2.MyApp.Produto{})
  end
end
