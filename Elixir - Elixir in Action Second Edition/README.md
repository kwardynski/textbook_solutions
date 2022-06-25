## Chapter 1 - First steps
- I/O operations are internally delegated to separate threads in Erlang, therefore any process that waits for an I/O operation to finish won't block the execution of other processes.
- Why use Elixir over Erlang? Elixir presents cleaner, more compact code which does a better job of revealing the process's intentions. Programs written in Elixir will be compiled and executed in BEAM.
- Since Elixir/Erlang run on BEAM, programs will never achieve the speed of machine-compiled code (C/C++). The goal isn't maximizing performance, instead the focus is to keep performance as predictable, reliable, and fault-tolerant as possible.

## Chapter 2 - Building Blocks 
- Everyting in Elixir is an expression that has a return value. This extends to constructs such as `if` and `case`.
- Elixir is dynamically typed -> the variable type is determined by the data which it contains at the moment.
- In Elixir, assigning a value to a variable is called _binding_.
- Data is immutable - once a memory location is occupied with data, it cannot be modified until that memory address is purged. Variables, however, can be re-bound. This simply makes them point to a different memory location. **Variables are mutable, data is immutable**.
- Elixir has automatic garbage-collection. This means memory does not have to be manually released. When a variable goes out of scope, the corresponding memory will be released sometime in the future.
- Tuples are most appropritae for grouping small, fixed number of elements together. Use lists for larger, dynamically sized collections.
- In Elixir, lists might _look_ like array from other languages, however they behave like singly-linked lists. Most of the operations on lists have O(n) time complexity (including getting the length of a list), therefore are not a good fit when direct access is called for.
    - When you modify the _n_th element of a list, the new version will contain shallow copies of the first _n_-1 elements, followed by the modified element. Ater that, the tails are completely shared. This is why adding elements to the end of a list is expensive in Elixir. To append a new element at the tail, you have to iterate and copy the entire list.
- Sigils can be useful for quick formatting of strings. The `~s` sigil allows you to include quotes without escape characters, and `~S` does not handle interpolation or escape characters:
```
iex(1) > ~s("Do... or do not. There is no try." - Master Yoda)
"\"Do... or do not. There is no try.\" - Master Yoda"

iex(2) > ~S(Not interpolated: #{3 + 0.14}\n)
"Not interpolated: #{3 + 0.14}\\n"
```

## Chapter 3 - Control flow
No notes taken for this chapter, however solutions to practice problems can be found [here](./ch03_practice/)

## Chapter 4 - Data abstractions
The basic principles of data abstraction in Elixir:
- A module is in charge of abstracting some data.
- The module's functions usually expect an instance of the data abstraction as the first argument.
- Modifier functions return a modified version of the abstraction.
- Query functions return some other type of data.

