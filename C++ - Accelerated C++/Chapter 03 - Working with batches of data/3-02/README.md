# 3-2
Write a program to compute and print the quartiles (that is, the quarter of the numbers with the largest values, the next highest quarter, and so on) of a set of integers.

## Solution
Full code in _quartile_calculator.cpp_

### Median
In this problem, since we'll be calculating the median 3 times, it makes sense to split that off into its own function:
```
double calc_median(vector<double> vect) {

	// Get the vector size
	vec_sz size = vect.size();

	// Calculate the median
	double median;
	vec_sz mid = size / 2;
	median = size % 2 == 0 ? (vect[mid] + vect[mid - 1]) / 2
		: vect[mid];

	return median;
}
```

### Quartiles
How we construct the vectors used to calculate Q1 and Q3 depends on whether our input vector contains an odd or even number of elements. After sorting, we split the vector in half, however if it contains an odd number of elements we discard the middle point.
```
EVEN: [1 2 3 4 5 6] 
[1 2 3 | 4 5 6] -> [1 2 3] & [4 5 6]

ODD: [1 2 3 4 5]
[1 2 | 3 | 4 5 ] -> [1 2] & [4 5]
```
To do this, I'll use a variable called `upper_start` which defines the index of our main vector in which the upper vector starts. The lower vector will always just be defined as starting at `main_vect.begin()` and ending at `main_vect.begin() + main_vect.size()/2)`:
```
vec_sz size = main_vect.size();
vec_sz upper_start;
if (size % 2 == 0) {
    upper_start = size / 2;
}
else {
    upper_start = size / 2 + 1;
}
vector<double> lower_vect(main_vect.begin(), main_vect.begin() + size / 2);
vector<double> upper_vect(main_vect.begin() + upper_start, main_vect.end());
```

### Result
Once we've gone ahead and split up our main vector into it's upper and lower components, we can call `calc_median` on the main vector and the resultant sub-components and print the results in the same way the final grade results were displayed in _grade_calculator.cpp_

**EVEN**
```
QUARTILE CALCULATOR
Please enter a list of at least 2 numbers: 1 2 3 4 5 6

Q1: 2
Q2: 3.5
Q3: 5
```

**ODD**
```
QUARTILE CALCULATOR
Please enter a list of at least 2 numbers: 1 2 3 4 5

Q1: 1.5
Q2: 3
Q3: 4.5
```