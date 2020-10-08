defmodule Desafio2Web.ReportController do
  use Desafio2Web, :controller

  alias Desafio2.MyApp
  alias Desafio2.HttpService

  def all(conn, _params) do
    files = Path.wildcard("assets/static/images/reports/*.csv")
    |> Enum.map(&Path.basename/1)

    render(conn, "index.html", files: files)
  end

  def create(conn, _params) do
    name = "produtos_#{ to_string(NaiveDateTime.utc_now)}.csv"
    file_path = "assets/static/images/reports/#{name}"
    file = File.open!(file_path, [:write, :utf8])

    MyApp.csv_content
    |> CSV.encode
    |> Enum.each(&IO.write(file, &1))

    HttpService.send_email(name, file_path)

    render(conn, "export.html", name: name)
  end
end
