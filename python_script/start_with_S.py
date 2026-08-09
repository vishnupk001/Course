# Create a Python script that prints all words that start with the letter S from the word_list list. Ignore the case while checking.

word_list = [ "apple" , "School" , "banana" , "sun" , "orange" , "Star" , "apple" , "sun" , "window" , "table" , "snake" , "chair" , "banana" , "Stone" , "phone" , "apple" , "sun" ]


for word in word_list:
  
  if word[0].lower() == "s":

    print(word)
    