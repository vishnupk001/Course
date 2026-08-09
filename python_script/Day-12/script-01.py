# Create a Python script that lists all .conf files directly under the /etc directory.

#Use the os.listdir() function to list the contents of the /etc directory, then iterate through the list and print only the files that end with .conf.



import os

contents = os.listdir('/etc')

for files in contents:

  if files.endswith('.conf'):

    print(files)