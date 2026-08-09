import json
import pprint

file = open('policy.json', 'r')

policy = json.load(file)

file.close()

pprint.pprint(policy)