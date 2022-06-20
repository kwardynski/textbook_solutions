# 4-1
We noted in §4.2.3/65 that it is essential that the argument types in the call to `max` match exactly. Will the following code work? If there is a problem, how would you fix it?
```
    int maxlen;
    Student_info s;
    max(s.name.size(), maxlen);
```

## Solution
The above code will not work - the question even tells us that. The two argument types supplied to `max` must match exactly; `maxlen` is of type `int`, not `std::string::size_type`. If we want this to work we have to change the type of `maxlen` as follows:
```
    std::string::size_type maxlen;
    Student_info s;
    max(s.name.size(), maxlen);
```

We could also cast `s.name.size()` from `std::string::size_type` to `int`, however that isn't exactly a _safe_ solution since we aren't absolutely guaranteed that the length of the student's name can be represented by an `int` (but who has a name that's 2147483647 letters long...)

