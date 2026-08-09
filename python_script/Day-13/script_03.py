# Create a Python script that counts the occurrence of every word in myfile.txt.

# Before counting:

# Convert every word to lowercase.M
# Remove the characters , and . from every word.
# The counting should be dynamic, which means your program must work for any word without hardcoding it.

file = open('myfile.txt','r')

word_count = {}

for lines in file:
  
  line = lines.lower().replace(',','').replace('.','').split()
  
  for word in line:
    
    if word not in word_count:

      word_count[word] = 1
      
    else:
      word_count[word] += 1
    
print(f'word_count = {word_count}')

file.close()