defmodule Sepomets do
  @moduledoc """
  Documentation for Sepomets.
  """

  alias Sepomets.Db
  alias Sepomets.PostalCodeData

  @doc """
  Obtiene todos los registros de Sepomex relacionados a un Código postal

  ## Examples

      iex> Sepomets.get("03100")
      [
        %Sepomets.PostalCodeData{
          city: %{code: "03", name: "Ciudad de México"},
          municipality: %{code: "014", name: "Benito Juárez"},
          postal_code: "03100",
          settlement: %{code: "0496", name: "Del Valle Centro"},
          settlement_type: %{code: "09", name: "Colonia"},
          state: %{code: "09", name: "Ciudad de México"},
          zone: "Urbano"
        },
        %Sepomets.PostalCodeData{
          city: %{code: "03", name: "Ciudad de México"},
          municipality: %{code: "014", name: "Benito Juárez"},
          postal_code: "03100",
          settlement: %{code: "2624", name: "Insurgentes San Borja"},
          settlement_type: %{code: "09", name: "Colonia"},
          state: %{code: "09", name: "Ciudad de México"},
          zone: "Urbano"
        }
      ]

  """
  @spec get(String.t()) :: [PostalCodeData.t()]
  defdelegate get(postal_code), to: Db

  @doc """
  Carga un archivo ZIP nuevo de códigos postales de Sepomex.

  ## Examples

      iex> Sepomets.load("fake/path/sepomex.zip')
      :ok
  """
  @spec load(String.t()) :: :ok | :file_not_found | {:error, String.t()}
  defdelegate load(file_path), to: Db

  @doc """
  Carga un archivo ZIP nuevo de códigos postales de Sepomex desde una URL

  ## Examples

      iex> Sepomets.load_from_url("http://fakeurl/file.zip')
      :ok
  """
  @spec load_from_url(String.t()) :: :ok | :file_not_found | {:error, String.t()}
  defdelegate load_from_url(file_path), to: Db
end
