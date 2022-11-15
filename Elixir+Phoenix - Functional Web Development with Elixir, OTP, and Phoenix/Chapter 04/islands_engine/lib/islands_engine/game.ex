defmodule IslandsEngine.Game do
  use GenServer

  alias IslandsEngine.Board
  alias IslandsEngine.Guesses
  alias IslandsEngine.Rules

  # This single-line function is actually quite significant - it will allow other processes
  # to programatically start a new game process
  def start_link(name) when is_binary(name) do
    GenServer.start_link(__MODULE__, name, [])
  end

  # General form of the init function is to pattern match on an argument, perform any necessary
  # initializations, then return a tagged tuple of {:ok, initial_state}
  # GenServer provides the name argument, we use it to help build the state we require
  def init(name) do
    player1 = %{name: name, board: Board.new(), guesses: Guesses.new()}
    player2 = %{name: nil, board: Board.new(), guesses: Guesses.new()}
    {:ok, %{player1: player1, player2: player2, rules: %Rules{}}}
  end

  # Adding a second player
  # We will use GenServer.call/2 to keep this SYNCHRONOUS
  def add_player(game, name) when is_binary(name) do
    GenServer.call(game, {:add_player, name})
  end

  def handle_call({:add_player, name}, _from, state_data) do
    with(
      {:ok, rules} <- Rules.check(state_data.rules, :add_player)
    ) do
      state_data
      |> update_player2_name(name)
      |> update_rules(rules)
      |> reply_success(:ok)
    else
      :error -> {:reply, :error, state_data}
    end
  end

  defp update_player2_name(state_data, name) do
    put_in(state_data.player2.name, name)
  end

  defp update_rules(state_data, rules) do
    %{state_data | rules: rules}
  end

  defp reply_success(state_data, reply) do
    {:reply, reply, state_data}
  end

end
