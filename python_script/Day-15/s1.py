import os

import posixpath

directory = '/etc/httpd/'

contents = os.walk(directory)

for content in contents:

  curDir = content[0]
  subDirs = content[1]
  subFiles = content[2]

#  print(content)
  for subDir in subDirs:

    absPath = posixpath.join(curDir,subDir)

    print(absPath)