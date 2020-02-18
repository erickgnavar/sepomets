# Sepomets

## Instalación

```elixir
def deps do
  [
    {:sepomets, github: "poncho/sepomets"}
  ]
end
```

## Uso

Lo primero que debes hacer es configurar el path del archivo ZIP de donde se cargará el catálogo de Sepomex

```elixir
config :sepomets, file: "file/path/sepomex.zip"
```

De ahí Sepomets se encargará de cargar todos los datos en una ETS a la cual podrás acceder mediante `Sepomets.get/1`, que retornará todos los registros bajo el código postal dado.

```elixir
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
```

## Encoding

El archivo por defecto se espera con el encode `latin1`. Si deseas que se lea con un encode diferente puedes especificarlo de la siguiente manera en la configuración

```elixir
config :sepomets, encode: :utf8
```
