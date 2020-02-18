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

  @doc """
  Carga un archivo de Sepomex
  """
  @spec load(String.t()) :: :ok | :file_not_found | {:error, String.t()}
  def load(file_path) do
    GenServer.cast(__MODULE__, {:load, file_path})
  end

  @doc """
  Carga un archivo de Sepomex desde una URL
  """
  @spec load(String.t()) :: :ok | :file_not_found | {:error, String.t()}
  def load_from_url(url) do
    url
    |> Mojito.get()
    |> case do
      {:ok, %Mojito.Response{status_code: 200, body: body}} ->
        path = Briefly.create!()
        File.write!(path, body)
        path

      _ ->
        nil
    end
    |> load()
  end

  def start_link(env) do
    GenServer.start_link(__MODULE__, env, name: __MODULE__)
  end

  ## Server

  @impl true
  def init(:test) do
    table = create_table()
    Mock.load(table)
    {:ok, table}
  end

  def init(_) do
    table = create_table()

    file_path = Application.get_env(:sepomets, :file)

    load(table, file_path)
  end

  @impl true
  def handle_cast({:load, file_path}, state) do
    load(@table, file_path)

    {:noreply, state}
  end

  ## Helpers

  defp load(table, file_path) do
    case Loader.load_file(table, file_path) do
      {:error, error} ->
        {:error, error}

      :file_not_found ->
        {:ok, :not_loaded}

      _ ->
        {:ok, :ok}
    end
  end

  # Crea la tabla ETS
  @spec create_table() :: atom()
  defp create_table() do
    :ets.new(@table, [:named_table, :bag, read_concurrency: true])
  end
end
