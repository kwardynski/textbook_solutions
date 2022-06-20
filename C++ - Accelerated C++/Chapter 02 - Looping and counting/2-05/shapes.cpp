#include <iostream>
#include <string>

// say what standard-library names we use
using std::cin;
using std::cout;
using std::endl;
using std::string;

int main()
{

	// square: 5x5
	const int square_width = 5;
	const int square_height = 5;
	for (int r = 0; r != square_height; ++r) {
		cout << string(square_width, '*') << endl;;
	}

	cout << endl;

	// rectangle: 6x3
	const int rect_width = 6;
	const int rect_height = 3;
	for (int r = 0; r != rect_height; ++r) {
		cout << string(rect_width, '*') << endl;
	}

	cout << endl;

	// triangle: 5
	const int triangle_size = 5;
	for (int r = 0; r != triangle_size; ++r) {
		cout << string(r + 1, '*') << endl;
	}

	return 0;
}
