#---
# Excerpted from "Genetic Algorithms in Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/smgaelixir for more book information.
#---
defmodule Schedule do
  @behaviour Problem
  alias Types.Chromosome

  @impl true
  def genotype do
    genes = for _ <- 1..10, do: Enum.random(0..1)
    %Chromosome{genes: genes, size: 10}
  end

  @impl true
  def fitness_function(chromosome) do
    schedule = chromosome.genes
    fitness =
      [schedule, difficulties(), usefulness(), interest()]
      |> Enum.zip()
      |> Enum.map(
          fn {class, diff, use, int} ->
            class * (0.3*use + 0.3*int - 0.3*diff)
          end
        )
      |> Enum.sum()
    credit =
      schedule
      |> Enum.zip(credit_hours())
      |> Enum.map(fn {class, credits} -> class * credits end)
      |> Enum.sum()

    if credit > 18.0, do: -99999, else: fitness
  end

  defp credit_hours, do: [3.0, 3.0, 3.0, 4.5, 3.0, 3.0, 3.0, 3.0, 4.5, 1.5]
  defp difficulties, do: [8.0, 9.0, 4.0, 3.0, 5.0, 2.0, 4.0, 2.0, 6.0, 1.0]
  defp usefulness, do: [8.0, 9.0, 6.0, 2.0, 8.0, 9.0, 1.0, 2.0, 5.0, 1.0]
  defp interest, do: [8.0, 8.0, 5.0, 9.0, 7.0, 2.0, 8.0, 2.0, 7.0, 10.0]

  @impl true
  def terminate?(_population, generation), do: generation == 1000
end

# soln = Genetic.run(Schedule)

soln = Genetic.run(Schedule,
                  reinsertion_strategy: &Toolbox.Reinsertion.elitist(&1, &2, &3, 0.1),
                  selection_rate: 0.8,
                  mutation_rate: 0.1)

IO.write("\n")
IO.inspect(soln)
