# Create a Python script that accepts a number. If the number contains exactly 2 or 3 digits, print "pass"; otherwise, print "fail".

number = input("Enter A Number : ")

length = len(number)

if length == 2:
    
    print("Pass")
    
else:
    
    print("Fail")