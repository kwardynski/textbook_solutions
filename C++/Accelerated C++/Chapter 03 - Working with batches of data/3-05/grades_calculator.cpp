#include <iomanip>
#include <ios>
#include <iostream>
#include <string>
#include <vector>

using std::cin;             using std::streamsize;
using std::cout;            using std::string;
using std::endl;            using std::vector;
using std::setprecision;    

int main()
{

    // Initialize variables to be used
    string name;
    vector<string> student_names;
    vector<double> student_grades;
    typedef vector<double>::size_type vec_sz;
    const vec_sz total_homeworks = 3;
    
    cout << "Please enter the student's name: ";
    while (cin >> name) {

        // Get name and append to student_names
        student_names.push_back(name);

        // Ask for homework grades - calculate overall homework total
        cout << "Please enter " << name << "'s " << total_homeworks << " homework grade scores: ";
        double homework_total_grade = 0;
        double homework_indiv_grade;
        for (vec_sz i = 0; i != total_homeworks; ++i) {
            cin >> homework_indiv_grade;
            homework_total_grade += homework_indiv_grade;
        }
        double homework_grade = homework_total_grade / total_homeworks;

        // Ask for midterm score
        cout << "Please enter " << name << "'s midterm grade: ";
        double midterm_grade;
        cin >> midterm_grade;

        // Ask for final exam score
        cout << "Please enter " << name << "'s final exam grade: ";
        double final_exam_grade;
        cin >> final_exam_grade;

        // Calculate final score and add to student_grades
        student_grades.push_back(0.4 * homework_grade + 0.2 * midterm_grade + 0.4 * final_exam_grade);

        // Continue loop or exit:
        cout << "Please enter next student's name (or EOF to finish): ";

    }

    // Display the final grades
    cout << endl;
    streamsize prec = cout.precision();
    for (int i = 0; i != student_names.size(); ++i){
        cout << "  " << student_names[i] << "'s final score is: " << setprecision(3) << student_grades[i] << "%" 
        << setprecision(prec) << endl;
    }

}