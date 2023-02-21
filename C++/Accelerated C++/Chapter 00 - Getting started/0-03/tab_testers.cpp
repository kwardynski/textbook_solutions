#include <iostream>

int main()
{

    // Test 1: 1 tab at start of line
    std::cout << "....|....|....|....|....|....|" << std::endl;
    std::cout << "\tONE tab used" << std::endl;

    // Test 2: 2 tabs at start of line
    std::cout << "....|....|....|....|....|....|" << std::endl;
    std::cout << "\t\tTWO tabs used" << std::endl;
    
    // Test 3: 1 tab within a line
    std::cout << "....|....|....|....|....|....|" << std::endl;
    std::cout << "-----\tONE tab used" << std::endl;
    
    // Test 4: 2 tabs within a line
    std::cout << "....|....|....|....|....|....|" << std::endl;
    std::cout << "-----\t\tTWO tabs used" << std::endl;

    return 0;
}
