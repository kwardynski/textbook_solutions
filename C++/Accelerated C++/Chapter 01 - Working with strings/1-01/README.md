# 1-1
Are the following definitions valid? Why or why not?
1. `const std::string hello = "Hello";`
2. `const std::string message = hello + ", world" + "!";`

## Solution
Yes, both of these definitions are valid as neither of them contain `string_literal + string_literal`, which is invalid.