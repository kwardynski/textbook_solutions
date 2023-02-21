defmodule Chapter07 do

  # 0.
  # Sum function in quesiton (with accumulator) from the text
  def sum_accumulator(list),                   do: _sum_accumulator(list, 0)           # main driver function - easier to call (has no accumulator)
  defp _sum_accumulator([], total),            do: total                               # sum function with empty list - just return accumulator
  defp _sum_accumulator([head | tail], total), do: _sum_accumulator(tail, head+total)  # sum function wit list - add head to total and run recursion on tail

  # Here I'm just going to call Enum.sum within a named function
  def sum_no_accumulator(list), do: Enum.sum(list);


  # 1.
  def mapsum(input_list, input_function) when is_list(input_list) and is_function(input_function) do
    input_list
    |> Enum.map(input_function) # pipe the list and input function into Enum.map
    |> Enum.sum()               # pipe that into Enum.sum to get the answer
  end


  # 2.
  def find_max(input_list) when is_list (input_list) do
    _find_max(input_list)
  end

  defp _find_max([head | tail]), do: _find_max(head, tail)                                                # if passed a list, assume head is current max and run _find_max/2
  defp _find_max(current_max, [head | tail]) when current_max > head, do: _find_max(current_max, tail)    # if current_max > next element, compare that with tail
  defp _find_max(current_max, [head | tail]) when current_max < head, do: _find_max(head, tail)           # if current max < next element, update max and compare with tail
  defp _find_max(current_max, []),                                    do: current_max                     # if reached end of list, return the max found value


  # 3.
  def caesar(char_list, n) when is_list(char_list) and is_integer(n) do
    char_list
    |> to_string()                                  # convert to a string
    |> String.downcase()                            # force string to be lower case
    |> to_charlist()                                # convert back to a charlist
    |> Enum.map(fn(char) -> _caesar(char, n) end)   # take each element of char_list and pass it through _caesar
  end

  defp _caesar(char, n) do
    max_val = ?z              # max allowable value (z)
    total_vals = ?z - ?a + 1  # total values (z - a + 1)

    # Check for wrapping condition, return appropriate value
    case char + n do
      new_char when new_char > max_val -> new_char - total_vals
      new_char when new_char < max_val -> new_char
    end
  end


  # 4.
  def span(from, to) do
    Enum.to_list(from..to)
  end

end
