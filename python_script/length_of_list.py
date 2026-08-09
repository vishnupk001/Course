# Create a Python script that prints the length of the given list without using the len() function.


word_list = [ "apple", "School" , "banana" , "sun" , "orange" ,"Star" , "apple" , "window" , "table" , "snake" , "chair" , "banana" , "Stone" , "phone" , "apple"  ]

counter = 0

for word in word_list:
  
  counter = counter + 1

print("Length of List : ", counter)
