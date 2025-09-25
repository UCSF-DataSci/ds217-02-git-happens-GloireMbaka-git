#!/bin/bash
echo
#create directory structure
mkdir -p src data output

# generate initial files
touch README.md .gitignore, requirements.txt

# create sample data files with 8 records
 cat > data/students.csv << 'EOF'
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

# Create python files 
cat > src/student_analysis.py << 'EOF'

# Analysis function

def main():
    # TODO: Implement main logic
    print("running basic descprtive statistics")

if __name__ == "__main__":
    main()

EOF

# make scirpt executable (to be run directly in the terminal)
echo "Setup Complete!"

#PART 3

cat > src/data_analysis.py << 'EOF'

# load and analyze student data
import csv
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

def calculate_average_grade(students):
    """Calculate the average of a list of grades and return average."""
    if not grades:
        return 0
    return sum(grades) / len(grades)

def count_math_students(students):
    """Count number of students per subject and return a dictionary with subject counts."""
    subject_count = {}
    for student in students:
        subject = student['subject']
        if subject in subject_count:
            subject_count[subject] += 1
        else:
            subject_count[subject] = 1
    return subject_count

    

