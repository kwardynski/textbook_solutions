# 1-5
Is this program valid? If so, what does it do? If not, say why not, and rewrite it to be valid.
```
#include <iostream>
#include <string>

int main()
{
	{ std::string s = "a string";
	{ std::string x = s + ", really";
	  std::cout << s << std::endl; }
	  std::cout << x << std::endl;
	} 
	return 0;
}
```

## Solution
No, this is not a valid program. The `x` variable in the last statement is undefined - more specifically `x` is called outside of the scope in which it is defined, therefore does not exist within the scope of where it is called.\
We can make this a valid program by either removing the inner set of curly braces, or simply removing all the curly braces.
```
#include <iostream>
#include <string>

int main()
{
	std::string s = "a string";
	std::string x = s + ", really";
	std::cout << s << std::endl; 
	std::cout << x << std::endl;
 
	return 0;
}
```
