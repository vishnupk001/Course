employees = [[ 'alex' , 5600 ] , [ 'sam' , 3200] , [ 'kevin' , 5600 ] , [ 'john' , 8400 ] ]

employee_name = input("Enter the name of employee : ")
isuserExists = False

for employee in employees:

    name = employee[0]

    if name.lower() == employee_name.lower():
      
      isuserExists = True

      print(f'Employee {name} is Exists {isuserExists}')
      break

print(f'Employee not Exists {isuserExists}')   

  


