# Create a Python function that accepts an age as a parameter and returns True if the person is a major. Otherwise, return False.

# Assume a person is a major if their age is 18 or above.

# Function Template

# def is_major(age):
#     # Write your logic here
# Clue

# Create a function named is_major.
# The function should accept one parameter named age.
# If age is greater than or equal to 18, return True.
# Otherwise, return False.

def is_major(age):
  
  if age >= 18:

    return True 
  
  return False

print(is_major(25))
print(is_major(18))
print(is_major(16))
print(is_major(40))
print(is_major(13))
print(is_major(1))