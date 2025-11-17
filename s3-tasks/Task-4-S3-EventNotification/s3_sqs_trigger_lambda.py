import boto3
import json
from boto3 import client
from urllib import unquote

print("Loading Lambda handler")
def lambda_handler(event, context):
    message = event['Records'][0]['body']
    print("=== message : "+message)
    message = json.loads(unquote(message))
    #Document
    s3_bucket_name= message['Records']['s3']['bucket']['name']
    document_name= message['Records']['s3']['object']['key']
    
    s3 = boto3.resource('s3')
    s3.Object(s3_bucket_name,'output/lambdahandled_'+document_name).copy_from(CopySource=s3_bucket_name+'/'+document_name)
    
    return 'success'
    
