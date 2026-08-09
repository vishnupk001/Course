import boto3
#ximport pprint

AWS_REGION = "ap-south-1"
AWS_ACCESS_KEY = "AKIAYFYJGMJ4CMH5QIER"
AWS_SECRET_KEY = "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"

client = boto3.client('s3',
                      aws_access_key_id=AWS_ACCESS_KEY,
                      aws_secret_access_key=AWS_SECRET_KEY,
                      region_name=AWS_REGION)

response = client.get_bucket_encryption(Bucket='botoencryption')

for rule in response['ServerSideEncryptionConfiguration']['Rules']:

   encryption_type = rule['BlockedEncryptionTypes']['EncryptionType'][0]
   key_enabled = rule['BucketKeyEnabled']

   print(f'Name : {Bucket} Encryption Type : {encryption_type}  Key Enabled : {key_enabled}')
