#include <iostream>

using std::cout;
using std::cin;
using std::endl;

int main()
{
    // Ask the user for the first number
    cout << "Please enter an integer: ";
    int num_1;
    cin >> num_1;

    // Ask the user for the second number
    cout << "Please enter another: ";
    int num_2;
    cin >> num_2;

    // Check which number is larger
    int larger_num;
    if (num_1 > num_2) {
        larger_num = num_1;
    }
    else {
        larger_num = num_2;
    }

    // Inform the user
    cout << larger_num << " is the larger of the two!" << endl;

    return 0;
}
