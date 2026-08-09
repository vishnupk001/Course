# Create a Python script that prints all the words from myfile.txt. Remove the characters , and . from every word before printing it.

file = open('myfile.txt','r')

for lines in file:
  
  for word in lines.lower().replace(',','').replace('.','').split():

    print(word)

file.close()