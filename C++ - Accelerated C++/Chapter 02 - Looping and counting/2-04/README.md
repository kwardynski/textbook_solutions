# 2-4
The framing program writes the mostly blank lines that separate the borders from the greeting one character at a time/ Change the program so that it writes all the spaces needed in a single output expression.

## Solution
Full code (as always) in _greeting_framing.cpp_.  
I'm going to approach this solution slightly differently than we've done the previous few - instead of seeing which _character_ we're on, we'll be checking which _line_ we're on.   
- Start by writing an asterisk
- If we're writing the TOP or BOTTOM rows, write `greeting.size() + 2 * pad_horz` asterisks
- If we're writing the GREETING row (i.e. floor(rows/2)), write the greeting padded with `pad_horz` spaces on either size
- If we're writing the EMPTY PADDING row (i.e. none of the above), print the blank line `string(greeting.size() + pad_horz * 2, ' ')`
- Finish the line by writing another asterisk and a `endl`

Compiling and running the program yields the result:

```
Please enter your first name: Kacper
Please enter how many spaces you would like for HORIZONTAL padding: 3
Please enter how many spaces you would like for VERTICAL padding: 1

**********************
*                    *
*   Hello, Kacper!   *
*                    *
**********************
```




