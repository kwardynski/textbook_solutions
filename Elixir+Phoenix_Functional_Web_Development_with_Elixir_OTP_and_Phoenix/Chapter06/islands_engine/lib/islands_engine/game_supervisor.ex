defmodule IslandsEngine.GameSupervisor do
  use Supervisor

  alias IslandsEngine.Game

  def start_link(_options) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    Supervisor.init([Game], strategy: :simple_one_for_one)
  end

  def start_game(name) do
    # 1. __MODULE__ evaluates to GameSupervisor, which is the local name we gave to the
    #    supervisor process. The supervisor Behaviour will translate this into the
    #    Supervisor process PID.
    # 2. GameSupervisor looks up the child_spec for the Game module, which is the type of
    #    child we told it to start in GameSupervisor.init/1,
    #    Supervisor.init([Game], strategy: :simple_one_for_one)
    # 3. The Game module's child_spec tells the supervisor to use the Game module and the
    #    start_link/1 function to start the child.
    # 4. GameSupervisor passes in the argument we supplied name to Game.start_link/1 to
    #    start and supervise the game.
    Supervisor.start_child(__MODULE__, [name])
  end

  def stop_game(name) do
    :ets.delete(:game_state, name)
    Supervisor.terminate_child(__MODULE__, pid_from_name(name))
  end

  defp pid_from_name(name) do
    name
    |> Game.via_tuple()
    |> GenServer.whereis()
  end
end
