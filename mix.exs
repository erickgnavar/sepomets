defmodule Sepomets.MixProject do
  use Mix.Project

  def project do
    [
      app: :sepomets,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      elixirc_options: [warnings_as_errors: true]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Sepomets.App, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:excoveralls, "~> 0.10.6", only: :test},
      {:mojito, "~> 0.6.1"},
      {:briefly, "~> 0.3.0"}
    ]
  end
end
