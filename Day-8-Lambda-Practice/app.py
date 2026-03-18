import json

def lambda_handler(event, context):
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Hi Sathya! welcome to Lambda Practice..!')
    }
