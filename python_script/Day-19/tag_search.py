import boto3

AWS_REGION = "ap-south-1" 
AWS_ACCESS_KEY = "AKIAXSN37B2VWHBT5UOZ"
AWS_SECRET_KEY = "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"

client = boto3.client('ec2', 
                      aws_access_key_id=AWS_ACCESS_KEY, 
                      aws_secret_access_key=AWS_SECRET_KEY, 
                      region_name=AWS_REGION)

response = client.describe_instances(Filters=[ 
                                          {'Name' : 'tag:Project', 'Values' : ['zomato']},
                                                
                                          {'Name' : 'tag:Environment', 'Values' : ['development']} 
                                        ])


for reservation in response['Reservations']:


  for instance in reservation['Instances']:
    
    instance_id = instance['InstanceId']

    print(f'Starting Instance : {instance_id}')

    client.start_instances(InstanceIds=[instance_id])