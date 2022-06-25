defmodule TodoList do

  def new() do
    %{}
  end

  def add_entry(todo_list, date, title) do
    Map.update(
      todo_list,
      date,
      [title],                        # <-- initial value
      fn titles -> [title | titles]   # <-- updater lambda
    )
  end

  def entries(todo_list, date) do
    Map.get(todo_list, date, [])
  end

end
