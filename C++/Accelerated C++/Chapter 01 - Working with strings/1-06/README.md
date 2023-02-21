# 1-6
What does the following program do if, when it asks for your input, you type two names (for example `Samuel Beckett`)? Predict the behavior before running the program, then try it.
```
#include <iostream>
#include <string>

int main()
{
    std::cout << "What is your name? ";
    std::string name;
    std::cin >> name;
    std::cout << "Hello, " << name
              << std::endl << "And what is yours? ";
    std::cin >> name;
    std::cout << "Hello, " << name
              <<"; nice to meet you too!" << std::endl;
    return 0; 
}
```

## Solution
1. After inputting the two names, the program will parse the input buffer until it reaches the first whitespace character (the space between `Samuel` and `Beckett`)
2. Samuel will be flushed from the buffer and assigned to the variable `name`
3. The program will then print `Hello, Samuel\nAnd what is yours? `
4. Next, `Beckett` will be pulled from the input buffer (since it's still there) and assigned to the variable `name`
5. Finally, the program will print `Hello, Beckett; nice to meet you too!` on the same line


Running the program yields the result:
```
What is your name? Samuel Beckett
Hello, Samuel
And what is yours? Hello, Beckett; nice to meet you too!
```
Cool