import json

main_file = open('policy.json', 'r')
ec2_file = open('ec2-action.txt', 'w')

policy = json.load(main_file)
main_file.close()



for statement in policy["Statement"]:
  
  actions = statement['Action']
  
  if isinstance(actions, list):

    for action in actions:

      if action.lower().startswith("ec2"):

        ec2_file.write(f'{action}\n')
        
ec2_file.close()