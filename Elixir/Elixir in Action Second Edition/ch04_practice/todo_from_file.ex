defmodule TodoList do

  @default_todo_file "todos.csv"
  defstruct auto_id: 1, entries: %{}

  def new() do
    %TodoList{}
  end

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)
    new_entries = Map.put(
      todo_list.entries,
      todo_list.auto_id,
      entry)
    %TodoList{todo_list | entries: new_entries, auto_id: todo_list.auto_id+1}
  end

  def import(todo_list \\ new(), todo_file \\ @default_todo_file) do
    TodoList.CsvImporter.import(todo_file)
    |> Enum.reduce(todo_list, fn(entry, acc) -> add_entry(acc, entry) end)
  end

end


defmodule TodoList.CsvImporter do

  # Imports a todo-list and stores as a list of maps
  def import(todo_file) do
    File.stream!(todo_file)                         # stream the file
    |> Stream.map(&String.replace(&1, "\n", ""))    # replace each newline character
    |> Stream.map(&String.replace(&1, "/", "-"))    # replace slash date delimiter with dash (easier formatting later on)
    |> Stream.map(&String.split(&1, ","))           # split at comma delimiter
    |> Enum.map(fn([date, title]) ->                # construct list of maps representing the todo list
      %{
        date: Date.from_iso8601!(date),
        title: title,
      }
    end)
  end

end
