import logparser

accessLogFile = "access.log"

accessLog = open (accessLogFile, 'r')

pathCounter = {}

for logLine in accessLog:

  request = logparser.parser(logLine)['request']

  path = request.split()[1]

  if path not in pathCounter:

    pathCounter[path] = 1

  else:

    pathCounter[path] = pathCounter[path] + 1

accessLog.close()

for path in pathCounter:

  freq = pathCounter[path]
  
  if freq > 10: # extra added line for checking freq greater than 10

    print (f' {freq:5} - {path}')