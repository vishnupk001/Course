# Create a Python script that accepts a word and checks whether the word starts with a vowel (a, e, i, o, or u). If it starts with a vowel, print "Starts with a vowel"; otherwise, print "Does not start with a vowel". Input: apple Output: Starts with a vowel ---------------------- Input: orange Output: Starts with a vowel ---------------------- Input: banana Output: Does not start with a vowel

word = input("Enter A word : ")

fchar = word[0].isupper()

if fchar == 'a' or fchar == 'A' or fchar == 'e' or fchar == 'E' or fchar == 'i' or fchar == 'I' or fchar == 'o' or fchar == 'O' or fchar == 'u' or fchar == 'U':
    
    print("Starts with a vowel")
    
else: 
    
    print("Does not start with a vowel")