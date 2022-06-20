# 2-3
Rewrite the framing program to ask the user to supply the amount of spacing to leave between the frame and the greeting.

## Solution
We're going to re-purpose the code we wrote for *2-02* and re-use the `pad_horz` and `pad_vert` variables, except now we'll ask the user to supply those values in the same way we ask the user for their name.  
I'm not going to put in any checks for the variable type returned, we'll assume that the user supplies an `int` type when prompted for the pads - if not we'll just let the program crash when it attempts to assign an invalid type to the `pad_horz`/`pad_vert` variables.  
Full code in _greeting_framing.cpp_.

Compiling and running the program yields the result:
```
Please enter your first name: Kacper
Please enter how many spaces you would like for HORIZONTAL padding: 0
Please enter how many spaces you would like for VERTICAL padding: 2

****************
*              *
*              *
*Hello, Kacper!*
*              *
*              *
****************
```
