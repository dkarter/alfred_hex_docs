Mix.install([:jason, :req])

query = System.argv() |> List.first()

[
  url: "https://hex.pm/api/packages",
  params: %{
    sort: "downloads",
    search: query
  }
]
|> Req.new()
|> Req.request!()
|> Map.fetch!(:body)
|> Enum.map(fn result ->
  %{
    title: result["name"],
    subtitle: get_in(result, ["meta", "description"]),
    arg: result["docs_html_url"],
    variables: %{
      package_url: result["html_url"]
    },
    quicklookurl: result["docs_html_url"]
  }
end)
|> then(&%{items: &1})
|> Jason.encode!()
|> IO.puts()
