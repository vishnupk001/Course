# Enter last character in a word and check any word entered

word = input("Enter A Word : ")

length = len(word)

if length > 0:
    
    lastchar = word[ length - 1 ]
    print(lastchar)
    
else:
    
    print("Empty Input")