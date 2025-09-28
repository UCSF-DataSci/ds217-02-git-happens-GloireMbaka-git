# load and analyze student data
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
    if not grades:
        return 0
    return sum(grades) / len(grades)

def count_math_students(students):
    """Count number of students in Math and return count of students in Math."""
    count_math = 0
    for student in students:
        if student['subject'].lower() == 'math':
            count_math += 1
    return count_math

def generate_report(students):
    """Generate a report of average grade and subject counts."""
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
