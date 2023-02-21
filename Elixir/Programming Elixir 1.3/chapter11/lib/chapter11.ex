# CHAPTER 11
# STRINGS AND BINARIES



defmodule Chapter11 do

  # 1.) Write a functon that returns true if a single-quoted string
  #     contains only printable ASCII characters (space through tilde).
  # (?" ") = 32
  # ?~     = 126
  # Therefore we need to go through each char, check if it is in
  # the range 32..126
  # If we ever encounter a character that's in the range, just continue
  # throwing false
  @ascii_range 32..126
  def check_ascii(char_list) when is_list(char_list) do
    _check_ascii(char_list, true)
  end

  # If we make it to last character, return boolean of last character check
  defp _check_ascii([head | []], _) do
    case head in @ascii_range do
      true -> true
      false -> false
    end
  end
  defp _check_ascii([head | tail], true), do: _check_ascii(tail, head in @ascii_range)  # check first character in list - pass that as tracker into _check_ascii
  defp _check_ascii(_char_list, false), do: false                                       # if false ever encountered, continue with false



  # 2.) Write an anagram?(word1, word2) that returns true if its parameters
  #     are anagrams
  # Have 2 clauses - one guarding for lists and the other for strings
  # Check that the REVERSE of word1 == word1 as well as word2
  def anagram?(word1, word2) when is_list(word1) and is_list(word2), do: Enum.reverse(word1) == word1   && Enum.reverse(word1) == word2
  def anagram?(word1, word2),                                        do: String.reverse(word1) == word1 && String.reverse(word1) == word2



  # 3.) Try the following in iex:
  #       iex> ['cat' | 'dog']
  #       ['cat', 100, 111, 103]
  #     Why does iex print 'cat' as a string, but 'dog' as individual
  #     numbers?
  # If you flip it (['dog' | 'cat']), you get 'dog' printed as a string
  # and 'cat' as individual numbers - this is likely a result of pattern
  # matching: 'cat' is the head so it's presumed to be a single instance,
  # and everything following is a list.



  # 4.) Write a function that takes a single-quoted string in the form of
  #     'number [+-*/] number' and returns the result of the calculation.
  #     The individual numbers do not have leading plus or minus signs:
  #        i.e. calculate('123 + 27') returns 150
  # I'm skipping guard clauses for real here.
  def expression_calculator(input_equation) do
    input_equation_string = List.to_string(input_equation)                # convert input LIST into STRING
     [value_1, operator, value_2] = String.split(input_equation_string)   # split by spaces
    _expression_calculator(_to_num(value_1), _to_num(value_2), operator)  # calculate expression (convert the value strings to floats in the function call)
  end

  defp _to_num(value) do
    {float_value, _} = Float.parse(value)
    float_value
  end

  defp _expression_calculator(val1, val2, operator) do
    case operator do
      "+" -> val1 + val2
      "-" -> val1 - val2
      "*" -> val1 * val2
      "/" -> val1 / val2
      _ -> IO.puts("!! I don't think '#{operator}' is a valid operator... !! ")
    end
  end



  # 5.) Write a function that takes a list of dqs (double quoted strings) and
  #     prints each on a separate line, centered in a column that has the width
  #     of the longest string. Make sure it works with UTF characters.
  # - Find length of longest string (can use Enum.max_by)
  # - Loop through the list:
  #     - Required padding = longest length - current length
  #     - Split in half
  #     - Pad and print out the string
  # I wanted to use String.pad_leading but I can't seem to get that to play nice
  # with IO.puts or IO.write, so instead of constructing an output string we're
  # just going to do string interpolation...
  def list_to_column(input_list) when is_list(input_list) do
    longest_word = Enum.max_by(input_list, fn(x) -> String.length(x) end)
    longest_word_length = String.length(longest_word)
    Enum.each(input_list, fn(word) -> _print_centered_word(word, longest_word_length) end)
  end

  defp _print_centered_word(word, longest_word_length) do
    required_spaces = longest_word_length - String.length(word)
    padding = div(required_spaces, 2)
    IO.puts("#{String.duplicate(" ", padding)}#{word}")
  end



  # 6.) Write a function to capitalize the sentences in a string. Each sentence is
  #     terminated by a period and a space. Right now, the case of the characters
  #     in the string is random.
  #         capitalize_sentences("oh. a DOG. woof.") = "Oh. A dog. Woof"
  # 1. Split string by ". "
  # 2. Loop through sentences:
  #     2.a Capitalize first character
  #     2.b Lower the rest
  #     2.c Recombine
  # - The nice thing is String.capitalize takes care of 2.a and 2.b. It returns a string
  #   where the first character is capitalized and the rest are lower case
  # - This might be lazy since we're not ensuring that the last sentence
  #   ends with a period, but I'm assuming the given input string is all
  #   complete sentences..
  def capitalize_sentences(input_sentence) when is_binary(input_sentence) do
    input_sentence
    |> String.split(". ")
    |> Enum.map(fn(sentence) -> String.capitalize(sentence) end)
    |> Enum.join(". ")
    |> IO.puts()
  end



  # 7.) Chapter 7 had an exercise about calculating sales tax on page 110. We
  #     now have the sales information in a file of coma-separated id, ship_to,
  #     and amoutn values.
  #     Write a function that reads and parses this file and then passes the result
  #     to the sales_tax function. Remember that the data should be formatted into
  #     a keyword list, and that the fields need to be the correc types (so
  #     the id field is an integer, and so on)
  #     You'll need the library functions: File.open, IO.read(file, :line)
  #     and IO.stream(file).
  # I think there's a typo here, wasn't that problem was in chapter 10?

  # Compile the sales tax function (this will only work with the current
  # file structure)
  #    > c10_path = "../chapter10/lib/chapter10.ex"
  #    > Code.require_file(c10_path)
  #    > Code.compile_file(c10_path)
  # That's not going to work since the inputs were hard coded in, I'm just going
  # to copy and paste for the sake of not editing already completed problems.
  # This is a perfect argument AGAINST hard coding stuff in but I'm doing it again
  # here anyways

  def calculate_tax() do
    order_file = "lib/orders.csv"
    tax_rates = [NC: 0.075, TX: 0.080]

    read_orders(order_file)
    |> Enum.map(fn(order) -> _add_tax(order, tax_rates) end)

  end

  # Step 1 - Read in the file.
  # Seems like IO.stream/1 isn't a function, and this whole thing can be accomplished
  # using File.open! and IO.stream/2. This is corroborated by pcewing's solution as well
  defp read_orders(order_file) do
    orders = File.open!(order_file)
    [_header_line | data_lines] = Enum.map(IO.stream(orders, :line), fn(x) -> String.trim(x) end)
    Enum.map(data_lines, fn(x) -> parse_order(x) end)
  end

  # Step 2 - Parse the order
  # Split the lines up by the delimiter (,), and convert each value to the correct
  # type. ID and net amount should be parsed into their individual types, but according
  # to pcewing, you need to remove the colon from the State atom first before
  # you parse it
  defp parse_order(order_line) do
    [id_string, state_string, amt_string] = String.split(order_line, ",")   # split up the order line string

    IO.puts(amt_string)

    {id, _extra} = Integer.parse(id_string)                                 # parse the order id into an integer
    {amt, _extra} = Float.parse(amt_string)                                 # parse the amount into a float
    state = state_string |> String.replace(":", "") |> String.to_atom()     # generate state atom as described above
    Keyword.new([{:id, id}, {:ship_to, state}, {:net_amount, amt}])         # construt new keyword list
  end

   # Step 3 - Calculate (and insert) the after tax value as before!
   defp _add_tax(order, tax_rate) do
     tax = Keyword.get(tax_rate, order[:ship_to], 0)                        # pull tax by using ship-to keyword (with 0 as default)
     total_amount = Float.round((1+tax)*Keyword.get(order, :net_amount),2)  # calculate total amount and round to 2 sig figs
     Keyword.put(order, :total_amount, total_amount)                        # insert it
   end

end
