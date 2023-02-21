# 2-5
Write a set of `"*"` characters so they form a square, rectangle, and a triangle.

## Solution
Full code in _shapes.cpp_.  
I'm going to use the same code for the rectangle and square:
- Input the width and the height
- Loop through `height` rows and print `string(shape_width, '*')` asterisks.  

I'll take a similar approach to the triangle with a slight modification
- Input size
- Loop through `size` rows and print `string(r+1, '*')` asterisks.
