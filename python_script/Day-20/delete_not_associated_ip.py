import boto3
import pprint

AWS_REGION = "ap-south-1"
AWS_ACCESS_KEY = "AKIAXSN37B2VWHBT5UOZ"
AWS_SECRET_KEY = "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"

client = boto3.client('ec2',
                      aws_access_key_id=AWS_ACCESS_KEY,
                      aws_secret_access_key=AWS_SECRET_KEY,
                      region_name=AWS_REGION)



response = client.describe_addresses()

for eip in response['Addresses']:
  
  allocation_id = eip['AllocationId']
  
  if 'AssociationId' not in eip:
   
   print (f'Releasing Unused Eip : {allocation_id}')
     
   client.release_address(AllocationId=allocation_id)

