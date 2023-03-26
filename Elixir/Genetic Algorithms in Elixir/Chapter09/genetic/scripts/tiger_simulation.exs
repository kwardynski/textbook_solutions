defmodule TigerSimulation do

  # TRAITS           | 0          | 1
  # -----------------+------------+------------
  # size             | smaller    | larger
  # swimming ability | low        | high
  # fat stores       | less       | more
  # activity period  | diurnal    | nocturnal
  # hunting range    | smaller    | larger
  # fur thickness    | less thick | more thick
  # tail length      | smaller    | larger

  # SCORES           | Tropical   | Tundra
  # -----------------+------------+------------
  # size             |  0.0       |  1.0
  # swimming ability |  3.0       |  3.0
  # fur color        |  2.0       | -2.0
  # fat stores       | -1.0       |  1.0
  # activity period  |  0.5       |  0.5
  # hunting ground   |  1.0       |  2.0
  # fur thickness    | -1.0       |  1.0
  # tail length      |  0.0       |  0.0

  @behaviour Problem
  alias Types.Chromosome

  defp tropic_scores(), do: [0.0, 3.0, 2.0, -1.0, 0.5, 1.0, -1.0, 0.0]
  defp tundra_scores(), do: [1.0, 3.0, -2.0, 1.0, 0.5, 2.0, 1.0, 0.0]

  @impl true
  def genotype() do
    genes = for _ <- 1..8, do: Enum.random(0..1)
    %Chromosome{genes: genes, size: 8}
  end

  @impl true
  def fitness_function(chromosome) do
    scores = tundra_scores()

    chromosome.genes
    |> Enum.zip(scores)
    |> Enum.map(fn {trait, score} -> trait*score end)
    |> Enum.sum()
  end

  @impl true
  def terminate?(_population, generation), do: generation == 1000

  def average_tiger(population) do
    genes = Enum.map(population, & &1.genes)
    fitnesses = Enum.map(population, & &1.fitness)
    ages = Enum.map(population, & &1.age)
    num_tigers = length(population)

    avg_fitness = Enum.sum(fitnesses) / num_tigers
    avg_age = Enum.sum(ages) / num_tigers
    avg_genes =
      genes
      |> Enum.zip()
      |> Enum.map(& Enum.sum(Tuple.to_list(&1)) / num_tigers)

    %Chromosome{genes: avg_genes, age: avg_age, fitness: avg_fitness}
  end
end

tiger = Genetic.run(
  TigerSimulation,
  population_size: 20,
  selection_rate: 0.9,
  mutation_rate: 0.1,
  statistics: %{average_tiger: &TigerSimulation.average_tiger/1}
)

IO.write("\n")
[0, 500, 1000]
|> Enum.each(fn (generation) ->
  {_, generation_stats} = Utilities.Statistics.lookup(generation)
  IO.inspect(generation_stats)
end)

IO.inspect(tiger)

Utilities.Genealogy.get_tree()
|> Graph.vertices
|> IO.inspect()
