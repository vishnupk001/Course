# Create a Python script that prints every line from the file myfile.txt

file = open('myfile.txt','r')

for lines in file:
  
  print(lines)

file.close()