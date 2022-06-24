## Practicing Tail Call Recursion
Here are a list of a couple functions you can write for practice:
- A `list_len/1` function that calculates the length of a list
- A `range/2` function that takes two integers, `from`, and `to`, and returns a list of all integer numbers in the given range
- A `positive/1` function that takes a list and returns another list that contains only the positive numbers from the input list  
Try to write these functions first in the non-tail-recursive form, and then convert them into the tail-recursive version.

### SOLUTIONS:
I actually struggled a bit with the non tail-call-recursive versions of these functions! The tail-call-recursive forms of the functions have a `_TC` suffix, while the non-tail-call-recursives have a `_nonTC` suffix. The functions can be found in [recursion_practice](recursion_practice.ex):
