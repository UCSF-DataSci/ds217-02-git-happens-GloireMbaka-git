#!/bin/bash
echo
#create directory structure
mkdir -p src/data/output

# generate initial files
touch README.md .gitignore, requirements.txt

# create sample data files with 8 records
cat > data/students.csv <<EOF
name,age,grade,subject
Alice,20,85,Math
Bob,19,92,Science
Charlie,21,78,English
Diana,20,88,Math
Eve,22,95,Science
Frank,19,82,History
Grace,21,91,Math
Henry,20,76,Science
EOF

#Create branch 
git checkout -b feature/project-scaffold

#Create python files 
cat > src/student_analysis.py <<EOF

# Analysis function

def main():
    # TODO: Implement main logic
        print("running basic descprtive statistics")

if __name__ == "__main__":
    main()
EOF
# make scirpt executable (to be run directly in the terminal)
echo "Setup Complete!"

#commit changes to feature branch
git add . setup_project.sh
git commit -m "Add project setup automatiion script"

#Merge feature branch to main
git checkout main
git merge feature/project-scaffold
echo "Merged feature/project-scaffold into main"


# set up python templates files
#creating data analysis function for the basic analysis
#PART 3: Basic analysis script
cat > src/data_analysis.py <<EOF
# load and analyze student data
#TODO: Implement CSV loading, average grade calculation, Math student counting, report generation, and report saving
import csv
from pathlib import Path

def load_student_data(csv_file):
    """Load student data from CSV file and return list of students data."""
    students = []
    try:
        with open(csv_file, 'r') as file:
            reader = csv.DictReader(file)
            for row in reader:
                students.append({
                    'name': row['name'],
                    'age': int(row['age']),
                    'grade': int(row['grade']),
                    'subject': row['subject']
                })
    except FileNotFoundError:
        print(f"Error: File {csv_file} not found")
    except Exception as e:
        print(f"Error loading data: {e}")

    return students

def calculate_average_grade(grades):
    """Calculate the average of a list of grades and return average."""
    #TODO: Implement average grade calculation
    if not grades:
        return 0
    return sum(grades) / len(grades)

def count_math_students(students):
    """Count number of students in Math and return count of students in Math."""
    #TODO: Implement Math student counting
    count_math = 0
    for student in students:
        if student['subject'].lower() == 'Math':
            count_math += 1
    return count_math

def generate_report(students):
    """Generate a report of average grade and subject counts."""
    #TODO: Implement report generation
    if not students:
        print("No student data available to generate report.")
        return None, 0
    
    # Calculate average grade and subject counts
    grades = [student['grade'] for student in students]
    average_grade = calculate_average_grade(grades)
    math_count = count_math_students(students)
    print(f"Average Grade: {average_grade:.2f}")
    print(f"Math Students: {math_count}")
    return average_grade, math_count

def save_results_to_file(filename, students, average, math_count):
    """Save analysis results to a file."""
    #TODO: Implement report saving
    try:
        with open(filename, 'w') as file:
            file.write("Student Grade Analysis\n")
            file.write("=" * 30 + "\n\n")

            file.write("Individual Grades:\n")
            for student in students:
                file.write(f"{student['name']}: {student['grade']}\n")

            file.write(f"\nSummary:\n")
            file.write(f"Average grade: {average:.1f}\n")
            file.write(f"Math Students: {math_count}\n")

        print(f"Results saved to {filename}")
        return True
    except Exception as e:
        print(f"Error saving file: {e}")
        return False

def main():
    """Main function to run the analysis."""
    #TODO: Implement main workflow
    print("Student Grade Analysis")
    print("=" * 40)

    # Load data from CSV
    students = load_student_data('data/students.csv')

    if not students:
        print("No student data to analyze")
        return

    # Generate report and get statistics
    average, math_count = generate_report(students)
    
    if average is None:
        return

    # Display results
    print(f"\nAnalyzed {len(students)} students")
    print(f"Average grade: {average:.1f}")
    print(f"Math students: {math_count}")

    # Save results
    output_file = 'output/basic_analysis.txt'
    Path('output').mkdir(exist_ok=True)

    save_results_to_file(output_file, students, average, math_count)

if __name__ == "__main__":
    main()
EOF
echo "created src/data_analysis.py with function tubs."

#PART 3B: Advanced analysis script

#creating data processing branch
git checkout -b feature/data-processing


#creating the data_analysis_functions.py file 
cat > src/data_analysis_functions.py <<EOF
"""Advanced Student Data Analysis Script"""
#TODO: Implement CSV loading, average grade calculation
#TODO: Math student counting, find highest, lowest grades
#TODO: report generation, and report saving

import csv
def load_students_data(csv_file):
    """Load student data from CSV file and return list of students data."""
    #TODO: Implement CSV loading AND RETURN LIST OF STUDENTS DATA
    students = []
    try:
        with open(csv_file, 'r') as file:
            reader = csv.DictReader(file)
            for row in reader:
                students.append({
                    'name': row['name'],
                    'age': int(row['age']),
                    'grade': int(row['grade']),
                    'subject': row['subject']
                })
    except FileNotFoundError:
        print(f"Error: File {csv_file} not found")
    except Exception as e:
        print(f"Error loading data: {e}")

    return students

