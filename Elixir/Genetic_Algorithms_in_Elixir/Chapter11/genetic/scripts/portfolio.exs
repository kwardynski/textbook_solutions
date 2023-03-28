#---
# Excerpted from "Genetic Algorithms in Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/smgaelixir for more book information.
#---
defmodule Portfolio do
  @behaviour Problem
  alias Types.Chromosome

  @impl true
  def genotype do
    genes = for _ <- 1..100, do: {:rand.uniform(10), :rand.uniform(10)}
    %Chromosome{genes: genes, size: 100}
  end

  @impl true
  def fitness_function(chromosome) do
    chromosome
    |> Enum.map(fn {roi, risk} -> 2 * roi - risk end)
    |> Enum.sum()
  end

  @impl true
  def terminate?(population, _generation), do: Enum.max_by(population, &Portfolio.fitness_function/1) == 20
end

