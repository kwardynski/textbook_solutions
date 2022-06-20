#include <iostream>

using std::cout;
using std::endl;

int main()
{
    const int start = 1;
    const int end = 10;

    int acc = start;
    int i = start;
    while (i < end) {
        acc = acc * i;
        ++i;
    }

    cout << acc << endl;

    return 0;
}