# 3-6
The average-grade computation in §3.1/36 might divide by zero if the student didn't enter any grades. Division by zero is undefined in C++, which means that the implementation is permitted to do anything it likes. What does your C++ implementation do in this case? Rewrite the program so that its behavior does not depend on how the implementation treats division by zero.

## Solution:

### Division by zero
_div_by_zero.cpp_ contains an attempted division by zero, the compiler displays the following warning:
```
warning: division by zero [-Wdiv-by-zero]
    2 |     double test = 12/0;
      |                   ~~^~

Build finished with warning(s).
```
I can however still compile the progam and execute it, but nothing happens - which leads me to believe that the division by zero simply terminates the program.

---

### Handling no homework grades
In order to do this, we need to slightly adjust the homework section of the code such that it returns an overall homework score of `0` if no homework entered (`homework.size() == 0`) instead of exiting, otherwise we compute the median homework grade as before. Full code can be found in _grade_calculator_upgrade.cpp_ - when compiled and run yields the following results:

**Enter homework assignments - expect total score of 80**
```
Please enter your first name: Kacper
Hello, Kacper!
Please enter your midterm and final exam grades: 80 80
Enter all your homework grades, followed by end-of-file: 70 80 90

Your final grade is 80
```

**No homework assignments entered - expect total score of 48**
```
Please enter your first name: Kacper
Hello, Kacper!
Please enter your midterm and final exam grades: 80 80
Enter all your homework grades, followed by end-of-file: 

Your final grade is 48
```

