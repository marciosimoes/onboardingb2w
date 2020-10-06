defmodule Desafio2Web.ReportControllerTest do
  use Desafio2Web.ConnCase

  alias Desafio2.MyApp

  test "report dos produtos", %{conn: conn} do
    conn = get(conn, "/reports/all")
    assert conn.status == 200
  end
end
