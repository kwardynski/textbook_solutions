# 0-2
Write a program that, when run, writes
```
    This (") is a quote, and this (\) is a backslash.
```

## Solution
Full code is in the `string_literals.cpp` file, but the gist of the problem is:
```
    std::cout << "This (\") is a quote, and this (\\) is a backslash." << std::endl;
```
You need to use the backslash character to "escape" the default behavior of the `"` and `\` characters.