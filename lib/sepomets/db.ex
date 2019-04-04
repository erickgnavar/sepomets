defmodule Sepomets.Db do
  use GenServer

  alias Sepomets.Loader
  alias Sepomets.PostalCodeData
  alias Sepomets.Mock

  @table :sepomex

  ## Client

  @doc """
  Obtiene todos los registros con el Código Postal dado
  """
  @spec get(String.t()) :: [PostalCodeData.t()]
  def get(postal_code) do
    case :ets.lookup(@table, postal_code) do
      [_ | _] = response ->
        Enum.map(response, fn {_, data} -> data end)

      _ ->
        []
    end
  end

  def start_link(env) do
    GenServer.start_link(__MODULE__, env)
  end

  ## Server

  @impl true
  def init(:test) do
    table = create_table()
    Mock.load(table)
    {:ok, table}
  end

  def init(_) do
    {:ok, {:not_loaded, create_table()}, {:continue, :load_file}}
  end

  @impl true
  def handle_continue(:load_file, {_, table}) do
    Loader.load_file(table)
    {:noreply, {:ok, table}}
  end

  ## Helpers

  # Crea la tabla ETS
  @spec create_table() :: atom()
  defp create_table() do
    :ets.new(@table, [:named_table, :bag, read_concurrency: true])
  end
end
