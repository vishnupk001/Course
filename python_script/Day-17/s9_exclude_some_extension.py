import logparser
import posixpath

accessLogFile = "access.log"

accessLog = open (accessLogFile, 'r')

pathCounter = {}

extExclude = ['.png', '.css', '.jpg', '.ico', '.gif' , '.html']

for logLine in accessLog:

  request = logparser.parser(logLine)['request']

  path = request.split()[1]

  extension = posixpath.splitext(path)[1]

  if extension not in extExclude:

    if path not in pathCounter:

      pathCounter[path] = 1

    else:

      pathCounter[path] = pathCounter[path] + 1

accessLog.close()

for path in pathCounter:

  freq = pathCounter[path]
  
  if freq > 10: # extra added line for checking freq greater than 10

    print (f' {freq:5} - {path}')