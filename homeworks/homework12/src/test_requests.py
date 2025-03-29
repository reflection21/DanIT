import requests

url = "http://127.0.0.1:5000/students"

log_file = "result.txt"

def log_response(request):
    log = f"url: {request.url}\nstatus: {request.status_code}\nresponse: {request.text}\n\n"  
    with open(log_file, "a") as file:  
        file.write(log)

open(log_file, "w").close()                                                                                                                                                                                                                                 

# GET all students
log_response(requests.get(url))
# POST create 3 strudent
students = [
    {"first_name": "Vlad", "last_name": "Kovalenko", "age": 23},
    {"first_name": "Oksana", "last_name": "Petriv", "age": 21},
    {"first_name": "Dmytro", "last_name": "Tkachenko", "age": 25}
]
for student in students:
    log_response(requests.post(url, json=student))
# GET all students
log_response(requests.get(url))
# PATCH update info about second student
log_response(requests.patch(f"{url}/2", json={"age": 33}))
# GET second student
log_response(requests.get(f"{url}/2"))
# PUT update all info about third student
data = {
    "first_name": "kolya",
    "last_name": "borach",
    "age": "21"
}
log_response(requests.put(f"{url}/3", json=data))
# GET third student
log_response(requests.get(f"{url}/3"))
# GET all students
log_response(requests.get(url))
# DELETE first student
log_response(requests.delete(f"{url}/1"))
# GET all students
log_response(requests.get(url))