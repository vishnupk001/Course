import json


file = open('policy.json', 'r')
policy = json.load(file)
file.close()


for statement in policy["Statement"]:
  
  actions = statement['Action']
  
  if isinstance(actions, list):

    print(len(actions))