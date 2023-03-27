defmodule Cargo do
  @behaviour Problem
  alias Types.Chromosome

  def profits(), do: [6, 5, 8, 9, 6, 7, 3, 1, 2, 6]
  def weights(), do: [10, 6, 8, 7, 10, 9, 7, 11, 6, 8]
  def weight_limit(), do: 40

  @impl true
  def genotype do
    genes = for _ <- 1..10, do: Enum.random(0..1)
    %Chromosome{genes: genes, size: 10}
  end

  @impl true
  def fitness_function(chromosome) do
    # The fitness function will now include a penalty function
    # If a solution exceeds the weight limit, the fitness automatically becomes 0.

    genes = chromosome.genes

    potential_profits =
      genes
      |> Enum.zip(profits())
      |> Enum.map(fn {gene, profit} -> gene*profit end)
      |> Enum.sum

    over_limit? =
      genes
      |> Enum.zip(weights())
      |> Enum.map(fn {gene, weight} -> gene*weight end)
      |> Enum.sum()
      |> Kernel.>(weight_limit())

    case over_limit? do
      true -> 0
      false -> potential_profits
    end
  end

  @impl true
  def terminate?(_population, 1000), do: true
  def terminate?(_population, _generation), do: false
end

soln = Genetic.run(Cargo, population_size: 50)

IO.write("\n")
IO.inspect(soln)

weight =
  soln.genes
  |> Enum.zip(Cargo.weights())
  |> Enum.map(fn {gene, weight} -> gene*weight end)
  |> Enum.sum()

IO.write("\nWeight is: #{weight}\n")
