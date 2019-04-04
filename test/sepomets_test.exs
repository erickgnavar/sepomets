defmodule SepometsTest do
  use ExUnit.Case
  doctest Sepomets

  alias Sepomets.PostalCodeData

  test "Should get postal code data" do
    assert Sepomets.get("03100") == [
             %PostalCodeData{
               city: %{code: "03", name: "Ciudad de México"},
               municipality: %{code: "014", name: "Benito Juárez"},
               postal_code: "03100",
               settlement: %{code: "0496", name: "Del Valle Centro"},
               settlement_type: %{code: "09", name: "Colonia"},
               state: %{code: "09", name: "Ciudad de México"},
               zone: "Urbano"
             },
             %PostalCodeData{
               city: %{code: "03", name: "Ciudad de México"},
               municipality: %{code: "014", name: "Benito Juárez"},
               postal_code: "03100",
               settlement: %{code: "2624", name: "Insurgentes San Borja"},
               settlement_type: %{code: "09", name: "Colonia"},
               state: %{code: "09", name: "Ciudad de México"},
               zone: "Urbano"
             }
           ]
  end
end
