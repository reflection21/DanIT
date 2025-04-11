import requests

url = "http://127.0.0.1:5000/students"

student = {
    "first_name": "Vlad", 
    "last_name": "Kovalenko",
    "age": 23
}

r = requests.post(url, json=student)

