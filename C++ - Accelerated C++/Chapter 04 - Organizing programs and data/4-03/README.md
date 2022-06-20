# 4-3
What happens if we rewrite the previous program to allow values up to but not including 1000 but neglect to change the arguments to `setw`? Rewrite the program to be more robust in the face of changes that allow i to grow without adjusting `setw` arguments.

## Solution
Since I'm such a brilliant coder and certified genius, my solution to **4-2** already accounts for the possibility of variable lengths (i.e. the _only_ hardcoded value is the `base_padding` variable), so I don't need to actually change my code to accomodate the behavior of `setw`.  
However, the question does ask what happens if the input to `setw` is less than the length of the variable we're trying to print to the stream so let's find out. There's some simple code in _setw_testing.cpp_ which is a dumbed-down version of _squares_display.cpp_ from **4-2** and has `setw(4)` hard-coded into the loop. When run and compiled yields the result:
```
1   1
2   4
3   9
...
31 961
321024
331089
...
998996004
999998001
10001000000
```

So if the value we're trying to print to the stream is _longer_ than the value provided to `setw`, there's no padding possible so it simply gets displayed "in place".
