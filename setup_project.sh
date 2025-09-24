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

# make scirpt executable
chmod +x setup_project.sh