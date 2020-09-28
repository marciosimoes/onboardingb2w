defmodule Desafio2.MyApp.ElasticSearch do
  alias Tirexs.HTTP, as: Api

  def post(index, type, conn, map \\ %{}) do
    map = Map.delete(map, :__meta__)
    make_uri_for(index,type)
    |> Api.post(add_default_event_header(conn, map))
  end

  defp make_uri_for(index, type), do: "/#{index}/#{type}/"

  defp add_default_event_header(conn, map) do
    map
    |> IO.inspect()
    |> Map.put(:'@timestamp' , to_string(NaiveDateTime.utc_now))
    |> Map.put(:client_ip, convert_tuple_to_string(conn.remote_ip))
    |> Map.put(:http_verb, conn.method)
    |> Map.put(:request_path, conn.request_path)
  end

  defp convert_tuple_to_string(tuple) do
    tuple
    |> Tuple.to_list()
    |> Enum.join(".")
  end
end
