import pytest
import requests

url = 'http://localhost:5000/students'
# test GET
@pytest.mark.parametrize("endpoint, expected_status", [
    ("", 200),
    ("/2", 200),
    ("/lastname/bryhynets", 200)
])
def test_api_requests(endpoint, expected_status):
    response = requests.get(f"{url}{endpoint}")
    assert response.status_code == expected_status
# test POST
@pytest.fixture
def create_student():
    return [
    {"first_name": "Andriy", "last_name": "Shevchenko", "age": 23},
    {"first_name": "Oksana", "last_name": "Petriv", "age": 21},
    {"first_name": "Dmytro", "last_name": "Tkachenko", "age": 25}
]

def test_add_student(create_student):
    for s in create_student:
        response = requests.post(url, json=s)
        assert response.status_code == 200
       
# test PUT
def test_put_student():
    response = requests.put("http://localhost:5000/students/3", json={"first_name": "Kolya", "last_name": "Borach", "age": 21})
    assert response.status_code == 200
    

# test PATCH
def test_patch_student():
    response = requests.patch("http://localhost:5000/students/2", json={"age": "21"})
    assert response.status_code == 200
      
# test DELETE
def test_delete_student():
    response = requests.delete("http://localhost:5000/students/2")
    assert response.status_code == 200
    