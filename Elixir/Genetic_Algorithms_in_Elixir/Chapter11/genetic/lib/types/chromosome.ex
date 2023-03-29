# ---
# Excerpted from "Genetic Algorithms in Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/smgaelixir for more book information.
# ---
defmodule Types.Chromosome do
  use Agent

  @type t :: %__MODULE__{
          genes: Enum.t(),
          size: integer(),
          fitness: number(),
          age: integer()
        }

  @enforce_keys :genes
  defstruct [
    :genes,
    id: Base.encode16(:crypto.strong_rand_bytes(64)),
    size: 0,
    fitness: 0,
    age: 0
  ]

  def start_link(genes) do
    Agent.start_link(fn -> %__MODULE__{genes: genes, size: Enum.count(genes)} end)
  end

  def get_fitness(pid) do
    Agent.get(pid, & &1.fitness)
  end

  def eval(pid, fitness) do
    c = Agent.get(pid, & &1)
    Agent.update(pid, fn -> %__MODULE__{c | fitness: fitness.(c)} end)
  end
end
