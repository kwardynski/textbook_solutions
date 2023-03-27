# ---
# Excerpted from "Genetic Algorithms in Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/smgaelixir for more book information.
# ---
defmodule Toolbox.Mutation do
  alias Types.Chromosome
  use Bitwise

  def flip(chromosome) do
    genes =
      chromosome.genes
      |> Enum.map(&(&1 ^^^ 1))

    %Chromosome{genes: genes, size: chromosome.size}
  end

  def flip(chromosome, p) do
    genes =
      chromosome.genes
      |> Enum.map(fn g ->
        if :rand.uniform() < p do
          g ^^^ 1
        else
          g
        end
      end)

    %Chromosome{genes: genes, size: chromosome.size}
  end

  def scramble(chromosome) do
    genes =
      chromosome.genes
      |> Enum.shuffle()

    %Chromosome{genes: genes, size: chromosome.size}
  end

  def scramble(chromosome, n) do
    start = :rand.uniform(n - 1)

    {lo, hi} =
      if start + n >= chromosome.size do
        {start - n, start}
      else
        {start, start + n}
      end

    head = Enum.slice(chromosome.genes, 0, lo)
    mid = Enum.slice(chromosome.genes, lo, hi)
    tail = Enum.slice(chromosome.genes, hi, chromosome.size)
    %Chromosome{genes: head ++ Enum.shuffle(mid) ++ tail, size: chromosome.size}
  end

  def gaussian(chromosome) do
    mu = Enum.sum(chromosome.genes) / length(chromosome.genes)

    sigma =
      chromosome.genes
      |> Enum.map(fn x -> (mu - x) * (mu - x) end)
      |> Enum.sum()
      |> Kernel./(length(chromosome.genes))

    genes =
      chromosome.genes
      |> Enum.map(fn _ ->
        :rand.normal(mu, sigma)
      end)

    %Chromosome{genes: genes, size: chromosome.size}
  end
end
