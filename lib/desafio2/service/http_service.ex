defmodule Desafio2.HttpService do
  alias HTTPoison

  def send_email(name, file_path) do
    HTTPoison.post("localhost:4500/send_email", {:multipart, [
      {:file, file_path, {"form-data", [
        {"name", "arquivo"}, {"filename", "produtos.csv"}]}, []}
      ]}
    )
  end
end
