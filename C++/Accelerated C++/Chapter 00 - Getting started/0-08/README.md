# 0-8
Is this a valid program? Why or why not?
```
    #include <iostream>
    int main() {
        // This is a comment that extends over several lines
        // by using // at the beginning of each line instead of using /*
        // or */ to delimit comments.
        std::cout << "Does this work?" << std::endl;
        return 0;
    }
```

## Solution
Yes, this is a valid program. Everything _after_ the "//" character sequence will be treated as a comment, so if we do it this way we have no floating text in our code. 
