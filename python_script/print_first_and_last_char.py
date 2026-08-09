# Accept a word and print its first and last characters.

word = input("Enter A Word : ")

length = len(word)

firstchar = word[0]
lastchar = word[ length - 1 ]

print(firstchar + lastchar)
