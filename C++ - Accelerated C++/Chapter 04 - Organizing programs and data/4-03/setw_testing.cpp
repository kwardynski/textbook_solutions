#include <iomanip>
#include <iostream>

using std::cout;
using std::endl;
using std::setw;

int main() {

    // start/end bounds of our loop
    int start_num = 1;
    int end_num = 1000;

    // run the test loop
    for (int i = start_num; i <= end_num; ++i) {
        cout << i;
        cout << setw(4) << (i*i) << endl;
    }

    return 0;
}

