defmodule Desafio2.Repo do
  use Ecto.Repo,
    otp_app: :desafio2,
    adapter: Mongo.Ecto
end
