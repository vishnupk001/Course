# Create a Python script that accepts a number as input, iterates through each digit, and prints the digit if it is even.

number = input("Enter A Number : ")


for item in number:
    
    if int(item) % 2 == 0:
        
        print(item)
     
       