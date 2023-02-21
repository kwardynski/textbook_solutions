# CHAPTER 05 - ANONYMOUS FUNCTIONS

## Notes:
* Anonymous functions (unlike named functions) require a "." between the function and parameter list
`fn.(arg1, arg2)`
* If a function takes no arguments, you still need parentheses to call it, 
but you can omit the parentheses from the function definition.
    * Is this true? seems to be with anonymous functions, however not named functions


## Problems

1. Create a function that does the following:\
    a. list_concat.([:a, :b], [:c, :d]) #=> [:a, :b, :c, :d]\
    b. sum.(1,2,3) #=> 6\
    c. pair_tuple_to_list.({1234, 5678}) #=> = [1234, 5678]
    
    These live as named functions in the chapter05.ex file, but their anonymous counterparts can be 
    as comments within the function definition

2. Create a function that takes 3 arguments. If the first two are zero, return "FizzBuzz".
If the first is zero, return "Fizz". If the second is zero return "Buzz". 
Otherwise return the third argument.

3. The operator `rem(a,b)` returns the remainder after dividing `a` by `b`. 
Write a function that takes a single integer `n`, and calls the function in the previous exercise, 
passing it `rem(n,3)`, `rem(n,5)` and `n`. Call it seven times with the arguments 10 -> 16.
You should get:\
`Buzz, 11, Fizz, 13, 14, FizzBuzz, 16`

    A for loop outside of the module calls this function, and displays the results in the console

4. Write a function `prefix` that takes a string. It should return a new function that takes
a second string. When that second function is called, it will return a string containing
the first string, a space, and the second string.

    A call to this function is made outside the module, and displays the results in the console

5. Use the `&` notation to rewrite the following:\
    a. Enum.map [1,2,3,4], fn x -> x + 2 end\
    b. Enum.each [1,2,3,4], fn x-> IO.inspect x end

```
> Enum.map [1,2,3,4], &(&1 + 2)
> Enum.each [1,2,3,4], &(IO.inspect(&1))
```