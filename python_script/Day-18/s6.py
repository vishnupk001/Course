import json

file = open('policy.json', 'r')
policy = json.load(file)
file.close()

Service_list = {}
for statement in policy["Statement"]:
  
  actions = statement['Action']
  
  if isinstance(actions, list):

    #print(actions)
    for action in actions:

      services = action.split(':')
      
      service = services[0]

      if service not in Service_list:
    
        Service_list[service] = 1

      else:

        Service_list[service] += 1

print(Service_list)