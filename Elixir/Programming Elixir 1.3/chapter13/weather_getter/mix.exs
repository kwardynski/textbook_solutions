defmodule WeatherGetter.MixProject do
  use Mix.Project

  def project do
    [
      app: :weather_getter,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:sweet_xml, "~> 0.7.1"}
    ]
  end
end
