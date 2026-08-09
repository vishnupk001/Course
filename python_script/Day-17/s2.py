accessLogFile = "access.log"

accessLog = open(accessLogFile, 'r')

ipCounter = {}

for logLine in accessLog:
  
  ip = logLine.split()[0]

  if ip not in ipCounter:

    ipCounter[ip] = 1
    
  else:

    ipCounter[ip] = ipCounter[ip] + 1
    
accessLog.close()

print (ipCounter)