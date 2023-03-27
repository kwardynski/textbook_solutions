# One-Max Problem solution script

# Define an initial population of 100, 1000-length bitstrings
population =
  for _ <- 1..100 do
    for _ <- 1..1000 do
      Enum.random(0..1)
    end
  end

# Evaluation
# This function takes a population and sorts it by the sum in descending order
# Better solutions will exist at the top of the population (and will be grouped
# together)
evaluate =
  fn population ->
    Enum.sort_by(population, &Enum.sum/1, &>=/2)
  end

# Parent Selection
# This function returns a list of tuples consisting of pairs of parents to be combined.
# Due to how the evaluate function works, the selection function will group parents of
# similar fitness together.
selection =
  fn population ->
    population
    |> Enum.chunk_every(2)
    |> Enum.map(&List.to_tuple(&1))
  end

# Crossover
# This "genetic" operation takes two or more parent chromosomes and creates two or more
# child chromosomes.
# A random crossover point is selected, and both parents are split at that index, then
# recombined with the tails swapped.
crossover =
  fn population ->
    Enum.reduce(population, [], fn {p1, p2}, acc ->
      cx_point = :rand.uniform(1000)
      {{h1, t1}, {h2, t2}} =
        {Enum.split(p1, cx_point), Enum.split(p2, cx_point)}
      [h1 ++ t2, h2 ++ t1 | acc]
    end)
  end

  # Mutation
  # You want to mutate a small portion of your population, this is to avoid premature convergence while
  # ensuring you are not mutating out all the progress you've made
  mutation =
    fn population ->
      population
      |> Enum.map(
        fn chromosome ->
          if :rand.uniform() < 0.05 do
            Enum.shuffle(chromosome)
          else
            chromosome
          end
        end
      )
    end

# Genetic Algorithm:
algorithm =
  fn population, algorithm ->
    best = Enum.max_by(population, &Enum.sum/1)
    IO.write("\rCurrent Best: " <> Integer.to_string(Enum.sum(best)))
  if Enum.sum(best) == 1000 do
    best
  else
    population
    |> evaluate.()
    |> selection.()
    |> crossover.()
    |> mutation.()
    |> algorithm.(algorithm)
  end
end

# Solution
solution = algorithm.(population, algorithm)
IO.puts("\nAnswer is: #{inspect solution}\n")
