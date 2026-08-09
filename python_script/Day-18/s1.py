import json

file = open('policy.json', 'r')

policy = json.load(file)

file.close()

for Statement in policy:
  
  length = len(policy["Statement"] )

print(f'Length = {length}')