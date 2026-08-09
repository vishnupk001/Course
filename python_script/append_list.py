# Create a Python script that appends all words that start with the letter S from the word_list list to another list called mylist. Initialize mylist as an empty list. Ignore the case while checking. Clue - Use a for loop to iterate through word_list. - Use lower() to ignore the case while checking. - Use the append() method to add matching words to mylist.

word_list = [ "apple" , "School" , "banana" , "sun" , "orange" , "Star" , "apple" , "sun" , "window" , "table" , "snake" , "chair" , "banana" , "Stone" , "phone" , "apple" , "sun" ]

mylist = []

print("mylist : ", mylist)

for item in word_list:
  
  if item[0].lower() == "s":
    
    mylist.append(item)

print("mylist : ", mylist)