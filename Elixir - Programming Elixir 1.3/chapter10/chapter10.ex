# CHAPTER 10
# PROCESSING COLLECTIONS - ENUM AND STREAM



defmodule Chapter10 do

  # 5.a
  def hard_all(list, f) do
     _hard_all(list, f)
  end

  defp _hard_all([], _), do: true
  defp _hard_all([head | tail], f) do
    case f.(head) do
      true -> _hard_all(tail, f)
      false -> false
    end
  end

  # 5.b
  def hard_each(list, f) do
    _hard_each(list, f)
  end

  defp _hard_each([], _), do: IO.puts("We're done with hard_each")
  defp _hard_each([head | tail], f) do
    f.(head)
    _hard_each(tail, f)
  end

  # 5.c
  def hard_filter(list, f) do
    _hard_filter(list, f, [])
  end

  defp _hard_filter([], _f, accumulator), do: accumulator
  defp _hard_filter([head | tail], f, accumulator) do
    if f.(head) do
      _hard_filter(tail, f, accumulator ++ [head])
    else
      _hard_filter(tail, f, accumulator)
    end
  end

  # 5.d
  def hard_split(list, count) when is_list(list) and is_integer(count) and count <= length(list) and count >= 0 do
    _hard_split({[], list}, count)
  end

  defp _hard_split({list_1, list_2}, count) when length(list_1) == count, do: {list_1, list_2}
  defp _hard_split({list_1, [head | tail]}, count) do
    _hard_split({list_1 ++ [head], tail}, count)
  end

  # 5.e
  def hard_take(_, 0), do: []
  def hard_take(list, amount) when is_list(list) and is_integer(amount) and abs(amount) <= length(list) do

    count = _hard_take_get_count(length(list), amount)  # calculate count (where to split the list)
    split_list = hard_split(list, count)                # split the list using hard split
    _hard_take_pull_result(split_list, amount)          # return the apropriate list from returned tuple

  end

  # Calculate split location based on sign of amount
  defp _hard_take_get_count(list_length, amount) when amount <= 0, do: list_length + amount
  defp _hard_take_get_count(_list_length, amount),                 do: amount

  # Return appropriate list from split tuple based on sign of amount
  defp _hard_take_pull_result({_list_1, list_2}, amount) when amount < 0, do: list_2
  defp _hard_take_pull_result({list_1, _list_2}, amount) when amount > 0, do: list_1


  # 6.
  defp _hard_flatten(flat_list, list) when length(list) == 0,          do: flat_list                                                  # return flattened list when input_list is emptied
  defp _hard_flatten([], [head | tail]) when not is_list(head),        do: _hard_flatten([head], tail)                                # force head to be a list if head is not a list ON FIRST RUN
  defp _hard_flatten(flat_list, [head | tail]) when not is_list(head), do: _hard_flatten(flat_list ++ [head], tail)                   # pop off head - concatenate if head IS NOT A LIST
  defp _hard_flatten(flat_list, [head | tail]) when is_list(head),     do: _hard_flatten(flat_list ++ _hard_flatten([], head), tail)  # pop off head, if it is a list, run recursively on it


  # 7.
  def return_prime(max_value) when is_integer(max_value) and max_value > 2 do
    for i <- Enum.to_list(2..max_value), prime_checker_handler(i), do: i
  end

  # Even numbers cannot be prime - return false
  defp prime_checker_handler(val) when rem(val,2) == 0, do: false

  # If odd - check to see if actually a prime number.
  defp prime_checker_handler(val) when rem(val,2) == 1 do
    max_query_value = round(:math.sqrt(val))                            # max query value
    query_list = Enum.drop_every(Enum.to_list(2..max_query_value),2)    # make list 3-> max query value (drop even numbers)
    prime_checker(val, query_list, true)                                # check if prime
  end

  defp prime_checker(_val, [], condition),   do: condition
  defp prime_checker(_, _, false),           do: false
  defp prime_checker(val, [head | tail], _), do: prime_checker(val, tail, rem(val, head) != 0)



  # 8.
  @tax_rates  [NC: 0.075, TX: 0.080]
  @orders  [
    [id: 123, ship_to: :NC, net_amount: 100.00],
    [id: 124, ship_to: :OK, net_amount:  35.50],
    [id: 125, ship_to: :TX, net_amount:  24.00],
    [id: 126, ship_to: :TX, net_amount:  44.80],
    [id: 127, ship_to: :NC, net_amount:  25.00],
    [id: 128, ship_to: :MA, net_amount:  10.00],
    [id: 129, ship_to: :CA, net_amount: 102.00],
    [id: 130, ship_to: :NC, net_amount:  50.00]
  ]

  def add_tax() do
    Enum.map(@orders, fn(order) -> _add_tax(order, @tax_rates) end)
  end

  # This isn't looking too "Elixir-ish" but oh well...
  defp _add_tax(order, tax_rate) do
    tax = Keyword.get(tax_rate, order[:ship_to], 0)                        # pull tax by using ship-to keyword (with 0 as default)
    total_amount = Float.round((1+tax)*Keyword.get(order, :net_amount),2)  # calculate total amount and round to 2 sig figs
    Keyword.put(order, :total_amount, total_amount)                        # insert it
  end

end
