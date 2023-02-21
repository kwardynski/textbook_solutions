# 3-4
Write a program to count how many times each distinct word appears in its input.

## Solution
Since vectors are the only containers we've encountered so far, that's the only container I will use for this solution. More optimal solutions exist if we use more "advanced" data types (like maps).  
This solution starts off like the others in the chapter - we as the user to input a list of words terminated by an EOF. We read this list of words into a vector and call std::sort to return the list sorted alphabetically. Next we loop over the list to see how many times we've encountered all the words given to us. 

### Variables
- acc: The counting "accumulator" we use - how many times a word has been encountered
- previous_word: this is a string variable we use for comparison, which will be `word_list[i-1]` in the loop. If `word_list[i] == previous_word` returns `true`, then we increase the accumulator, if it returns `false` then we know we've encountered a new word.

### NOTES:
- In this solution, I actually start the loop from index `i = 1`, i.e. the _second_ word in the list. We need a point of comparison so we set `previous_word` to be the first word of `word_list` and set `acc` to 1 (since we've seen the first word once).
- There's a final `if` statement at the end of the word counting loop which is required to show how many times we've seen the last word in the alphabetically sorted list.

### Results:
Full code found in _word_counter.cpp_. Compiling and running the code yields the following result:
```
UNIQUE WORD COUNTER
Please enter a list of words: a list of words where the words list and words are repeated

Word "a" encountered 1 times
Word "and" encountered 1 times
Word "are" encountered 1 times
Word "list" encountered 2 times
Word "of" encountered 1 times
Word "repeated" encountered 1 times
Word "the" encountered 1 times
Word "where" encountered 1 times
Word "words" encountered 3 times
```