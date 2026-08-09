# Create a Python script that appends all words that start with the letter 's' from the `word_list` list to another list called `mylist`. Initialize `mylist` as an empty list. **Ignore the case** while checking. If a word already exists in `mylist`, do **not** add it again. Input word_list = [ "apple", "School", "banana", "sun", "orange", "Star", "apple", "sun", "window", "table", "snake", "chair", "banana", "Stone", "phone", "apple", "sun" ] mylist = [] Clue * Use a `for` loop to iterate through `word_list`. * Use `lower()` to ignore the case while checking. * Before calling `append()`, check whether the word is already present in `mylist` using the `in` operator. (not in) * Append the word only if it does **not** already exist in `mylist`.

word_list = [ "apple" , "School" , "banana" , "sun" , "orange" , "Star" , "apple" , "sun" , "window" , "table" , "snake" , "chair" , "banana" , "Stone" , "phone" , "apple" , "sun" ]

mylist = []

print("mylist : ", mylist)

for word in word_list:
  
  if word[0].lower() == "s":
    
    if word not in mylist:
      
      mylist.append(word)
    

print("mylist : ", mylist)