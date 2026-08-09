import logparser
import posixpath

accessLogFile = "access.log"

accessLog = open (accessLogFile, 'r')

pathCounter = {}

for logLine in accessLog:

    logParts = logparser.parser(logLine)

    path = logParts['request'].split()[1]

    status = logParts['status']

    if status == '404':

      if path not in pathCounter:

        pathCounter[path] = 1

      else:

        pathCounter[path] = pathCounter[path] + 1

accessLog.close()

for path in pathCounter:

  freq = pathCounter[path]

  print(f' {freq:5} - {path}')