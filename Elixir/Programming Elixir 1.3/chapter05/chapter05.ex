defmodule Chapter05 do

  # 1.a
  def list_concat(list1, list2) do
    list1 ++ list2

    # as anonymous function:
    # iex> list_concat = fn(list1, list2) -> list1 ++ list2 end
  end

  # 1.b
  def sum(a, b, c) do
    a + b + c

    # as anonymous function:
    # iex> sum = fn(a, b, c) -> a+b+c end
  end

  # 1.c
  def pair_tuple_to_list(tuple) do
    # you can also pattern match the arguments list as pair_tuple_to_list({part1, part2})
    {part1, part2} = tuple
    [part1, part2]

    # as anonymous function:
    # iex> pair_tuple_to_list = fn({part1, part2}) -> [part1, part2] end
  end


  # 2
  def fizzbuzz_proto(a,b,c) do
    case {a,b,c} do
      {0,0,_} -> IO.puts("FizzBuzz")
      {0,_,_} -> IO.puts("Fizz")
      {_,0,_} -> IO.puts("Buzz")
      {_,_,c} -> IO.puts("#{c}")
    end
  end


  # 3
  def fizzbuzz(n) do
    fizzbuzz_proto(rem(n,3), rem(n,5), n)
  end


  # 4
  def prefix(string1) do
    fn string2 -> "#{string1} #{string2}" end
  end

end



# ---------------------------------------------------------------------- #
# Run the problem 3 loop
IO.puts("\nProblem 3: Run FizzBuzz \"Loop\"")
for n <- 10..16, do: Chapter5.fizzbuzz(n)

# Test the problem 4 prefix function
IO.puts("\nProblem 4: Prefix")
test_fn = Chapter5.prefix("Hello")
IO.puts(test_fn.("kwardynski"))
