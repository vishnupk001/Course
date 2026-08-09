#Accept a 2-digit number and print the sum of its digits.

number = input("Enter A Number : ")


length = len(number) # Use len() function to find the length


if length == 2:
    
    fnum = number[0] # this is subscript operation ot find first item in an object
    lnum = number[1] # this is subscript operation ot find second item in an object
    
    fnum_int = int(fnum) # Use int() function to convert string to int
    lnum_int = int(lnum) # Use int() function to convert string to int
    result = fnum_int + lnum_int
    
    print(result)
    
else:
    
    print("Error")


