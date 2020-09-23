defmodule Desafio2.Repo.Migrations.CreateProdutos do
  use Ecto.Migration

  def change do
    create table(:produtos) do
      add :sku, :integer
      add :nome, :string
      add :descricao, :string
      add :quantidade, :integer
      add :preco, :float

      timestamps()
    end

  end
end
