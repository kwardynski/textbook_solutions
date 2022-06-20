#include <iostream>

using std::cout;
using std::endl;

int main()
{
    const int start = 10;
    const int end = -5;

    int i = start;
    while (i > end) {
        cout << i << endl;
        --i;
    }

    return 0;
}