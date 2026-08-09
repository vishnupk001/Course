import logparser

accessLogfile = "access.log"
ipLogfile = "ip_g_100.log"

accessLog = open(accessLogfile, 'r')
ipLog = open(ipLogfile, 'w')

ipCounter= {}

for logLine in accessLog:
  
  ip = logparser.parser(logLine)['host']
    
  if ip not in ipCounter:

    ipCounter[ip] = 1

  else:

    ipCounter[ip] = ipCounter[ip] + 1
    
accessLog.close()

for ips in ipCounter:

  freq = ipCounter[ips]
  
  if freq > 100: # extra added line for checking freq greater than 10

    ipLog.write(f'{ips:15} - {freq}\n')

ipLog.close()

