defmodule WhatTheHexWeb.PageView do
  use WhatTheHexWeb, :view

  def render("show.json", %{data: data}) do
    data
  end
end
