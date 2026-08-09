# 2 - Create a Python script that accepts a number. If the given number is even, print Even; otherwise, print Odd. Make sure the input is a digit. Clue: number % 2 returns: 0 if the number is even. 1 if the number is odd. ---------------------- Input: 8 Output: Even ---------------------- Input: 5 Output: Odd


number = input("Enter A Number : ")

 

if number.isdigit() and int(number) % 2 == 0:
   
    print("Even")

if number.isdigit() and int(number) % 2 == 1:
    
    print("Odd")

else: 
    
    print("Invalid Input")
    