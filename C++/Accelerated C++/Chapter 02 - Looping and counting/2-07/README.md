# 2-7
Write a program to count down from 10 to -5

## Solution
I'm going to use a while loop that relies on two variables, `start` and `end`. We'll set the variable `i` to be equal to `start`, print it, then decrement it while it remains equal to or greater than `end`.  
Full code in _countdown.cpp_
```
const int start = 10;
const int end = -5;

int i = start;
while (i >= end) {
    cout << i << endl;
    --i;
}
```
