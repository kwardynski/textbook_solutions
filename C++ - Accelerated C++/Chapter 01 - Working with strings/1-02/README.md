# 1-2
Are the following definitions valid? Why or why not?
1. `const std::string exclam = "!";`
2. `const std::string message = "Hello" + ", world" + exclam;`

## Solution
No, the second line is invalid as we're attempting to call the left associative '+' operator on two string literals.