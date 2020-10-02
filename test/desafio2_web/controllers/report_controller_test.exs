defmodule Desafio2Web.ReportControllerTest do
  use Desafio2Web.ConnCase

  alias Desafio2.MyApp

  test "report dos produtos", %{conn: conn} do
    conn = get(conn, "/report")
    assert conn.status == 200
    assert get_resp_header(conn, "content-type") == ["text/csv; charset=utf-8"]
  end
end
