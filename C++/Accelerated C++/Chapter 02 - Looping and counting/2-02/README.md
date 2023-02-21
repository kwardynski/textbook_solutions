# 2-2
Change the framing program so that it uses a different amount of space to separate the sides from the greeting than it uses to separate the top and bottom borders from the greeting.

## Solution
We're going to split up the `pad` variable into two here: `pad_vert` and `pad_horz`, which I will be setting to 2 and 5, respectively. We will then have to adjust the definitions for the `rows` and `cols` variables accordingly as well as the constants which to compare `r` and `c` to when determining whether it is time to write the greeting. Full code in _greeting_framing.cpp_.

Compiling and running the program yields the result:
```
Please enter your first name: Kacper

**************************
*                        *
*                        *
*     Hello, Kacper!     *
*                        *
*                        *
**************************
```


