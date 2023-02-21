# 3-5
Write a program that will keep track of grades for several students at once. The program could keep two vectors in sync: the first should hold the student's names, and the second the final grades that can be computed as input is read. For now, you should assume a fixed number of homework grades.  We'll see in §4.1.3/56 how to handle a variable number of grades intermixed with student names.

## Solution
Since we're allowed to assume a fixed number of homework grades, I'm going to set that to 3 for simplicity. 
1. Ask for student's name - put this into the `student_names` vector.
2. Ask for the 3 homework grades - calculate the average homework score.
3. Ask for student's midterm and final exam grades
4. Compute the final grade, put the result into the `student_grades` vector.
5. Continue steps 1-3 until and EOF character encountered.
6. Once EOF encountered, display all the student names and grades.

Full code can be found in _grades_calculator.cpp_. When compiled and run yields the result:
```
Please enter the student's name: Kacper
Please enter Kacper's 3 homework grade scores: 82 75 88.3
Please enter Kacper's midterm grade: 69.5
Please enter Kacper's final exam grade: 82.1
Please enter next student's name (or EOF to finish): Jeffrey
Please enter Jeffrey's 3 homework grade scores: 58.5 55 68.2
Please enter Jeffrey's midterm grade: 92.5
Please enter Jeffrey's final exam grade: 77.3
Please enter next student's name (or EOF to finish): ^Z

  Kacper's final score is: 79.4%
  Jeffrey's final score is: 73.6%
```