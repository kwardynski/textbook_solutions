# 3-1
Suppose we wish to find the median of a collection of values. Assume that we have read some of the values so far, and that we have no idea how many values remain to be read. Prove that we cannot afford to discard any of the values that we have read.  
_Hint_: One proof strategy is to assume that we can discard a value, and then find values for the unread - and therefore unknown - part of our collection that would cause the median to be the value that we discarded.

## Solution
I'm going to take a slightly different approach to this problem and show that discarding any value from a list will change the median of that set of numbers.

List: [1, 2, 3, 5, 6]  
Median: 3

Discard Index | Discard Value | Median
--- | --- | ---
0 | 1 | 4
1 | 2 | 4
2 | 3 | 3.5
3 | 5 | 2.5 
4 | 6 | 2.5

If _any_ number is removed from the initial list, we end up with a completely different median for the remaining set. There is absolutely nothing unique or special about this list of numbers, (and without going into any overly complicated mathematical proofs) it's safe to say that there must exist other lists whose medians will change upon discarding one ore more values, therefore we cannot afford to discard any values while reading in a collection of values whose median we wish to compute.