defmodule Times do

  def double(n) do
    2*n
  end

  # 1
  def triple(n) do
    3*n
  end

  # 2e
  # iex times.ex
  # iex
  # > c("times.ex")

  # 3.) Add a quadruple function. (Maybe it could call the double function)
  def quadruple_literal(n) do
    4*n
  end
  def quadruple(n)do
    2*double(n)
  end

end
