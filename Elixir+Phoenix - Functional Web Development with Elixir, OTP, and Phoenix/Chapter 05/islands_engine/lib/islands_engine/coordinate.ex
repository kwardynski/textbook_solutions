defmodule IslandsEngine.Coordinate do
  alias __MODULE__
  @enforce_keys [:row, :col] # ensure that both keys are present whenever we create a new struct
  @board_range 1..10

  defstruct [
    :row,
    :col
  ]

  # Create a new Coordinate struct, ensuring the row/col values are within the
  # bounds of the board
  def new(row, col) when row in (@board_range) and col in (@board_range) do
    {:ok, %Coordinate{row: row, col: col}}
  end

  def new(_row, _col) do
    {:error, :invalid_coordinate}
  end



end
