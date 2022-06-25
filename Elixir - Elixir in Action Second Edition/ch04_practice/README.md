# Data Abstraction Practice
Create a `TodoList` instance using a comma-separated file.
- Assume you have a `todos.csv` file in the current folder
- Each line of the file describes a single to-do entry: `2018/12/19,Dentist`
- Assume the comma character doesn't appear in the entry title.

### SOLUTION:
The function `TodoList.CsvImporter.import/1` re-uses some of the functionality from Chapter 3's stream practice - it reads in the todo list and returns a list of maps each with a `date` key and a `title` key. This function is called by `TodoList.import/2`, and each of the entries are then passed into `TodoList.add_entry/2` which adds the individual entries to the `%TodoList{}` struct.
```
iex todo_from_file.ex

iex(1)> TodoList.import()
%TodoList{
  auto_id: 4,
  entries: %{
    1 => %{date: ~D[2018-12-19], id: 1, title: "Dentist"},
    2 => %{date: ~D[2018-12-20], id: 2, title: "Shopping"},
    3 => %{date: ~D[2018-12-19], id: 3, title: "Movies"}
  }
}
```