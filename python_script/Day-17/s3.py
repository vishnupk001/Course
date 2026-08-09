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

# ['83.149.9.216': 23, '24.236.252.67': 1, '93.114.45.13': 6)

for ip in ipCounter:
  
  freq = ipCounter[ip]
  
  if freq >= 100:

    print(f'{ip:15} - {freq:5}')
    print(f'{ip:>15} - {freq:<5}')
    print(f'{ip:^15} - {freq:^5}')