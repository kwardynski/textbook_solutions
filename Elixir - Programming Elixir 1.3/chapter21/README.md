# CHAPTER 21 - Macros and Code Evaluation

This is the first chapter where I'm actively confused reading through it the first time. Hopefully solving the practice problems helps make these use cases clear.

## Problems:

1. Write a macro called `myunless` that implements the standard `unless` functionality. You're allowed to use the regular `if` expression in it.

This is basically the "opposite" of the `myif` macro from the textbook (i.e. the `do` and `else` clauses are switched in the `case` block) so the code is going to be very similar.

```
iex my_unless.exs
iex(1)> require My
My
iex(2)> My.unless 420==69 do IO.puts("Different Funny Numbers") else IO.puts("Same Funny Numbers") end
Different Funny Numbers
:ok
iex(3)> My.unless 69==69 do IO.puts("ans != Nice") else IO.puts("ans = Nice") end
ans = Nice
:ok
```

2. Write a macro called `times_n` that takes a single numeric argument. It should define a function called `times_n` in the caller's module that itself takes a single argument, and multiplies that argument by `n`. So calling `times_n(3)` should create a function called `times_3` and calling `times_3(4)` should return 12. Here's an example of it in use:
```
defmodule Test do
    require Times
    Times.times_n(3)
    Times.times_n(4)
end

IO.puts Test.times_3(4)  # => 12
IO.puts Test.times_4(5)  # => 20
```

- We need to define the function handle as an atom - if done with a string we get a compile error downstream

