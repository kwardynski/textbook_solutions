
defmodule Issues.ColumnFormatter do

  @moduledoc """
  Exercise: OrganizingAProject-4
  Write the code to format data into columns, like the sample output at
  the start of the chapter. Try to do it wihtout using if or cond
  """

  @doc """
  Returns a list of keys from the input_data list.
  Not putting any guards or pattern matching in the function definition since
  it's only being used here and I know it's correct. inb4 poor coding practice
  """
  def get_data_keys(input_map_list) do
    [h | _] = input_map_list
    Map.keys(h)
  end


  @doc """
  Returns length of longest datum per key in the map list
  """
  def get_longest_string(key_list, input_map_list) do
    do_get_longest_string(key_list, input_map_list, %{})
  end

  # Reduce the data down to a list of datum per attribute
  # Find the longest one, add to "longest_string_list"
  defp do_get_longest_string([], _, longest_string_list), do: longest_string_list
  defp do_get_longest_string([h | t], input_map_list, longest_string_list) do
    longest_entry = Enum.map(input_map_list, fn(x) -> x[h] end)
    |> Enum.max_by(fn(x) -> String.length(x) end)
    do_get_longest_string(t, input_map_list, Map.put(longest_string_list, h, String.length(longest_entry)))
  end


  @doc """
  Display the table
    - Spoof a "input_data" map with the header values in the title to re-use the write_lines function
    - Write out the border (this code kinda sucks but it works)
    - Write out the data lines
  """
  def display_table(longest_string_list, input_data) do

    # Write the title
    write_lines(longest_string_list, [%{id: "#", created_at: "created_at", title: "title"}])

    # Write the "border"
    IO.puts(String.duplicate("-", longest_string_list[:id]+2) <> "+"
      <> String.duplicate("-", longest_string_list[:created_at]+2) <> "+"
      <> String.duplicate("-", longest_string_list[:title]+2))

    # Write the data
    write_lines(longest_string_list, input_data)
  end


  @doc """
  Write the actual lines
    - Create the padded string for each portion
    - Display in terminal with IO.puts()
    - Run recursively until input_data list is empty
  """
  def write_lines(_, []), do: nil
  def write_lines(longest_string_list, [h | t]) do
    id_line = format_string(h[:id], longest_string_list[:id])
    created_at_line = format_string(h[:created_at], longest_string_list[:created_at])
    title_line = format_string(h[:title], longest_string_list[:title])
    IO.puts(" #{id_line} | #{created_at_line} | #{title_line}")
    write_lines(longest_string_list, t)
  end


  @doc """
  Pad the data lines with space at the end to match longest column datum length
  """
  def format_string(input_string, required_length) do
    input_string <> String.duplicate(" ", required_length - String.length(input_string))
  end

end

# Here I'll define a dataset for testing - I'll use a list of maps with 3 attributes
#     This isn't the best way to do it per-se but let's roll with it for the sake of
#     getting the problem done
#     For the sake of simplicity, I'm going to set the id: class to string
input_data = [
  %{id: "889", created_at: "2013-03-16T22:03:13Z", title: "MIX_PATH environment variable (of sorts)"},
  %{id: "892", created_at: "2013-03-20T19:22:07Z", title: "Enhanced mix test --cover"},
  %{id: "893", created_at: "2013-03-21T06:23:00Z", title: "mix test time reports"},
  %{id: "898", created_at: "2013-03-23T19:19:08Z", title: "Add mix compile --warnings-as-errors"}
]

## Main driver:
# Issues.ColumnFormatter.get_data_keys(input_data)
# |> Issues.ColumnFormatter.get_longest_string(input_data)
# |> Issues.ColumnFormatter.display_table(input_data)
