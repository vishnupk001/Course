# Create a Python program that accepts a word as input and prints its length.

word = input("Enter a word : ")

count_length = 0
    
for item in word:
    
    if item.isalpha():
        
        count_length = count_length + 1 
    
print(count_length)

  