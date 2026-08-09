# Create a Python script that counts the occurrence of each IP address in the apache.log file.

#The counting should be dynamic, which means your program must work for any IP address without hardcoding it.

file = open('apache.log', 'r')

ip_count = {}

for lines in file:
  
  fields = lines.split(':')
  
  ip = fields[0]

  if ip not in ip_count:

    ip_count[ip] = 1
  
  else:
    
    ip_count[ip] += 1

print(f'ip_count = {ip_count}')

file.close()