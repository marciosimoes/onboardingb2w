defmodule Desafio2Web.ReportController do
  use Desafio2Web, :controller

  alias Desafio2.MyApp

  def all(conn, _params) do
    files = Path.wildcard("assets/static/images/reports/*.csv")
    |> Enum.map(&Path.basename/1)

    render(conn, "index.html", files: files)
  end

  def create(conn, _params) do
    name = "images/reports/produtos_#{ to_string(NaiveDateTime.utc_now)}.csv"
    file = File.open!("assets/static/#{name}", [:write, :utf8])

    MyApp.csv_content
    |> CSV.encode
    |> Enum.each(&IO.write(file, &1))

    render(conn, "export.html", name: name)
  end
end
