defmodule WeatherGetter do
  import SweetXml
  @weather_url Application.get_env(:weather_getter, :url)

  # Main driver for weather display module
  def display_weather do
    response = HTTPoison.get(@weather_url, [], follow_redirect: true) |> get_response
    case response do
      {:error, error_message} -> IO.puts(error_message)
      {:ok, body}             -> do_display_weather(body)
    end
  end


  # Functions to handle the response from HTTPoison
  def get_response({:ok, %{status_code: 200, body: body}}), do: {:ok, body}
  def get_response({:ok, %{status_code: status_code}}), do: {:error, "Expected status code of 200, received #{status_code}"}
  def get_response({:error, error}), do: {:error, error}


  # Handler for displaying results (if no errors encountered)
  def do_display_weather(body) do

    # Get fields to display, fill them from body
    filled_fields = return_requested_fields()
      |> Enum.map(fn(field) -> fill_requested_field(field, body) end)

    # Get the longest friendly name and value string length for formatting
    longest_friendly = Enum.reduce(filled_fields, 0, fn field, acc -> get_longest_string(field[:friendly_name], acc) end)
    longest_value = Enum.reduce(filled_fields, 0, fn field, acc -> get_longest_string(field[:value], acc) end)

    # Display the results
    IO.puts("WEATHER:")
    IO.puts("--#{String.duplicate("-", longest_friendly)}-+-#{String.duplicate("-", longest_value)}")
    Enum.each(filled_fields, fn(field) -> print_field(field, longest_friendly) end)
  end


  # Requested fields as a tuple of Field Name and Friendly Name
  defp return_requested_fields() do
    [
      {"location", "Location"},
      {"observation_time", "Time"},
      {"weather", "Weather"},
      {"temp_f", "Temperature (F)"},
      {"relative_humidity", "Relative Humidity"},
      {"wind_dir", "Wind Direction"},
      {"wind_mph", "Wind Speed (mph)"}
    ]
  end


  # Pulls requested field values form XML body using SweetXml, returns as a list of maps
  def fill_requested_field({field_name, friendly_name}, body) do
    field_value = body
      |> SweetXml.xpath(~x"//#{field_name}/text()")
      |> List.to_string()
    %{field_name: field_name, friendly_name: friendly_name, value: field_value}
  end


  # Callback to return longest string length in attribute list
  def get_longest_string(string, longest) do
    cond do
      String.length(string) > longest -> String.length(string)
      true                            -> longest
    end
  end


  # Display formatted value string
  def print_field(field, longest_friendly) do
    required_padding = longest_friendly - String.length(field[:friendly_name])
    IO.puts("  #{field[:friendly_name]}#{String.duplicate(" ",required_padding)} | #{field[:value]}")
  end

end
