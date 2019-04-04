defmodule Sepomets.PostalCodeData do
  @moduledoc """
  Manejo de la estructura de la información relacionada a un código postal
  """

  defstruct [
    :postal_code,
    :settlement,
    :settlement_type,
    :municipality,
    :state,
    :city,
    :zone
  ]

  [
    "20341",
    "El Salto de los Salado",
    "Ranchería",
    "Aguascalientes",
    "Aguascalientes",
    "",
    "20999",
    "01",
    "20999",
    "",
    "29",
    ""
  ]

  def parse(data) do
    [
      postal_code,
      settlement,
      settlement_type,
      municipality,
      state,
      city,
      _,
      state_code,
      _,
      _,
      settlement_type_code,
      municipality_code,
      settlement_code,
      zone,
      city_code
    ] = String.split(data, "|")

    %__MODULE__{
      postal_code: postal_code,
      municipality: %{
        name: municipality,
        code: municipality_code
      },
      state: %{name: state, code: state_code},
      city: %{name: city, code: city_code},
      settlement: %{name: settlement, code: settlement_code},
      settlement_type: %{name: settlement_type, code: settlement_type_code},
      zone: zone
    }
  end
end
