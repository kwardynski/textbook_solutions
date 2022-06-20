# 1-3
Is the following program valid? If so, what does it do? If not, why?
 ```
#include <iostream>
#include <string>

int main()
{
    { const std::string s = "a string";
      std::cout << s << std::endl; }

    { const std::string s = "another string";
      std::cout << s << std::endl; }
    return 0;
}
 ```

 ## Solution
 Yes, this is a valid program, it prints the two strings:
 ```
 a string
 another string
 ```