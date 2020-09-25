defmodule Desafio2.MyApp.Redis do
  alias Exredis.Api
  alias Poison

  def get(key) do
    case Api.get(key) do
      :undefined -> {:error}
      value -> {:ok, value}
    end
  end

  def set(%{id: key} = struct) do
    set(key,struct)
  end

  def set(key,value) do
    Api.set(key, Poison.encode!(value))
  end

  def del(%{id: key}) do
    del(key)
  end

  def del(key) do
    Api.del(key)
  end
end
