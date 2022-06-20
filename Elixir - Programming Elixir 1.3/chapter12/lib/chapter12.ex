# CHAPTER 12
# CONTROL FLOW



defmodule Chapter12 do

  # 1.) Rewrite the FizzBuzz example using case
  # I'm just going to hard-code in this going from 1-20
  # You get the point...
  def fizzbuzz() do
    1..20
    |> Enum.to_list()
    |> Enum.map(fn(x) -> _fizzbuzz(rem(x,3), rem(x, 5), x) end)
  end

  defp _fizzbuzz(a,b,c) do
    case {a,b,c} do
      {0, 0, _} -> "FizzBuzz"
      {0, _, _} -> "Fizz"
      {_, 0, _} -> "Buzz"
      {_, _, _} -> c
    end
  end



  # 2.) We now have three different implementations of FizzBuzz. One uses
  #     cond, one uses case, and one uses separate functions with guard clauses.
  #     Take a minute to look at all three. Which do you feel best expresses
  #     the problem. Which will be easiest to maintain?
  #     The case style and the implementation using guard clauses are different
  #     from control structures in most other languages. If you feel that one
  #     of these was the best implementation, can you think of ways to remind
  #     yourself to investigave these options as you write Elixir code in
  #     the future?

  # I think the most recent one (case) best expresses the problem. It's a relatively
  # easy problem to understand, and seeing the four possible options laid out
  # one after the other makes the most sense from a quick-reference standpoint. That
  # being said, using separate functions with guard clauses will likely be the easiest
  # to maintain one function behavior without affecting the others - although you can
  # achieve something similar with the case version.
  # I try to write code that is dynamic and easy to follow, so I will likely choose
  # the methods that allow for that style of code.



  # 3.) Many built in functions have two forms. The xxx form returns the tuple
  #     {:ok, data} and the xxx! form returns data on success but raises and
  #     exception otherwise. However, some functions do not have the xxx! form.
  #     Write an ok! function that takes an arbitary parameter. If the parameter
  #     is the tuple {:ok, data}, return the data. Otherwise raise an exception
  #     containing information from the parameter.
  def ok!({:ok, data}), do: data
  def ok!(input) do
    IO.inspect(input)
    raise RuntimeError
  end


end
