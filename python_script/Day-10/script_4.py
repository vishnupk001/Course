#4. Create a Python program that prints the names of employees whose email address belongs to the @yahoo.com domain.

employees = {
    "Alex": {
        "name": "Alex",
        "age": 28,
        "salary": 65000,
        "email": "alex@yahoo.com",
        "experience": 4,
        "languages": ["Python", "Bash", "Go"]
    },
    "John": {
        "name": "John",
        "age": 35,
        "salary": 85000,
        "email": "john@gmail.com",
        "experience": 10,
        "languages": ["Python", "Java", "SQL"]
    },
    "Sarah": {
        "name": "Sarah",
        "age": 31,
        "salary": 72000,
        "email": "sarah@yahoo.com",
        "experience": 6,
        "languages": ["Python", "JavaScript", "HTML"]
    },
    "Emma": {
        "name": "Emma",
        "age": 26,
        "salary": 60000,
        "email": "emma@gmail.com",
        "experience": 3,
        "languages": ["C", "C++", "Python"]
    },
    "David": {
        "name": "David",
        "age": 40,
        "salary": 95000,
        "email": "david@yahoo.com",
        "experience": 15,
        "languages": ["Rust", "Go", "Python"]
    }
}

for employee in employees:
    
  if employees[employee]["email"].endswith('@yahoo.com'):
        
    print(employees[employee]["name"])