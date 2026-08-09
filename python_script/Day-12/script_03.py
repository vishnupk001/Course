# Create a Python script that checks whether the following files exist on the system.

files = [
    "/etc/os-release",
    "/etc/passwd",
    "/etc/nofile"
]

import posixpath


for file in files:
  
  if posixpath.exists(file):
      
    print(f'{file} : Exits')

  else: 

    print(f'{file} : Not Found')