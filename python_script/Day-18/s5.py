import json

main_file = open('policy.json', 'r')

service_file = open('service.txt', 'w')

policy = json.load(main_file)
main_file.close()

Service_list = []

for statement in policy["Statement"]:
  
  actions = statement['Action']
  
  if isinstance(actions, list):

    for action in actions:

      services = action.split(':')
      
      service = services[0]

      if service not in Service_list:

        Service_list.append(service)

        service_file.write(f'{service}\n')
        
service_file.close()