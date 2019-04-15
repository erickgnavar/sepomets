defmodule Sepomets.App do
  @moduledoc false

  use Application

  @env Mix.env()

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Sepomets.Db, [@env])
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
