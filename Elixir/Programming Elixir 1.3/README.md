# Programming Elixir 1.3
## Textbook Problems

NOTE:
Mix isn't introduced until Chapter 13, but I've been using it for all the preceeding chapters./
It really wasn't necessary since all the solution functions live inside one module and there are no tests - I may re-factor this at some point.


[Chapter 5 - Anonymous Functions](https://github.com/kwardynski/textbook_problems_elixir_programming_elixir_1.3/tree/master/chapter05)
* The two do_guess attempts on lines 101 and 108 could probably be combined into 1 block. The new_range would be created within an if/else statement, that way you could cut down on some redundant code.

[Chapter 6 - Modules and Named Functions](https://github.com/kwardynski/textbook_problems_elixir_programming_elixir_1.3/tree/master/chapter06)
* Not going to do 7.e -> Use "Poison.decode!()" to convert JSON string to Elixir data structure
* When using System.cmd -> second argument MUST be a list of arguments

[Chapter 7 - Lists and Recursion](https://github.com/kwardynski/textbook_problems_elixir_programming_elixir_1.3/tree/master/chapter07)

[Chapter 10 - Processing Collections-Enum and Stream](https://github.com/kwardynski/textbook_problems_elixir_programming_elixir_1.3/tree/master/chapter10)
* Problems start numbered at 5 since they're a continuation of the problems from CH07 (where they ended at 4)

[Chapter 11 - Strings and Binaries](https://github.com/kwardynski/textbook_problems_elixir_programming_elixir_1.3/tree/master/chapter11)
* No code for Problem 3: description of the solution is in [chapter11.ex](https://github.com/kwardynski/textbook_problems_elixir_programming_elixir_1.3/blob/master/chapter11/lib/chapter11.ex)
  * ['cat' | 'dog'] displays at ['cat' 100, 111, 103] because 'cat' is the head in the [head | tail] pattern match, therefore it is treated as a single element

[Chapter 12 - Control Flow](https://github.com/kwardynski/textbook_problems_elixir_programming_elixir_1.3/tree/master/chapter12)

[Chapter 13 - Organizing a Project](https://github.com/kwardynski/textbook_problems_elixir_programming_elixir_1.3/tree/master/chapter13)

[Chapter 14 - Tooling](https://github.com/kwardynski/textbook_problems_elixir_programming_elixir_1.3/tree/master/chapter14)

[Chapter 15 - Working with Multiple Processes](https://github.com/kwardynski/textbook_problems_elixir_programming_elixir_1.3/tree/master/chapter15)

[Chapter 16 - Nodes-The Key to Distributing Services](https://github.com/kwardynski/textbook_problems_elixir_programming_elixir_1.3/tree/master/chapter16)

[Chapter 17 - OTP: Servers](https://github.com/kwardynski/textbook_problems_elixir_programming_elixir_1.3/tree/master/chapter17)

[Chapter 18 - OTP: Supervisors](https://github.com/kwardynski/textbook_problems_elixir_programming_elixir_1.3/tree/master/chapter18)
* `mix new --sup sequence` did not fill out `lib/sequence.ex` as expected... What the author claims to be the contents of `lib/sequence.ex` are the contents of `lib/sequence/application.ex`
* There's also a mix of worker/supervisor lists as the child specifications have changed between the current Elixir release and Elixir 1.3 in the text

[Chapter 19 - OTP: Applications](https://github.com/kwardynski/textbook_problems_elixir_programming_elixir_1.3/tree/master/chapter19)
* I'm having nothing but problems trying to create a release using :exrm as a dependency - all I get are relx and erlware_commons compilation errors. I don't think any of this is actually necessary with Elixir 1.13 (what I'm running)
* A lot of this release stuff has changed between 1.3 and 1.13 so I'm going to skip the rest of this chapter.

[Chapter 20 - OTP: Tasks and Agents](https://github.com/kwardynski/textbook_problems_elixir_programming_elixir_1.3/tree/master/chapter20)
* No problems for this chapter, but the "follow along" examples are uploaded.

[Chapter 21 - Macros and Code Evaluation](https://github.com/kwardynski/textbook_problems_elixir_programming_elixir_1.3/tree/master/chapter21)