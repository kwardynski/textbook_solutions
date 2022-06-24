defmodule StreamPractice do

  @input_file "stream_practice.txt"

  # Returns a list of numbers representing the lengths of each line in a file
  def lines_lengths!(file_path \\ @input_file) do
    retrieve_file_stream(file_path)
    |> Enum.map(&String.length/1)
  end


  # Returns the length of the longest line in a file
  # We can re-use everything from lines_lengths!/1
  def longest_line_length!(file_path \\ @input_file) do
    lines_lengths!(file_path)
    |> Enum.max()
  end


  # Returns the contents of the longest line in a file
  def longest_line!(file_path \\ @input_file) do
    retrieve_file_stream(file_path)
    |> Enum.max_by(&String.length/1)
  end


  # Returns a list of numbers representing the word count for each line in a file
  def words_per_line!(file_path \\ @input_file) do
    retrieve_file_stream(file_path)
    |> Enum.map(&String.split/1)
    |> Enum.map(&length/1)
  end


  # Helper function - returns a lazy stream with newline characters removed
  defp retrieve_file_stream(file_path) do
    File.stream!(file_path)
    |> Stream.map(&String.replace(&1, "\n", ""))
  end

end
