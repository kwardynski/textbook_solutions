defmodule IslandsEngine.Rules do
  alias __MODULE__

  defstruct [
    state: :initialized,
    player1: :islands_not_set,
    player2: :islands_not_set
  ]

  def new() do
    %Rules{}
  end

  # Initial state action - adding a new player which results in an initialized game
  def check(%Rules{state: :initialized} = rules, :add_player) do
    {:ok, %Rules{rules | state: :players_set}}
  end

  # When we are in :players_set, it is OK for both players to position their islands
  # Two conditions are valid for this state:
  #   - neither player has set their islands
  #   - one player has set their islands while the otehr has not
  def check(%Rules{state: :players_set} = rules, {:position_islands, player}) do
    case Map.fetch!(rules, player) do
      :islands_set -> :error
      :islands_not_set -> {:ok, rules}
    end
  end

  # Let players set their islands, transition to beginning the game if both players
  # have set their islands
  def check(%Rules{state: :players_set} = rules, {:set_islands, player}) do
    rules = Map.put(rules, player, :islands_set)
    case both_players_islands_set?(rules) do
      true -> {:ok, %Rules{rules | state: :player1_turn}}
      false -> {:ok, rules}
    end
  end

  # Allow player 1 to guess a coordinate
  # The allowable transitions are either to :player2_turn or :game_over
  def check(%Rules{state: :player1_turn} = rules, {:guess_coordinate, :player1}) do
    {:ok, %Rules{rules | state: :player2_turn}}
  end

  # Check whether player1 has won the game
  def check(%Rules{state: :player1_turn} = rules, {:win_check, win_or_not}) do
    case win_or_not do
      :no_win -> {:ok, rules}
      :win -> {:ok, %Rules{rules | state: :game_over}}
    end
  end

  # Allow player 2 to guess a coordinate
  # The allowable transitions are either to :player1_turn or :game_over
  def check(%Rules{state: :player2_turn} = rules, {:guess_coordinate, :player2}) do
    {:ok, %Rules{rules | state: :player1_turn}}
  end

  # Check whether player1 has won the game
  def check(%Rules{state: :player2_turn} = rules, {:win_check, win_or_not}) do
    case win_or_not do
      :no_win -> {:ok, rules}
      :win -> {:ok, %Rules{rules | state: :game_over}}
    end
  end

  # Catch-all check clause which will ALWAYS MATCH
  def check(_state, _action), do: :error

  # Return true if BOTH players have set their islands
  defp both_players_islands_set?(rules) do
    rules.player1 == :islands_set && rules.player2 == :islands_set
  end


end
