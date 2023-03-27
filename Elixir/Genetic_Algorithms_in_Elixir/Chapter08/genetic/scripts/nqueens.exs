#---
# Excerpted from "Genetic Algorithms in Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/smgaelixir for more book information.
#---
defmodule NQueens do
  @behaviour Problem
  alias Types.Chromosome

  @impl true
  def genotype do
    genes = Enum.shuffle(0..7)
    %Chromosome{genes: genes, size: 8}
  end

  @impl true
  def fitness_function(chromosome) do
    diag_clashes =
      for i <- 0..7, j <- 0..7 do
        if i != j do
          dx = abs(i - j)
          dy = abs(Enum.at(chromosome.genes, i) - Enum.at(chromosome.genes, j))
          if dx == dy do
            1
          else
            0
          end
        else
          0
        end
      end
    length(Enum.uniq(chromosome.genes)) - Enum.sum(diag_clashes)
  end

  @impl true
  def terminate?(population, _generation), do:
    Enum.max_by(population, &NQueens.fitness_function/1).fitness == 8
end

soln = Genetic.run(NQueens)

IO.write("\n")
IO.inspect(soln)