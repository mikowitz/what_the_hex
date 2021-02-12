defmodule WhatTheHexWeb.PageView do
  use WhatTheHexWeb, :view

  alias WhatTheHexWeb.Endpoint

  def render("show.json", %{data: data}) do
    data
  end

  def link_for_package(package) do
    url = Endpoint.url() <> "/" <> package
    [_, path] = String.split(url, "//")

    {path, url}
  end
end
