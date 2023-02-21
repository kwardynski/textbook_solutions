defmodule GenerateTestingData do

  # Deletes and re-makes a directory
  def clear_directory(path) do
    case File.exists?(path) do
      true  -> File.rm_rf!(path)
      false -> nil
    end
    File.mkdir(path)
  end


  # Generates num_files count of text files containing a random number (no more than max_words) and
  # assortment of words from library
  # Naming convention: fileXXX_YYY.txt
  #   XXX = file number
  #   YYY = number of words "cat" in the file
  def make_files(file_num, test_dir, max_words, library) do

    file_contents = Enum.map(Enum.to_list(1..:rand.uniform(max_words)), fn(_) -> Enum.random(library) end)
    total_cat = count_word(file_contents, "cat")
    file_name = "#{test_dir}file#{String.pad_leading(Integer.to_string(file_num),3,"0")}_#{String.pad_leading(Integer.to_string(total_cat),3,"0")}.txt"
    File.write!(file_name, Enum.join(file_contents, "\n"))

  end


  # Counts number of times a word appears in a list
  def count_word(word_list, word) do
    count_map = Enum.frequencies(word_list)
    case count_map[word] do
      nil -> 0
      _   -> count_map[word]
    end
  end

end

# Testing Parameters
max_files = 100
max_words = 50
library = ["the", "quick", "brown", "fox", "jumped", "over", "the", "lazy", "dog", "before", "scaring", "the", "gassy", "cat"]
num_files = :rand.uniform(max_files)

# Prepare testing files
test_dir = "testing_data/"
GenerateTestingData.clear_directory(test_dir)
Enum.each(Enum.to_list(1..num_files), fn(x) ->
  GenerateTestingData.make_files(x, test_dir, max_words, library)
end)
