# 0-7
Is this a valid program? Why or why not?
```
    #include <iostream>
    int main() {
        /* This is a comment that extends over several lines
           because it uses /* and */ as its starting and ending delimiters */
        std::cout << "Does this work?" << std::endl;
        return 0;
    }
```

## Solution
No, it is not. The comment ends at the first "*/" on the second line, therefore we have the text "as its starting and ending delimiters */" just floating text (undeclared identifiers) and cannot be compiled.