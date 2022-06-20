# 2-8
Write a program to generate the product of the numbers in the range `[1,10)`.

## Solution
This problem is essentially asking us to calculate `9!`. Since we've only been introduced to `for` and `while` loops at this point, I'm going to stick with those tools to solve the problem. We'll use a similar approach to the previous problem where we set a `start` and `end` variable, but now we'll keep an `accumulator` which we will multiply by our variable `i` which we increased by 1 until we reach the `end` upper bound.  
Full code can be found in _factorial.cpp_
```
const int start = 1;
const int end = 10;

int acc = start;
int i = start;
while (i < end) {
    acc = acc * i;
    ++i;
}
```

This results in an answer of `362880`, which is equal to `9!`.

