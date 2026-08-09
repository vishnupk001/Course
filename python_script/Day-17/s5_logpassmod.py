# Use logparser module to split the log line.

import logparser

accessLogFile = "access.log"

accessLog = open (accessLogFile, 'r')

for logLine in accessLog:

  print (logLine)

  print()

  print(logLine.split())

  print()

  print(logparser. parser (logLine))

  print()

  break