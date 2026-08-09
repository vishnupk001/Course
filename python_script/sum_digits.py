# Create a Python script that accepts a number as input, iterates through each digit, and prints the sum of all the digits.

number = input("Enter A Number : ")

sum_digit = 0

if number.isdigit():
    
  for item in number:
        
          sum_digit = sum_digit + int(item)
        
  print("Sum of the Digit : ",sum_digit)

else: 
    
    print ("Invalid Input")