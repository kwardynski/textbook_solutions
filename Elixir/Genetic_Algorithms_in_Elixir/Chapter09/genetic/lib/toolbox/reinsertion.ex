# ---
# Excerpted from "Genetic Algorithms in Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/smgaelixir for more book information.
# ---
defmodule Toolbox.Reinsertion do
  def pure(_parents, offspring, _leftovers), do: offspring

  def elitist(parents, offspring, leftovers, survival_rate \\ 0.1) do
    old =
      (parents ++ leftovers)
      |> unzip([])

    n = floor(length(old) * survival_rate)

    survivors =
      old
      |> List.flatten()
      |> Enum.sort_by(& &1.fitness, &>=/2)
      |> Enum.take(n)

    offspring ++ survivors
  end

  def uniform(parents, offspring, leftover, survival_rate) do
    old = parents ++ leftover
    n = floor(length(old) * survival_rate)

    survivors =
      old
      |> Enum.take_random(n)

    offspring ++ survivors
  end

  defp unzip([], unzipped_list), do: unzipped_list

  defp unzip([head | tail], unzipped_list) do
    case head do
      %Types.Chromosome{} ->
        unzip(tail, [head | unzipped_list])

      {%Types.Chromosome{}, %Types.Chromosome{}} ->
        {c1, c2} = head
        unzip(tail, [c1, c2 | unzipped_list])

      _ ->
        raise "no clause to format: #{inspect(head)}"
    end
  end
end
