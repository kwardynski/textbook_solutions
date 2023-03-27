defmodule Portfolio do
  @doc """
  A simple genetic algorithm to solve a trivial portfolio optimization.
  Outcome is to maximize ROI while minimizing risk.
  """

  @behaviour Problem
  alias Types.Chromosome

  def target_fitness, do: 180

  @impl true
  def genotype do
    genes = for _ <- 1..100 do
      {:rand.uniform(10), :rand.uniform(10)}
    end

    %Chromosome{genes: genes, size: 10}
  end

  @impl true
  def fitness_function(chromosome) do
    chromosome
    |> Enum.map(fn {roi, risk} -> 2 * roi - risk end)
    |> Enum.sum()
  end

  @impl true
  def terminate?(population, _generation) do
    max_value = Enum.max_by(population, &Portfolio.fitness_function/1)
    max_value > target_fitness()
  end
end
