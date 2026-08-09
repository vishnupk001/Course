# Create a Python script that accepts a word as input and prints the number of lowercase letters in the word.

word = input("Enter A Word : ")

counter = 0

for item in word:
    
    if item.islower():
        
        counter = counter + 1
        
print("Lowercase_count : ",counter)