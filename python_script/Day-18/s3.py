import json
import pprint

file = open('policy.json', 'r')
policy = json.load(file)
file.close()

Service_list = []
counter = 0

for statement in policy["Statement"]:
  
  actions = statement['Action']
  
  if isinstance(actions, list):

    for action in actions:

      services = action.split(':')
      
      service = services[0]

      if service not in Service_list:
        
        Service_list.append(service)
  
print(f'lenght = {len(Service_list)}')