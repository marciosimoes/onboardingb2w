defmodule Desafio2Web.Router do
  use Desafio2Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Desafio2Web do
    pipe_through :browser

    get "/", PageController, :index
    resources "/produtos", ProdutoController
    # update
    post "/produtos/:id", ProdutoController, :update
    patch "/produtos/:id", ProdutoController, :update
    # search
    get "/produtos/search/:nome", ProdutoController, :search
    # report
    get "/reports", ReportController, :all
    get "/reports/create", ReportController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", Desafio2Web do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: Desafio2Web.Telemetry
    end
  end
end
