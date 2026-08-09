import logparser

accessLogFile = "access.log"

accessLog = open(accessLogFile, 'r')

ipCounter = {}

lc = 1

for logLine in accessLog:

  print(lc)

  ip = logparser. parser(logLine)['host']

  if ip not in ipCounter:

    ipCounter[ip] = 1

  else:

    ipCounter[ip] = ipCounter[ip] + 1

  lc = lc + 1

accessLog.close()

print(ipCounter)