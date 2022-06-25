defmodule RecursionPractice do

  # Function to calculate the length of a list
  # Non tail-call-recursive form
  def list_len_nonTC([]), do: 0
  def list_len_nonTC([ _head | tail ]) do
    1+list_len_nonTC(tail)
  end

  # Function to calculate the length of a list
  # Tail-call-recursive form
  def list_len_TC(input_list) when is_list(input_list) do
    do_list_len_TC(input_list, 0)
  end

  defp do_list_len_TC([], len), do: len
  defp do_list_len_TC([_head |tail ], len) do
    do_list_len_TC(tail, len+1)
  end


  # Function to return a list of integers in a given range
  # Non tail-call-recursive form
  def range_nonTC(from, to) when from > to, do: []
  def range_nonTC(from, to) do
    [from] ++ range_nonTC(from+1, to)
  end

  # Function to return a list of integers in a given range
  # Tail-call-recursive form
  def range_TC(from, to) do
    do_range_TC(from, to, [])
  end

  defp do_range_TC(from, to, range_list) when to < from, do: range_list
  defp do_range_TC(from, to, range_list) do
    do_range_TC(from, to-1, [to | range_list])
  end


  # Function to return only the positive values from a list
  # Non tail-call-recursive form
  def positive_nonTC([]), do: []
  def positive_nonTC([head | tail]) do
    case head > 0 do
      true  -> [head] ++ positive_nonTC(tail)
      false -> positive_nonTC(tail)
    end
  end

  # Function to return only the positive values from a list
  # Tail-call-recursive form
  def positive_TC(input_list) when is_list(input_list) do
    do_positive_TC(input_list, [])
  end

  def do_positive_TC([], positive_list), do: Enum.reverse(positive_list)
  def do_positive_TC([head | tail], positive_list) do
    case head > 0 do
      true  -> do_positive_TC(tail, [head | positive_list])
      false -> do_positive_TC(tail, positive_list)
    end
  end

end
