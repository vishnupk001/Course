# Create a Python script that accepts a word as input and prints the number of uppercase letters in the word.

word = input("Enter A Word : ")

counter = 0

for item in word:
    
    if item.isupper():
        
        counter = counter + 1
        
print("Uppercase_count : ",counter)
     


