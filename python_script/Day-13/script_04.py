#Create a Python script that prints all IP addresses from the apache.log file.

file = open('apache.log', 'r')

for lines in file:
  
  fields = lines.split(':')
  
  ip = fields[0]

  print(ip)

file.close()