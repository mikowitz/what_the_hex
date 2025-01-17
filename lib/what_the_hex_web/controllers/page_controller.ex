defmodule WhatTheHexWeb.PageController do
  use WhatTheHexWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
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

    case data["docs_html_url"] do
      nil ->
        case github_link(links) do
          {_, link} -> link
          nil -> 
            case data["html_url"] do
              nil -> data["url"]
              link when is_bitstring(link) -> link
            end
        end
      link when is_bitstring(link) -> link
    end
  end

  defp github_link(links) do
    Enum.find(links, fn {k, _v} -> String.downcase(k) == "github" end)
  end
end
