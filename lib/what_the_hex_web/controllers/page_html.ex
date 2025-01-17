defmodule WhatTheHexWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use WhatTheHexWeb, :html
  alias WhatTheHexWeb.Endpoint

  embed_templates "page_html/*"

  def link_for_package(package) do
    url = Endpoint.url() <> "/" <> package
    [_, path] = String.split(url, "//")

    {path, url}
  end
end
