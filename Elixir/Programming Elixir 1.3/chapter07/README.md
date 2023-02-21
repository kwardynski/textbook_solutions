# CHAPTER 07 - LISTS AND RECURSION

## Problems:
0. I defined our sum function to carry a partial total as a second parameter so I could illustrate
   how to use accumulators to build values. The sum function can also be written without an accumulator. 
   Can you do it?

   Yes - I think we can simply call `Enum.sum`... Not sure if I'm being cheeky or if that's what the
   autor is actually after.

1. Write a `mapsum` function that takes a list and a function. It applies the function to each element of the 
   list and sums the result, so `mapsum([1,2,3], &(&1*&1))` returns 14.
   - Use Enum.map to apply a function to all elements of a list
   - Use Enum.sum to return the sum of the resultant list
   - This could also be done with an accumulator but let's not

2. Write a `max(list)` function that returns the element with the maximum value in the list. (This is
   slightly trickier than it sounds)

   This could easily be done with an if/than statement, but since we're practicing Elixir I'm guessing
   the intent is to do this with guard statements.\
   We also don't want to pass 0 as the initial value since the list could all be negative, so we'll overload
   this function to return the head of the list if it's given 1 argument, or run the comparison if it's given 
   two arguments.

3. An Elixir single-quoted string is actually a list of individual character codes. Write a `casear(list, n)` 
   function that adds n to each list element, wrapping if teh addition results in a character greater than 'z'.

   I'm going to force the input to be a char list, then I'm going to set it all to lower case so we
   don't have to deal with upper case characters. I know that's lazy but what are *you* going to do about it?

4. Write a function `MyList.span(from, to)` that returns a list of the numbers from 'from' to 'to'.\
    i.e. `MyList.span(2,5)` returns `[2, 3, 4, 5]`

    We should probably use guard clauses to check and enforce that this runs if 'to' < 'from'
      * Turns out Enum.list(x..y) doesn't care if y < x
      * I'm going to call this `Chapter07.span/2` since it's in the `Chapter07` module and I don't
        want to define another module just for this. Lazy - I know.
