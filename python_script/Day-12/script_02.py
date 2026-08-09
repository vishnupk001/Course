# Create a Python script that prints the name and size of every file directly under the /etc directory.

#Only print entries that are regular files. Ignore directories and other file types.

import os
import posixpath

directory = '/etc'

contents = os.listdir(directory)


for files in contents:
    
  absPath = posixpath.join(directory,files)
  absFile = posixpath.isfile(absPath)

  if absFile:
    
    absFileSize = posixpath.getsize(absPath)
   
    print(files,absFileSize)  