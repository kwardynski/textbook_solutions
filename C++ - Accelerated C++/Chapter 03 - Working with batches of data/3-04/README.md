# 3-4 
Write a program to report the length of the longest and shortest string in its input.

## Solution
Again, I'm going to start this problem off just like the previous one - we ask the user for a list of words, read them in to a vector, and ensure that we've received at minimum one word. This time we don't need to sort the list, however we'll be using FOUR accumulators: the shortest and longest words encountered, and their lengths. Like before, we'll set the initial accumulator values to represent the **first** word in the list, then loop through the rest comparing the current word to the accumulator.  
- If the current word is SHORTER than the recorded shortest word, update the `shortest_word` and `shortest_length` variables accordingly.
- If the current word is longer than the recorded longest word, update the `longest_word` and `longest_length` variables accordingly.

Full code found in _word_lengths.cpp_ - when compiled and run yields the following result:
```
SHORTEST / LONGEST WORD FINDER
Please enter a list of words: list of words where a is the shortest and superlongword is the longest

Longest word encountered: superlongword with a length of 13 characters
Shortest word encountered: a with a length of 1 characters
```
