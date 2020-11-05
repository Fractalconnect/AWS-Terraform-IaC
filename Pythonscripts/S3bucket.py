
import boto3
bucket_name = (input('Enter the s3 bucket name you want to create? '))

s3 = boto3.resource('s3')

bucket = s3.create_bucket(ACL='public-read-write',
        Bucket = bucket_name,
        CreateBucketConfiguration={
            'LocationConstraint': 'ca-central-1'},
)

for b_name in s3.buckets.all():
    print(b_name.name)
