#---
# Excerpted from "Genetic Algorithms in Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/smgaelixir for more book information.
#---
defmodule Types.Chromosome do

  @type t :: %__MODULE__{
    genes: Enum.t,
    size: integer(),
    fitness: number(),
    age: integer()
  }

  @enforce_keys :genes
  defstruct [:genes, size: 0, fitness: 0, age: 0]
end