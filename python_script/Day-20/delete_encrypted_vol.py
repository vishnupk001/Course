import boto3


AWS_REGION = "ap-south-1"
AWS_ACCESS_KEY = "AKIAXSN37B2VWHBT5UOZ"
AWS_SECRET_KEY = "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"

client = boto3.client('ec2',
                      aws_access_key_id=AWS_ACCESS_KEY,
                      aws_secret_access_key=AWS_SECRET_KEY,
                      region_name=AWS_REGION)




response = client.describe_volumes(Filters=[ 
                                          {'Name' : 'tag:Project', 'Values' : ['shopping']},
                                                
                                          {'Name' : 'tag:Environment', 'Values' : ['development']},

                                          {'Name' : 'encrypted', 'Values' : ['true']}
                                        ])

for volume in response['Volumes']:

  volume_id = volume['VolumeId']
  
  print(f'Deleting Volume : {volume_id}') 

  client.delete_volume(VolumeId=volume_id)