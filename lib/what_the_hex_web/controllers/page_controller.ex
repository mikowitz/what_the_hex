defmodule WhatTheHexWeb.PageController do
  use WhatTheHexWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"package" => package}) do
    case HTTPoison.get("https://hex.pm/api/packages/#{package}") do
      {:ok, %{status_code: 200, body: body}} ->
        data = Poison.decode!(body)
        redirect(conn, external: find_link(data))
      {:ok, %{status_code: 404}} ->
        conn
        |> put_flash(:error, "Could not find published Hex package #{package}")
        |> render("index.html")
    end
  end

  defp find_link(data) do
    links = data["meta"]["links"]

    case github_link(links) do
      {_, link} -> link
      nil ->
        case hexdocs_link(links) do
          {_, link} -> link
          nil -> data["url"]
        end
    end
  end

  defp github_link(links) do
    Enum.find(links, fn {k, v} -> String.downcase(k) == "github" end)
  end

  defp hexdocs_link(links) do
    Enum.find(links, fn {k, v} -> Regex.match?(~r/hexdocs/i, v) end)
  end
end
