#include <iomanip>
#include <iostream>
#include <string>

using std::cout;
using std::endl;
using std::setw;
using std::string;
using std::to_string;
typedef string::size_type s_len;

int main() {

    // start/end bounds of our loop
    int start_num = 1;
    int end_num = 100;

    s_len base_padding = 3;                             // minimal padding between integer and square
    s_len max_num_length = to_string(end_num).length(); // length of the largest integer in the range

    for (int i = start_num; i <= end_num; ++i) {
        s_len digit_diff = max_num_length - to_string(i).length();      // digit difference between current and max integer
        s_len square_length = to_string(i*i).length();                  // length of the square of the integer
        s_len req_length = digit_diff + base_padding + square_length;   // required stream length to align the columns

        // display the results
        cout << i;
        cout << setw(req_length) << (i*i) << endl;
    }

    return 0;
}