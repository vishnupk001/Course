# 2. Create a Python program that prints the sum of all the numbers in the given list. Some numbers are represented as strings. Include both integer values and numeric strings in the sum. Ignore any non-numeric strings.

numbers = [3, '5', '6', 'alex', 7, 8]

total = 0

for number in numbers:
  
  if str(number).isdigit():     
    
    total = total + int(number)
    
print(total)

   
