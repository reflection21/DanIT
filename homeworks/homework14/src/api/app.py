from flask import Flask, jsonify, request  # type: ignore
import csv

CSV_FILE = 'students.csv' #csv file

app = Flask(__name__)

# reads the CSV file and returns a list of students as dictionaries
def read_students(): 
    with open(CSV_FILE, "r") as file: 
        reader = csv.DictReader(file)
        students = [row for row in reader] # convert rows to a list of dictionaries
    return students  
# add new student in csv file
def append_student(id, first_name, last_name, age):  
    with open(CSV_FILE, mode="a", newline='', encoding='utf-8') as file:
        fieldnames = ["id", "first_name", "last_name", "age"]
        writer = csv.DictWriter(file, fieldnames=fieldnames)
        # Check if the file is empty, if it is, write the header
        if file.tell() == 0:  # Check if the file is empty
            writer.writeheader()
        writer.writerow({"id": id, "first_name": first_name, "last_name": last_name, "age": age})
# overwrites the CSV file with a new list of students
def update_students(students): 
    with open(CSV_FILE, mode="w") as file:
        fieldnames = ["id", "first_name", "last_name", "age"]
        writer = csv.DictWriter(file, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(students)
# returns the full list of students
@app.route("/students", methods=["GET"])  
def get_students():
    return jsonify(read_students()), 200
# returns a student by ID
@app.route("/students/<id>", methods=["GET"]) 
def get_student_by_id(id):
    # students = read_students()
    for student in read_students():
        if student["id"] == id:
            return jsonify(student), 200
    return jsonify({"error": "Student not found"}), 404
# returns students by last name
@app.route("/students/lastname/<last_name>", methods=["GET"]) 
def get_students_by_last_name(last_name):
    # s - student
    students = [ s for s in read_students() if s["last_name"].lower() == last_name.lower()]  
    if students:
        return jsonify(students), 200
    else:
        return jsonify({"error": "No students found with this last name"}), 404
# add new student
@app.route("/students", methods=["POST"]) 
def add_student():
    data = request.get_json()  
    first_name = data.get("first_name")
    last_name = data.get("last_name")
    age = data.get("age")   
    next_id = 1
    if not first_name or not last_name or not age:
        return jsonify({"error": "Missing data"}), 400
    students = read_students()   
    if students:                       
        next_id = int(students[-1]["id"]) + 1
    append_student(next_id, first_name, last_name, age)
    return jsonify({"message": f"Student {first_name} {last_name} added successfully"}), 200
# updates an existing student's full details
@app.route("/students/<id>", methods=["PUT"])
def update_student(id):
    data = request.get_json()  
    first_name = data.get("first_name")
    last_name = data.get("last_name")
    age = data.get("age")
    if not first_name or not last_name or not age:
        return jsonify({"error": "No valid fields provided"}), 400
    students = read_students()  
    for student in students:
        if student["id"] == id:
            student["first_name"] = first_name
            student["last_name"] = last_name
            student["age"] = age
            update_students(students)
            return jsonify({"message": "Student updated successfully"}), 200
    return jsonify({"error": "Student not found"}), 404
# updates a student
@app.route("/students/<id>", methods=["PATCH"])
def patch_student(id):
    data = request.get_json()  
    first_name = data.get("first_name")
    last_name = data.get("last_name")
    age = data.get("age")
    students = read_students()  
    for student in students:
        if student["id"] == id:
            if first_name:    
                student["first_name"] = first_name
            if last_name:    
                student["last_name"] = last_name
            if age:    
                student["age"] = age
            update_students(students)
            return jsonify({"message": "Student updated successfully"}), 200
    return jsonify({"error": "Student not found"}), 404
# delete a student by ID
@app.route("/students/<id>", methods=["DELETE"])
def delete_student(id):
    students = read_students()
    updated_students = [student for student in students if student["id"] != id]
    if len(updated_students) == len(students):
        return jsonify({"error": "Student not found"}), 404
    update_students(updated_students)
    return jsonify({"message": "Student deleted successfully"}), 200

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)