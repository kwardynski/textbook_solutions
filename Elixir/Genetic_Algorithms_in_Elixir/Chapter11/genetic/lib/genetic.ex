# ---
# Excerpted from "Genetic Algorithms in Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/smgaelixir for more book information.
# ---
defmodule Genetic do
  alias Types.Chromosome

  def initialize(genotype, opts \\ []) do
    population_size = Keyword.get(opts, :population_size, 100)
    for _ <- 1..population_size do
      {:ok, pid} = Chromosome.start_link(genes: genotype.())
      pid
    end
  end

  def evaluate(population, fitness_function, _opts \\ []) do
    population
    |> Enum.map(&Task.async(fn -> Chromosome.eval(&1, fitness_function) end))
    |> Enum.sort_by(fn c -> Chromosome.get_fitness(c) end, &>=/2)
  end

  def select(population, opts \\ []) do
    select_fn = Keyword.get(opts, :selection_type, &Toolbox.Selection.elite/2)
    select_rate = Keyword.get(opts, :selection_rate, 0.8)
    n = round(length(population) * select_rate)
    n = if rem(n, 2) == 0, do: n, else: n + 1

    parents =
      select_fn
      |> apply([population, n])

    leftover = MapSet.difference(MapSet.new(population), MapSet.new(parents))

    parents =
      parents
      |> Enum.chunk_every(2)
      |> Enum.map(&List.to_tuple(&1))

    {parents, MapSet.to_list(leftover)}
  end

  def crossover(population, opts \\ []) do
    crossover_fn = Keyword.get(opts, :crossover_type, &Toolbox.Crossover.single_point/2)

    population
    |> Enum.reduce(
      [],
      fn {p1, p2}, acc ->
        {c1, c2} = apply(crossover_fn, [p1, p2])
        Utilities.Genealogy.add_chromosome(p1, p2, c1)
        Utilities.Genealogy.add_chromosome(p1, p2, c2)
        [c1 | [c2 | acc]]
      end
    )
  end

  def mutation(population, opts \\ []) do
    mutate_fn = Keyword.get(opts, :mutation_type, &Toolbox.Mutation.scramble/1)
    rate = Keyword.get(opts, :mutation_rate, 0.05)
    n = floor(length(population) * rate)

    population
    |> Enum.take_random(n)
    |> Enum.map(fn chromosome ->
      mutant = apply(mutate_fn, [chromosome])
      Utilities.Genealogy.add_chromosome(chromosome, mutant)
      mutant
    end)
  end

  def reinsertion(parents, offspring, leftover, opts \\ []) do
    strategy = Keyword.get(opts, :reinsertion_strategy, &Toolbox.Reinsertion.pure/3)
    apply(strategy, [parents, offspring, leftover])
  end

  def run(problem, opts \\ []) do
    population = initialize(&problem.genotype/0)

    population
    |> evolve(problem, 0, opts)
  end

  def evolve(population, problem, generation, opts \\ []) do
    population = evaluate(population, &problem.fitness_function/1, opts)
    statistics(population, generation, opts)
    best = hd(population)

    if problem.terminate?(population, generation) do
      best
    else
      {parents, leftover} = select(population, opts)
      children = crossover(parents, opts)
      mutants = mutation(population, opts)
      offspring = children ++ mutants
      new_population = reinsertion(parents, offspring, leftover, opts)
      evolve(new_population, problem, generation + 1, opts)
    end
  end

  def statistics(population, generation, opts \\ []) do
    default_statistics = [
      min_fitness: &Enum.min_by(&1, fn c -> c.fitness end).fitness,
      max_fitness: &Enum.max_by(&1, fn c -> c.fitness end).fitness,
      mean_fitness: &Enum.sum(Enum.map(&1, fn c -> c.fitness end))
    ]

    statistics = Keyword.get(opts, :statistics, default_statistics)

    statistics_map =
      statistics
      |> Enum.reduce(%{}, fn {key, func}, acc ->
        Map.put(acc, key, func.(population))
      end)

    Utilities.Statistics.insert(generation, statistics_map)
  end

  def pmap(collection, func) do
    collection
    |> Enum.map(fn member -> func.(member) end)
    |> Enum.map(fn task -> Task.async(fn -> task end) end)
    |> Enum.map(&Task.await(&1))
  end
end
