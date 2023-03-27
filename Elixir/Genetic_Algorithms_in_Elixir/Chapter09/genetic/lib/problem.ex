# ---
# Excerpted from "Genetic Algorithms in Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/smgaelixir for more book information.
# ---
defmodule Problem do
  alias Types.Chromosome

  @callback genotype :: Chromosome.t()

  @callback fitness_function(Chromosome.t()) :: number()

  @callback terminate?(Enum.t(), integer()) :: boolean()
end
