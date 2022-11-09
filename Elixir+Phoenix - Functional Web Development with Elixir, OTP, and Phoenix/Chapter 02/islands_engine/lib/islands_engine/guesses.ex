defmodule IslandsEngine.Guesses do
  alias IslandsEngine.Guesses
  alias __MODULE__
  @enforce_keys [:hits, :misses]

  defstruct [
    :hits,
    :misses
  ]

  def new() do
    %Guesses{
      hits: MapSet.new(),
      misses: MapSet.new()
    }
  end

  # def new() do
  #   %Guesses{
  #     hits: MapSet.new(),
  #     misses: MapSet.new()
  #   }
  # end
end
