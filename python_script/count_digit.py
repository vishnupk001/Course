# Create a Python script that accepts a word as input and prints the number of digits in the word.

emailid = input("Enter your Email_ID: ")

counter = 0

for item in emailid:
    
    if item.isdigit():
        
        counter = counter + 1
        
print("Digit_count : ",counter)