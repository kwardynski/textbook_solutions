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
typedef string::size_type str_sz;

int main()
{

	// Ask user for a list of words
	cout << "SHORTEST / LONGEST WORD FINDER" << endl;
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
	
	// Initialize "comparison" variables
	string shortest_word = word_list[0];
	str_sz shortest_length = shortest_word.length();
	string longest_word = word_list[0];
	str_sz longest_length = longest_word.length();
	
	// Loop through the list starting at the SECOND word and compare lengths
	if (word_list.size() > 1) {
		for (vec_sz i = 1; i < word_list.size(); ++i) {

			// Check for SHORTER word
			if (word_list[i].length() < shortest_length) {
				shortest_word = word_list[i];
				shortest_length = shortest_word.length();
			}

			// Check for LONGER word
			if (word_list[i].length() > longest_length) {
				longest_word = word_list[i];
				longest_length = longest_word.length();
			}
		}
	}

	// Display the length stats
	cout << "Longest word encountered: " << longest_word << " with a length of " << longest_length << " characters" << endl;
	cout << "Shortest word encountered: " << shortest_word << " with a length of " << shortest_length << " characters" << endl;
	
	return 0;
}
