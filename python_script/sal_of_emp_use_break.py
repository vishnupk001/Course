employees = [[ 'alex' , 5600 ] , [ 'sam' , 3200] , [ 'kevin' , 5600 ] , [ 'john' , 8400 ] ]

search = input("Enter the name of emplyee : ")

for employee in employees:
  
  name = employee[0]
  salary = employee[1]

  if name.lower() == search.lower():

    print(f'Salary of {name} is {salary}')
    break

