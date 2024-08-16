import boto3
import botocore

def handler(event, context):
   print(f'boto3 version: {boto3.__version__}')
   print(f'botocore version: {botocore.__version__}')
   return {"message":"Sample handler running"}
