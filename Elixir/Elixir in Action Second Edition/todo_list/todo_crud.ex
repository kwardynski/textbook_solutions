defmodule TodoList do

  # Struct that describes the to-do list
  defstruct [
    auto_id: 1,
    entries: %{}
  ]

  # Creates a new TodoList struct instance
  def new(), do: %TodoList{}


  # Function to add a new entry to the to-do list
  # It must also st the ID for the entry being added and auto_increment the auto_id field
  def add_entry(todo_list, entry) do

    # Sets the new entry's ID
    entry = Map.put(entry, :id, todo_list.auto_id)

    # Adds the new entry to the entries list
    new_entries = Map.put(
      todo_list.entries,
      todo_list.auto_id,
      entry
    )

    # Updates the struct
    %TodoList{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
  end


  # Returns any tasks for the given day
  def entries(todo_list, date) do
    todo_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)   # filters entries
    |> Enum.map(fn {_, entry} -> entry end)                     # takes only the value
  end


  # Updates an entry based on the given function and entry id
  #   1.  Look up the entry with the given ID using Map.fetch
  #   2a. If entry doesn't exist, you receive an :error, and return
  #       the original version of the list
  #   2b. If the entry exists, you receive {:ok, value}, upon which you can
  #       call the updater function, store the modified entry, add it to the
  #       TodoList instance, and return the new instance
  def update_entry(todo_list, entry_id, updater_fun) do
    case Map.fetch(todo_list.entries, entry_id) do
      # No entry - returns the unchanged list
      :error -> todo_list
      # Entry exists, performs the update and returns the modified list
      {:ok, old_entry} ->
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList{todo_list | entries: new_entries}
    end
  end


  # Deletes and entry from the to-do list
  def delete_entry(todo_list, entry_id) do
    %TodoList{todo_list | entries: Map.delete(todo_list.entries, entry_id)}
  end

end
