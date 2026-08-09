# Create a Python script that prints the name of the employee with the highest salary.

# Use the sorted() function to sort the employee_salary dictionary by salary in descending order.

# Create a function named get_salary and use it as the key argument of the sorted() function.

employee_salary = {
    "Alice": 45000,
    "Bob": 52000,
    "Charlie": 61000,
    "David": 48000,
    "Emma": 75000,
    "Frank": 68000,
    "Grace": 55000,
    "Henry": 92000,
    "Isabella": 47000,
    "Jack": 81000
}

def get_salary(item):
  
  return item[-1]

result = sorted(employee_salary.items(), key= get_salary, reverse= True)

print(result[0][0])
