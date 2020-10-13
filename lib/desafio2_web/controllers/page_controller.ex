defmodule Desafio2Web.PageController do
  use Desafio2Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def sentry_check(_conn, _params) do
    raise "Hello world"
  end
end
