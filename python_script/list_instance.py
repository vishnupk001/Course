import boto3
import pprint
AWS_REGION = "ap-south-1" 
AWS_ACCESS_KEY = "AKIAXSN37B2VWHBT5UOZ"
AWS_SECRET_KEY = "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"

client = boto3.client('ec2', 
                      aws_access_key_id=AWS_ACCESS_KEY, 
                      aws_secret_access_key=AWS_SECRET_KEY, 
                      region_name=AWS_REGION)

response = client.describe_instances(InstanceIds=['i-0f815b9a7062c3b49'])

#pprint.pprint(response)

print(response['Reservations'][0]['Instances'][0]['InstanceId'])
print(response['Reservations'][0]['Instances'][0]['PublicIpAddress'])