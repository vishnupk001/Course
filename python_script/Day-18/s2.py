import json

file = open('policy.json', 'r')

policy = json.load(file)

file.close()

for statement in policy['Statement']:
  
  actions = statement['Action']
  
  if isinstance(actions, list):

    for action in actions:

      print(action)
    
  else: 
    
    print(actions)