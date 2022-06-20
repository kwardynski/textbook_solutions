defmodule Sequence.MixProject do
  use Mix.Project

  def project do
    [
      app: :sequence,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],

      # Initial starting MODULE
      #   - Pass 456 as the argument to Sequence.Application.start as the initial number
      #   - This can also be done as an environment variable: "env: [initial_number: 456]"
      #     which can then be accessed with Application.get_env(:sequence, :initial_number)
      mod: {Sequence.Application, 456},

      registered: [Sequence.Server]      # register the sequence server
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
    ]
  end
end
