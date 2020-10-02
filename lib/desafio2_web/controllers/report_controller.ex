defmodule Desafio2Web.ReportController do
  use Desafio2Web, :controller

  alias Desafio2.MyApp

  def export(conn, _params) do
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"report.csv\"")
    |> send_resp(200, MyApp.csv_content)
  end
end
