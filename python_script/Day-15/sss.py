import os
import posixpath
import tarfile

directory = "/etc/httpd"
extension = ".conf"
conf_backup = "/tmp/httpd-conf-files.tar"

tar = open(conf_backup,'w')
contents = os.walk(directory)

for content in contents:

  curDir = content[0]
  subDirs = content[1]
  subFiles = content[2]

  for subFile in subFiles:

    fileAbsPath = posixpath.join(curDir, subFile)

    if fileAbsPath.endswith(extension):

      tar.add(fileAbsPath)

tar.close()