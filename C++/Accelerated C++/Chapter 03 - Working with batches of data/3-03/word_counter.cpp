#include <algorithm>
#include <iostream>
#include <string>
#include <vector>

using std::cin;             
using std::cout;            
using std::endl; 
using std::sort; 
using std::string;
using std::vector;

typedef vector<int>::size_type vec_sz;

void display_word_count(string previous_word, vec_sz acc) {
	cout << "Word \"" << previous_word << "\" encountered " << acc << " times" << endl;
}

int main()
{
	// Ask user for a list of words
	cout << "UNIQUE WORD COUNTER" << endl;
	cout << "Please enter a list of words: ";

	// Read into word_list variable 
	vector<string> word_list;
	string word;
	while (cin >> word) {
		word_list.push_back(word);
	}

	// Ensure we've received at least 1 word
	if (word_list.size() < 1) {
		cout << "You have to put in at least one word..." << endl;;
		return 1;
	}

	// Sort
	sort(word_list.begin(), word_list.end());

	// Loop through the list starting at the SECOND word and count occurences
	string previous_word = word_list[0];	// set previous word to first word of list for comparison
	vec_sz acc = 1;                         // set the accumulator to 1 (first word seen 1 time)
	if (word_list.size() > 1){
		for (vec_sz i = 1; i < word_list.size(); ++i) {

			// If we encounter a repeat word - increase the accumulator
			if (previous_word == word_list[i]) {
				++acc;
			}
			// If we encounter a new word - display the times we encountered the
			// previous unique word, reset previous word string and accumulator to 1
			else {
				display_word_count(previous_word, acc);
				previous_word = word_list[i];
				acc = 1;
			}
		}
	}

    // Display the number of times the LAST word was encountered
	display_word_count(previous_word, acc);

	return 0;
}
