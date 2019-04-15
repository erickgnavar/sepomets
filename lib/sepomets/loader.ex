defmodule Sepomets.Loader do
  alias Sepomets.PostalCodeData

  require Logger

  @defaut_file_path "files/sepomex.zip"

  @doc """
  Carga la información de Sepomex a la tabla ETS desde un archivo
  """
  @spec load_file(atom()) :: :ok
  def load_file(table) do
    Logger.debug(fn -> "Start loading Sepomex data" end)

    file_path = Application.get_env(:sepomets, :file, @defaut_file_path)

    case extract_file(file_path) do
      {:ok, file_path} ->
        load_file_data(table, file_path)
        Logger.debug(fn -> "Finish loading Sepomex data" end)
        File.rm!(file_path)

      _ ->
        Logger.error("Sepomex data file not found")
    end
  end

  # Carga la información del archivo de Sepomex a la tabla ETS
  @spec load_file_data(atom(), String.t()) :: :ok
  defp load_file_data(table, file_path) do
    file_path
    |> File.stream!([{:encoding, :latin1}])
    |> Stream.map(&String.trim/1)
    |> Stream.drop(2)
    |> Stream.each(fn data ->
      insert_postal_code_data(table, data)
    end)
    |> Stream.run()
  end

  # Parsea e inserta la línea del archivo de Sepomex
  @spec insert_postal_code_data(atom(), String.t()) :: boolean
  defp insert_postal_code_data(table, data) do
    postal_code_data = PostalCodeData.parse(data)

    :ets.insert(table, {postal_code_data.postal_code, postal_code_data})
  end

  # Extrae el archivo de Sepomex del ZIP
  @spec extract_file(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  defp extract_file(zip_file_path) do
    unzipped_files =
      zip_file_path
      |> to_charlist()
      |> :zip.unzip()

    case unzipped_files do
      {:ok, [extracted_file_path]} ->
        {:ok, extracted_file_path}

      _ ->
        {:error, "Archivo ZIP de Sepomex no existe"}
    end
  end
end
