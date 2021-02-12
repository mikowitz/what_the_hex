defmodule WhatTheHex.Repo do
  use Ecto.Repo,
    otp_app: :what_the_hex,
    adapter: Ecto.Adapters.Postgres
end
