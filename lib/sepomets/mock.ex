defmodule Sepomets.Mock do
  alias Sepomets.PostalCodeData

  def load(table) do
    :ets.insert(
      table,
      {"03100",
       %PostalCodeData{
         city: %{code: "03", name: "Ciudad de México"},
         municipality: %{code: "014", name: "Benito Juárez"},
         postal_code: "03100",
         settlement: %{code: "0496", name: "Del Valle Centro"},
         settlement_type: %{code: "09", name: "Colonia"},
         state: %{code: "09", name: "Ciudad de México"},
         zone: "Urbano"
       }}
    )

    :ets.insert(
      table,
      {"03100",
       %PostalCodeData{
         city: %{code: "03", name: "Ciudad de México"},
         municipality: %{code: "014", name: "Benito Juárez"},
         postal_code: "03100",
         settlement: %{code: "2624", name: "Insurgentes San Borja"},
         settlement_type: %{code: "09", name: "Colonia"},
         state: %{code: "09", name: "Ciudad de México"},
         zone: "Urbano"
       }}
    )
  end
end
