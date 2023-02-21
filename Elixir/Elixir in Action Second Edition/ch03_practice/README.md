# Tail Call Recursion
Here are a list of a couple functions you can write for practice:
- A `list_len/1` function that calculates the length of a list
- A `range/2` function that takes two integers, `from`, and `to`, and returns a list of all integer numbers in the given range
- A `positive/1` function that takes a list and returns another list that contains only the positive numbers from the input list  
Try to write these functions first in the non-tail-recursive form, and then convert them into the tail-recursive version.

### SOLUTIONS:
I actually struggled a bit with the non tail-call-recursive versions of these functions! The tail-call-recursive forms of the functions have a `_TC` suffix, while the non-tail-call-recursives have a `_nonTC` suffix. The functions can be found in [recursion_practice](recursion_practice.ex):


# Streams - Lazy Enumerables
Here are some (steram/lazy enumerable) exercise ideas that may help you get into the swing of things. Using `large_lines!/1` as a model, write the following functions:
- A `lines_lengths!/1` that takes a file path and returns a list of numbers, with each number representing the length of the corresponding line from the file.
- A `longest_line_length!/1` that returns the length of the longest line in a file.
- A `longest_line!/1` that returns the contents of the longest line in a file.
- A `words_per_line!/1` that returns a list of numbers, with each number representing the word count in a file. Hint: to get the word count of a line, use `length(String.split(line))`.

### SOLUTIONS:
The above function definitions can be found in the [stream_practice](stream_practice.ex) module, and all use the [recursion_practice.txt](recursion_practice.txt) file as the default input for testing. 
```
iex stream_practice.ex
Erlang/OTP 24 [erts-12.3.1] [source] [64-bit] [smp:12:12] [ds:12:12:10] [async-threads:1] [jit]

Interactive Elixir (1.13.0) - press Ctrl+C to exit (type h() ENTER for help)

iex(1)>StreamPractice.lines_lengths!()
[6, 27, 60, 29, 19, 32]

iex(2)>StreamPractice.longest_line_length!()
60

iex(3)>StreamPractice.longest_line!()
"This is the longest line in the file containing eleven words"

iex(4)>StreamPractice.words_per_line!()
[1, 5, 11, 6, 3, 4]
```
