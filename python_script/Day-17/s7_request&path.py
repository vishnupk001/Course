import logparser

accessLogFile = "access.log"

accessLog = open (accessLogFile, 'r')

for logLine in accessLog:

  request = logparser.parser(logLine)['request']

  path = request. split()[1]

  print(request)

  print("================================================")

  print (path)

  break

accessLog. close()