def analyze_data(students):
    """Analyze data and return dictionary with multiple statistics."""
    #TODO: Implement data analysis and return dictionary with multiple statistics
    if not students:
        print("No student data available for analysis.")
        return None, None

    # Calculate average grade
    grades = [student['grade'] for student in students]
    average_grade = sum(grades) / len(grades) if grades else 0

    # Count number of students per subject
    subject_count = {}
    for student in students:
        subject = student['subject']
        if subject in subject_count:
            subject_count[subject] += 1
        else:
            subject_count[subject] = 1

    return average_grade, subject_count

# Find highest and lowest grades
def find_highest_grade(grades):
    """Find the highest grade in a list."""
    if not grades:
        return 0
    return max(grades)

def find_lowest_grade(grades):
    """Find the highest grade in a list."""
    if not grades:
        return 0
    return min(grades)

# Analyze grade distribution

def analyze_grade_distribution(grades):
    """Analyze the distribution of grades."""
    #TODO: Implement grade distribution analysis AND RETURN DISTRIBUTION DICTIONARY
    if not grades:
        return {}

    # Count grades by letter grades ranges
    distribution = {
        'A (90-100)': 0,
        'B (80-89)': 0,
        'C (70-79)': 0,
        'D (60-69)': 0,
        'F (0-59)': 0
    }

    for grade in grades:
        if grade >= 90:
            distribution['A (90-100)'] += 1
        elif grade >= 80:
            distribution['B (80-89)'] += 1
        elif grade >= 70:
            distribution['C (70-79)'] += 1
        elif grade >= 60:
            distribution['D (60-69)'] += 1
        else:
            distribution['F (0-59)'] += 1

    return distribution

   #Generate detailed report

def generate_detailed_report(students, filename):
    """Generate a comprehensive analysis report."""
    #TODO: Implement detailed report generation AND SAVE TO FILENAME
    if not students:
        print("No data to analyze")
        return False

    # Get grades and basic statistics
    grades = [student['grade'] for student in students]
    highest = find_highest_grade(grades)
    lowest = min(grades) if grades else 0

    # Analyze grade distribution
    distribution = analyze_grade_distribution(grades)

    # Generate report
    try:
        with open(filename, 'w') as file:
            file.write("COMPREHENSIVE STUDENT ANALYSIS REPORT\n")
            file.write("=" * 50 + "\n\n")

            file.write(f"Report generated on: {__import__('datetime').datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\\n\\n")

            file.write("BASIC STATISTICS\n")
            file.write("-" * 20 + "\n")
            file.write(f"Total students: {len(students)}\n")
            # file.write(f"Average grade: {average:.1f}\n")
            file.write(f"Highest grade: {highest}\n")
            file.write(f"Lowest grade: {lowest}\n")
            file.write(f"Grade range: {highest - lowest}\n\n")

            file.write("GRADE DISTRIBUTION\n")
            file.write("-" * 20 + "\n")
            for grade_range, count in distribution.items():
                percentage = (count / len(students)) * 100 if students else 0
                file.write(f"{grade_range}: {count} students ({percentage:.1f}%)\n")
            file.write("\n")

            file.write("INDIVIDUAL STUDENT RECORDS\n")
            file.write("-" * 30 + "\n")
            for student in students:
                file.write(f"Name: {student['name']}\n")
                file.write(f"  Age: {student['age']}\n")
                file.write(f"  Grade: {student['grade']}\n")
                file.write(f"  Subject: {student['subject']}\n")
                file.write("\n")

        print(f"Detailed report saved to {filename}")
        return True
    except Exception as e:
        print(f"Error generating report: {e}")
        return False

#
def main():
    """Main function demonstrating module usage."""
    #TODO: Implement main workflow for advanced analysis
    print("Advanced Student Analysis - Module Usage")
    print("=" * 45)

    # Load data using imported function
    students = load_students_data('data/students.csv')

    if not students:
        print("No data loaded. Please check data/students.csv")
        return

    print(f"Loaded {len(students)} students")

    # Use imported functions
    grades = [student['grade'] for student in students]
    highest = find_highest_grade(grades)
    lowest = find_lowest_grade(grades)

    # print(f"Average grade: {average:.1f}")
    print(f"Highest grade: {highest}")
    print(f"Lowest grade: {lowest}")
    print(f"Grade range: {highest - lowest}")

 # Advanced analysis using new functions
    distribution = analyze_grade_distribution(grades)
    print("\\nGrade Distribution:")
    for grade_range, count in distribution.items():
        percentage = (count / len(students)) * 100
        print(f"{grade_range}: {count} students ({percentage:.1f}%)")

    # Generate comprehensive report
    generate_detailed_report(students, 'output/analysis_report.txt')

    # Save basic results using imported function
    # save_results_to_file('output/module_analysis.txt', students, average, highest)

    print("\\n✅ Advanced analysis complete!")

if __name__ == "__main__":
    main()
EOF
echo "created src/data_analysis_functions.py with advanced analysis functions."


#commit changes to feature branch
git add . setup_project.sh
git commit -m "Add advanced automatiion script"

#Merge feature branch to main
git checkout main
git merge feature/data-processing
echo "Merged feature/data-processing into main"
