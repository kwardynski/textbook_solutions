#include <iostream>
#include <string>

// say what standard-library names we use
using std::cin;
using std::cout;
using std::endl;
using std::string;

int main()
{

	// ask for the person's name
	cout << "Please enter your first name: ";

	// read the name
	string name;
	cin >> name;

	// build the message that we intend to write
	const string greeting = "Hello, " + name + "!";

	// ask the user for VERTICAL padding
	cout << "Please enter how many spaces you would like for HORIZONTAL padding: ";
	int pad_horz_temp;
	cin >> pad_horz_temp;
	const int pad_horz = pad_horz_temp;

	// ask the user for HORIZONTAL padding
	cout << "Please enter how many spaces you would like for VERTICAL padding: ";
	int pad_vert_temp;
	cin >> pad_vert_temp;
	const int pad_vert = pad_vert_temp;
	
	// the number of rows and columns to write
	const int rows = pad_vert * 2 + 3;
	const string::size_type cols = greeting.size() + pad_horz * 2 + 2;

	// write a blank line to separate the output from the iput
	cout << endl;


	// write the output
	// invariant: we have written r rows SO FAR
	for (int r = 0; r != rows; ++r) {

		// Start by writing an asterisk
		cout << "*";

		// Are we writing TOP/BOTTOM row
		if (r == 0 || r == rows - 1) {
			cout << string(greeting.size() + pad_horz * 2, '*');
		}
		
		// Are we writing the GREETING row - we have written floor(rows/2) rows
		else if (r == rows/2) {
			cout << string(pad_horz, ' ') + greeting + string(pad_horz, ' ');
		}

		// Are we writing an EMPTY PADDING row
		else {
			cout << string(greeting.size() + pad_horz * 2, ' ');
		}

		// finish by writing an asterisk and newline
		cout << "*" << endl;
	}

	return 0;
}
