#Create a Python script that counts how many times the page /login.html was accessed in the apache.log file.

file = open('apache.log', 'r')

count = 0

for lines in file:
  
  fields = lines.split(':')
  
  page_path = fields[2]

  if page_path == '/login.html':
    
    count += 1
  
print(f'/login.html accessed {count} times')

file.close()