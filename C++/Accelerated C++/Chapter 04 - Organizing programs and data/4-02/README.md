# 4-2
Write a program to calculate the squares of `int` values up to 100. The program should write two columns: The first lists the value; the second contains the square of that value. Use `setw` (described above) to manage the output so that the values line up in columns.

## Solution
The description for `setw` is as follows:
```
setw(n)  Returns a value of type streamsize (§3.1/36) that, when written on an
         output stream s, has the effect of calling s.width(n)
```
So what we want to do is first find the length of the largest pre-square integer (100), which we will use as the basis for our streamsize manipulation. I'm also going to set a value called `base_padding` to 3, which specified the _minimum_ whitespace characters between the end of our pre-squared integer and our squared result. In order to calculate the required streamlength of the squared portion of our line, we can do some simple arithmetic represented by the following pseudocode:
```
digit_diff = num_digits(100) - num_digits(current_integer)
square_length = num_digits(current_integer^2)
required_stream_length = digit_diff + base_padding + square_length
```

Full code can be found in _squares_display.cpp_, which when compiled and run yields the following result:
```
1     1  
2     4  
3     9  
4     16 
5     25 
6     36 
7     49 
8     64 
9     81 
10    100
...
98    9604
99    9801
100   10000
```