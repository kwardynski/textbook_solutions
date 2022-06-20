# 0-10
Rewrite the `Hello, world!` program so that a newline occurs everywhere that whitespace is allowed in the program.

## Solution
We're just going to replace the space with a "\n" character, full code can be found in the `hello_world_newline.cpp` file.
```
    std::cout << "Hello,\nworld!" << std::endl;
```