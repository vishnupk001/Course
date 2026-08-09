# Create a Python function called iseven() that accepts a number as a parameter and returns boolean True if the number is even; otherwise, it returns boolean False.

def iseven(number):
   
  if number % 2 == 0:
    
    result = True
  
  else:

    result = False
  
  return result
  
print(iseven(9))

print(iseven(10))

print(iseven(17))

print(iseven(22))
