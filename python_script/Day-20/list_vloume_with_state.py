import boto3


AWS_REGION = "ap-south-1"
AWS_ACCESS_KEY = "AKIAXSN37B2VWHBT5UOZ"
AWS_SECRET_KEY = "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"

client = boto3.client('ec2',
                      aws_access_key_id=AWS_ACCESS_KEY,
                      aws_secret_access_key=AWS_SECRET_KEY,
                      region_name=AWS_REGION)



response = client.describe_volumes(VolumeIds=['vol-01b7b29010267f8d7'])

for volume in response['Volumes']:

  volume_id = volume['VolumeId']
  volume_state = volume['State']
  volume_encrypt_status = volume['Encrypted']
  
  print(f'Id : {volume_id:^25} State : {volume_state:^10} Encrypted : {volume_encrypt_status}')