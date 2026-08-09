# Create a python script for finding the height number from a two digit number. eg: 34 , 46

number = input("Enter a Four Digit Number : ")

length = len(number)

if length == 2 and number.isdigit():
    
    vartemp = int(number[0])

    for item in number:
        
        if int(item) > vartemp:
        
           vartemp = int(item)
    
    print(vartemp)
    
else:
    
    print("Invalid Entry")