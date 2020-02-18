defmodule Sepomets.Loader do
  @moduledoc """
  Modulo de carga de archivo de Sepomex
  """

  alias Sepomets.PostalCodeData

  require Logger

  @doc """
  Carga la información de Sepomex a la tabla ETS desde un archivo
  """
  @spec load_file(atom(), String.t()) :: :ok
  def load_file(_table, nil) do
    not_found()
  end

  def load_file(table, file_path) do
    case extract_file(file_path) do
      {:ok, file_path} ->
        Logger.debug(fn -> "Iniciando carga de Sepomex" end)
        load_file_data(table, file_path)
        Logger.debug(fn -> "Carga de Sepomex finalizada" end)
        File.rm!(file_path)

      _ ->
        not_found()
    end
  end

  # Loguea que el archivo de Sepomex no se ha encontrado
  @spec not_found :: :file_not_found
  defp not_found do
    Logger.error("Archivo de Sepomex no encontrado")
    :file_not_found
  end

  # Carga la información del archivo de Sepomex a la tabla ETS
  @spec load_file_data(atom(), String.t()) :: :ok
  defp load_file_data(table, file_path) do
    encoding = Application.get_env(:sepomets, :encoding, :latin1)

    file_path
    |> File.stream!([{:encoding, encoding}])
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
