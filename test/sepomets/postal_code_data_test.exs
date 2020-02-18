defmodule Sepomets.PostalCodeDataTest do
  use ExUnit.Case

  alias Sepomets.PostalCodeData

  test "Should parse Sepomex data to struct" do
    data =
      "01000|San Ángel|Colonia|Álvaro Obregón|Ciudad de México|Ciudad de México|01001|09|01001||09|010|0001|Urbano|01"

    assert PostalCodeData.parse(data) ==
             %Sepomets.PostalCodeData{
               postal_code: "01000",
               city: %{code: "01", name: "Ciudad de México"},
               municipality: %{code: "010", name: "Álvaro Obregón"},
               settlement: %{code: "0001", name: "San Ángel"},
               settlement_type: %{code: "09", name: "Colonia"},
               state: %{code: "09", name: "Ciudad de México"},
               zone: "Urbano",
               office: "01001"
             }
  end
end
