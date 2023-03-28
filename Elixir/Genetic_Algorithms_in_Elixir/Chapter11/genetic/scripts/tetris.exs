defmodule TetrisInterface do
  use Agent

  def start_link(path_to_tetris_rom) do
    int = Alex.new()

    game =
      int
      |> Alex.set_option(:display_screen, true)
      |> Alex.set_option(:sound, true)
      |> Alex.set_option(:random_seed, 123)
      |> Alex.load(path_to_tetris_rom)

    Agent.start_link(fn -> game end, name: __MODULE__)
  end
end

defmodule Tetris do
  @behaviour Problem
  alias Types.Chromosome

  @impl true
  def genotype() do
    game = Agent.get(TetrisInterface, & &1)
    genes = for _ <- 1..1000, do: Enum.random(game.legal_actions)
    %Chromosome{genes: genes, size: 1000}
  end

  @impl true
  def fitness_function(chromosome) do
    game = Agent.get(TetrisInterface, & &1)
    actions = chromosome.genes

    game =
      actions
      |> Enum.reduce(game, fn action, game ->
        Alex.step(game, action)
      end)

    reward = game.reward
    Alex.reset(game)
    reward
  end

  @impl true
  def terminate(_population, generation), do: generation == 5
end

TetrisInterface.start_link("priv/tetris.bin")
soln = Genetic.run(Tetris, population_size: 10)
IO.write("\n")
IO.write("Best is #{soln}\n")
