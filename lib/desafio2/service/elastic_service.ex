defmodule Desafio2.ElasticService do
  alias Tirexs.HTTP, as: Api
  import Tirexs.Search

  def post(index, type, conn, map \\ %{}) do
    map = Map.delete(map, :__meta__)
    make_uri_for_post(index,type)
    |> Api.post(add_default_event_header(conn, map))
  end

  def get(index, type, field, key) do
    query = search [index: index, type: type] do
      query do
        match "nome", key
      end
    end
    {:ok, _status_code, resultado} = Tirexs.Query.create_resource(query)
    resultado[:hits][:hits]
  end

  defp make_uri_for_post(index, type), do: "/#{index}/#{type}/"

  defp convert_tuple_to_string(tuple) do
    tuple
    |> Tuple.to_list()
    |> Enum.join(".")
  end

  defp add_default_event_header(conn, map) do
    map
    |> IO.inspect()
    |> Map.put(:'@timestamp' , to_string(NaiveDateTime.utc_now))
    |> Map.put(:client_ip, convert_tuple_to_string(conn.remote_ip))
    |> Map.put(:http_verb, conn.method)
    |> Map.put(:request_path, conn.request_path)
  end
end
