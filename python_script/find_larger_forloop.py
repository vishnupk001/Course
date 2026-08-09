
# Create a python script for finding the height number from a four digit number. eg: 3452

number = input("Enter a Four Digit Number : ")

length = len(number)

if length == 4 and number.isdigit():
    
    vartemp = int(number[0])

    for item in number:
        
        if int(item) > vartemp:
        
           vartemp = int(item)
    
    print(vartemp)
    
else:
    
    print("Invalid Entry")
