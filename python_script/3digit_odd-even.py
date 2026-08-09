# Enter 3 digit number (123) and find each digit are odd or even.

number = input("Enter Three Digit Number : ")

number_1 = int(number[0])
number_2 = int(number[1])
number_3 = int(number[2])

if number_1 % 2 == 0 and number_2 % 2 == 0 and number_3 % 2 == 0:
    
    print("Even","Even","Even")
    
if number_1 % 2 == 0 and number_2 % 2 == 0 and number_3 % 2 == 1:
    
    print("Even","Even","Odd")

if number_1 % 2 == 0 and number_2 % 2 == 1 and number_3 % 2 == 1:
    
    print("Even","Odd","Odd")
    
if number_1 % 2 == 1 and number_2 % 2 == 1 and number_3 % 2 == 1:
    
    print("Odd","Odd","Odd")

if number_1 % 2 == 1 and number_2 % 2 == 1 and number_3 % 2 == 0:
    
    print("Odd","Odd","Even")
    
if number_1 % 2 == 1 and number_2 % 2 == 0 and number_3 % 2 == 0:
    
    print("Odd","Even","Even")
    
if number_1 % 2 == 0 and number_2 % 2 == 1 and number_3 % 2 == 0:
    
    print("Even","Odd","Even")
    
if number_1 % 2 == 1 and number_2 % 2 == 0 and number_3 % 2 == 1:
    
    print("Odd","Even","Odd")