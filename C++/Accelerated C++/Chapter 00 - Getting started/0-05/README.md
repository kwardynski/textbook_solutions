# 0-5
Is this a valid program? Why or why not?
```
    #include <iostream>
    int main()  std::cout << "Hello, world!" << std::endl;
```

## Solution
No, this is not a valid program. We're missing the curly braces around the print statement - there's nothing for the compiler to treat as a _unit_ so we get a bunch of errors.