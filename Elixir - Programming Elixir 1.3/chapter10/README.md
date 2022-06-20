# CHAPTER 10 - PROCESSING COLLECTIONS, ENUM AND STREAM

## Problems:

5. Implement the following Enum functions using no library functions of list comprehensions: all?, each, 
   filter, split, and take. You may need to use an if statement to implement filter

   I'm going to assume the user puts the correct types in for these arguments, so even though I know
   it's lazy, we're going to skip some guard clauses here.

    - a. `Enum.all?` - checks whether ALL elements in a list meet a condition. The main driver function
      will take a list and a function which returns a boolean, then we'll do some recursion on that
      list to validate. If one value passes, move on to the next. If anything fails, return false. We
      also need a condition for empty list (which indicates all values passed the test)
    - b. `Enum.each` - invokes a function on each element of a list. Same as above except we just need 
      run the function.
    - c. `Enum.filter` - returns only those elements for which `f` returns true. We can use an accumulator for this. Since 
      we aren't supposed to use any library functions, I'm assuming we can't append any values that pass the
      filter to the head of the accumulator and revers, so I'm going to do `[list] ++ [val]` to keep things in order,
      even though that's taxing computationally.
    - d. `Enum.split` - Splits the list in two, leaving `x` elements in teh first one. Returns the data as a tuple of
      lists: `{[list_1], [list_1]}`. We'll add some guards here to make sure the function is being passed a list, and the
      count is a positive integer. Process this with recursion, pop the head off the list and append it to the
      end of a new list.
    - e. `Enum.take` - takes an 'amount' of elements from an enumerable. Positive amount, takes from the beginning. Negative
      amount, takes from the end. 0 returns []. Again, let's use some guards here to make sure we're passing a list to the
      function, and an integer whose **ABSOLUTE** value is less that the length of the list (since we can have negative
      inputs).\
      I'm actually going to calculate 'count' based on amount (positive or negative) and re-cycle `hard_split` from
      5.d above.

6. Write a flatten(list) functoin that takes a list that may contain any number of sublists, which themselves may contain sublists, to any depth. It returns the elements of these lists as a flat list:\
`[1, [2, 3, [4] ], 5, [[[6]]]] = [1,2,3,4,5,6]`
    - Introduce guard clauses such that input has to be a list, and has to contain at least 1 element.
    - If list of length 1 is passed, simply return that list.
    - Pop off head of input list, concatenate to end of an accumulator - need specific clauses if the returned
      head is itself a list or not!
    - Not sure I'm too keen on having 4 guard clauses for this but oh well...

7. In the last exercise of Chapter 7, you wrote a span function. Use it and list comprehensions to return a list
   of prime numbers from `2` to `n`.
   - No I didn't - I just re-wrote Enum.to_list but oh well...
   - Even numbers cannot be prime, so if an even number is encountered, return false
   - Odd numbers must be checked like so:
        - Divide by odd numbers between 3 and `round(sqrt(number))`
        - If any of those return a remainder of 0, return false

8. The Pragmatic Bookshelf has offices in Texas (TX) and North Carolina (NC), so we have to charge sales tax on orders shipped 
   to these states. The rates can be expressed as a keyword list: `tax_rates`. A list of orders can be expressed as: `orders`.
   Write a function that takes both lists and returns a copy of the orders, but with an extra field, total_amount, which is the net plus sales tax.  If a shipment is not in NC or TX, there's no tax applied.

   I'm going to define these attributes just to make the function call slightly easier:\
   `@tax_rates` and `@orders`\
   Use `Enum.map` to operate on each element of the orders list and insert a new keyword pair with a support function
