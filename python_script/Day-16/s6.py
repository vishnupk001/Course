# Create a Python script that prints all employee names from the employee_salary dictionary in reverse alphabetical order.

# Use the .keys() method and the sort() function.

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

employees = sorted(employee_salary.keys(), reverse= True)

for employee in employees:

  print(employee)
