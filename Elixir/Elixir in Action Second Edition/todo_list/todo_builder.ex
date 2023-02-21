defmodule TodoList do

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TodoList{},                        # <-- initial accumulator value
      fn entry, todo_list_acc ->
        add_entry(todo_list_acc, entry)   # <-- iteratively updates the accumulator
      end
    )

    # The add_entry lambda can be made more compact with the capture operator:
    # &add_entry(&2, &1)
  end
end
