import logparser

accessLogfile = "access.log"
ipLogfile = "ip_g_100.log"

accessLog = open(accessLogfile, 'r')
#ipLog = open(ipLogfile, 'w')

ipCounter= {}

for logLine in accessLog:
  
  ip = logparser.parser(logLine)['host']
    
  if ip not in ipCounter:

    ipCounter[ip] = 1

  else:

    ipCounter[ip] = ipCounter[ip] + 1
    
accessLog.close()

def get_freq(item):
  
  return item[1]

result = sorted(ipCounter.items(), key= get_freq, reverse= True)[0:10] #slicing method [-5:] print last 5 results, [1:12] will get first 13 elements

print(result)

print("==============================================")
for ips in result:
  
  ip_address = ips[0]

  freq = ips[1]

  print(f'{ip_address:15} - {freq:4}')
