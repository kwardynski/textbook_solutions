# 1-4
What about this one? What if we change `}}` to `};}` in the third line from the end?
```
#include <iostream>
#include <string>

int main()
{
    { const std::string s = "a string";
    std::cout << s << std::endl;

    { const std::string s = "another string";
    std::cout << s << std::endl; } ; }
    return 0;
}
```

## Solution
Yes - this is still a valid program as the curly braces still make valid blocks. If we add the semicolon between the two close curly braces we still have a valid program. The scope does not change.