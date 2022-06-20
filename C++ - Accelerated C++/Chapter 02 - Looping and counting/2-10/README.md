# 2-10
Explain the use of `std::` in the following program:
```
int main()
{
    int k = 0;
    while (k != n) {            // invariant: we have written k asterisks so far
        using std::cout;
        cout << "*";
        ++k;
    }
    std::cout << std::endl;     // std:: is required here
    return 0;
}
```

## Solution
The first instance of `std::` is bound to the scope of the `while` block - and essentially means that the `cout` used just below is using `cout` from the standard library. The second occurence of `std::` is required because we're outside of the scope of the above `while` block, meaning we have to specify we're using `std::cout`. If we simply tried to use `cout` there we'd get an error telling us that the "identifier cout is undefined".