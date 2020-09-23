defmodule Desafio2Web.PageController do
  use Desafio2Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
