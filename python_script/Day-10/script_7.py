# 7. Create a Python program that prints each employee's name and the number of years they spent in the company.

employees = {
    "Alex": {
        "name": "Alex",
        "age": 28,
        "salary": 65000,
        "email": "alex@yahoo.com",
        "join_year": 2021,
        "retire_year": 2022,
        "languages": ["Python", "Bash", "Go"]
    },
    "John": {
        "name": "John",
        "age": 35,
        "salary": 85000,
        "email": "john@gmail.com",
        "join_year": 2014,
        "retire_year": 2051,
        "languages": ["Python", "Java", "SQL"]
    },
    "Sarah": {
        "name": "Sarah",
        "age": 31,
        "salary": 72000,
        "email": "sarah@yahoo.com",
        "join_year": 2018,
        "retire_year": 2055,
        "languages": ["Python", "JavaScript", "HTML"]
    },
    "Emma": {
        "name": "Emma",
        "age": 26,
        "salary": 60000,
        "email": "emma@gmail.com",
        "join_year": 2023,
        "retire_year": 2030,
        "languages": ["C", "C++", "Python"]
    },
    "David": {
        "name": "David",
        "age": 40,
        "salary": 95000,
        "email": "david@yahoo.com",
        "join_year": 2009,
        "retire_year": 2046,
        "languages": ["Rust", "Go", "Python"]
    }
}


for employee in employees:
    
  No_of_years_spent = employees[employee]["retire_year"] - employees[employee]["join_year"]
    
  print(f'{employees[employee]["name"]} {No_of_years_spent}')