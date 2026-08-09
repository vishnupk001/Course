'''
accessLogFile = "access.log"

accessLog = open(accessLogFile, 'r')

for logLine in accessLog:
  
  print(logLine.split()[3][1:12])
 
accessLog. close()
'''

'''
accessLogFile = "access.log"

accessLog = open(accessLogFile, 'r')

dateCounter = {}

for logLine in accessLog:

    date = logLine.split()[3][1:12]

    if date not in dateCounter:
      
      dateCounter[date] = 1

    else:
      
      dateCounter[date] += 1

accessLog. close()
      
print(dateCounter)

# total = sum(d.values()). check in python3 terminal 
'''