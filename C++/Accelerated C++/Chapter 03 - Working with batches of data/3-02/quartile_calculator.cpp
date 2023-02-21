#include <algorithm>
#include <iomanip>
#include <ios>
#include <iostream>
#include <vector>

using std::cin;             using std::sort;
using std::cout;            using std::streamsize;
using std::endl;            using std::vector;
using std::setprecision;    

typedef vector<int>::size_type vec_sz;


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


int main()
{

	// Ask user for a list of integers
	cout << "QUARTILE CALCULATOR" << endl;
	cout << "Please enter a list of at least 2 numbers: ";

	// Read into main_vect variable
	vector<double> main_vect;
	double elem;
	while (cin >> elem) {
		main_vect.push_back(elem);
	}

	// Ensure we've received at least 2 values
	if (main_vect.size() < 2) {
		cout << "Expected at least 2 integers, received " << main_vect.size() << endl;
		return 1;
	}

	// Sort
	sort(main_vect.begin(), main_vect.end());

	// Separate lower/upper vectors
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

	// Display results
	streamsize prec = cout.precision();
	cout << "Q1: " << setprecision(2) << calc_median(lower_vect) << endl <<
		"Q2: " << calc_median(main_vect) << endl <<
		"Q3: " << calc_median(upper_vect) <<
		setprecision(prec) << endl;

	return 0;
}
