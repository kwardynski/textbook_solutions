# CHAPTER 06 - MODULES AND NAMED FUNCTIONS

## Notes:
* When writing guard clauses, short circuit operators (`||` and `&&`) are not allowed...
* When you define a named function, you can give a default value to any of the parameters with the syntax `param \\ default`


## Problems
Problems 1-3 are in the `times.ex` module, 4-7 are in the `other_problems.ex` module.

1. Extend the `Times` module with a triple function that multiplies its parameter by 3

2. Run the results in iex. Use both techniques to compile the file\
        * `iex times.ex`\
        * `iex`\
            > c("times.ex")

3. Add a quadruple funciton (Maybe it could call the double function)
    - `quadruple_literal(n)` multiples a value by 4
    - `quadruple(n)` call `double(n)` and multiplies the result by 2

4. Implement and run a function `sum(n)` that uses recursion to calculate the sum of integers from
   1 to n. You'll need to write this function inside a module in a separate file.
    - This is easily implemented with recursion
    - A guard clause prevents passing a negative value for `n`, or else the recursion would go on forever

5.  Write a function `gcd(x,y)` that finds the greatest common divisor between two non-negative integers. 
    Algebraically, `gcd(x,y`) is `x` if `y` is zero; it's `gcs(y, rem(x,y))` otherwise.
    - I'm going to skip the guard clause here - we're not dealing with guard clauses or conditional
      statements here so oh well... 

6. I'm thinking of a number between 1 and 1000... The most efficient way to find a number is to guess halfway between the
   low and high numbers of the range. If our geuss is too big, then the answer lies between the bottom of the range and one less than our guess. If our guess is too small, then the answer lies between one or more than our guess 
   and the end of the range. Your API will be guess(actual, range) where range is an Elixir range.\
   **HNTS:**
    * You may need to implement a helper function with an additional parameter (the currently guessed number)
    * The div(a,b) function performs integer division
    * Guard clauses are your friends
    * Patterns can match the low and high parts of a range (a..b = 4..8)

    Basically for this, find the midpoint of the range and compare the the input value. If it's larger, split min..(guess-1) in 
    half and keep going. If it's smaller, split (guess+1)..max in half and keep going. There are ample guard clauses here
    which ensure an integer is passed as argument 1, and a range which contains argument 1 is passed in as argument 2.

7. Find the library functions to do the following, and then use each in iex.
    - Convert a float to a string with two decimal digits (Erlang) -> `:erlang.float_to_binary`
    - Get the value of an operating-system environment variable (Elixir) -> `System.get_env`
    - Return the extension component of a file name (Elixir) -> `Path.extname`
    - Return the process's current working directory (Elixir)-> `File.cwd`
    - Convert a string containing JSON into Elixir data structures. -> `Poison.decode!`
    - Execute a command in your operating system's shell -> `System.cmd`

    I'm not goint to do too much in the way of guards and checks here - for simplicity all the function calls
    are going to assume you're not a dingus and hte inputs are always the correct class/format. I'm also going
    To skip 7.e, just use `Poison.decode!`
