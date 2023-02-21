# 0-3
The string literal "\t" represents a tab character; different C++ implementations display tabs in different ways. Experiment with your implementation to learn how it treats tabs.

## Solution
The only test I can really think of i seeing how many spaces a tab represents at the beginning of a line, and in the middle. I'll see if putting consecutive tabs does anything as well. The test code can be found in `tab_testers.cpp`.

```
....|....|....|....|....|....|
        ONE tab used
....|....|....|....|....|....|
                TWO tabs used
....|....|....|....|....|....|
-----   ONE tab used
....|....|....|....|....|....|
-----           TWO tabs used
```

So it looks like a tab represents 8 characters _except_ when it's the first tab in a series of tabs in the middle of a line - then it's 3 spaces. Cool.