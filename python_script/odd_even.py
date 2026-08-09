#Find a number is odd or even number using modulus operator

number = input("Enter A Number : ")

number_int = int(number) # Use int() function to convert string to int

if number_int % 2 == 0: # Here using modulus operator 
   
    print("Even")
    
else: 
    
    print("Odd")



