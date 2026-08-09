# Create a Python script that prints the page paths whose loading time is less than 300 milliseconds from the apache.log file.

file = open('apache.log', 'r')

for lines in file:
  
  fields = lines.split(':')
  
  page_path = fields[2]

  loading_time = int(fields[3])

  if loading_time < 300:

    print(page_path)

file.close()