import logparser

accessLogfile = "access.log"

accessLog = open (accessLogfile, 'r')

ipCounter= {}

for logLine in accessLog:
  
  ip = logparser.parser(logLine)['host']
    
  if ip not in ipCounter:

    ipCounter[ip] = 1

  else:

    ipCounter[ip] = ipCounter[ip] + 1
    
accessLog.close()

print(ipCounter)