defmodule TodoList do

  def add_entry(todo_list, entry) do
    MultiDict.add(todo_list, entry.date, entry)
  end
end
