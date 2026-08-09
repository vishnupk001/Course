import logparser 

accessLogFile = "access.log"

accessLog = open (accessLogFile, 'r')

Status_Counter = {}

for logLine in accessLog:

    logParts = logparser.parser(logLine)

    status = logParts['status']

    if status not in Status_Counter:

      Status_Counter[status] = 1

    else:

      Status_Counter[status] += 1 

accessLog.close()

print(Status_Counter)

